# macOS 下的本地 WebServer

快速搭建可快迁移的本地 WebServer，支持多版本 php，多虚拟主机，多端口。

本目录包含 macOS 平台专用的配置文件，使用 launchd 进行服务管理。

## 环境要求

- macOS 10.10+ 
- Homebrew (推荐安装方式)

## 快速安装

我们提供了自动安装脚本，一键完成环境搭建：

```bash
cd macOS
chmod +x setup.sh
./setup.sh
```

该脚本会自动：
- 安装 Homebrew（如果未安装）
- 安装 nginx 和 php
- 创建必要的目录结构
- 设置正确的权限
- 复制配置文件
- 启动服务

## 手动安装

### 使用 Homebrew（推荐）

```bash
# 安装 nginx
brew install nginx

# 安装 php
brew install php

# 启动服务
brew services start nginx
brew services start php
```

### 手动安装

如果不使用 Homebrew，也可以手动下载安装：

1. 从 [nginx.org](https://nginx.org/en/download.html) 下载 nginx
2. 从 [php.net](https://www.php.net/downloads.php) 下载 php

## nginx 配置

1. 修改 nginx 配置文件（通常在 `/usr/local/etc/nginx/nginx.conf`）
2. 在 http 节点下添加 `include vhosts/*.conf;`
3. 在 `/usr/local/etc/nginx/vhosts/` 目录下添加虚拟主机配置，参考 [nginx/examples/vhosts/](./nginx/examples/vhosts/)
4. 使用提供的 launchd 配置管理服务

## php 配置

1. 配置 PHP-FPM（配置文件通常在 `/usr/local/etc/php/php-fpm.conf`）
2. 确保 PHP-FPM 监听 127.0.0.1:9000（与 nginx 配置匹配）
3. 使用提供的 launchd 配置管理服务

## 服务管理

### 使用 Homebrew Services（推荐）

```bash
# 启动服务
brew services start nginx
brew services start php

# 停止服务
brew services stop nginx
brew services stop php

# 重启服务
brew services restart nginx
brew services restart php

# 查看服务状态
brew services list | grep nginx
brew services list | grep php
```

### 使用 launchd（手动方式）

```bash
# 复制 plist 文件到 LaunchAgents
cp nginx/com.nginx.plist ~/Library/LaunchAgents/
cp php/com.php-fpm.plist ~/Library/LaunchAgents/

# 加载服务
launchctl load ~/Library/LaunchAgents/com.nginx.plist
launchctl load ~/Library/LaunchAgents/com.php-fpm.plist

# 启动服务
launchctl start com.nginx
launchctl start com.php-fpm

# 停止服务
launchctl stop com.nginx
launchctl stop com.php-fpm

# 卸载服务
launchctl unload ~/Library/LaunchAgents/com.nginx.plist
launchctl unload ~/Library/LaunchAgents/com.php-fpm.plist
```

## 目录结构

```
/usr/local/var/www/          # 网站根目录
├── default/                 # 默认站点
├── site1.local/             # 站点1
└── site2.local/             # 站点2

/usr/local/etc/nginx/        # nginx 配置目录
├── nginx.conf               # 主配置文件
└── vhosts/                  # 虚拟主机配置目录

/usr/local/var/log/nginx/    # nginx 日志目录
```

## FAQ

### 如何修改 nginx 配置？
修改 `/usr/local/etc/nginx/nginx.conf` 文件，然后重启 nginx 服务。

### 如何添加虚拟主机？
在 `/usr/local/etc/nginx/vhosts/` 目录下添加 .conf 文件，参考 examples 目录中的示例。

### 如何切换 PHP 版本？
```bash
# 使用 Homebrew 安装多个版本
brew install php@7.4 php@8.0 php@8.1

# 切换版本
brew unlink php
brew link php@8.0

# 重启 php 服务
brew services restart php
```

### 权限问题
如果遇到权限问题，确保相关目录有正确的权限：
```bash
sudo chown -R $(whoami):staff /usr/local/var/www
sudo chown -R $(whoami):staff /usr/local/var/log/nginx
```