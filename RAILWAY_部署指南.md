# 🚂 Railway 部署完整教程

## 📋 前置准备（已完成 ✅）

- ✅ 项目已推送到 GitHub：`https://github.com/xdq2005adam/wordcloud`
- ✅ `server.js` 已配置 `process.env.PORT`
- ✅ `package.json` 有 `start` 脚本
- ✅ `Procfile` 已存在

---

## 🚀 开始部署（5个步骤）

### 步骤 1：注册 Railway 账号

1. 访问 **[railway.app](https://railway.app)**
2. 点击右上角 **"Start a New Project"** 或 **"Login"**
3. **选择登录方式**：
   - 🎯 **推荐**：点击 **"Login with GitHub"**（使用你的 GitHub 账号）
   - 或使用邮箱注册

> 💡 **提示**：使用 GitHub 登录最方便，因为可以直接连接仓库

---

### 步骤 2：连接 GitHub 仓库

1. 登录后，点击 **"New Project"**（新建项目）
2. 选择 **"Deploy from GitHub repo"**（从 GitHub 仓库部署）
3. 如果是第一次使用，会提示授权 Railway 访问 GitHub：
   - 点击 **"Configure GitHub App"**
   - 选择要授权的仓库（可以选择所有仓库，或只授权 `wordcloud` 仓库）
   - 点击 **"Install"** 完成授权
4. **搜索并选择**你的仓库：`xdq2005adam/wordcloud`
5. 点击仓库名称开始部署

---

### 步骤 3：等待自动部署

Railway 会自动执行以下操作：

1. ✅ **检测项目类型**：自动识别为 Node.js 项目
2. ✅ **安装依赖**：运行 `npm install`
3. ✅ **启动服务**：运行 `npm start`（使用 Procfile 中的配置）
4. ✅ **分配域名**：自动生成一个 `.up.railway.app` 域名

**⏱️ 等待时间**：约 2-3 分钟

你可以看到：
- 📊 **构建日志**：实时显示部署进度
- 📈 **状态指示器**：显示部署状态（Building → Deploying → Deployed）

---

### 步骤 4：获取访问地址

1. 等待部署完成后，会显示 **"Deployment successful"** ✅
2. 在项目页面，找到 **"Settings"**（设置）标签
3. 点击 **"Domains"**（域名）
4. 你会看到一个类似这样的域名：
   ```
   https://你的项目名.up.railway.app
   ```
5. **复制这个域名**，这就是你的应用地址！

---

### 步骤 5：测试访问

1. **打开主页面**：
   ```
   https://你的域名.up.railway.app/
   ```

2. **打开输入页面**：
   ```
   https://你的域名.up.railway.app/input.html
   ```

3. **测试功能**：
   - 📱 在电脑上打开主页面，查看二维码
   - 📲 用手机扫描二维码，打开输入页面
   - ✍️ 在手机上输入文字并发送
   - 🎨 在电脑上查看词云是否实时更新

---

## 🔍 查看部署状态

### 部署日志

- 点击项目中的 **"Deployments"** 标签
- 选择最新的部署记录
- 可以查看完整的构建和运行日志

### 实时日志

- 点击 **"Logs"** 标签
- 实时查看应用运行日志（类似 `console.log` 输出）

### 监控指标

- 点击 **"Metrics"** 标签
- 查看 CPU、内存使用情况

---

## 🔧 配置说明

### 端口配置（已自动配置 ✅）

你的代码已经正确配置：
```javascript
const PORT = process.env.PORT || 3000;
```

Railway 会自动设置 `process.env.PORT`，无需手动配置。

### 环境变量（可选）

如果需要自定义配置：

1. 在 Railway 项目页面，点击 **"Variables"** 标签
2. 点击 **"New Variable"**
3. 添加环境变量，例如：
   - `NODE_ENV` = `production`
   - 其他自定义变量

---

## 📝 常见问题

### ⚠️ **重要：Railway 加载不出 GitHub 仓库？**

**这是最常见的问题！** 快速解决方法：

1. **Railway 右上角头像** → **"Account Settings"**
2. 找到 **"GitHub"** 部分
3. 点击 **"Reconnect"** 或 **"Manage"**
4. 在 GitHub 授权页面，**确保选择了仓库访问权限**
5. 选择 **"Only select repositories"** → 选择 `wordcloud` 仓库
6. 点击 **"Install"** 完成授权
7. 返回 Railway 重试

**详细故障排除指南**：查看 [RAILWAY_故障排除.md](./RAILWAY_故障排除.md) 📖

---

### ❌ 问题 1：部署失败

**症状**：部署状态显示 "Failed"

**解决方法**：
1. 点击失败的部署，查看详细错误日志
2. 常见原因：
   - 依赖安装失败：检查 `package.json` 是否正确
   - 代码错误：在本地运行 `npm start` 测试
   - 端口配置错误：确保使用 `process.env.PORT`

### ❌ 问题 2：访问 404 错误

**症状**：能访问域名，但显示 404

**解决方法**：
- 确保访问的是根路径 `/` 或 `/input.html`
- 检查 `server.js` 中的路由配置是否正确

### ❌ 问题 3：WebSocket 连接失败

**症状**：输入页面能打开，但发送消息后没有反应

**解决方法**：
1. 打开浏览器开发者工具（F12）
2. 查看 Console（控制台）是否有错误
3. 检查 Network（网络）标签，看 WebSocket 连接是否成功
4. Railway 免费计划支持 WebSocket，应该没问题

### ❌ 问题 4：部署后无法访问

**检查清单**：
- [ ] 部署状态是 "Deployed"（绿色✅）
- [ ] 服务正在运行（Metrics 页面显示活动）
- [ ] 域名已生成（Settings → Domains）
- [ ] 尝试访问完整 URL（包括 `https://`）
- [ ] 检查浏览器控制台是否有错误

---

## 🔄 更新代码后重新部署

Railway 支持自动部署：

1. **修改代码**后，提交到 GitHub：
   ```bash
   git add .
   git commit -m "更新说明"
   git push
   ```

2. **Railway 会自动检测** GitHub 推送
3. **自动触发重新部署**（约 2-3 分钟）
4. 无需手动操作！🎉

---

## 💰 费用说明

### Railway 免费计划

- ✅ **$5 免费额度/月**
- ✅ 足够小项目使用（每天运行几小时没问题）
- ✅ 支持 WebSocket
- ✅ 自动 HTTPS 证书
- ✅ 自动部署
- ✅ 无需信用卡

### 超出免费额度后

- 按实际使用量付费（非常便宜）
- 或升级到付费计划（$20/月起）

---

## ✅ 部署成功检查清单

部署完成后，请确认：

- [ ] ✅ 可以访问主页面（`/`）
- [ ] ✅ 可以访问输入页面（`/input.html`）
- [ ] ✅ 二维码能正常显示
- [ ] ✅ 在输入页面能发送消息
- [ ] ✅ 主页面词云能实时更新
- [ ] ✅ WebSocket 连接正常（浏览器控制台无错误）
- [ ] ✅ 手机扫码后能正常访问

---

## 🎉 部署完成！

恭喜！你的词云应用已经成功部署到 Railway 了！

**现在你可以：**
- 🌐 分享你的 Railway URL 给任何人使用
- 📱 在任何地方用手机扫码输入内容
- 🎨 实时查看词云更新

**下一步建议：**
- 如果需要自定义域名，可以在 Settings → Domains 中配置
- 如果需要国内访问更快，可以考虑使用 Cloudflare CDN

---

## 📞 需要帮助？

如果遇到问题：

1. **查看 Railway 部署日志**：Deployments → 点击失败的部署
2. **查看应用日志**：Logs 标签
3. **检查浏览器控制台**：F12 → Console
4. **本地测试**：确保 `npm start` 能在本地正常运行

---

## 📸 部署步骤截图提示

如果你需要更详细的指导，可以：

1. 访问 [Railway 官方文档](https://docs.railway.app)
2. 查看 Railway 控制台的每个页面
3. 所有操作都有清晰的按钮和提示

**祝你部署顺利！** 🚀

