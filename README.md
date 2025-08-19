# 跨平台本地 WebServer

快速搭建可快迁移的本地 WebServer，支持多版本 php，多虚拟主机，多端口。

本项目是基于 [nginx](https://nginx.org/en/) 和 [php](https://www.php.net/) 的本地 WebServer，支持 **Windows** 和 **macOS** 平台。

## 平台支持

- **Windows**: 使用 [winsw](https://github.com/winsw/winsw) 将服务注册为系统服务
- **macOS**: 使用 launchd 进行服务管理

## 快速开始

请根据你的操作系统选择对应的目录：

- **Windows 用户**: 请查看 [windows/](./windows/) 目录
- **macOS 用户**: 请查看 [macOS/](./macOS/) 目录

## 简介

虽然 node / php / python 等都可以快速启动一个 web server。 但是相对来说，功能肯定远不如 nginx。而且 nginx 也是一个跨平台的 web server，所以在本地搭建一个 nginx 服务，可以快速迁移到线上。

### Windows 平台的优势

在 Windows 平台上，相比其他解决方案：

**相比 [XAMPP](https://www.apachefriends.org/zh_cn/index.html):**

1. XAMPP 不能比较方便的支持多个php版本。
2. web 入口我更希望是 nginx，而不是 apache。
3. XAMPP 不能很方便的支持多个虚拟主机，配置形式和线上常用的 宝塔面板等差异较大。

**相比 [phpstudy](https://www.xp.cn/):**

1. 很久没有新的版本的了，不知道还维护与否。
2. 内置的 nginx 版本太旧了，不方便单独升级。

### macOS 平台的优势

在 macOS 平台上，使用系统原生的 launchd 进行服务管理，更加稳定可靠。同时配合 Homebrew 可以非常方便地管理 nginx 和 php 的版本。

## 平台特定说明

### Windows

详细的 Windows 安装和配置说明请查看 [windows/README.md](./windows/README.md)

### macOS

详细的 macOS 安装和配置说明请查看 [macOS/README.md](./macOS/README.md)

## 目录结构

```
.
├── windows/          # Windows 平台专用文件
│   ├── nginx/        # nginx 相关配置和可执行文件
│   ├── php/          # php 相关配置和可执行文件
│   └── root/         # 网站根目录
├── macOS/            # macOS 平台专用文件
│   ├── nginx/        # nginx 相关配置和 launchd plist
│   ├── php/          # php 相关配置和 launchd plist
│   └── root/         # 网站根目录
└── README.md         # 本文件
```
