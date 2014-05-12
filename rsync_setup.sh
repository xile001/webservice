#!/bin/bash
# centos 6.5
# xile(qq:278825498)
# rsnychro.sh

set -e -u

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

# 根目录
export PATH_ROOT=`pwd`

# bin目录 
export BIN_PATH="${PATH_ROOT}/bin"

# source目录
export SOURCE_PATH="${PATH_ROOT}/source"

# ssh密钥目录
USER_SSH='/root/.ssh'

# 生成ssh密钥
if [ ! -e ${USER_SSH}/id_rsa.pub ];then
    ssh-keygen -t rsa -f ${USER_SSH}/id_rsa -C '' -N '' -q
fi

# 主服务器分享目录
SRC='/var/webservice/www/'

# 从服务器目录
DES='/var/webservice/www'

for i in `cat /root/webos/clients`
do
  #获取用户名和IP
  SERVER_UNAME=`echo $i | cut -d: -f1`
  SERVER_IPADDR=`echo $i | cut -d: -f2` 
  SERVER_PASS=`echo $i | cut -d: -f3`

  $BIN_PATH/ssh-copy-id.exp $SERVER_PASS "${SERVER_UNAME}@${SERVER_IPADDR}" "${USER_SSH}/id_rsa.pub" 

  rsync -aHze ssh --exclude=".svn" --delete $SRC ${SERVER_UNAME}@${SERVER_IPADDR}:$DES

  $BIN_PATH/sshlogin.exp $SERVER_PASS $SERVER_UNAME $SERVER_IPADDR "(rm -rf $USER_SSH)" 

done