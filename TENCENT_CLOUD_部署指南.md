# 🚀 腾讯云部署完整指南

## 💰 费用说明

### 方案一：轻量应用服务器（推荐）⭐

**适合场景：** 个人项目、小规模使用、预算有限

**配置推荐：**
- **入门级**：1核2GB内存，5M带宽，40GB SSD
  - 限时活动价：**96元/年**（约8元/月）
  - 常规价格：**24-30元/月**
- **标准级**：2核4GB内存，6M带宽，80GB SSD
  - 价格：**约50-60元/月**

**优点：**
- ✅ 价格便宜，适合个人项目
- ✅ 国内访问速度快
- ✅ 配置简单，开箱即用
- ✅ 包含公网IP和带宽

**缺点：**
- ⚠️ 需要备案才能使用域名（IP访问无需备案）
- ⚠️ 需要自己维护服务器

### 方案二：标准云服务器（CVM）

**适合场景：** 需要更高性能、更大带宽

**配置推荐：**
- 2核4GB内存，2M带宽：**约178元/月**（2137元/年）
- 2核4GB内存，3M带宽：**约196元/月**

**优点：**
- ✅ 性能更强
- ✅ 可扩展性好
- ✅ 支持更多配置选项

**缺点：**
- ❌ 价格较高
- ❌ 对于词云项目来说配置过剩

---

## 📋 部署前准备

### 1. 购买轻量应用服务器

1. **访问腾讯云官网**
   - 网址：https://cloud.tencent.com
   - 注册/登录账号（新用户有优惠）

2. **选择轻量应用服务器**
   - 产品 → 轻量应用服务器
   - 点击"立即选购"

3. **选择配置**
   - **地域**：选择离你最近的（如北京、上海、广州）
   - **镜像**：选择 **Ubuntu 22.04 LTS** 或 **CentOS 7.9**
   - **套餐**：选择 **1核2GB，5M带宽**（入门配置足够）
   - **购买时长**：建议选择1年（更便宜）

4. **完成购买**
   - 设置密码（或使用SSH密钥）
   - 完成支付
   - 等待服务器创建（约1-2分钟）

### 2. 获取服务器信息

购买完成后，在控制台可以看到：
- **公网IP**：例如 `123.123.123.123`
- **系统**：Ubuntu/CentOS
- **用户名**：`root`（Ubuntu）或 `root`（CentOS）

---

## 🔧 部署步骤

### 第一步：连接服务器

#### Windows 用户（使用 PuTTY 或 PowerShell）

**方法一：使用 PowerShell（Windows 10/11 自带）**

```powershell
# 打开 PowerShell，输入以下命令
ssh root@你的服务器IP
# 例如：ssh root@123.123.123.123
```

**方法二：使用 PuTTY**

1. 下载 PuTTY：https://www.putty.org/
2. 打开 PuTTY
3. 输入服务器IP，端口22
4. 点击"Open"
5. 输入用户名：`root`
6. 输入密码（输入时不会显示，直接输入后按回车）

#### Mac/Linux 用户

```bash
ssh root@你的服务器IP
# 例如：ssh root@123.123.123.123
```

### 第二步：安装 Node.js 环境

#### Ubuntu 系统（推荐）

```bash
# 更新系统
apt update && apt upgrade -y

# 安装 Node.js 18.x（使用 NodeSource 官方源）
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# 验证安装
node -v  # 应该显示 v18.x.x
npm -v   # 应该显示 9.x.x 或更高
```

#### CentOS 系统

```bash
# 更新系统
yum update -y

# 安装 Node.js 18.x
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# 验证安装
node -v
npm -v
```

### 第三步：安装 PM2（进程管理工具）

```bash
# 全局安装 PM2
npm install -g pm2

# 验证安装
pm2 -v
```

**PM2 的作用：**
- ✅ 保持应用持续运行（即使断开SSH）
- ✅ 崩溃自动重启
- ✅ 开机自启动
- ✅ 日志管理

### 第四步：上传项目文件

#### 方法一：使用 Git（推荐）

```bash
# 安装 Git（如果还没有）
apt install git -y  # Ubuntu
# 或
yum install git -y  # CentOS

# 创建项目目录
mkdir -p /opt/wordcloud
cd /opt/wordcloud

# 克隆你的项目（如果有Git仓库）
git clone https://github.com/你的用户名/你的仓库名.git .

# 或者直接初始化并添加文件（见方法二）
```

