# xss-audit 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/songjianyang/xss-audit#installation
# 更新日期：2026-11-03
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/songjianyang/xss-audit.git
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Copy-Item -Recurse -Force .\xss-audit "$HOME\.claude\skills\xss-audit"
Write-Host "装好后在 agent 里输入 /xss-audit src/"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/songjianyang/xss-audit#installation'
