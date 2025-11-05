# 🚀 Cloudflare 免费二级域名加速教程（无需购买域名）

> **适合人群：** 完全新手，没有域名，只想用 Cloudflare 免费二级域名加速 Railway 部署

---

## 📋 教程概述

这个教程会教你：
- ✅ 使用 Cloudflare 提供的**免费二级域名**（格式：`xxx.trycloudflare.com`）
- ✅ 无需购买任何域名，完全免费
- ✅ 让你的 Railway 应用通过 Cloudflare 加速（国内访问更快）
- ✅ 自动获得 HTTPS 证书（SSL）
- ✅ 支持 WebSocket（你的词云应用可以正常工作）

**预计时间：** 20-30 分钟

---

## 🎯 前置条件

在开始之前，请确保：
- ✅ 你的应用已经部署在 Railway 上（如果还没部署，请先完成部署）
- ✅ 你知道你的 Railway URL（例如：`web-production-27bb4.up.railway.app`）
- ✅ 有一台电脑（Windows、Mac 或 Linux 都可以）
- ✅ 有网络连接

---

## 第一步：注册 Cloudflare 账号（如果还没有）

### 步骤 1.1：访问 Cloudflare 官网

1. 打开浏览器（Chrome、Edge、Firefox 都可以）
2. 访问：**https://dash.cloudflare.com/sign-up**
3. 或者访问：**https://cloudflare.com**，然后点击右上角的 **"Sign Up"**

### 步骤 1.2：注册账号

1. 输入你的**邮箱地址**（建议使用常用邮箱，如 Gmail、QQ 邮箱等）
2. 输入**密码**（至少 8 个字符，建议包含大小写字母和数字）
3. 点击 **"Sign Up"**（注册）

**示例：**
```
邮箱：your-email@gmail.com
密码：YourPassword123
```

### 步骤 1.3：验证邮箱

1. 查看你的邮箱收件箱
2. 找到来自 Cloudflare 的验证邮件
3. 点击邮件中的**验证链接**
4. 如果没收到邮件，检查垃圾邮件文件夹

### 步骤 1.4：登录 Cloudflare

1. 验证邮箱后，访问：**https://dash.cloudflare.com**
2. 输入你的邮箱和密码
3. 点击 **"Log in"**（登录）

**✅ 完成！** 现在你应该能看到 Cloudflare 的控制台了。

---

## 第二步：安装 cloudflared（Cloudflare Tunnel 客户端）

`cloudflared` 是一个命令行工具，用来创建和管理 Cloudflare Tunnel。

### 步骤 2.1：选择你的操作系统

根据你的电脑系统，选择对应的安装方法：

---

### 📱 Windows 系统安装方法

#### 方法 A：使用 PowerShell 下载（推荐，最简单）

1. **打开 PowerShell**
   - 按 `Win + X` 键
   - 选择 **"Windows PowerShell"** 或 **"终端"**
   - 或者按 `Win + R`，输入 `powershell`，回车

2. **下载 cloudflared**
   在 PowerShell 中输入以下命令（**一行一行复制粘贴**）：

   ```powershell
   # 创建一个临时文件夹（可选）
   cd $env:USERPROFILE\Desktop
   
   # 下载 cloudflared
   Invoke-WebRequest -Uri "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe" -OutFile "cloudflared.exe"
   ```

3. **等待下载完成**
   - 下载完成后，你应该能在桌面上看到 `cloudflared.exe` 文件

4. **验证安装**
   在 PowerShell 中输入：
   ```powershell
   cd $env:USERPROFILE\Desktop
   .\cloudflared.exe --version
   ```
   
   如果看到版本号（例如：`cloudflared 2024.x.x`），说明安装成功！

5. **（可选）添加到 PATH**
   如果你想在任何地方都能使用 `cloudflared`，可以：
   - 将 `cloudflared.exe` 复制到 `C:\Windows\System32\` 文件夹
   - 或者创建一个文件夹（如 `C:\cloudflared\`），将文件放进去，然后添加到系统 PATH

**✅ Windows 安装完成！**

---

### 🍎 macOS 系统安装方法

#### 方法 A：使用 Homebrew（推荐）

1. **打开终端（Terminal）**
   - 按 `Cmd + Space`，输入 "Terminal"，回车

2. **安装 Homebrew**（如果还没安装）
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
   按照提示输入密码和确认

3. **安装 cloudflared**
   ```bash
   brew install cloudflared
   ```

4. **验证安装**
   ```bash
   cloudflared --version
   ```

**✅ macOS 安装完成！**

---

### 🐧 Linux 系统安装方法

#### Ubuntu/Debian 系统：

```bash
# 下载安装包
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

