import { http } from '@kit.NetworkKit';

interface GeneratedObjectLiteralInterface_3 {
  src_text: string;
  translated_text: string;
  from: string;
  to: string;
}

export async function translateText(text: string, from: string, to: string): Promise<string> {
  const url = 'http://localhost:3000/api/translate'; // 替换为实际后端 IP 和端口
  let httpRequest = http.createHttp();
  try {
    const response = await httpRequest.request(url, {
      method: http.RequestMethod.POST,
      extraData: { text, from, to },
      header: { 'Content-Type': 'application/json' }
    });

    // 假设后端返回 JSON 格式 { translated_text: "<value>" }
    const result:GeneratedObjectLiteralInterface_3 = JSON.parse(response.result.toString());
    return result.translated_text || '翻译失败';
  } catch (error) {
    console.error('Error translating text:', error);
    return '翻译失败';
  }
}
