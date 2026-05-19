const { isAuthed, readFile, writeFile } = require('./_utils');

// Strip any ?v=... corruption from data URLs
function cleanQR(val) {
  if (!val) return '';
  if (val.includes('?')) return val.split('?')[0];
  return val;
}

module.exports = async (req, res) => {
  if (!isAuthed(req)) return res.status(401).json({ ok: false, error: 'Unauthorized' });

  // GET — auto-heal corrupted QR data on read
  if (req.method === 'GET') {
    try {
      const { data, sha } = await readFile('payment_config.json');
      // Auto-heal: if corrupted data exists, clean and save it
      const tbQR = cleanQR(data.telebirr?.qr_image || '');
      const cbeQR = cleanQR(data.cbe?.qr_image || '');
      const wasCorrupted = tbQR !== (data.telebirr?.qr_image || '') || cbeQR !== (data.cbe?.qr_image || '');
      if (wasCorrupted) {
        data.telebirr.qr_image = tbQR;
        data.cbe.qr_image = cbeQR;
        // Save cleaned version back to GitHub
        await writeFile('payment_config.json', data, sha, 'Auto-heal: remove corrupted QR data');
      }
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
          qr_image:     cleanQR(existing.telebirr?.qr_image || ''),
        },
        cbe: {
          account:      String(b.cbe?.account      || existing.cbe?.account      || ''),
          account_name: String(b.cbe?.account_name || existing.cbe?.account_name || ''),
          hint:         String(b.cbe?.hint         || existing.cbe?.hint         || ''),
          qr_image:     cleanQR(existing.cbe?.qr_image || ''),
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
