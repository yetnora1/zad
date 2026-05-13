<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ZAD Cafe - Admin Panel</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root{--primary:#E8784A;--secondary:#D4A853;--dark:#1a0f0a;--light:#F5E6D3;--bg:#2C1810;--card:#3D2317;--border:rgba(212,168,83,0.2);--shadow:rgba(0,0,0,0.3);}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:var(--dark);color:var(--light);line-height:1.6;min-height:100vh;}
.container{max-width:1400px;margin:0 auto;padding:2rem;}
.header{background:linear-gradient(135deg,var(--primary),var(--secondary));padding:2rem;border-radius:16px;margin-bottom:2rem;box-shadow:0 10px 40px var(--shadow);}
.header h1{font-size:2rem;color:#fff;margin-bottom:.5rem;}
.header p{color:rgba(255,255,255,.9);font-size:.95rem;}
.logout-btn{position:absolute;top:2rem;right:2rem;padding:.7rem 1.5rem;background:rgba(255,255,255,.2);color:#fff;border:1px solid rgba(255,255,255,.3);border-radius:8px;cursor:pointer;transition:.3s;font-family:'Poppins',sans-serif;font-size:.9rem;}
.logout-btn:hover{background:rgba(255,255,255,.3);}
.tabs{display:flex;gap:1rem;margin-bottom:2rem;border-bottom:2px solid var(--border);}
.tab{padding:1rem 2rem;background:transparent;border:none;color:var(--light);cursor:pointer;font-family:'Poppins',sans-serif;font-size:.95rem;transition:.3s;border-bottom:3px solid transparent;margin-bottom:-2px;}
.tab.active{color:var(--primary);border-bottom-color:var(--primary);font-weight:600;}
.tab:hover{color:var(--primary);}
.tab-content{display:none;}
.tab-content.active{display:block;}
.card{background:var(--card);border-radius:16px;padding:2rem;margin-bottom:2rem;border:1px solid var(--border);box-shadow:0 5px 20px var(--shadow);}
.card h2{color:var(--primary);margin-bottom:1.5rem;font-size:1.5rem;}
.form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:1.5rem;margin-bottom:1.5rem;}
.form-group{display:flex;flex-direction:column;gap:.5rem;}
.form-group label{color:var(--secondary);font-size:.9rem;font-weight:600;}
.form-group input,.form-group select,.form-group textarea{padding:.8rem;border-radius:8px;border:1px solid var(--border);background:var(--bg);color:var(--light);font-family:'Poppins',sans-serif;font-size:.9rem;}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{outline:none;border-color:var(--primary);}
.form-group textarea{resize:vertical;min-height:80px;}
.btn{padding:.8rem 1.5rem;border-radius:8px;border:none;cursor:pointer;font-family:'Poppins',sans-serif;font-size:.9rem;font-weight:600;transition:.3s;}
.btn-primary{background:var(--primary);color:#fff;}
.btn-primary:hover{background:#c25e28;transform:translateY(-2px);box-shadow:0 5px 15px rgba(232,120,74,.4);}
.btn-secondary{background:var(--secondary);color:var(--dark);}
.btn-secondary:hover{background:#b8922e;}
.btn-danger{background:#e74c3c;color:#fff;}
.btn-danger:hover{background:#c0392b;}
.btn-success{background:#27ae60;color:#fff;}
.btn-success:hover{background:#229954;}
.btn-small{padding:.5rem 1rem;font-size:.85rem;}
.items-grid{display:grid;gap:1rem;}
.item-row{background:var(--bg);border-radius:12px;padding:1.5rem;border:1px solid var(--border);display:grid;grid-template-columns:80px 1fr auto;gap:1.5rem;align-items:center;}
.item-img{width:80px;height:80px;border-radius:8px;object-fit:cover;background:var(--dark);}
.item-info h3{color:var(--light);font-size:1.1rem;margin-bottom:.3rem;}
.item-info p{color:var(--secondary);font-size:.85rem;margin-bottom:.2rem;}
.item-price{color:var(--primary);font-size:1.2rem;font-weight:700;}
.item-actions{display:flex;gap:.5rem;}
.category-section{margin-bottom:3rem;}
.category-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem;padding-bottom:1rem;border-bottom:2px solid var(--border);}
.category-header h3{color:var(--secondary);font-size:1.3rem;text-transform:capitalize;}
.modal{display:none;position:fixed;inset:0;background:rgba(0,0,0,.8);backdrop-filter:blur(5px);z-index:1000;align-items:center;justify-content:center;padding:2rem;}
.modal.active{display:flex;}
.modal-content{background:var(--card);border-radius:16px;max-width:600px;width:100%;max-height:90vh;overflow-y:auto;border:1px solid var(--border);}
.modal-header{padding:1.5rem;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center;}
.modal-header h3{color:var(--primary);font-size:1.3rem;}
.modal-close{background:none;border:none;color:var(--light);font-size:1.5rem;cursor:pointer;width:32px;height:32px;display:flex;align-items:center;justify-content:center;border-radius:50%;transition:.3s;}
.modal-close:hover{background:rgba(255,255,255,.1);}
.modal-body{padding:2rem;}
.alert{padding:1rem 1.5rem;border-radius:8px;margin-bottom:1.5rem;font-size:.9rem;}
.alert-success{background:rgba(39,174,96,.2);border:1px solid rgba(39,174,96,.4);color:#27ae60;}
.alert-error{background:rgba(231,76,60,.2);border:1px solid rgba(231,76,60,.4);color:#e74c3c;}
.login-container{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:2rem;}
.login-card{background:var(--card);border-radius:24px;padding:3rem;max-width:400px;width:100%;border:1px solid var(--border);box-shadow:0 20px 60px var(--shadow);}
.login-card h1{color:var(--primary);text-align:center;margin-bottom:2rem;font-size:2rem;}
.login-card .form-group{margin-bottom:1.5rem;}
.login-card .btn{width:100%;}
.image-preview{width:100%;max-width:200px;height:150px;border-radius:8px;object-fit:cover;margin-top:.5rem;background:var(--dark);border:1px solid var(--border);}
.checkbox-group{display:flex;gap:1rem;flex-wrap:wrap;}
.checkbox-label{display:flex;align-items:center;gap:.5rem;cursor:pointer;padding:.5rem 1rem;background:var(--bg);border-radius:8px;border:1px solid var(--border);transition:.3s;}
.checkbox-label:hover{border-color:var(--primary);}
.checkbox-label input{cursor:pointer;}
.nutrition-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:1rem;}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:1.5rem;margin-bottom:2rem;}
.stat-card{background:linear-gradient(135deg,var(--primary),var(--secondary));border-radius:12px;padding:1.5rem;text-align:center;color:#fff;}
.stat-card h3{font-size:2rem;margin-bottom:.3rem;}
.stat-card p{font-size:.9rem;opacity:.9;}
@media(max-width:768px){.form-grid{grid-template-columns:1fr;}.item-row{grid-template-columns:60px 1fr;}.item-actions{grid-column:1/-1;justify-content:flex-start;}.stats{grid-template-columns:repeat(2,1fr);}}
</style>
</head>
<body>

<div id="loginScreen" class="login-container">
<div class="login-card">
<h1><i class="fas fa-lock"></i> ZAD Admin</h1>
<div id="loginError"></div>
<div class="form-group">
<label>Password</label>
<input type="password" id="loginPassword" placeholder="Enter admin password">
</div>
<button class="btn btn-primary" onclick="login()">Login</button>
</div>
</div>

<div id="adminPanel" style="display:none;">
<button class="logout-btn" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>

<div class="container">
<div class="header">
<h1><i class="fas fa-coffee"></i> ZAD Cafe Admin Panel</h1>
<p>Manage your menu items and payment methods</p>
</div>

<div class="stats" id="stats"></div>

<div class="tabs">
<button class="tab active" onclick="switchTab('menu')"><i class="fas fa-utensils"></i> Menu Items</button>
<button class="tab" onclick="switchTab('payment')"><i class="fas fa-credit-card"></i> Payment Methods</button>
</div>

<div id="menuTab" class="tab-content active">
<div class="card">
<h2>Menu Management</h2>
<div id="menuContent"></div>
</div>
</div>

<div id="paymentTab" class="tab-content">
<div class="card">
<h2>Payment Configuration</h2>
<div id="paymentAlert"></div>
<div class="form-grid">
<div class="form-group">
<label><i class="fas fa-mobile-alt"></i> Telebirr Phone</label>
<input type="text" id="telebirrPhone" placeholder="+251912345678">
</div>
<div class="form-group">
<label>Telebirr Account Name</label>
<input type="text" id="telebirrName" placeholder="ZAD Cafe">
</div>
<div class="form-group">
<label>Telebirr Hint</label>
<input type="text" id="telebirrHint" placeholder="Scan to pay with Telebirr">
</div>
<div class="form-group">
<label><i class="fas fa-university"></i> CBE Account Number</label>
<input type="text" id="cbeAccount" placeholder="1000123456">
</div>
<div class="form-group">
<label>CBE Account Name</label>
<input type="text" id="cbeName" placeholder="ZAD Cafe">
</div>
<div class="form-group">
<label>CBE Hint</label>
<input type="text" id="cbeHint" placeholder="Scan to pay with CBE">
</div>
</div>
<button class="btn btn-primary" onclick="savePayment()"><i class="fas fa-save"></i> Save Payment Config</button>
</div>
</div>

</div>
</div>

<div id="itemModal" class="modal">
<div class="modal-content">
<div class="modal-header">
<h3 id="modalTitle">Add Item</h3>
<button class="modal-close" onclick="closeModal()">&times;</button>
</div>
<div class="modal-body">
<div id="modalAlert"></div>
<form id="itemForm" onsubmit="saveItem(event)">
<input type="hidden" id="editCategory">
<input type="hidden" id="editIndex">
<div class="form-grid">
<div class="form-group">
<label>English Name *</label>
<input type="text" id="itemName" required>
</div>
<div class="form-group">
<label>Amharic Name *</label>
<input type="text" id="itemAmharic" required>
</div>
<div class="form-group">
<label>Price (Birr) *</label>
<input type="number" id="itemPrice" min="0" required>
</div>
<div class="form-group">
<label>Category *</label>
<select id="itemCategory" required>
<option value="pasta">Pasta</option>
<option value="rice">Rice</option>
<option value="sandwich">Sandwich</option>
<option value="burger">Burger</option>
<option value="pizza">Pizza</option>
<option value="extra">Extras</option>
<option value="fresh">Fresh Drinks</option>
<option value="cold">Cold Drinks</option>
<option value="juice">Juice</option>
<option value="breakfast">Breakfast</option>
</select>
</div>
</div>
<div class="form-group">
<label>Description *</label>
<textarea id="itemDesc" required></textarea>
</div>
<div class="form-group">
<label>Image Path *</label>
<input type="text" id="itemImage" placeholder="images/item.jpg" required>
<input type="file" id="imageUpload" accept="image/*" onchange="uploadImage()" style="margin-top:.5rem;">
<img id="imagePreview" class="image-preview" style="display:none;">
</div>
<div class="form-group">
<label>Badge (optional)</label>
<input type="text" id="itemBadge" placeholder="Chef's Pick">
</div>
<div class="form-group">
<label>Diet Tags</label>
<div class="checkbox-group">
<label class="checkbox-label"><input type="checkbox" id="dietV" value="v"> Vegan</label>
<label class="checkbox-label"><input type="checkbox" id="dietGF" value="gf"> Gluten-Free</label>
<label class="checkbox-label"><input type="checkbox" id="dietSP" value="sp"> Spicy</label>
</div>
</div>
<div class="form-group">
<label>Nutrition Info (optional)</label>
<div class="nutrition-grid">
<input type="number" id="nutCal" placeholder="Calories" min="0">
<input type="number" id="nutPro" placeholder="Protein (g)" min="0">
<input type="number" id="nutCarb" placeholder="Carbs (g)" min="0">
<input type="number" id="nutFat" placeholder="Fat (g)" min="0">
</div>
</div>
<button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Item</button>
</form>
</div>
</div>
</div>

<script>
let menuData = {};
let paymentData = {};

async function api(action, data = null, method = 'POST') {
const opts = { method, headers: {} };
if (data) {
if (data instanceof FormData) {
opts.body = data;
} else {
opts.headers['Content-Type'] = 'application/json';
opts.body = JSON.stringify(data);
}
}
const url = `admin_api.php?action=${action}`;
const res = await fetch(url, opts);
return await res.json();
}

async function login() {
const pw = document.getElementById('loginPassword').value;
const result = await api('login', { password: pw });
if (result.ok) {
document.getElementById('loginScreen').style.display = 'none';
document.getElementById('adminPanel').style.display = 'block';
loadData();
} else {
document.getElementById('loginError').innerHTML = '<div class="alert alert-error">Wrong password</div>';
}
}

async function logout() {
await api('logout');
location.reload();
}

async function checkAuth() {
const result = await api('check', null, 'GET');
if (result.ok) {
document.getElementById('loginScreen').style.display = 'none';
document.getElementById('adminPanel').style.display = 'block';
loadData();
}
}

async function loadData() {
const menu = await api('get_menu', null, 'GET');
const payment = await api('get_payment', null, 'GET');
if (menu.ok) {
menuData = menu.data;
renderMenu();
updateStats();
}
if (payment.ok) {
paymentData = payment.data;
renderPayment();
}
}

function updateStats() {
let total = 0;
for (const cat in menuData) total += menuData[cat].length;
const categories = Object.keys(menuData).length;
const avgPrice = Math.round(Object.values(menuData).flat().reduce((sum, item) => sum + item.p, 0) / total);
const html = `
<div class="stat-card"><h3>${total}</h3><p>Total Items</p></div>
<div class="stat-card"><h3>${categories}</h3><p>Categories</p></div>
<div class="stat-card"><h3>${avgPrice} Birr</h3><p>Avg Price</p></div>
<div class="stat-card"><h3><i class="fas fa-check"></i></h3><p>All Systems OK</p></div>
`;
document.getElementById('stats').innerHTML = html;
}

function renderMenu() {
let html = '';
const cats = ['pasta','rice','sandwich','burger','pizza','extra','fresh','cold','juice','breakfast'];
for (const cat of cats) {
const items = menuData[cat] || [];
html += `<div class="category-section">
<div class="category-header">
<h3><i class="fas fa-utensils"></i> ${cat.charAt(0).toUpperCase() + cat.slice(1)} (${items.length})</h3>
<button class="btn btn-success btn-small" onclick="openAddModal('${cat}')"><i class="fas fa-plus"></i> Add Item</button>
</div>
<div class="items-grid">`;
items.forEach((item, idx) => {
html += `<div class="item-row">
<img src="${item.i}" class="item-img" alt="${item.n}">
<div class="item-info">
<h3>${item.n}</h3>
<p>${item.a}</p>
<p>${item.d}</p>
<span class="item-price">${item.p} Birr</span>
</div>
<div class="item-actions">
<button class="btn btn-secondary btn-small" onclick="editItem('${cat}', ${idx})"><i class="fas fa-edit"></i></button>
<button class="btn btn-danger btn-small" onclick="deleteItem('${cat}', ${idx})"><i class="fas fa-trash"></i></button>
</div>
</div>`;
});
html += '</div></div>';
}
document.getElementById('menuContent').innerHTML = html;
}

function renderPayment() {
document.getElementById('telebirrPhone').value = paymentData.telebirr?.phone || '';
document.getElementById('telebirrName').value = paymentData.telebirr?.account_name || '';
document.getElementById('telebirrHint').value = paymentData.telebirr?.hint || '';
document.getElementById('cbeAccount').value = paymentData.cbe?.account || '';
document.getElementById('cbeName').value = paymentData.cbe?.account_name || '';
document.getElementById('cbeHint').value = paymentData.cbe?.hint || '';
}

function switchTab(tab) {
document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
event.target.classList.add('active');
document.getElementById(tab + 'Tab').classList.add('active');
}

function openAddModal(cat) {
document.getElementById('modalTitle').textContent = 'Add New Item';
document.getElementById('itemForm').reset();
document.getElementById('editCategory').value = '';
document.getElementById('editIndex').value = '';
document.getElementById('itemCategory').value = cat;
document.getElementById('imagePreview').style.display = 'none';
document.getElementById('itemModal').classList.add('active');
}

function editItem(cat, idx) {
const item = menuData[cat][idx];
document.getElementById('modalTitle').textContent = 'Edit Item';
document.getElementById('editCategory').value = cat;
document.getElementById('editIndex').value = idx;
document.getElementById('itemName').value = item.n;
document.getElementById('itemAmharic').value = item.a;
document.getElementById('itemPrice').value = item.p;
document.getElementById('itemCategory').value = cat;
document.getElementById('itemDesc').value = item.d;
document.getElementById('itemImage').value = item.i;
document.getElementById('itemBadge').value = item.b || '';
document.getElementById('dietV').checked = item.dt?.includes('v') || false;
document.getElementById('dietGF').checked = item.dt?.includes('gf') || false;
document.getElementById('dietSP').checked = item.dt?.includes('sp') || false;
if (item.nut) {
document.getElementById('nutCal').value = item.nut.cal || '';
document.getElementById('nutPro').value = item.nut.pro || '';
document.getElementById('nutCarb').value = item.nut.carb || '';
document.getElementById('nutFat').value = item.nut.fat || '';
}
const preview = document.getElementById('imagePreview');
preview.src = item.i;
preview.style.display = 'block';
document.getElementById('itemModal').classList.add('active');
}

function closeModal() {
document.getElementById('itemModal').classList.remove('active');
document.getElementById('modalAlert').innerHTML = '';
}

async function saveItem(e) {
e.preventDefault();
const cat = document.getElementById('itemCategory').value;
const editCat = document.getElementById('editCategory').value;
const editIdx = document.getElementById('editIndex').value;
const item = {
n: document.getElementById('itemName').value,
a: document.getElementById('itemAmharic').value,
p: parseInt(document.getElementById('itemPrice').value),
d: document.getElementById('itemDesc').value,
i: document.getElementById('itemImage').value,
};
const badge = document.getElementById('itemBadge').value;
if (badge) item.b = badge;
const dt = [];
if (document.getElementById('dietV').checked) dt.push('v');
if (document.getElementById('dietGF').checked) dt.push('gf');
if (document.getElementById('dietSP').checked) dt.push('sp');
if (dt.length) item.dt = dt;
const cal = document.getElementById('nutCal').value;
const pro = document.getElementById('nutPro').value;
const carb = document.getElementById('nutCarb').value;
const fat = document.getElementById('nutFat').value;
if (cal || pro || carb || fat) {
item.nut = {
cal: parseInt(cal) || 0,
pro: parseInt(pro) || 0,
carb: parseInt(carb) || 0,
fat: parseInt(fat) || 0,
};
}
if (editIdx !== '') {
menuData[editCat][editIdx] = item;
if (editCat !== cat) {
menuData[editCat].splice(editIdx, 1);
menuData[cat].push(item);
}
} else {
if (!menuData[cat]) menuData[cat] = [];
menuData[cat].push(item);
}
const result = await api('save_menu', menuData);
if (result.ok) {
closeModal();
renderMenu();
updateStats();
showAlert('modalAlert', 'Item saved successfully!', 'success');
} else {
showAlert('modalAlert', 'Failed to save: ' + result.error, 'error');
}
}

async function deleteItem(cat, idx) {
if (!confirm('Delete this item?')) return;
menuData[cat].splice(idx, 1);
const result = await api('save_menu', menuData);
if (result.ok) {
renderMenu();
updateStats();
}
}

async function savePayment() {
const data = {
telebirr: {
phone: document.getElementById('telebirrPhone').value,
account_name: document.getElementById('telebirrName').value,
hint: document.getElementById('telebirrHint').value,
},
cbe: {
account: document.getElementById('cbeAccount').value,
account_name: document.getElementById('cbeName').value,
hint: document.getElementById('cbeHint').value,
}
};
const result = await api('save_payment', data);
if (result.ok) {
showAlert('paymentAlert', 'Payment config saved!', 'success');
} else {
showAlert('paymentAlert', 'Failed: ' + result.error, 'error');
}
}

async function uploadImage() {
const file = document.getElementById('imageUpload').files[0];
if (!file) return;
const fd = new FormData();
fd.append('image', file);
const result = await api('upload_image', fd);
if (result.ok) {
document.getElementById('itemImage').value = result.path;
const preview = document.getElementById('imagePreview');
preview.src = result.path;
preview.style.display = 'block';
} else {
alert('Upload failed: ' + result.error);
}
}

function showAlert(id, msg, type) {
const el = document.getElementById(id);
el.innerHTML = `<div class="alert alert-${type}">${msg}</div>`;
setTimeout(() => el.innerHTML = '', 3000);
}

checkAuth();
</script>
</body>
</html>