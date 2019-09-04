![1567386063166](assets/1567386063166.png)

[TOC]





# 第六单元-Apache（二）



## 6.1 虚拟主机

### 6.1.1 什么是虚拟主机

在一个Apache服务器上可以配置多个虚拟主机，实现一个服务器**提供多站点服务**，其实就是访问同一个服务器上的不同目录。**一个服务器主机可以运行多个网站，每个网站都是一个虚拟主机**。

​	

### 6.1.2 虚拟主机类型

Apache虚拟主机的实现方式有3种。

- 基于**IP**的虚拟主机
- 基于**端口**的虚拟主机
- 基于**域名**的虚拟主机





6.1.3 VirtualHost参数的意义	



```
<VirtualHost *:80>
    #文档的根目录
    DocumentRoot "D:\phpStudy\WWW\cq"
    #域名
    ServerName www.cq.com
    ServerAlias 
    #配置rewrite相关选项
  <Directory "D:\phpStudy\WWW\cq">
      Options FollowSymLinks ExecCGI
	  #是否启用rewrite
      AllowOverride All 
      Order allow,deny
	  #是否显示列表 （在发布项目后一般是不启用，对于这个配置，针对DocumentRoot在apachede的默认文件夹外的目录生效。比如下面的例一 ）
      Options +indexes 
      Allow from all
	  #拒绝所有的访问
      #Deny from all  
      Require all granted
  </Directory>
</VirtualHost



<VirtualHost *:80>								#服务器ip和端口
    DocumentRoot "/project/code/public/www"	    #站点目录
    ServerName www.bw.com				#访问域名 
    ServerAlias bw.com				#给虚拟主机增加多个域名，上面网址的别名
    
    # AddType application/x-httpd-php .htm  #添加可以执行php的文件类型，为shtml文件开启SSI，使浏览器能解析，不至于直接输出代码就是指.htm可以解析php

    AddType text/html .shtml

    #为.shtml开启包含（include），在.shtml文件中（如<!--include ……-->）可以引入文件

    AddOutputFilter INCLUDES .shtml

    #映射URL到文件系统的特定区域

    Alias /widget/ E:/project/cankao/code/public/www/widget/
    Alias /section/ E:/project/cankao/code/public/www/section/

    #权限设置，标签中的地址是相对于DocumentRoot的

    <Directory "/">

        参数设置Indexes开启索引，可以在浏览器中显示当前目录文件列表。一般框架中因后台模板不是html的后台虚拟主机不加Includes

        Options -Indexes FollowSymLinks Includes

        #查找打开文件和顺序

        DirectoryIndex index.shtml index.html

        #权限

        Allow from all
    </Directory>
</VirtualHost>
```



### 6.1.3 启用虚拟主机的准备工作

```shell
#安装httpd
yum install httpd -y

#禁用默认的主机模式
vim /etc/httpd/conf/httpd.conf
注释下面这行内容
#DocumentRoot "/var/www/html"
```







## 6.2 基于IP的虚拟主机

### 6.2.1 配置基于IP的虚拟主机

#### 6.2.1.1 为主机添加多个IP

```shell
#查看原有IP
ip a

#手动添加ip（注意添加的ip必须与虚机属于同一网络段L）
ip addr add 10.0.0.30/24 dev eth0
```

#### 6.2.1.2 添加虚拟主机配置文件

```shell
cd /etc/httpd/conf.d/
vim virtualhost.conf
#基于IP的虚拟主机配置
<VirtualHost 10.0.0.21:80>
  DocumentRoot "/var/www/bw"
  ServerName    www.bw.com
</VirtualHost>

<VirtualHost 10.0.0.30:80>
  DocumentRoot "/var/www/wg"
  ServerName    www.wg.com
</VirtualHost>


####创建目录
mkdir -p /var/www/bw
mkdir -p /var/www/wg

####创建测试文件
echo 'this is bw' >>/var/www/bw/index.html
echo 'this is wg' >>/var/www/wg/index.html
```

**测试访问：**














<<<<<<< HEAD
6.1.3 VirtualHost参数的意义





6.2 基于IP的虚拟主机

6.2.1 配置基于IP的虚拟主机



6.3 基于端口的虚拟主机

6.3.1 配置基于端口的虚拟主机



=======



6.3 基于端口的虚拟主机

6.3.1 配置基于端口的虚拟主机

>>>>>>> 3619846f71c9abc32b29669f9641c562931096e6
6.4 基于域名的虚拟主机

6.4.1 配置基于域名的虚拟主机