#### 方法二：使用 SCP 上传（Windows/Mac/Linux）

**Windows PowerShell：**

```powershell
# 在项目目录下执行
scp -r * root@你的服务器IP:/opt/wordcloud/
```

**Mac/Linux：**

```bash
# 在项目目录下执行
scp -r * root@你的服务器IP:/opt/wordcloud/
```

**或者使用 FTP 工具：**
- Windows：FileZilla、WinSCP
- Mac：FileZilla、Cyberduck

**上传的文件包括：**
- `server.js`
- `package.json`
- `index.html`
- `input.html`
- `lib/` 目录
- `qr_code.png`
- 其他项目文件

### 第五步：安装项目依赖

```bash
# 进入项目目录
cd /opt/wordcloud

# 安装依赖
npm install
```

### 第六步：配置防火墙（重要！）

#### 方法一：在腾讯云控制台配置

1. 登录腾讯云控制台
2. 进入 **轻量应用服务器** → 选择你的服务器
3. 点击 **防火墙** 标签
4. 点击 **添加规则**
5. 添加以下规则：
   - **应用类型**：自定义
   - **协议**：TCP
   - **端口**：3000
   - **策略**：允许
   - **备注**：词云服务端口
6. 点击 **确定**

#### 方法二：使用命令行（Ubuntu）

```bash
# 如果使用 ufw
ufw allow 3000/tcp
ufw reload

# 或者使用 iptables
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
```

### 第七步：启动服务

```bash
# 进入项目目录
cd /opt/wordcloud

# 使用 PM2 启动服务
pm2 start server.js --name wordcloud

# 查看运行状态
pm2 status

# 查看日志
pm2 logs wordcloud
```

### 第八步：设置开机自启动

```bash
# 保存当前 PM2 进程列表
pm2 save

# 设置 PM2 开机自启动
pm2 startup

# 执行上面命令输出的命令（通常是 sudo 开头的命令）
# 例如：sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u root --hp /root
```

### 第九步：测试访问

打开浏览器访问：
- **主页面**：`http://你的服务器IP:3000`
- **输入页面**：`http://你的服务器IP:3000/input.html`

例如：`http://123.123.123.123:3000`

---

## 🔄 常用管理命令

### PM2 管理命令

```bash
# 查看所有进程
pm2 list

# 查看日志
pm2 logs wordcloud

# 停止服务
pm2 stop wordcloud

# 重启服务
pm2 restart wordcloud

# 删除服务
pm2 delete wordcloud

# 查看详细信息
pm2 info wordcloud

# 监控
pm2 monit
```

### 更新代码后重新部署

```bash
# 方法一：如果使用 Git
cd /opt/wordcloud
git pull
pm2 restart wordcloud

# 方法二：如果手动上传
# 1. 上传新文件（使用 SCP 或 FTP）
# 2. 重启服务
cd /opt/wordcloud
pm2 restart wordcloud
```

---

## 🌐 配置域名访问（可选）

### 前置要求

1. **域名备案**（必须）
   - 如果使用国内服务器，域名必须备案
   - 备案流程：腾讯云控制台 → 网站备案 → 开始备案
   - 备案时间：约 7-20 个工作日

2. **域名解析**
   - 在域名管理中添加 A 记录
   - 主机记录：`@` 或 `www`
   - 记录值：你的服务器公网IP

### 使用 Nginx 反向代理（推荐）

#### 1. 安装 Nginx

```bash
# Ubuntu
apt install nginx -y

# CentOS
yum install nginx -y
```

#### 2. 配置 Nginx

```bash
# 编辑配置文件
nano /etc/nginx/sites-available/default
# CentOS 使用：nano /etc/nginx/nginx.conf
```

**添加以下配置：**

```nginx
server {
    listen 80;
    server_name 你的域名.com;  # 替换为你的域名

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

#### 3. 重启 Nginx

```bash
# 测试配置
nginx -t

# 重启 Nginx
systemctl restart nginx

