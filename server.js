const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const path = require('path');
const compression = require('compression');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// 启用 Gzip 压缩（减少传输量 60-80%）
app.use(compression());

// 静态文件服务（优化缓存）
app.use(express.static(path.join(__dirname), {
    maxAge: '1d', // 缓存 1 天
    etag: true,
    lastModified: true
}));

// 路由
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/input.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'input.html'));
});

// 健康检查端点（用于监控服务保持服务活跃，防止休眠）
app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'ok',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// WebSocket连接处理
io.on('connection', (socket) => {
    console.log('新客户端连接:', socket.id);

    // 接收客户端发送的消息
    socket.on('sendMessage', (data, callback) => {
        try {
            const text = data.text?.trim();
            
            if (!text || text.length === 0) {
                if (callback) callback({ success: false, message: '内容不能为空' });
                return;
            }

            if (text.length > 200) {
                if (callback) callback({ success: false, message: '内容过长' });
                return;
            }

            // 广播消息给所有连接的客户端（包括主页面）
            io.emit('newMessage', {
                text: text,
                timestamp: new Date().toISOString(),
                id: socket.id
            });

            console.log('收到消息:', text, '来自:', socket.id);

            // 发送成功响应
            if (callback) callback({ success: true });
        } catch (error) {
            console.error('处理消息时出错:', error);
            if (callback) callback({ success: false, message: '服务器错误' });
        }
    });

    // 断开连接
    socket.on('disconnect', () => {
        console.log('客户端断开连接:', socket.id);
    });
});

// 优化响应头（减少延迟）
app.use((req, res, next) => {
    // 移除不必要的响应头
    res.removeHeader('X-Powered-By');
    // 添加安全头
    res.setHeader('X-Content-Type-Options', 'nosniff');
    next();
});

// 启动服务器
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`服务器运行在 http://localhost:${PORT}`);
    console.log(`主页面: http://localhost:${PORT}`);
    console.log(`输入页面: http://localhost:${PORT}/input.html`);
    console.log(`健康检查: http://localhost:${PORT}/health`);
});

