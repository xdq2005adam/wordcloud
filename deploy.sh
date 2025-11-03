#!/bin/bash
# 词云项目一键部署脚本
# 适用于腾讯云/阿里云等Linux服务器

echo "🚀 开始部署词云项目..."

# 检查是否安装了 Node.js
if ! command -v node &> /dev/null; then
    echo "📦 安装 Node.js..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 18
    nvm use 18
    echo "✅ Node.js 安装完成"
else
    echo "✅ Node.js 已安装: $(node --version)"
fi

# 检查是否安装了 PM2
if ! command -v pm2 &> /dev/null; then
    echo "📦 安装 PM2..."
    npm install -g pm2
    echo "✅ PM2 安装完成"
else
    echo "✅ PM2 已安装"
fi

# 安装项目依赖
echo "📦 安装项目依赖..."
npm install

# 停止旧的服务（如果存在）
pm2 stop wordcloud 2>/dev/null || true
pm2 delete wordcloud 2>/dev/null || true

# 启动服务
echo "🚀 启动服务..."
pm2 start server.js --name wordcloud

# 保存 PM2 配置
pm2 save

# 设置开机自启
pm2 startup | grep -v PM2 | bash || true

echo ""
echo "✅ 部署完成！"
echo ""
echo "📊 查看服务状态: pm2 status"
echo "📝 查看日志: pm2 logs wordcloud"
echo "🔄 重启服务: pm2 restart wordcloud"
echo "🛑 停止服务: pm2 stop wordcloud"
echo ""
echo "🌐 访问地址: http://$(curl -s ifconfig.me):3000"

