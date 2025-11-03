# 🚀 快速部署指南

## 方案一：Railway 部署（5分钟上手）⭐

### 步骤：
1. **访问** [railway.app](https://railway.app) 并注册（使用 GitHub 账号）
2. **点击** "New Project" → "Deploy from GitHub repo"
3. **选择** 你的仓库
4. **等待** 自动部署完成（约 2-3 分钟）
5. **获取** 部署后的 URL，即可访问

### 优点：
- ✅ 完全免费（每月 $5 免费额度）
- ✅ 支持 WebSocket
- ✅ 自动 HTTPS
- ✅ 零配置

### 访问速度：
- 在中国访问可能稍慢，但可用
- 可通过 Cloudflare CDN 加速

---

## 方案二：Render 部署（5分钟上手）

### 步骤：
1. **访问** [render.com](https://render.com) 并注册
2. **点击** "New" → "Web Service"
3. **连接** GitHub 仓库
4. **配置**：
   - Build Command: `npm install`
   - Start Command: `npm start`
5. **选择** Free Plan
6. **部署**

### 注意：
⚠️ 免费计划会在 15 分钟无活动后休眠，首次访问需要等待唤醒

---

## 方案三：腾讯云服务器（国内访问最快）🔥

### 步骤：
1. **购买** 腾讯云轻量应用服务器（最低配置，约 24 元/月）
2. **选择** 国内地域（北京/上海/广州）
3. **SSH 连接** 服务器
4. **运行部署脚本**：
   ```bash
   # 安装 Node.js
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   source ~/.bashrc
   nvm install 18
   
   # 安装 PM2
   npm install -g pm2
   
   # 克隆或上传项目
   git clone <your-repo-url>
   cd 词云
   
   # 安装依赖并启动
   npm install
   pm2 start server.js --name wordcloud
   pm2 save
   pm2 startup
   ```
5. **开放端口**：在腾讯云控制台开放 3000 端口
6. **访问**：`http://你的服务器IP:3000`

### 优点：
- ✅ 国内访问速度极快
- ✅ 稳定可靠
- ✅ 支持 WebSocket

---

## 方案四：Cloudflare 加速（CDN + Tunnel）⚡

### ⚠️ 重要说明：

**Cloudflare 不能直接托管此项目！** 原因：
- ❌ **Cloudflare Pages** - 只支持静态网站，不支持 Node.js 服务器
- ❌ **Cloudflare Workers** - 需要完全重写代码（不能用 Express.js），Socket.io 可能不兼容
- ✅ **Cloudflare CDN + Tunnel** - 可以作为加速方案，配合其他平台使用

### 推荐用法：Cloudflare 作为加速层

将应用部署在 **Railway/Render/腾讯云**，然后用 Cloudflare 加速：

#### 方案 A：使用 Cloudflare CDN（需要域名）

1. **部署应用**：先在 Railway/Render/腾讯云部署
2. **添加域名**：在 Cloudflare 控制台添加你的域名
3. **配置 DNS**：添加 A 记录或 CNAME 指向你的应用服务器
4. **启用代理**：开启橙色云朵（代理模式）
5. **自动加速**：Cloudflare 会自动提供：
   - ✅ 全球 CDN 加速
   - ✅ 免费 HTTPS/SSL
   - ✅ DDoS 防护
   - ✅ WebSocket 支持（通过代理）

#### 方案 B：使用 Cloudflare Tunnel（无需公网 IP）

1. **安装 cloudflared**：
   ```bash
   # Linux
   curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared
   chmod +x /usr/local/bin/cloudflared
   
   # 或在服务器上运行
   cloudflared tunnel --url http://localhost:3000
   ```
2. **获取隧道 URL**：会得到一个 `*.trycloudflare.com` 的临时 URL
3. **优点**：
   - ✅ 无需公网 IP
   - ✅ 自动 HTTPS
   - ✅ 支持 WebSocket

### 适用场景：
- ✅ 已有域名，想加速访问
- ✅ 想获得免费 HTTPS 和 CDN
- ✅ 需要 DDoS 防护
- ❌ 不适合：直接托管 Node.js 应用

---

## 🎯 推荐选择

| 方案 | 费用 | 国内速度 | 难度 | 推荐度 |
|------|------|----------|------|--------|
| Railway | 免费 | ⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ |
| Render | 免费 | ⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐ |
| 腾讯云 | 24元/月 | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Cloudflare CDN | 免费 | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐（作为加速层） |

**如果预算有限：** 选择 Railway  
**如果需要国内访问快：** 选择腾讯云

---

## 📝 部署后检查清单

- [ ] 服务正常启动
- [ ] 可以访问主页面（`/`）
- [ ] 可以访问输入页面（`/input.html`）
- [ ] WebSocket 连接正常（发送消息后词云能更新）
- [ ] 二维码能正常显示

---

## 🆘 常见问题

### Q: Railway/Render 部署后无法访问？
A: 检查端口配置，确保使用 `process.env.PORT`（代码中已配置）

### Q: WebSocket 连接失败？
A: 确保部署平台支持 WebSocket（Railway 和 Render 都支持）

### Q: 国内访问很慢？
A: 考虑使用腾讯云服务器，或通过 Cloudflare CDN 加速（需要域名）

### Q: 可以用 Cloudflare 直接部署吗？
A: 不可以。Cloudflare Pages 只支持静态网站，Workers 需要完全重写代码。建议先用 Railway/Render 部署，再用 Cloudflare CDN 加速。

### Q: 服务会自动停止？
A: Render 免费计划会休眠，Railway 不会。建议使用 Railway 或付费方案。

