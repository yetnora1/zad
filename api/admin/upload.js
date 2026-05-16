const { isAuthed, writeRawFile, getFileSha } = require('./_utils');

module.exports = async (req, res) => {
  if (req.method !== 'POST') return res.status(405).end();
  if (!isAuthed(req)) return res.status(401).json({ ok: false, error: 'Unauthorized' });

  try {
    const { data: base64Data, ext, name } = req.body || {};
    if (!base64Data) return res.status(400).json({ ok: false, error: 'No image data' });

    const allowedExt = ['jpg','jpeg','png','webp','gif'];
    const fileExt = (ext || 'jpg').toLowerCase().replace('.','');
    if (!allowedExt.includes(fileExt)) return res.status(400).json({ ok: false, error: 'Invalid file type' });

    const safeName = (name || `img_${Date.now()}`).replace(/[^a-z0-9_\-]/gi, '_');
    const filePath = `images/${safeName}.${fileExt}`;
    const sha = await getFileSha(filePath);

    await writeRawFile(filePath, base64Data, sha, `Admin: upload menu image ${safeName}`);

    return res.json({ ok: true, path: filePath });
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