# 安装
sudo dpkg -i cloudflared-linux-amd64.deb

# 验证
cloudflared --version
```

#### 其他 Linux 发行版：

```bash
# 下载可执行文件
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared

# 添加执行权限
chmod +x cloudflared

# 移动到系统路径（可选）
sudo mv cloudflared /usr/local/bin/

# 验证
cloudflared --version
```

**✅ Linux 安装完成！**

---

## 第三步：登录 Cloudflare 账户

这一步会让 `cloudflared` 工具连接到你的 Cloudflare 账户。

### 步骤 3.1：打开命令行/PowerShell/终端

- **Windows：** 打开 PowerShell
- **macOS：** 打开 Terminal
- **Linux：** 打开终端

### 步骤 3.2：运行登录命令

**Windows（如果 cloudflared.exe 在桌面）：**
```powershell
cd $env:USERPROFILE\Desktop
.\cloudflared.exe tunnel login
```

**macOS/Linux：**
```bash
cloudflared tunnel login
```

### 步骤 3.3：授权访问

1. **命令运行后，会自动打开浏览器**
   - 如果没有自动打开，会显示一个 URL，手动复制到浏览器打开

2. **选择你的域名**
   - 如果你还没有添加任何域名到 Cloudflare，会显示一个空列表
   - **没关系！** 点击 **"Authorize"**（授权）按钮
   - 这会创建一个特殊的账户权限，用于 Tunnel 功能

3. **完成授权**
   - 浏览器会显示 "Success!"（成功）
   - 你可以关闭浏览器窗口

4. **返回命令行**
   - 命令行应该显示类似：`✅ Login successful`（登录成功）

**✅ 登录完成！**

---

## 第四步：创建永久隧道

现在我们要创建一个**永久隧道**，它会给你一个免费的二级域名。

### 步骤 4.1：创建隧道

在命令行中输入（将 `wordcloud` 改成你喜欢的名字，比如 `myapp`、`wordcloud` 等）：

**Windows：**
```powershell
cd $env:USERPROFILE\Desktop
.\cloudflared.exe tunnel create wordcloud
```

**macOS/Linux：**
```bash
cloudflared tunnel create wordcloud
```

**输出示例：**
```
Created tunnel wordcloud with id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

**重要：** 记住这个**隧道 ID**（上面的 `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`），后面会用到！

### 步骤 4.2：创建路由（获取免费域名）

现在我们要创建一个 DNS 路由，这样就能获得免费域名了。

**Windows：**
```powershell
.\cloudflared.exe tunnel route dns wordcloud wordcloud-app.trycloudflare.com
```

**macOS/Linux：**
```bash
cloudflared tunnel route dns wordcloud wordcloud-app.trycloudflare.com
```

**说明：**
- `wordcloud` 是你刚才创建的隧道名称
- `wordcloud-app.trycloudflare.com` 是你想要的域名（可以改成任何名字，但必须以 `.trycloudflare.com` 结尾）

**输出示例：**
```
✅ DNS record created: wordcloud-app.trycloudflare.com
```

**🎉 恭喜！** 你现在有一个免费域名了：`wordcloud-app.trycloudflare.com`

**注意：** 如果你想要不同的域名，可以再运行一次命令，使用不同的名字。

---

## 第五步：创建配置文件

我们需要创建一个配置文件，告诉 Cloudflare Tunnel 如何连接到你的 Railway 应用。

### 步骤 5.1：找到配置文件位置

**Windows：**
配置文件位置：`C:\Users\你的用户名\.cloudflared\config.yml`

例如：`C:\Users\张三\.cloudflared\config.yml`

**macOS/Linux：**
配置文件位置：`~/.cloudflared/config.yml`

例如：`/Users/你的用户名/.cloudflared/config.yml`

### 步骤 5.2：创建配置文件目录

**Windows（PowerShell）：**
```powershell
# 创建目录（如果不存在）
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cloudflared"
```

**macOS/Linux：**
```bash
mkdir -p ~/.cloudflared
```

### 步骤 5.3：创建配置文件

**Windows：**
```powershell
# 打开记事本创建文件
notepad "$env:USERPROFILE\.cloudflared\config.yml"
```

**macOS/Linux：**
```bash
nano ~/.cloudflared/config.yml
```

### 步骤 5.4：编辑配置文件内容

