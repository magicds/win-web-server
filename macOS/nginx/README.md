# nginx 目录

1. 从 [nginx.org](https://nginx.org/en/download.html) 下载你需要的版本，或使用 Homebrew 安装: `brew install nginx`
2. 修改 conf/nginx.conf 下的配置文件，http节点下添加 `include vhosts/*.conf;`，http 下的 server 节点配置注释或者删除
3. 在 conf/vhosts 目录下添加你的虚拟主机配置文件，参考 [examples](./examples/)。
4. 使用 launchd 管理服务:
   - 复制 `com.nginx.plist` 到 `~/Library/LaunchAgents/`
   - 运行 `launchctl load ~/Library/LaunchAgents/com.nginx.plist` 加载服务
   - 运行 `launchctl start com.nginx` 启动服务

## 服务管理命令

```bash
# 启动服务
launchctl start com.nginx

# 停止服务
launchctl stop com.nginx

# 重启服务
launchctl stop com.nginx && launchctl start com.nginx

# 查看服务状态
launchctl list | grep nginx
```