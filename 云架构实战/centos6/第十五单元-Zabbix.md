![1568535055846](assets/1568535055846.png)



[TOC]



# 第十五单元-Zabbix

![improved_dashboard1](assets/improved_dashboard1.png)



## 15.1 Zabbix是什么

​	Zabbix是一个高度集成的企业级开源网络监控解决方案，与Cacti、nagios类似，提供分布式监控以及集中的web管理界面。



## 15.2 Zabbix的功能

​	zabbix具备常见商业监控软件所具备的功能，例如主机性能监控，网络设备性能监控，数据库性能监控，ftp等通用协议的监控，能够灵活利用可定制警告机制，允许用户对事件发送基于E-mail的警告，保证相关人员可以快速解决。还能够利用存储数据提供杰出的报表及实时的图形化数据处理，实现对监控主机7x24小时集中监控。



## 15.3 Zabbix的组件

​	Zabbix通过C/S模式采集数据通过B/S模式在web端展示和配置，zabbix-server服务端监听端口为10051，而zabbix-agent客户端监听端口为10050。





## 15.4 实验环境

| 主机                | 操作系统  | IP地址    | 主要软件                                                    |
| ------------------- | --------- | --------- | ----------------------------------------------------------- |
| zabbix-server服务端 | centos6.8 | 10.0.0.21 | httpd, php5.6, mysql5.6, zabbix-server4.0,  zabbix-agent4.0 |
| zabbix-agent客户端  | centos6.8 | 10.0.0.22 | zabbix-server4.0,  zabbix-agent4.0                          |



## 15.5 zabbix-server服务端操作

### 15.5.1 搭建LAMP环境

zabbix需要mysql 5.6以上版本，删除旧的版本

```shell
yum -y remove mysql*
```

下载MySQL5.6版本并安装

```shell
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum -y install mysql-server mysql
```


安装php5.6和Apache服务

#获取yum源

```shell
wget -O /etc/yum.repos.d/remi.repo http://rpms.famillecollet.com/enterprise/remi.repo
yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-ldap php-bcmath php-odbc php-pear php-xml php-xmlrpc php-mhash libjpeg* php-mysql php-gd php-mbstring
```

#安装apache

```shell
yum -y install httpd
```

#整合apache和php

```shell
vim /etc/httpd/conf/httpd.conf
DirectoryIndex index.html index.html.var index.php
AddType application/x-httpd-php .php
```

#重启httpd和mysql

```shell
/etc/init.d/httpd restart
/etc/init.d/mysqld restart
```

#设置mysql登录密码

```shell
/usr/bin/mysqladmin -u root password '123456'
```



### 15.5.2 安装zabbix-4.0

官网安装地址

https://www.zabbix.com/download?zabbix=4.0&os_distribution=centos&os_version=6&db=mysql

#配置zabbix源

```shell
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-release-4.0-2.el6.noarch.rpm
yum clean all
```

#安装Zabbix server, frontend, agent

```
yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-agent
```



### 15.5.3 初始化mysql数据库

```sql
mysql -uroot -p123456

mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> grant all privileges on zabbix.* to zabbix@localhost identified by '123456';
mysql> quit;

zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p123456 zabbix
```



### 15.5.4 编辑zabbix-server配置文件

```shell
vim /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=123456
```



### 15.5.5 复制zabbix站点文件到apache站点目录

```
mkdir -p /var/www/html/zabbix
cp -a /usr/share/zabbix/* /var/www/html/zabbix/
```



### 15.5.6 重启httpd，zabbix-server，zabbix-agent









5.4.1zabbix-agent
15.4.2和zabbix-server
15.5Zabbx-server的安装
15.4.1Zabbx-server的安装
15.4.2Zabbx-server的配置
15.6Zabbx的测试使用
15.7Zabbix
15.8Zabbx配置邮件报警
15.9综合案例考核

















