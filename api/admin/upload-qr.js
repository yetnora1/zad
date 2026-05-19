const { isAuthed, readFile, writeFile } = require('./_utils');

module.exports = async (req, res) => {
  if (req.method !== 'POST') return res.status(405).end();
  if (!isAuthed(req)) return res.status(401).json({ ok: false, error: 'Unauthorized' });

  try {
    const { provider, data: base64Data, ext } = req.body || {};
    if (!['telebirr','cbe'].includes(provider)) return res.status(400).json({ ok: false, error: 'Invalid provider' });
    if (!base64Data) return res.status(400).json({ ok: false, error: 'No image data' });

    const allowedExt = ['jpg','jpeg','png','webp','gif'];
    const fileExt = (ext || 'png').toLowerCase().replace('.','');
    if (!allowedExt.includes(fileExt)) return res.status(400).json({ ok: false, error: 'Invalid file type' });

    const mimeMap = { jpg:'image/jpeg', jpeg:'image/jpeg', png:'image/png', webp:'image/webp', gif:'image/gif' };
    const mime = mimeMap[fileExt] || 'image/png';

    // Store as data URL directly in payment_config.json (no static file dependency)
    const dataUrl = `data:${mime};base64,${base64Data}`;

    const { data: cfg, sha: cfgSha } = await readFile('payment_config.json');
    cfg[provider].qr_image = dataUrl;
    await writeFile('payment_config.json', cfg, cfgSha, `Admin: upload ${provider} QR code`);

    return res.json({ ok: true, path: dataUrl });
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
