# macOS Web Root 目录

此目录用于存放网站文件。

默认路径: `/usr/local/var/www/`

## 创建目录结构

```bash
# 创建默认网站根目录
sudo mkdir -p /usr/local/var/www/default

# 设置权限
sudo chown -R $(whoami):staff /usr/local/var/www

# 创建测试页面
echo "<?php phpinfo(); ?>" > /usr/local/var/www/default/index.php
echo "<h1>Hello from macOS Web Server!</h1>" > /usr/local/var/www/default/index.html
```

## 虚拟主机

可以在 `/usr/local/var/www/` 下创建多个目录，对应不同的虚拟主机:

```
/usr/local/var/www/
├── default/          # 默认站点
├── site1.local/      # 站点1
├── site2.local/      # 站点2
└── ...
```

在 nginx 的 vhosts 配置中指向对应的目录即可。