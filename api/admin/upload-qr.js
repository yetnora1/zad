const { isAuthed, readFile, writeFile, writeRawFile, getFileSha } = require('./_utils');

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

    const filePath = `images/${provider}_qr.${fileExt}`;

    // Get existing SHA if file exists (needed for GitHub update)
    const sha = await getFileSha(filePath);

    // Commit image to GitHub repo
    await writeRawFile(filePath, base64Data, sha, `Admin: upload ${provider} QR code`);

    // Update payment_config.json with new QR image path
    const { data: cfg, sha: cfgSha } = await readFile('payment_config.json');
    cfg[provider].qr_image = filePath;
    await writeFile('payment_config.json', cfg, cfgSha, `Admin: set ${provider} QR image path`);

    return res.json({ ok: true, path: filePath });
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