# 设置开机自启
systemctl enable nginx
```

#### 4. 配置防火墙开放 80 端口

在腾讯云控制台防火墙中添加：
- 端口：80
- 协议：TCP
- 策略：允许

---

## 🔒 安全建议

### 1. 修改 SSH 端口（可选）

```bash
# 编辑 SSH 配置
nano /etc/ssh/sshd_config

# 修改 Port 22 为其他端口（如 2222）
Port 2222

# 重启 SSH
systemctl restart sshd
```

### 2. 配置防火墙规则

只开放必要的端口：
- 22（SSH）
- 3000（应用端口）
- 80（HTTP，如果使用 Nginx）
- 443（HTTPS，如果配置 SSL）

### 3. 定期更新系统

```bash
# Ubuntu
apt update && apt upgrade -y

# CentOS
yum update -y
```

---

## 📝 常见问题

### ❌ 问题 1：无法连接服务器

**解决方法：**
1. 检查服务器是否在运行（腾讯云控制台）
2. 检查防火墙是否开放 22 端口
3. 检查 IP 地址是否正确
4. 检查密码是否正确

### ❌ 问题 2：npm install 失败

**解决方法：**
```bash
# 清除 npm 缓存
npm cache clean --force

# 使用国内镜像（可选）
npm config set registry https://registry.npmmirror.com

# 重新安装
npm install
```

### ❌ 问题 3：服务无法访问

**检查清单：**
- [ ] 服务是否在运行：`pm2 status`
- [ ] 防火墙是否开放 3000 端口
- [ ] 检查日志：`pm2 logs wordcloud`
- [ ] 尝试本地访问：`curl http://localhost:3000`

### ❌ 问题 4：WebSocket 连接失败

**解决方法：**
1. 确保 Nginx 配置了 WebSocket 支持（如果使用 Nginx）
2. 检查防火墙是否开放相应端口
3. 查看浏览器控制台错误信息

### ❌ 问题 5：PM2 服务无法开机自启

**解决方法：**
```bash
# 重新生成启动脚本
pm2 startup

# 复制输出的命令并执行
# 然后保存进程列表
pm2 save
```

---

## 💡 优化建议

### 1. 使用 Nginx 反向代理

优点：
- 可以使用 80 端口（无需输入端口号）
- 可以配置 SSL 证书（HTTPS）
- 更好的性能

### 2. 配置 SSL 证书（HTTPS）

**使用 Let's Encrypt 免费证书：**

```bash
# 安装 Certbot
apt install certbot python3-certbot-nginx -y

# 申请证书
certbot --nginx -d 你的域名.com

# 自动续期
certbot renew --dry-run
```

### 3. 监控和日志

```bash
# 查看实时日志
pm2 logs wordcloud --lines 100

# 查看系统资源
pm2 monit

# 或使用系统命令
htop  # 需要先安装：apt install htop
```

---

## 📊 费用总结

### 最低配置方案（推荐）

- **服务器**：轻量应用服务器 1核2GB，5M带宽
  - 限时活动：**96元/年**（约8元/月）
  - 常规价格：**24-30元/月**
- **域名**：可选，约 **10-50元/年**
- **备案**：免费

### 总计

- **最便宜**：96元/年（限时活动，仅服务器）
- **常规价格**：约 288-360元/年（仅服务器）
- **包含域名**：约 300-410元/年

---

## ✅ 部署完成检查清单

- [ ] 服务器已购买并运行
- [ ] Node.js 已安装（版本 18+）
- [ ] PM2 已安装
- [ ] 项目文件已上传
- [ ] 依赖已安装（`npm install`）
- [ ] 防火墙已开放 3000 端口
- [ ] 服务已启动（`pm2 status`）
- [ ] 可以访问主页面（IP:3000）
- [ ] 可以访问输入页面（IP:3000/input.html）
- [ ] WebSocket 连接正常
- [ ] 开机自启已配置（`pm2 startup` 和 `pm2 save`）

---

## 🎉 完成！

现在你的词云项目已经部署到腾讯云了！

**访问地址：**
- 主页面：`http://你的服务器IP:3000`
- 输入页面：`http://你的服务器IP:3000/input.html`

**如果需要帮助，可以查看：**
- PM2 日志：`pm2 logs wordcloud`
- 服务器状态：`pm2 status`
- 系统资源：`pm2 monit`

祝你使用愉快！🚀

