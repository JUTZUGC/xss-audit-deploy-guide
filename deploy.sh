#!/usr/bin/env bash
set -euo pipefail
# xss-audit 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/songjianyang/xss-audit#installation
# 更新日期：2026-11-03
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/songjianyang/xss-audit.git
mkdir -p ~/.claude/skills && cp -r xss-audit ~/.claude/skills/xss-audit
echo "装好后在 agent 里输入 /xss-audit src/"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/songjianyang/xss-audit#installation"
