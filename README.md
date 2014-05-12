webservice
==========

一键同时安装(nginx|apache、php、memcached)到多台服务器

实验安装环境

	os：			cenos 6.5
	apr: 			apr-1.5.1
	apr-util:  		apr-util-1.5.3
	apache:			httpd-2.4.9
	nginx:			nginx-1.4.7
	libmcrypt:		libmcrypt-2.5.7
	php:			php-5.4.26
	libevent:		libevent-2.0.21-stable
	memcached服务器:	memcached-1.4.17
	memcache php服务：	memcache-2.2.7
	yum -y install gcc gcc-c++ gcc-g77 flex bison autoconf automake bzip2-devel ncuress-devel zlib-devel libjpeg-devel libpng-devel libtiff-devel freetype-devel pam-devel openssl-devel libxml2-devel gettext-devel pcre-devel libcurl-devel expect rsync

以上安装本人均在root用户下实施

安装前配置
	1.用root身份登录安装
	2.确保各服务器yum源网络可访问(官方的即可)
	3.将每个服务器用户名、ip和密码写入clients文件(如:uname:ip:password) 以换行结束
	4.配置autoindex.sh文件(详细配置参见文件内部注释)
-----------------------------------------------------------------------------------------------------------
安装实例:
	执行autoindex.sh文件
	选择安装选项（ nmcp: nginx+php+memcached   amcp: apache+php+memcached  quit:退出 ）
	查看安装日志(由配置文件install.sh提拱,也可以到终端安装脚本下log文件夹下用tailf webinstall 查看当前安装状况)

	安装完webservice环境之后执行rsync_setup.sh 可以把本服务器的指定访目录同步到各服务中，具体配置见rsync_setup.sh文件
	
