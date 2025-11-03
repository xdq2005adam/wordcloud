# 🚂 Railway 快速开始（1分钟）

## 超简单三步走

### 1️⃣ 准备 GitHub 仓库
```bash
# 如果还没推送到 GitHub
git add .
git commit -m "准备部署"
git push
```

### 2️⃣ 在 Railway 部署
1. 访问 [railway.app](https://railway.app)
2. 用 GitHub 登录
3. 点击 "New Project" → "Deploy from GitHub repo"
4. 选择你的仓库
5. 等待 2-3 分钟

### 3️⃣ 获取 URL
1. 部署完成后，点击 "Settings" → "Domains"
2. 复制 URL（例如：`xxx.up.railway.app`）
3. 访问测试！

---

## ✅ 一键检查清单

部署前确认：
- [ ] 代码已推送到 GitHub
- [ ] `server.js` 使用 `process.env.PORT`（已配置 ✅）
- [ ] `package.json` 有 `start` 脚本（已配置 ✅）

部署后测试：
- [ ] 能访问主页面 `/`
- [ ] 能访问输入页面 `/input.html`
- [ ] 能发送消息并看到词云更新

---

## 📖 详细教程

需要更详细的步骤？查看 [RAILWAY_DEPLOY.md](./RAILWAY_DEPLOY.md)

---

## 🆘 遇到问题？

1. **部署失败** → 查看 Railway 日志
2. **无法访问** → 确认部署状态是 "Deployed"
3. **WebSocket 错误** → 检查浏览器控制台

---

**就是这么简单！🎉**

