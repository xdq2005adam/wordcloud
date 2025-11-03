# 🚂 Railway 部署详细教程

## 📋 准备工作

### 1. 确保项目已准备就绪
✅ 项目已配置：
- `server.js` 使用 `process.env.PORT`（Railway 会自动设置）
- `package.json` 有 `start` 脚本
- `Procfile` 已存在（可选）

### 2. 确保代码已推送到 GitHub
如果还没有，请先：
```bash
# 初始化 Git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit"

# 在 GitHub 创建新仓库，然后推送
git remote add origin https://github.com/你的用户名/你的仓库名.git
git branch -M main
git push -u origin main
```

---

## 🚀 Railway 部署步骤（5分钟）

### 步骤 1：注册 Railway 账号

1. **访问** [railway.app](https://railway.app)
2. **点击** "Start a New Project"
3. **选择登录方式**：
   - 推荐：使用 **GitHub** 账号登录（最方便）
   - 或使用邮箱注册

### 步骤 2：创建新项目

1. **登录后**，点击 "**New Project**" 按钮
2. **选择** "**Deploy from GitHub repo**"（从 GitHub 仓库部署）
3. **授权** Railway 访问你的 GitHub（如果第一次使用）
4. **搜索并选择** 你的仓库（例如：`你的用户名/词云`）
5. **点击** 仓库名称

### 步骤 3：自动部署

Railway 会自动：
- ✅ 检测到 Node.js 项目
- ✅ 运行 `npm install` 安装依赖
- ✅ 运行 `npm start` 启动服务
- ✅ 分配一个公共 URL（例如：`xxx.railway.app`）

**等待时间**：约 2-3 分钟

### 步骤 4：查看部署状态

1. **等待部署完成**（页面会显示构建日志）
2. **看到 "Deployment successful"** 表示成功
3. **点击** "Settings" → "Domains"
4. **复制** Railway 生成的域名（例如：`xxx.up.railway.app`）

### 步骤 5：测试访问

1. **打开** Railway 提供的 URL
2. **访问主页面**：`https://xxx.up.railway.app/`
3. **访问输入页面**：`https://xxx.up.railway.app/input.html`
4. **测试功能**：
   - 在输入页面发送消息
   - 在主页面查看词云是否实时更新

---

## 🔧 配置说明

### 端口配置（已自动配置）

你的 `server.js` 已经正确配置：
```javascript
const PORT = process.env.PORT || 3000;
```

Railway 会自动设置 `process.env.PORT`，无需手动配置。

### 环境变量（可选）

如果需要自定义配置，可以：
1. 在 Railway 项目页面点击 "**Variables**"
2. 添加环境变量（例如：`NODE_ENV=production`）

---

## 📝 常见问题排查

### ❌ 问题 1：部署失败

**可能原因**：
- 依赖安装失败
- 代码有错误

**解决方法**：
1. 查看 Railway 的部署日志（Deployments → 点击失败的部署）
2. 检查错误信息
3. 本地测试：`npm install && npm start` 确保能正常运行

### ❌ 问题 2：访问 404

**可能原因**：
- 路由配置问题
- 静态文件路径错误

**解决方法**：
- 检查 `server.js` 中的路由配置
- 确保 `index.html` 和 `input.html` 在项目根目录

### ❌ 问题 3：WebSocket 连接失败

**可能原因**：
- Railway 免费计划可能有限制

**解决方法**：
- 检查浏览器控制台的错误信息
- 确保 Socket.io 配置正确（代码中已配置 CORS）

### ❌ 问题 4：部署后无法访问

**检查清单**：
- [ ] 部署状态是 "Deployed"（绿色）
- [ ] 服务正在运行（Metrics 页面）
- [ ] 域名已生成（Settings → Domains）
- [ ] 尝试访问完整 URL（包括 `https://`）

---

## 🎯 后续操作

### 1. 更新代码后自动部署

Railway 会自动检测 GitHub 推送：
- 推送到 `main` 分支会自动触发重新部署
- 无需手动操作

### 2. 自定义域名（可选）

1. 在 Railway 项目页面 → **Settings** → **Domains**
2. 点击 "**Custom Domain**"
3. 输入你的域名
4. 按照提示配置 DNS 记录

### 3. 查看日志和监控

- **Logs**：实时查看应用日志
- **Metrics**：查看 CPU、内存使用情况

---

## 💰 费用说明

### Railway 免费计划
- ✅ **$5 免费额度/月**（足够小项目使用）
- ✅ 支持 WebSocket
- ✅ 自动 HTTPS
- ✅ 自动部署

### 超出免费额度后
- 按使用量付费（非常便宜）
- 或升级到付费计划

---

## ✅ 部署成功检查清单

部署完成后，请确认：

- [ ] 可以访问主页面（`/`）
- [ ] 可以访问输入页面（`/input.html`）
- [ ] 在输入页面能发送消息
- [ ] 主页面词云能实时更新
- [ ] 二维码能正常显示
- [ ] WebSocket 连接正常（浏览器控制台无错误）

---

## 🎉 恭喜！

如果以上都正常，你的词云应用已经成功部署到 Railway 了！

**下一步**：
- 分享你的 Railway URL 给朋友使用
- 如果需要国内访问更快，可以考虑加 Cloudflare CDN（见 `QUICK_DEPLOY.md`）

---

## 📞 需要帮助？

如果遇到问题：
1. 查看 Railway 的部署日志
2. 检查浏览器控制台的错误
3. 确认代码在本地能正常运行

