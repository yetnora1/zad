const { isAuthed, readFile, writeFile } = require('./_utils');

const VALID_CATS = ['pasta','rice','sandwich','burger','pizza','extra','fresh','cold','juice','breakfast'];

module.exports = async (req, res) => {
  if (!isAuthed(req)) return res.status(401).json({ ok: false, error: 'Unauthorized' });

  // GET — return current menu
  if (req.method === 'GET') {
    try {
      const { data } = await readFile('menu_data.json');
      return res.json({ ok: true, data });
    } catch (e) {
      return res.status(500).json({ ok: false, error: e.message });
    }
  }

  // POST — save menu
  if (req.method === 'POST') {
    try {
      const incoming = req.body;
      if (!incoming || typeof incoming !== 'object') return res.status(400).json({ ok: false, error: 'Invalid data' });

      const { sha } = await readFile('menu_data.json');

      // Sanitize
      const clean = {};
      for (const cat of VALID_CATS) {
        clean[cat] = (incoming[cat] || [])
          .filter(i => i.n)
          .map(i => {
            const entry = { n: String(i.n), a: String(i.a || ''), p: parseInt(i.p) || 0, d: String(i.d || ''), i: String(i.i || '') };
            if (i.b) entry.b = String(i.b);
            if (Array.isArray(i.dt) && i.dt.length) entry.dt = i.dt.filter(t => ['v','gf','sp'].includes(t));
            if (i.nut) entry.nut = { cal: parseInt(i.nut.cal)||0, pro: parseInt(i.nut.pro)||0, carb: parseInt(i.nut.carb)||0, fat: parseInt(i.nut.fat)||0 };
            return entry;
          });
      }

      await writeFile('menu_data.json', clean, sha, 'Admin: update menu data');
      return res.json({ ok: true });
    } catch (e) {
      return res.status(500).json({ ok: false, error: e.message });
    }
  }

  res.status(405).end();
};
