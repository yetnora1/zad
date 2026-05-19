const https = require('https');

const BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN || '8796906586:AAEbACDB_jXZ9v_UGl1L5oZTfPs5mV6Pc3U';
const CHAT_ID   = process.env.TELEGRAM_CHAT_ID   || ''; // set this in Vercel env vars

function sendTelegram(text) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify({ chat_id: CHAT_ID, text, parse_mode: 'Markdown' });
    const opts = {
      hostname: 'api.telegram.org',
      path: `/bot${BOT_TOKEN}/sendMessage`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body)
      }
    };
    const req = https.request(opts, res => {
      let d = '';
      res.on('data', c => d += c);
      res.on('end', () => { try { resolve(JSON.parse(d)); } catch(e) { reject(e); } });
    });
    req.on('error', reject);
    req.write(body);
    req.end();
  });
}

module.exports = async (req, res) => {
  // Allow CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ ok: false, error: 'Method not allowed' });

  const { name, phone, message, lang } = req.body || {};

  if (!name || !message) {
    return res.status(400).json({ ok: false, error: 'Name and message are required' });
  }

  if (!CHAT_ID) {
    return res.status(500).json({ ok: false, error: 'Telegram not configured' });
  }

  const text = [
    `📩 *New Feedback — ZAD Cafe*`,
    ``,
    `👤 *Name:* ${name}`,
    phone ? `📞 *Phone:* ${phone}` : null,
    `💬 *Message:*\n${message}`,
    ``,
    `🌐 *Language:* ${lang === 'am' ? 'Amharic' : 'English'}`,
    `🕐 *Time:* ${new Date().toLocaleString('en-ET', { timeZone: 'Africa/Addis_Ababa' })}`
  ].filter(Boolean).join('\n');

  try {
    const result = await sendTelegram(text);
    if (result.ok) {
      return res.json({
        ok: true,
        message: lang === 'am' ? 'አስተያየትዎ ተልኳል! ✅' : 'Feedback sent successfully! ✅'
      });
    } else {
      return res.status(500).json({ ok: false, error: result.description || 'Telegram error' });
    }
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
