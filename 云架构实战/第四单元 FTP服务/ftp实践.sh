#安装
yum install -y vsftpd

#启动
/etc/init.d/vsftpd start

#查看vsftp进程状态
/etc/init.d/vsftpd status

#设置开机自启
chkconfig vsftpd on

# 关闭防火墙和Selinux
service iptables stop
setenforce 0

#精简查看配置文件
cd /etc/vsftpd
egrep -v '^$|^#' vsftpd.conf

#查看vsftp进程
ps -ef|grep vsftpd

#查看vsftp端口
ss -lntp|grep vsftpd

####启动后就可以进行，匿名用户测试，默认只有查看和下载权限。