**重要：** 你需要替换以下内容：
1. `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` → 你的**隧道 ID**（第四步中获得的）
2. `你的用户名` → 你的 Windows/macOS/Linux 用户名
3. `wordcloud-app.trycloudflare.com` → 你的域名（如果不同）
4. `web-production-27bb4.up.railway.app` → 你的 **Railway URL**

**Windows 配置文件内容：**

```yaml
tunnel: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
credentials-file: C:\Users\你的用户名\.cloudflared\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json

ingress:
  - hostname: wordcloud-app.trycloudflare.com
    service: https://web-production-27bb4.up.railway.app
  
  - service: http_status:404
```

**macOS/Linux 配置文件内容：**

```yaml
tunnel: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
credentials-file: /Users/你的用户名/.cloudflared/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json

ingress:
  - hostname: wordcloud-app.trycloudflare.com
    service: https://web-production-27bb4.up.railway.app
  
  - service: http_status:404
```

**详细说明：**
- `tunnel:` 后面是你的隧道 ID
- `credentials-file:` 是认证文件路径（**文件名是你的隧道 ID + `.json`**）
- `hostname:` 是你的免费域名
- `service:` 是你的 Railway URL（**确保是 HTTPS**）

### 步骤 5.5：保存文件

- **Windows（记事本）：** 按 `Ctrl + S` 保存，然后关闭记事本
- **macOS/Linux（nano）：** 按 `Ctrl + X`，然后按 `Y`，再按 `Enter` 保存

**✅ 配置文件创建完成！**

---

## 第六步：测试隧道（本地测试）

在部署到 Railway 之前，我们先在本地测试一下隧道是否正常工作。

### 步骤 6.1：运行隧道

**Windows：**
```powershell
cd $env:USERPROFILE\Desktop
.\cloudflared.exe tunnel run wordcloud
```

**macOS/Linux：**
```bash
cloudflared tunnel run wordcloud
```

### 步骤 6.2：查看输出

你应该看到类似这样的输出：
```
2024-01-01T12:00:00Z INF Starting metrics server
2024-01-01T12:00:00Z INF +--------------------------------------------------------------------------------------------+
2024-01-01T12:00:00Z INF |  Your quick Tunnel has been created! Visit it at (it may take some time to be reachable): |
2024-01-01T12:00:00Z INF |  https://wordcloud-app.trycloudflare.com                                 |
2024-01-01T12:00:00Z INF +--------------------------------------------------------------------------------------------+
```

### 步骤 6.3：测试访问

1. **保持命令行窗口开着**（不要关闭！）
2. **打开浏览器**
3. **访问你的域名：** `https://wordcloud-app.trycloudflare.com`
4. **应该能看到你的词云应用了！**

### 步骤 6.4：测试 WebSocket

1. **打开浏览器开发者工具**（按 `F12`）
2. **进入 Console（控制台）标签**
3. **访问主页面**，应该看到：
   ```
   ✓ WebSocket连接成功！Socket ID: xxx
   ```

4. **打开输入页面：** `https://wordcloud-app.trycloudflare.com/input.html`
5. **发送一条消息**
6. **在主页面应该能看到词云更新**

### 步骤 6.5：停止测试

测试完成后，在命令行窗口按 `Ctrl + C` 停止隧道。

**✅ 本地测试完成！** 如果一切正常，继续下一步。

---

## 第七步：在 Railway 上部署隧道（让隧道一直运行）

现在我们要让隧道在 Railway 上持续运行，这样你就不需要一直开着电脑了。

### 步骤 7.1：准备文件

在你的项目文件夹中创建以下文件：

#### 文件 1：创建 `Dockerfile.tunnel`

在项目根目录创建 `Dockerfile.tunnel`：

```dockerfile
FROM cloudflare/cloudflared:latest

# 复制配置文件
COPY config.yml /etc/cloudflared/config.yml

# 复制认证文件（需要从本地复制）
COPY credentials.json /etc/cloudflared/credentials.json

# 运行隧道
CMD ["tunnel", "--config", "/etc/cloudflared/config.yml", "run"]
```

