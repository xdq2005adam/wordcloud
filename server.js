const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const path = require('path');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// 静态文件服务
app.use(express.static(path.join(__dirname)));

// 路由
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/input.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'input.html'));
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

// 启动服务器
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`服务器运行在 http://localhost:${PORT}`);
    console.log(`主页面: http://localhost:${PORT}`);
    console.log(`输入页面: http://localhost:${PORT}/input.html`);
});

