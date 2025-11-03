# 本地库文件说明

此文件夹用于存放项目的本地JavaScript库文件。

## 当前文件

- `wordcloud2.js` - WordCloud2词云生成库（已安装）

## 缺失文件（可选）

- `qrcode.min.js` - QRCode二维码生成库

**注意**：如果 `qrcode.min.js` 不存在，系统会自动使用在线API（api.qrserver.com）作为备用方案生成二维码，功能不受影响。

## 手动下载 qrcode.min.js（可选）

如果您希望使用本地QRCode库而不是在线API，可以：

1. 访问以下任意链接下载 `qrcode.min.js`：
   - https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js
   - https://unpkg.com/qrcode@1.5.3/build/qrcode.min.js

2. 将下载的文件保存到 `lib/qrcode.min.js`

3. 刷新浏览器页面

