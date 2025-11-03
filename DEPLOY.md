# 部署指南 - 词云项目

本项目需要 Node.js 后端和 WebSocket 支持，以下是适合在中国访问的免费/低成本部署方案：

## 🚀 推荐方案（按优先级排序）

### 方案一：Railway（推荐）⭐
**优点：** 免费额度充足，支持 WebSocket，部署简单，全球访问
**缺点：** 在中国访问可能较慢（可通过 CDN 加速）

**部署步骤：**
1. 访问 [Railway.app](https://railway.app)
2. 使用 GitHub 账号登录
3. 点击 "New Project" → "Deploy from GitHub repo"
4. 选择你的仓库
5. Railway 会自动检测 Node.js 项目并部署
6. 设置环境变量（如需要）
7. 部署完成后获得公网 URL

**费用：** 每月 $5 免费额度（通常足够小型项目使用）

---

### 方案二：Render ⭐
**优点：** 免费额度，支持 WebSocket，部署简单
**缺点：** 在中国访问可能较慢

**部署步骤：**
1. 访问 [Render.com](https://render.com)
2. 使用 GitHub 账号登录
3. 点击 "New" → "Web Service"
4. 连接 GitHub 仓库
5. 配置：
   - Build Command: `npm install`
   - Start Command: `npm start`
6. 选择免费计划
7. 部署

**费用：** 免费计划可用，但服务会在 15 分钟无活动后休眠

---

### 方案三：腾讯云轻量应用服务器（国内访问最佳）🔥
**优点：** 国内访问速度快，稳定，支持 WebSocket
**缺点：** 需要付费（但价格较低），需要备案

**部署步骤：**
1. 访问 [腾讯云轻量应用服务器](https://cloud.tencent.com/product/lighthouse)
2. 购买最低配置（约 24-30 元/月）
3. 选择国内地域（如北京、上海）
4. SSH 连接服务器
5. 安装 Node.js：
   ```bash
   # 使用 nvm 安装 Node.js
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install 18
   ```
6. 上传项目文件或使用 Git 克隆
7. 安装依赖：`npm install`
8. 使用 PM2 运行：
   ```bash
   npm install -g pm2
   pm2 start server.js --name wordcloud
   pm2 save
   pm2 startup
   ```
9. 配置防火墙开放端口（3000）
10. 如需域名访问，需要备案

**费用：** 约 24-30 元/月

---

### 方案四：阿里云函数计算（Serverless）
**优点：** 按量付费，有免费额度，国内访问快
**缺点：** WebSocket 支持需要配置，相对复杂

**适用场景：** 适合有一定技术基础的用户

---

### 方案五：Vercel + Socket.io（不推荐）
**注意：** Vercel 不支持传统 WebSocket，需要使用 Serverless Functions，配置复杂

---

## 🛠️ 部署前准备

### 1. 创建部署配置文件

#### Railway/Render 需要的配置：

创建 `Procfile` 文件：
```
web: node server.js
```

#### 确保 package.json 有正确的启动脚本：
```json
{
  "scripts": {
    "start": "node server.js"
  }
}
```

### 2. 环境变量配置

如果部署平台支持，可以设置：
- `PORT`: 服务器端口（Railway/Render 会自动设置）

### 3. 确保依赖正确

检查 `package.json` 中的依赖是否完整：
- express
- socket.io
- 其他必需依赖

---

## 📝 部署后优化（针对国内访问）

### 使用 Cloudflare CDN 加速（适用于 Railway/Render）

1. 注册 [Cloudflare](https://cloudflare.com)
2. 添加你的域名
3. 修改 DNS 设置，指向 Railway/Render 的 URL
4. 启用 Cloudflare 的 CDN 加速

**注意：** WebSocket 需要启用 Cloudflare 的 WebSocket 支持

---

## 🎯 快速部署脚本（适合腾讯云服务器）

创建 `deploy.sh` 脚本：

```bash
#!/bin/bash
# 安装 Node.js (使用 nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 18
nvm use 18

# 安装 PM2
npm install -g pm2

# 安装项目依赖
npm install

# 启动服务
pm2 start server.js --name wordcloud
pm2 save
pm2 startup
```

---

## 💡 推荐选择

**如果预算有限：** Railway（免费额度充足）
**如果需要国内访问快：** 腾讯云轻量应用服务器（24-30元/月）
**如果需要快速测试：** Render（免费计划，但会休眠）

---

## 📞 需要帮助？

如果部署过程中遇到问题，可以：
1. 检查服务器日志
2. 确认端口是否正确开放
3. 检查防火墙设置
4. 验证 Node.js 版本（建议使用 Node.js 16+）

