#!/bin/sh
# taiji 插件的 hook 入口：找到 taiji 二进制后把 stdin 原样交给 `taiji decide --hook`。
# 查找顺序：$TAIJI_BIN → ~/.local/bin/taiji → /opt/homebrew/bin/taiji → /usr/local/bin/taiji → PATH 里的 taiji。
# 只接受绝对路径：宿主以项目目录为 cwd 运行 hook，PATH 里有 `.` 或空段时不能执行仓库里的同名文件。
# 找不到或不可执行：不输出（宿主按放行处理），只在 stderr 提示一次怎么安装。
bin=""
for cand in "${TAIJI_BIN:-}" "${HOME}/.local/bin/taiji" /opt/homebrew/bin/taiji /usr/local/bin/taiji; do
  case "${cand}" in
    /*) if [ -f "${cand}" ] && [ -x "${cand}" ]; then bin="${cand}"; break; fi ;;
  esac
done
if [ -z "${bin}" ]; then
  # 自己逐段查 PATH，跳过空段与相对目录（`command -v` 会把 `.` 里的命中补成绝对路径，挡不住）。
  old_ifs="${IFS}"
  IFS=:
  for dir in ${PATH:-}; do
    case "${dir}" in
      /*) if [ -f "${dir}/taiji" ] && [ -x "${dir}/taiji" ]; then bin="${dir}/taiji"; break; fi ;;
    esac
  done
  IFS="${old_ifs}"
fi
if [ -z "${bin}" ]; then
  echo "taiji 插件：没找到 taiji 可执行文件，本次不做判断。安装：curl -fsSL https://github.com/WinsPan/taiji-releases/releases/latest/download/install.sh | sh" >&2
  exit 0
fi
exec "${bin}" decide --hook "$@"
