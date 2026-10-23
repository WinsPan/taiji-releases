# taiji

本地智能体命令行。这个仓库只放预编译的发布件。

## 安装

```sh
curl -fsSL https://github.com/WinsPan/taiji-releases/releases/latest/download/install.sh | sh
```

目前提供 Apple 芯片（M 系列）的 macOS 版本，装到 `~/.local/bin`。可用 `TAIJI_INSTALL_DIR` 改目录、
`TAIJI_VERSION=v0.1.0` 指定版本、`TAIJI_DOWNLOAD_BASE` 换镜像地址。

## 开始

```sh
taiji          # 第一次会引导你接入模型：ChatGPT 账号登录，或 API key（Anthropic / OpenAI 兼容）
taiji setup    # 重新配置、再加一个提供方
taiji update   # 升级到最新版（--check 只检查）
```

## 校验

每个包旁边有同名 `.sha256`，安装脚本会自动校验。