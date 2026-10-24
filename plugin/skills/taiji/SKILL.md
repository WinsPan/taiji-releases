---
name: taiji
description: 把一个需要长时间自主执行、多步工具调用或独立验收的任务交给本机的 Taiji 代理去做，并取回结构化结果；或让 Taiji 对一段内容做本地风险 / 一致性判断。适用：用户说「交给 taiji」「用 taiji 跑」、任务要持续到测试全绿、需要在隔离的工作目录里执行。不适用：一两步就能完成的改动。
disable-model-invocation: false
---

# 用 Taiji 代理执行任务

Taiji 是本机安装的命令行代理（`taiji --version` 可确认）。它有自己的权限闸、沙箱、会话日志与完成门禁，适合把整块任务外包出去。

## 一次性任务（推荐）

```bash
taiji run --json --work-dir <目录> --permission-mode project "<任务描述>"
```
- 输出是逐行 NDJSON：`session`、`status`、`text`、`tool_call`、`tool_result`、`final`、`error`。只取最后一行 `{"type":"final","text":...}` 作为结果；退出码 0 表示完成。
- 要独立验收：加 `--check "<验收命令>"`，Taiji 会一直做到命令通过或达到检查上限。
- 要预算：`--budget-tokens N --budget-minutes N`。
- 不要加 `--yes`；`project` 模式下项目内改动自动放行，跨出目录才会停下来（无人值守时按拒绝处理，并在 `final` 里说明）。

## 长会话 / 多轮

```bash
taiji serve --acp
```
以 Agent Client Protocol v1 对接：`initialize` → `session/new{cwd}` → `session/prompt`，进度在 `session/update`，审批在 `session/request_permission`。

## 本地判断（不联网）

```bash
echo '{"model": "taiji-decide", "state": "<材料>", "questions": {"ok": {"type": "noul", "instructions": "<陈述>"}}}' | taiji decide --jev
```
返回每个问题的概率；也可用内置问题：`taiji decide --state "<材料>" --question done --question consistent`（`taiji decide --list` 列出全部内置问题）。

## 结果处理

把 `final.text` 原样转述给用户，并指出 Taiji 的会话 ID（`session` 事件里的 `session_id`），用户可用 `taiji log <ID>` 回看全过程。
