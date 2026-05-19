const { readFile } = require('./admin/_utils');

module.exports = async (req, res) => {
  // Public endpoint - no auth required
  // Returns latest payment_config.json directly from GitHub (bypasses Vercel static cache)
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate');
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  try {
    const { data } = await readFile('payment_config.json');
    // Clean any corrupted QR data
    if(data.telebirr?.qr_image?.includes('?'))data.telebirr.qr_image=data.telebirr.qr_image.split('?')[0];
    if(data.cbe?.qr_image?.includes('?'))data.cbe.qr_image=data.cbe.qr_image.split('?')[0];
    return res.json({ ok: true, data });
  } catch (e) {
    return res.status(500).json({ ok: false, error: e.message });
  }
};
