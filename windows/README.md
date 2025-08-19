# Windows 下的本地 WebServer

快速搭建可快迁移的本地 WebServer，支持多版本 php，多虚拟主机，多端口。

本目录包含 Windows 平台专用的配置文件和可执行文件，使用 [winsw](https://github.com/winsw/winsw) 将 nginx 和 php 注册为系统服务，方便管理。

## nginx

1. 从 [nginx.org](https://nginx.org/en/download.html) 下载你需要的版本，之后解压放在在 nginx 目录下。
2. 修改 conf/nginx.conf 下的配置文件，http节点下添加 `include vhosts/*.conf;`，http 下的 server 节点配置注释或者删除
3. 在 conf/vhosts 目录下添加你的虚拟主机配置文件，参考 [nginx/examples/vhosts/](./nginx/examples/vhosts/)。
4. 修改 [nginx/nginx-server.xml](./nginx/nginx-server.xml) 中启动的注册服务配置。
5. 管理员身份运行 `nginx-server.exe install` 注册为系统服务。

## php

1. 从 [php](https://www.php.net/downloads.php) 下载需要的版本放在 php 目录下。
2. 修改 [php/php-server.xml](./php/php-server.xml) 中启动的版本和端口号。
3. 管理员身份运行 `php-server.exe install` 注册为系统服务。

## 服务管理

### 注册服务
```cmd
# 注册 nginx 服务（管理员权限）
nginx-server.exe install

# 注册 php 服务（管理员权限）
php-server.exe install
```

### 启动/停止服务
```cmd
# 启动服务
net start nginx
net start php-cgi

# 停止服务
net stop nginx
net stop php-cgi
```

### 卸载服务
```cmd
# 停止并卸载 nginx 服务
net stop nginx
nginx-server.exe uninstall

# 停止并卸载 php 服务
net stop php-cgi
php-server.exe uninstall
```

## FAQ

### 如何修改 nginx 配置？
修改 nginx 安装目录下的 conf/nginx.conf 文件，然后重启 nginx 服务。

### 如何添加虚拟主机？
在 nginx/conf/vhosts/ 目录下添加 .conf 文件，参考 examples 目录中的示例。

### 如何切换 PHP 版本？
1. 下载新版本的 PHP 到 php 目录
2. 修改 php-server.xml 中的可执行文件路径
3. 重新安装 php 服务