#### 文件 2：创建 `railway-tunnel.json`（Railway 配置文件）

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile.tunnel"
  },
  "deploy": {
    "startCommand": "tunnel --config /etc/cloudflared/config.yml run",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### 步骤 7.2：获取认证文件

**Windows：**
认证文件位置：`C:\Users\你的用户名\.cloudflared\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json`

**macOS/Linux：**
认证文件位置：`~/.cloudflared/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json`

**重要：** 这个文件包含你的账户认证信息，**不要分享给任何人！**

### 步骤 7.3：上传文件到 Railway

#### 方法 A：使用 Railway Web 界面（推荐）

1. **登录 Railway**
   - 访问 https://railway.app
   - 登录你的账号

2. **创建新服务**
   - 在你的项目中，点击 **"New"** → **"Empty Service"**
   - 命名为：`cloudflare-tunnel`（或任何名字）

3. **上传文件**
   - 点击服务 → **"Settings"** → **"Source"**
   - 选择 **"Connect GitHub"** 或 **"Upload Files"**
   - 上传以下文件：
     - `Dockerfile.tunnel`
     - `config.yml`（需要修改路径）
     - `credentials.json`（认证文件）

4. **修改配置文件路径**
   在 Railway 中，路径会不同。修改 `config.yml`：
   ```yaml
   tunnel: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   credentials-file: /etc/cloudflared/credentials.json

   ingress:
     - hostname: wordcloud-app.trycloudflare.com
       service: https://web-production-27bb4.up.railway.app
     
     - service: http_status:404
   ```

5. **部署**
   - Railway 会自动检测 Dockerfile 并部署
   - 等待部署完成（通常 2-5 分钟）

#### 方法 B：使用 Git（如果你用 Git）

1. **将文件添加到项目**
   ```bash
   # 复制认证文件到项目目录（重命名为 credentials.json）
   # Windows PowerShell:
   Copy-Item "$env:USERPROFILE\.cloudflared\你的隧道ID.json" -Destination "credentials.json"
   
   # macOS/Linux:
   cp ~/.cloudflared/你的隧道ID.json credentials.json
   ```

2. **修改 config.yml**
   在项目根目录的 `config.yml`：
   ```yaml
   tunnel: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   credentials-file: /etc/cloudflared/credentials.json

   ingress:
     - hostname: wordcloud-app.trycloudflare.com
       service: https://web-production-27bb4.up.railway.app
     
     - service: http_status:404
   ```

3. **提交到 Git**
   ```bash
   git add Dockerfile.tunnel config.yml credentials.json
   git commit -m "Add Cloudflare Tunnel"
   git push
   ```

4. **在 Railway 中连接 Git**
   - Railway 会自动检测并部署

### 步骤 7.4：验证部署

1. **查看 Railway 日志**
   - 在 Railway 中打开你的隧道服务
   - 点击 **"Deployments"** → **"View Logs"**
   - 应该看到类似：
     ```
     ✅ Tunnel is running
     ```

2. **测试访问**
   - 访问：`https://wordcloud-app.trycloudflare.com`
   - 应该能看到你的应用

3. **关闭本地隧道**
   - 如果你之前在本地运行了隧道，现在可以关闭了
   - Railway 上的隧道会一直运行

**✅ 部署完成！** 现在你的隧道在 Railway 上持续运行了！

---

## 第八步：验证一切正常

### 检查清单

- [ ] 可以访问 `https://wordcloud-app.trycloudflare.com`
- [ ] 主页面可以正常加载
- [ ] 输入页面（`/input.html`）可以正常加载
- [ ] WebSocket 连接成功（浏览器控制台无错误）
- [ ] 可以发送消息并看到词云更新
- [ ] Railway 日志显示隧道正在运行

### 测试步骤

1. **打开浏览器开发者工具**（`F12`）
2. **访问主页面**
3. **查看 Console（控制台）**
   - 应该看到：`✓ WebSocket连接成功！Socket ID: xxx`
   - 不应该有红色错误信息

4. **测试功能**
   - 打开新标签页：`https://wordcloud-app.trycloudflare.com/input.html`
   - 输入一条消息并发送
   - 返回主页面，应该能看到词云更新

**✅ 一切正常！** 恭喜你完成了配置！

---

## 🐛 常见问题排除

### 问题 1：无法访问域名

**症状：** 访问 `https://xxx.trycloudflare.com` 显示错误或无法连接

**解决方法：**

1. **检查隧道是否运行**
   - 查看 Railway 日志，确认隧道正在运行
   - 如果没有运行，检查配置文件是否正确

2. **检查配置文件**
   - 确认 `config.yml` 中的 Railway URL 正确
   - 确认 Railway URL 是 HTTPS（不是 HTTP）

3. **检查认证文件**
   - 确认 `credentials.json` 文件已上传到 Railway
   - 确认文件路径正确

### 问题 2：WebSocket 连接失败

**症状：** 浏览器控制台显示 WebSocket 错误

**解决方法：**

1. **检查 Railway 服务**
   - 确认你的主应用（词云应用）在 Railway 上正常运行
   - 确认 Railway URL 可以正常访问

2. **检查隧道配置**
   - 确认 `service:` 指向的是 HTTPS URL
   - 确认 URL 末尾没有斜杠 `/`

3. **清除浏览器缓存**
   - 按 `Ctrl+Shift+Delete`（Windows）或 `Cmd+Shift+Delete`（Mac）
   - 清除缓存和 Cookie
   - 重新访问

### 问题 3：隧道在 Railway 上无法启动

**症状：** Railway 日志显示错误或隧道无法启动

**解决方法：**

1. **检查文件路径**
   - 确认 `config.yml` 中的路径是 `/etc/cloudflared/credentials.json`
   - 确认 `Dockerfile.tunnel` 正确复制了文件

2. **检查认证文件**
   - 确认 `credentials.json` 文件已上传
   - 确认文件名正确（不是 `.txt` 或 `.json.txt`）

3. **查看详细日志**
   - 在 Railway 中查看完整的错误日志
   - 根据错误信息调整配置

### 问题 4：域名访问很慢

**症状：** 访问域名很慢，不如直接访问 Railway

**解决方法：**

1. **等待 DNS 传播**
   - 新创建的域名可能需要几分钟到几小时才能完全生效
   - 耐心等待

2. **检查 Cloudflare 状态**
   - 访问 Cloudflare Dashboard
   - 确认隧道状态正常

3. **使用不同的域名**
   - 尝试创建另一个域名，看是否更快

### 问题 5：忘记隧道 ID

**解决方法：**

**Windows：**
```powershell
cd $env:USERPROFILE\Desktop
.\cloudflared.exe tunnel list
```

**macOS/Linux：**
```bash
cloudflared tunnel list
```

这会显示你所有的隧道和它们的 ID。

### 问题 6：想删除隧道重新开始

**解决方法：**

1. **删除隧道**
   ```bash
   cloudflared tunnel delete wordcloud
   ```

2. **删除 DNS 路由**
   ```bash
   cloudflared tunnel route dns delete wordcloud-app.trycloudflare.com
   ```

3. **重新开始** 按照本教程重新创建

---

## 📝 重要提示

### ⚠️ 安全提示

1. **不要分享认证文件**
   - `credentials.json` 文件包含你的账户认证信息
   - 不要上传到公开的 Git 仓库
   - 如果泄露，立即删除隧道并重新创建

2. **保护你的隧道**
   - 不要将隧道 ID 分享给不信任的人
   - 定期检查隧道状态

### 💡 使用建议

1. **保持隧道运行**
   - 确保 Railway 上的隧道服务一直运行
   - 如果隧道停止，域名将无法访问

2. **监控日志**
   - 定期查看 Railway 日志
   - 如果发现错误，及时处理

3. **备份配置**
   - 保存你的 `config.yml` 文件
   - 记录你的隧道 ID 和域名

### 🎯 域名说明

- **免费域名格式：** `xxx.trycloudflare.com`
- **域名永久有效**（只要隧道在运行）
- **可以创建多个域名**（创建多个隧道）
- **域名无法自定义**（必须是 `.trycloudflare.com` 结尾）

---

## 🎉 完成！

恭喜你完成了 Cloudflare Tunnel 的配置！现在你的应用：

- ✅ 通过 Cloudflare 免费二级域名访问
- ✅ 享受 Cloudflare CDN 加速
- ✅ 自动获得 HTTPS 证书
- ✅ 支持 WebSocket（词云功能正常）
- ✅ 完全免费

**你的免费域名：** `https://wordcloud-app.trycloudflare.com`

**下一步：**
- 分享你的域名给朋友使用
- 监控访问情况
- 如果遇到问题，参考故障排除部分

---

## 📞 需要帮助？

如果遇到问题：
1. 查看本教程的故障排除部分
2. 查看 Cloudflare Tunnel 官方文档：https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/
3. 查看 Railway 日志，寻找错误信息
4. 确认所有配置步骤都正确完成

---

## 📚 相关文件

- `server.js` - 你的服务器代码（已优化支持 Cloudflare）
- `config.yml` - Cloudflare Tunnel 配置文件
- `Dockerfile.tunnel` - Railway 部署配置文件

---

**祝你使用愉快！** 🚀

