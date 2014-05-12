#!/bin/bash
# centos 6.5
# xile(qq:278825498)
# runs.sh

set -u -e

tar -zxf webservice.tar.gz
cd webservice

# 安装软件名称
SOFT_NAME=${1-"nmcp"}

# 目标安装目录
INSTALL_PATH=${2-"/var/webservice"}

# 将本地安装日志发送到服务器IP
LOG_SERVER_PATH=${3-}

# 将本地安装日志发送到服务器密码
LOG_SERVER_PASS=${4-}

#开启iptables 80端口 1:开启  0:不设置
IPTABLES_STATU=${5-0}

nohup ./autoindex.sh ${SOFT_NAME} ${INSTALL_PATH} ${LOG_SERVER_PATH} ${LOG_SERVER_PASS} ${IPTABLES_STATU} &>> ./log/webinstall & 

exit
