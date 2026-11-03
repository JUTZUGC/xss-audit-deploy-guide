# xss-audit 一键安装指南

> 第三方部署指南 · 非 xss-audit 官方仓库。官方项目：[songjianyang/xss-audit](https://github.com/songjianyang/xss-audit)
> 内容来自官方文档（2026-11-03）。项目迭代快，请以[官方文档](https://github.com/songjianyang/xss-audit#installation)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 这是静态审计技能，不是扫描服务。它只读代码，不运行应用，也不能证明漏洞可利用；报告里的结论需要人工复核。需要 Claude Code、Cursor、Copilot、Windsurf 或 Cline 等支持技能的客户端。审计结果写到项目根目录的 `xss-audit-report.md`。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/xss-audit-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会把技能目录复制进 agent 的 skills 目录，随后可直接调用，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## xss-audit 是什么？

xss-audit 是开源的让 agent 按 14 层检查把前端代码里的 XSS 入口翻一遍，再出报告（协议：MIT，<img src="https://img.shields.io/github/stars/songjianyang/xss-audit?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

针对 React、TypeScript 与 JavaScript 项目的静态 XSS 审计：覆盖 SVG、MathML、CSS 注入、Markdown 管线、mXSS、JSON-in-script、URL 校验与 Trusted Types 等 14 层检查。

- 14 层检查，覆盖常见绕过面
- 只读代码，不改项目
- 支持 React 与 TypeScript
- 输出带严重级别的 Markdown 报告
- 区分已执行与理论步骤
- MIT，可改

（来源：[官方仓库](https://github.com/songjianyang/xss-audit)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 547 stars | 名称搜索 17 条（每页 20 条时一页） |
| 14 层检查覆盖全面 | — |
| 只读代码 | 风险低 |
| 输出结构化报告 | — |
| 支持主流前端技术栈 | — |
| MIT | 可扩展 |

| 需要注意 | 说明 |
|---|---|
| 只做静态分析 | — |
| 不能证明漏洞可利用 | — |
| 需要支持技能的客户端 | — |
| 大仓库耗时 | — |
| 项目很新 | 检查项可能变 |

> 以上基于官方文档与社区反馈整理（2026-11-03），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/songjianyang/xss-audit.git
mkdir -p ~/.claude/skills && cp -r xss-audit ~/.claude/skills/xss-audit
echo "装好后在 agent 里输入 /xss-audit src/"
```

部署步骤来源：[https://github.com/songjianyang/xss-audit#installation](https://github.com/songjianyang/xss-audit#installation)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 14 层检查、安装方式与报告输出 | 已核对 2026-11-03 |
| 未实测安装与审计 | 说明 2026-11-03 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-03 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-03 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

以 Agent Skill 形式接入，本身不含 MCP；本仓库的 MCP 只提供安装步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-03）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\xss-audit-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 怎么用

```text
/xss-audit
/xss-audit src/
```

技能会读代码并在项目根目录写 `xss-audit-report.md`，同名文件已存在时自动加时间戳。

## 报告内容

| 部分 | 说明 |
|---|---|
| 摘要 | 严重级别数量与待人工复核项 |
| 发现 | 高/中/低危，附证据 |
| 复现说明 | 区分理论步骤与实际执行 |

## 注意

- 静态审计不等于漏洞可利用
- 只覆盖前端代码，后端与运行时不在范围
- 报告要人工复核后再修复
- 大仓库耗时长，可只传子目录
- MIT，可自行扩展检查层

## 常见坑

- 技能找不到：确认目录名与 skills 路径
- 没有报告：检查当前目录是否可写
- 误报多：按证据逐条复核，别直接改
- 扫描太慢：先只传 `src/` 子目录
- 漏掉后端：本技能只覆盖前端代码
- 报告覆盖旧文件：会自动加时间戳，注意找最新

## 免责声明

本仓库为第三方指南，与 xss-audit 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-03），项目迭代快，请以[官方文档](https://github.com/songjianyang/xss-audit#installation)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
