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
    // Ensure no query string corruption
    const cleanDataUrl = dataUrl.split('?')[0];

    const { data: cfg, sha: cfgSha } = await readFile('payment_config.json');
    // Also clean any existing corrupted data
    if(cfg.telebirr?.qr_image && cfg.telebirr.qr_image.includes('?'))cfg.telebirr.qr_image=cfg.telebirr.qr_image.split('?')[0];
    if(cfg.cbe?.qr_image && cfg.cbe.qr_image.includes('?'))cfg.cbe.qr_image=cfg.cbe.qr_image.split('?')[0];
    cfg[provider].qr_image = cleanDataUrl;
    await writeFile('payment_config.json', cfg, cfgSha, `Admin: upload ${provider} QR code`);

    return res.json({ ok: true, path: cleanDataUrl });
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
