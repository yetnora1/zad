const { PASSWORD, createToken } = require('./_utils');

module.exports = async (req, res) => {
  if (req.method !== 'POST') return res.status(405).end();
  const { password } = req.body || {};
  if (password !== PASSWORD) return res.status(401).json({ ok: false, error: 'Wrong password' });
  const token = createToken();
  res.setHeader('Set-Cookie', `zad_admin=${token}; Path=/; HttpOnly; SameSite=Strict; Max-Age=86400`);
  res.json({ ok: true });
};
