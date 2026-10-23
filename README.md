# taiji

本地智能体命令行。这个仓库只放预编译的发布件。

## 安装

```sh
curl -fsSL https://github.com/WinsPan/taiji-releases/releases/latest/download/install.sh | sh
```

目前提供 Apple 芯片（M 系列）的 macOS 版本，装到 `~/.local/bin`。可用 `TAIJI_INSTALL_DIR` 改目录、
`TAIJI_VERSION=v0.1.0` 指定版本、`TAIJI_DOWNLOAD_BASE` 换镜像地址。升级就再执行一次安装命令。

## 接入模型（三选一）

```sh
taiji auth login     # 用 ChatGPT 账号登录（已登录 Codex 的机器会自动沿用）
taiji providers add <名字> --type anthropic|openai --base-url <地址> --api-key <KEY>
export TAIJI_API_KEY=…   # OpenAI 兼容接口
```

然后运行 `taiji` 进入交互界面，`taiji --help` 查看全部命令。

## 校验

每个包旁边有同名 `.sha256`，安装脚本会自动校验。