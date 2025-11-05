# Railway Tunnel 部署指南（快速参考）

## 快速部署步骤

### 1. 在本地完成 Tunnel 创建和配置

参考 `CLOUDFLARE_免费二级域名教程.md` 的步骤 1-6，完成：
- ✅ 注册 Cloudflare 账号
- ✅ 安装 cloudflared
- ✅ 登录 Cloudflare
- ✅ 创建隧道
- ✅ 创建路由（获得免费域名）
- ✅ 创建配置文件

### 2. 准备文件上传到 Railway

#### 文件 1：修改 config.yml

将本地的 `~/.cloudflared/config.yml` 复制到项目根目录，并修改：

```yaml
tunnel: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # 你的隧道 ID
credentials-file: /etc/cloudflared/credentials.json  # Railway 路径

ingress:
  - hostname: wordcloud-app.trycloudflare.com  # 你的域名
    service: https://web-production-27bb4.up.railway.app  # 你的 Railway URL
  - service: http_status:404
```

#### 文件 2：复制认证文件

**Windows PowerShell:**
```powershell
# 找到你的认证文件（文件名是你的隧道ID.json）
# 例如：C:\Users\你的用户名\.cloudflared\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json

# 复制到项目目录并重命名为 credentials.json
Copy-Item "$env:USERPROFILE\.cloudflared\你的隧道ID.json" -Destination "credentials.json"
```

**macOS/Linux:**
```bash
# 找到你的认证文件（文件名是你的隧道ID.json）
# 例如：~/.cloudflared/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json

# 复制到项目目录并重命名为 credentials.json
cp ~/.cloudflared/你的隧道ID.json credentials.json
```

#### 文件 3：Dockerfile.tunnel

已经创建好了 `Dockerfile.tunnel`，不需要修改。

### 3. 在 Railway 上部署

#### 方法 A：使用 Railway Web 界面

1. 登录 Railway：https://railway.app
2. 在你的项目中点击 **"New"** → **"Empty Service"**
3. 命名为：`cloudflare-tunnel`
4. 点击 **"Settings"** → **"Source"**
5. 选择 **"Deploy from GitHub repo"** 或 **"Deploy from local directory"**
6. 上传以下文件：
   - `Dockerfile.tunnel`
   - `config.yml`
   - `credentials.json`
7. Railway 会自动检测 Dockerfile 并开始部署
8. 等待部署完成（2-5 分钟）

#### 方法 B：使用 Git

1. 将文件添加到 Git：
   ```bash
   git add Dockerfile.tunnel config.yml credentials.json
   git commit -m "Add Cloudflare Tunnel"
   git push
   ```

2. 在 Railway 中：
   - 点击 **"New"** → **"Empty Service"**
   - 选择 **"Deploy from GitHub repo"**
   - 选择你的仓库
   - Railway 会自动检测并部署

### 4. 验证部署

1. 查看 Railway 日志：
   - 打开服务 → **"Deployments"** → **"View Logs"**
   - 应该看到：`✅ Tunnel is running`

2. 访问你的域名：
   - `https://wordcloud-app.trycloudflare.com`
   - 应该能看到你的应用

3. 测试 WebSocket：
   - 打开浏览器开发者工具（F12）
   - 访问主页面
   - 应该看到：`✓ WebSocket连接成功！`

## 重要提示

⚠️ **安全警告：**
- `credentials.json` 包含你的账户认证信息
- **不要**上传到公开的 Git 仓库
- 如果使用 Git，确保仓库是私有的，或使用 Railway 的环境变量

## 故障排除

如果部署失败：
1. 检查 `config.yml` 中的路径是否正确（`/etc/cloudflared/credentials.json`）
2. 检查 `credentials.json` 文件是否已上传
3. 检查 Railway URL 是否正确（必须是 HTTPS）
4. 查看 Railway 日志获取详细错误信息

## 相关文件

- `CLOUDFLARE_免费二级域名教程.md` - 完整详细教程
- `Dockerfile.tunnel` - Docker 配置文件
- `config.yml.example` - 配置文件示例

