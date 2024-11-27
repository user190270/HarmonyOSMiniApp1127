const express = require('express');
const bodyParser = require('body-parser');
const translationRouter = require('./routes/translation');

const app = express();
const PORT = 3000;

// 中间件
app.use(bodyParser.json());

// 使用翻译路由
app.use('/api', translationRouter);

// 启动服务
app.listen(PORT, () => {
    console.log(`后端服务已启动：http://localhost:${PORT}`);
});
