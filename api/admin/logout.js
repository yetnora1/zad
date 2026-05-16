module.exports = (req, res) => {
  res.setHeader('Set-Cookie', 'zad_admin=; Path=/; HttpOnly; Max-Age=0');
  res.json({ ok: true });
};
