# Git 初始化脚本 - 只在词云项目目录初始化
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

# 删除可能存在的错误 Git 仓库
if (Test-Path "node_modules\qrcode\.git") {
    Remove-Item "node_modules\qrcode\.git" -Recurse -Force
    Write-Host "已删除 node_modules/qrcode/.git"
}

# 如果当前目录已经有 .git，先检查
if (Test-Path ".git") {
    $gitRoot = git rev-parse --show-toplevel 2>$null
    if ($gitRoot -and $gitRoot -ne $projectPath) {
        Write-Host "发现错误的 Git 仓库位置，正在清理..."
        Remove-Item ".git" -Recurse -Force
    }
}

# 初始化 Git（如果还没有）
if (-not (Test-Path ".git")) {
    git init
    git branch -M main
    Write-Host "Git 仓库已初始化"
}

# 添加文件
git add .

# 检查状态
Write-Host "`nGit 状态："
git status --short

Write-Host "`n准备提交..."
git commit -m "Initial commit: 词云项目 - 支持实时词云生成和WebSocket通信"

Write-Host "`n✅ Git 初始化完成！"
Write-Host "下一步：在 GitHub 创建仓库后运行："
Write-Host "  git remote add origin https://github.com/你的用户名/仓库名.git"
Write-Host "  git push -u origin main"

