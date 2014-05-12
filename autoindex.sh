#!/bin/bash
# centos 6.5
# xile(qq:278825498)
# install.sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

set -e -u

# 安装expect
yum -y install expect

# 设置log服务器IP和密码
LOG_SERVER_PATH='root@192.168.0.1:/root/webos'

LOG_SERVER_PASS='test'

# 打开iptables 80端口 1:开启 0:不设置
IPTABLES_STATU=1 

# 设置安装目录
INSTALL_PATH="/var/webservice"

# 根目录
export PATH_ROOT=`pwd`

# bin目录 
export BIN_PATH="${PATH_ROOT}/bin"

# source目录
export SOURCE_PATH="${PATH_ROOT}/source"

# 安装选项
OPTTONS="nmcp amcp quit"

select opt in $OPTTONS
do
   SOFT_NAME=$opt
   if [ "$SOFT_NAME" == "quit" ];then
	exit
   fi
   for i in `cat ${PATH_ROOT}/clients`
   do
	#获取用户名、IP和密码
	server_uname=`echo $i | cut -d: -f1`
	server_ipaddr=`echo $i | cut -d: -f2`
	server_pass=`echo $i | cut -d: -f3`
      
	#安装scp
 	${BIN_PATH}/sshlogin_eof.exp $server_pass $server_uname $server_ipaddr "(yum -y install openssh-clients)" &> /dev/null

	#传送安装文件
	${BIN_PATH}/scp.exp $server_pass "${server_uname}@${server_ipaddr}:" "${BIN_PATH}/runs.sh" 
	${BIN_PATH}/scp.exp $server_pass "${server_uname}@${server_ipaddr}:" "${SOURCE_PATH}/webservice.tar.gz" 

	#登录并执行脚本文件
 	${BIN_PATH}/sshlogin_eof.exp $server_pass $server_uname $server_ipaddr "(./runs.sh ${SOFT_NAME} ${INSTALL_PATH} ${LOG_SERVER_PATH} ${LOG_SERVER_PASS} ${IPTABLES_STATU})"
   done
   exit
done
