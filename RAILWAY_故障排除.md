# 🔧 Railway 无法加载 GitHub 仓库 - 故障排除指南

## 🎯 问题：Railway 加载不出 GitHub 仓库

这是最常见的问题之一，通常与 GitHub 授权有关。按照以下步骤逐一排查：

---

## ✅ 解决方案 1：重新授权 GitHub App（最常见）

### 步骤：

1. **访问 Railway 设置**
   - 登录 [railway.app](https://railway.app)
   - 点击右上角头像 → **"Account Settings"**（账户设置）
   - 或访问：https://railway.app/account

2. **检查 GitHub 连接**
   - 在 Account Settings 页面，找到 **"GitHub"** 部分
   - 查看是否显示 "Connected"（已连接）

3. **重新授权**
   - 如果显示 "Disconnect"（断开连接），点击它
   - 然后点击 **"Connect GitHub"** 重新连接
   - 如果已连接，点击 **"Reconnect"** 或 **"Manage"**

4. **授权 Railway 访问仓库**
   - 会跳转到 GitHub 授权页面
   - **重要**：选择要授权的仓库范围
     - ✅ **推荐**：选择 **"Only select repositories"**（仅选择特定仓库）
     - 然后选择 `wordcloud` 仓库
     - 或者选择 **"All repositories"**（所有仓库）- 更简单
   - 点击 **"Install"** 或 **"Authorize"** 完成授权

5. **返回 Railway 重试**
   - 授权完成后，回到 Railway
   - 点击 **"New Project"** → **"Deploy from GitHub repo"**
   - 现在应该能看到你的仓库了

---

## ✅ 解决方案 2：检查仓库是否为私有

### 如果仓库是私有的：

1. **确保已授权私有仓库访问**
   - 在 GitHub 授权页面，确保选择了私有仓库
   - Railway 需要明确授权才能访问私有仓库

2. **或者将仓库改为公开（临时）**
   - 如果只是测试，可以临时改为公开：
   - GitHub → 你的仓库 → Settings → 最下方 → Change visibility → Make public
   - 部署完成后再改回私有（可选）

---

## ✅ 解决方案 3：直接在 GitHub 仓库中连接 Railway

### 替代方法：

1. **从 GitHub 仓库页面连接**
   - 访问你的 GitHub 仓库：`https://github.com/xdq2005adam/wordcloud`
   - 点击仓库右上角的 **"Settings"**（设置）
   - 在左侧菜单找到 **"Integrations"** 或 **"Deployments"**
   - 如果看到 Railway，点击连接
   - 或者访问：https://railway.app/new/template

2. **使用 Railway 模板部署**
   - 访问：https://railway.app/new/template
   - 选择 **"Deploy from GitHub repo"**
   - 搜索 `xdq2005adam/wordcloud`
   - 如果还是看不到，继续下面的步骤

---

## ✅ 解决方案 4：清除浏览器缓存和 Cookie

### 步骤：

1. **清除 Railway 相关 Cookie**
   - 按 `F12` 打开开发者工具
   - 或者右键 → "检查" → "Application" 标签
   - 找到 **"Cookies"** → `https://railway.app`
   - 删除所有 Cookie
   - 刷新页面，重新登录

2. **或者使用无痕模式**
   - 按 `Ctrl+Shift+N`（Chrome）或 `Ctrl+Shift+P`（Firefox）
   - 在无痕窗口中访问 Railway
   - 重新登录并授权

---

## ✅ 解决方案 5：检查 GitHub 账号权限

### 步骤：

1. **确认 GitHub 账号状态**
   - 访问 https://github.com/settings/applications
   - 查看 **"Authorized GitHub Apps"**（已授权的应用）
   - 确认 **"Railway"** 在列表中
   - 如果不在，说明授权失败，需要重新授权

2. **检查授权范围**
   - 点击 Railway 应用
   - 确认授权范围包含：
     - ✅ Repository access（仓库访问）
     - ✅ Repository contents（仓库内容）
     - ✅ Repository metadata（仓库元数据）

3. **撤销并重新授权**
   - 如果授权有问题，点击 **"Revoke"**（撤销）
   - 然后回到 Railway 重新授权

---

## ✅ 解决方案 6：使用 GitHub 账号重新登录 Railway

### 步骤：

1. **退出 Railway**
   - Railway 右上角头像 → **"Sign Out"**（退出）

2. **重新登录**
   - 访问 [railway.app](https://railway.app)
   - 点击 **"Login with GitHub"**
   - 使用 GitHub 账号登录

3. **完成授权流程**
   - 按照 GitHub 的授权提示完成
   - 确保授权了仓库访问权限

---

## ✅ 解决方案 7：检查网络连接

### 如果在中国大陆：

1. **网络问题可能导致加载失败**
   - Railway 和 GitHub 都需要稳定的网络连接
   - 如果加载很慢或超时，可能是网络问题

2. **解决方法**：
   - 使用 VPN 或代理（如果可用）
   - 或者稍后重试
   - 或者使用手机热点尝试

---

## ✅ 解决方案 8：手动输入仓库 URL（最后手段）

### 如果以上都不行：

1. **使用 Railway CLI**
   - 安装 Railway CLI：
     ```bash
     npm install -g @railway/cli
     ```
   - 登录：
     ```bash
     railway login
     ```
   - 在项目目录中初始化：
     ```bash
     railway init
     ```
   - 连接仓库：
     ```bash
     railway link
     ```

2. **或者通过 Git 部署**
   - 在 Railway 中创建空项目
   - 在项目设置中找到 Git 仓库配置
   - 手动输入仓库 URL：`https://github.com/xdq2005adam/wordcloud.git`

---

## 🔍 快速诊断清单

请逐一检查：

- [ ] 是否使用 GitHub 账号登录 Railway？
- [ ] Railway 账户设置中是否显示 GitHub 已连接？
- [ ] GitHub 授权页面是否允许了仓库访问？
- [ ] 仓库是否为私有？如果是，是否授权了私有仓库访问？
- [ ] 是否尝试过清除浏览器缓存？
- [ ] 是否尝试过重新登录 Railway？
- [ ] 网络连接是否正常？

---

## 📞 如果以上方法都不行

### 联系支持：

1. **Railway 支持**
   - 访问：https://railway.app/discord
   - 加入 Discord 社区寻求帮助
   - 或查看文档：https://docs.railway.app

2. **GitHub 支持**
   - 检查 GitHub 状态：https://www.githubstatus.com
   - 确认 GitHub 服务正常

3. **提供信息**
   - 截图错误信息
   - 描述具体在哪一步卡住
   - 说明尝试了哪些方法

---

## 💡 推荐操作顺序

**按优先级尝试：**

1. ✅ **解决方案 1**：重新授权 GitHub App（90% 的情况能解决）
2. ✅ **解决方案 6**：重新登录 Railway
3. ✅ **解决方案 4**：清除缓存
4. ✅ **解决方案 2**：检查仓库权限
5. ✅ **解决方案 8**：使用 CLI 或手动配置

---

## 🎯 最可能的原因

根据经验，**90% 的情况是授权问题**：

- GitHub App 授权过期
- 授权时没有选择仓库
- 授权范围不足

**解决方法**：重新授权，确保选择了仓库访问权限。

---

## ✅ 成功标志

当你看到以下界面，说明成功了：

- Railway 显示仓库列表
- 能看到 `xdq2005adam/wordcloud` 仓库
- 点击仓库后能开始部署

---

**祝你解决问题！如果还有问题，告诉我具体在哪一步卡住了，我会继续帮你！** 🚀

