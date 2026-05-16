const { isAuthed, readFile, writeFile } = require('./_utils');

module.exports = async (req, res) => {
  if (!isAuthed(req)) return res.status(401).json({ ok: false, error: 'Unauthorized' });

  // GET
  if (req.method === 'GET') {
    try {
      const { data } = await readFile('payment_config.json');
      return res.json({ ok: true, data });
    } catch (e) {
      return res.status(500).json({ ok: false, error: e.message });
    }
  }

  // POST
  if (req.method === 'POST') {
    try {
      const b = req.body || {};
      const { data: existing, sha } = await readFile('payment_config.json');

      const clean = {
        telebirr: {
          phone:        String(b.telebirr?.phone        || existing.telebirr?.phone        || ''),
          account_name: String(b.telebirr?.account_name || existing.telebirr?.account_name || ''),
          hint:         String(b.telebirr?.hint         || existing.telebirr?.hint         || ''),
          qr_image:     existing.telebirr?.qr_image || '',
        },
        cbe: {
          account:      String(b.cbe?.account      || existing.cbe?.account      || ''),
          account_name: String(b.cbe?.account_name || existing.cbe?.account_name || ''),
          hint:         String(b.cbe?.hint         || existing.cbe?.hint         || ''),
          qr_image:     existing.cbe?.qr_image || '',
        }
      };

      await writeFile('payment_config.json', clean, sha, 'Admin: update payment config');
      return res.json({ ok: true });
    } catch (e) {
      return res.status(500).json({ ok: false, error: e.message });
    }
  }

  res.status(405).end();
};
