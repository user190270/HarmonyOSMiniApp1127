const express = require('express');
const axios = require('axios');
const config = require('../config/apiConfig');
const router = express.Router();

let token = '';
let tokenExpiration = 0;

// 获取 Token 的方法
async function fetchToken() {
    const currentTime = Date.now();
    if (token && currentTime < tokenExpiration) {
        return token; // 如果 token 仍然有效，直接返回
    }

    try {
        const response = await axios.post(config.tokenUrl, {
            auth: {
                identity: {
                    methods: ['password'],
                    password: {
                        user: {
                            name: config.iamAccount,
                            password: config.iamPassword,
                            domain: { name: config.tenantName }
                        }
                    }
                },
                scope: { project: { name: config.projectName } }
            }
        }, {
            headers: { 'Content-Type': 'application/json' }
        });

        token = response.headers['x-subject-token']; // 提取 token
        tokenExpiration = Date.now() + 3600 * 1000; // 假设 token 有效期为 1 小时
        return token;
    } catch (error) {
        console.error('获取 Token 出错：', error);
        throw new Error('Token 获取失败');
    }
}

// 翻译接口
router.post('/translate', async (req, res) => {
    const { text, from, to } = req.body;

    try {
        const token = await fetchToken(); // 获取 token
        const response = await axios.post(config.serviceUrl, {
            text, from, to
        }, {
            headers: {
                'Content-Type': 'application/json',
                'X-Auth-Token': token
            }
        });

        res.json(response.data); // 返回翻译结果
    } catch (error) {
        console.error('翻译请求失败：', error);
        res.status(500).json({ error: '翻译请求失败' });
    }
});

module.exports = router;
