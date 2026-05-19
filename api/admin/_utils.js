const crypto = require('crypto');
const https  = require('https');

const PASSWORD  = process.env.ADMIN_PASSWORD  || 'admin@zad';
const SECRET    = process.env.ADMIN_SECRET    || 'zad-admin-secret-2024';
const GH_TOKEN  = process.env.GITHUB_TOKEN    || '';
const GH_OWNER  = process.env.GITHUB_OWNER   || 'yetnora1';
const GH_REPO   = process.env.GITHUB_REPO    || 'zad';
const GH_BRANCH = 'main';

/* ── Auth ─────────────────────────────────────────────────── */
function createToken() {
  const b = Buffer.from(JSON.stringify({ t: Date.now() })).toString('base64url');
  const s = crypto.createHmac('sha256', SECRET).update(b).digest('hex');
  return `${b}.${s}`;
}

function verifyToken(token) {
  if (!token) return false;
  try {
    const [b, s] = token.split('.');
    const e = crypto.createHmac('sha256', SECRET).update(b).digest('hex');
    return s.length === e.length &&
      crypto.timingSafeEqual(Buffer.from(s, 'hex'), Buffer.from(e, 'hex'));
  } catch { return false; }
}

function getToken(req) {
  const m = (req.headers.cookie || '').match(/zad_admin=([^;]+)/);
  return m ? m[1] : null;
}

function isAuthed(req) { return verifyToken(getToken(req)); }

/* ── GitHub helpers ───────────────────────────────────────── */
function ghReq(method, path, body) {
  return new Promise((resolve, reject) => {
    const bStr = body ? JSON.stringify(body) : null;
    const opts = {
      hostname: 'api.github.com',
      path,
      method,
      headers: {
        Authorization: `Bearer ${GH_TOKEN}`,
        'User-Agent': 'ZAD-Admin',
        Accept: 'application/vnd.github+json',
        ...(bStr ? { 'Content-Type': 'application/json', 'Content-Length': Buffer.byteLength(bStr) } : {})
      }
    };
    const req = https.request(opts, res => {
      let d = '';
      res.on('data', c => d += c);
      res.on('end', () => { try { resolve(JSON.parse(d)); } catch (e) { reject(e); } });
    });
    req.on('error', reject);
    if (bStr) req.write(bStr);
    req.end();
  });
}

async function readFile(filePath) {
  const r = await ghReq('GET', `/repos/${GH_OWNER}/${GH_REPO}/contents/${filePath}?ref=${GH_BRANCH}&t=${Date.now()}`);
  if (r.message) throw new Error(r.message);
  return { data: JSON.parse(Buffer.from(r.content, 'base64').toString()), sha: r.sha };
}

async function writeFile(filePath, data, sha, msg) {
  const content = Buffer.from(JSON.stringify(data, null, 2)).toString('base64');
  const r = await ghReq('PUT', `/repos/${GH_OWNER}/${GH_REPO}/contents/${filePath}`, {
    message: msg, content, sha, branch: GH_BRANCH
  });
  // Check for GitHub API errors
  if (r.message && !r.content) throw new Error(`GitHub write failed: ${r.message}`);
  return r;
}

async function writeRawFile(filePath, base64Content, sha, msg) {
  const body = { message: msg, content: base64Content, branch: GH_BRANCH };
  if (sha) body.sha = sha;
  return ghReq('PUT', `/repos/${GH_OWNER}/${GH_REPO}/contents/${filePath}`, body);
}

async function getFileSha(filePath) {
  try {
    const r = await ghReq('GET', `/repos/${GH_OWNER}/${GH_REPO}/contents/${filePath}?ref=${GH_BRANCH}`);
    return r.sha || null;
  } catch { return null; }
}

module.exports = { PASSWORD, createToken, isAuthed, readFile, writeFile, writeRawFile, getFileSha };
