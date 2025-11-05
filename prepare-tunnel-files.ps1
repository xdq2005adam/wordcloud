# Cloudflare Tunnel 文件准备脚本（Windows PowerShell）
# 使用方法：在 PowerShell 中运行：.\prepare-tunnel-files.ps1

Write-Host "🚀 Cloudflare Tunnel 文件准备脚本" -ForegroundColor Green
Write-Host ""

# 检查是否在项目目录
if (-not (Test-Path "server.js")) {
    Write-Host "❌ 错误：请在项目根目录运行此脚本！" -ForegroundColor Red
    exit 1
}

# 1. 获取隧道 ID
Write-Host "步骤 1：输入你的隧道 ID" -ForegroundColor Yellow
$tunnelId = Read-Host "请输入隧道 ID（格式：xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx）"

if (-not $tunnelId -or $tunnelId -notmatch '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$') {
    Write-Host "❌ 隧道 ID 格式不正确！" -ForegroundColor Red
    exit 1
}

# 2. 获取域名
Write-Host ""
Write-Host "步骤 2：输入你的免费域名" -ForegroundColor Yellow
$hostname = Read-Host "请输入域名（例如：wordcloud-app.trycloudflare.com）"

if (-not $hostname -or $hostname -notmatch '\.trycloudflare\.com$') {
    Write-Host "❌ 域名必须是 .trycloudflare.com 结尾！" -ForegroundColor Red
    exit 1
}

# 3. 获取 Railway URL
Write-Host ""
Write-Host "步骤 3：输入你的 Railway URL" -ForegroundColor Yellow
$railwayUrl = Read-Host "请输入 Railway URL（例如：https://web-production-27bb4.up.railway.app）"

if (-not $railwayUrl -or $railwayUrl -notmatch '^https://') {
    Write-Host "⚠️  警告：Railway URL 应该是 HTTPS！" -ForegroundColor Yellow
}

# 4. 查找认证文件
Write-Host ""
Write-Host "步骤 4：查找认证文件..." -ForegroundColor Yellow
$credentialsPath = "$env:USERPROFILE\.cloudflared\$tunnelId.json"

if (-not (Test-Path $credentialsPath)) {
    Write-Host "❌ 找不到认证文件：$credentialsPath" -ForegroundColor Red
    Write-Host "请确认："
    Write-Host "  1. 你已经运行了 'cloudflared tunnel login'"
    Write-Host "  2. 你已经运行了 'cloudflared tunnel create wordcloud'"
    Write-Host "  3. 隧道 ID 正确"
    exit 1
}

Write-Host "✅ 找到认证文件：$credentialsPath" -ForegroundColor Green

# 5. 创建 config.yml
Write-Host ""
Write-Host "步骤 5：创建 config.yml..." -ForegroundColor Yellow

$configContent = @"
tunnel: $tunnelId
credentials-file: /etc/cloudflared/credentials.json

ingress:
  - hostname: $hostname
    service: $railwayUrl
  
  - service: http_status:404
"@

$configContent | Out-File -FilePath "config.yml" -Encoding UTF8
Write-Host "✅ 已创建 config.yml" -ForegroundColor Green

# 6. 复制认证文件
Write-Host ""
Write-Host "步骤 6：复制认证文件..." -ForegroundColor Yellow
Copy-Item $credentialsPath -Destination "credentials.json" -Force
Write-Host "✅ 已复制认证文件为 credentials.json" -ForegroundColor Green

# 7. 检查 Dockerfile.tunnel
if (-not (Test-Path "Dockerfile.tunnel")) {
    Write-Host ""
    Write-Host "⚠️  警告：Dockerfile.tunnel 不存在！" -ForegroundColor Yellow
    Write-Host "请确保 Dockerfile.tunnel 文件存在。" -ForegroundColor Yellow
}

# 完成
Write-Host ""
Write-Host "✅ 文件准备完成！" -ForegroundColor Green
Write-Host ""
Write-Host "准备上传到 Railway 的文件："
Write-Host "  - config.yml" -ForegroundColor Cyan
Write-Host "  - credentials.json" -ForegroundColor Cyan
Write-Host "  - Dockerfile.tunnel" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  安全提示：credentials.json 包含敏感信息，请确保："
Write-Host "  1. 不要上传到公开的 Git 仓库"
Write-Host "  2. 使用私有仓库或 Railway 环境变量"
Write-Host ""
Write-Host "下一步：参考 RAILWAY_TUNNEL_部署.md 进行部署"

