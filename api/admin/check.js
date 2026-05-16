const { isAuthed } = require('./_utils');

module.exports = (req, res) => {
  res.json({ ok: isAuthed(req) });
};
