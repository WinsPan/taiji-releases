#!/bin/sh
# taiji 插件的 hook 入口：找到 taiji 二进制后把 stdin 原样交给 `taiji decide --hook`。
# 查找顺序：$TAIJI_BIN → PATH 里的 taiji → ~/.local/bin/taiji。找不到或不可执行：不输出（宿主按放行处理），
# 只在 stderr 提示一次怎么安装。
bin=""
if [ -n "${TAIJI_BIN:-}" ] && [ -x "${TAIJI_BIN}" ]; then
  bin="${TAIJI_BIN}"
elif command -v taiji >/dev/null 2>&1; then
  bin="$(command -v taiji)"
elif [ -x "${HOME}/.local/bin/taiji" ]; then
  bin="${HOME}/.local/bin/taiji"
fi
if [ -z "${bin}" ]; then
  echo "taiji 插件：没找到 taiji 可执行文件，本次不做判断。安装：curl -fsSL https://github.com/WinsPan/taiji-releases/releases/latest/download/install.sh | sh" >&2
  exit 0
fi
exec "${bin}" decide --hook "$@"
