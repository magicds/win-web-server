# php 目录

1. 安装 PHP，推荐使用 Homebrew: `brew install php`
2. 或者从 [php.net](https://www.php.net/downloads.php) 下载需要的版本手动安装
3. 使用 launchd 管理 PHP-FPM 服务:
   - 复制 `com.php-fpm.plist` 到 `~/Library/LaunchAgents/`
   - 运行 `launchctl load ~/Library/LaunchAgents/com.php-fpm.plist` 加载服务
   - 运行 `launchctl start com.php-fpm` 启动服务

## 服务管理命令

```bash
# 启动服务
launchctl start com.php-fpm

# 停止服务
launchctl stop com.php-fpm

# 重启服务
launchctl stop com.php-fpm && launchctl start com.php-fpm

# 查看服务状态
launchctl list | grep php-fpm

# 查看 PHP-FPM 进程
ps aux | grep php-fpm
```

## 配置说明

PHP-FPM 默认监听 127.0.0.1:9000，与 nginx 配置保持一致。

可以通过修改 `/usr/local/etc/php/php-fpm.d/www.conf` 来调整配置。