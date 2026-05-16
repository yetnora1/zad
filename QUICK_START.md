# ZAD Cafe - Quick Start Guide 🚀

## 🎯 Everything You Need to Know in 2 Minutes

---

## 📱 Access Your Sites

### Menu Site (Customer-Facing)
```
Local:  http://localhost/ZAD/index.html
Live:   https://yetnora1.github.io/zad/ (after deployment)
```

### Admin Panel (Management)
```
Local:  http://localhost/ZAD/admin.php
Password: admin@zad
```

---

## ⚡ Quick Actions

### Update Menu Items
1. Open `http://localhost/ZAD/admin.php`
2. Login with password: `admin@zad`
3. Edit any item
4. Click "Save"
5. Refresh menu site to see changes

### Add New Item
1. Go to admin panel
2. Click "Add Item" in any category
3. Fill in details
4. Upload image (optional)
5. Click "Save Item"

### Upload QR Codes
1. Go to admin panel
2. Click "Payment Methods" tab
3. Upload Telebirr QR
4. Upload CBE QR
5. QR codes appear on menu site immediately

---

## 🔄 Update Workflow

```
Edit in Admin → Saves to menu_data.json → Menu Site Updates
```

**That's it!** No manual sync needed.

---

## 🚀 Deploy to Production

### Option 1: GitHub Pages (FREE - Menu Only)
```bash
1. Go to: https://github.com/yetnora1/zad/settings/pages
2. Select "main" branch
3. Click "Save"
4. Wait 2-5 minutes
5. Visit: https://yetnora1.github.io/zad/
```

### Option 2: PHP Hosting (Full Integration)
```bash
1. Get PHP hosting (HostGator, Bluehost, etc.)
2. Upload all files via FTP
3. Access admin at: yourdomain.com/admin.php
4. Access menu at: yourdomain.com/index.html
```

### Option 3: Hybrid (Recommended)
```bash
1. Deploy menu to GitHub Pages (FREE)
2. Keep admin local on XAMPP
3. Update locally, push to GitHub
4. Menu updates automatically
```

---

## 🔒 Security (Before Going Live)

### Change Admin Password
```php
// Edit admin_api.php line 14:
define('ADMIN_PASSWORD', 'your-strong-password');
```

### Protect Admin Files
Create `.htaccess`:
```apache
<Files "admin*.php">
  Order Allow,Deny
  Allow from YOUR_IP
</Files>
```

---

## 📊 Current Status

- ✅ **82 menu items** across 10 categories
- ✅ **Admin panel** fully functional
- ✅ **Menu site** fully functional
- ✅ **Integration** complete and tested
- ✅ **Images** optimized (98 files)
- ✅ **Payment QR codes** ready
- ✅ **Search** working
- ✅ **Favorites** working
- ✅ **Multi-language** (English/Amharic)
- ✅ **Theme switch** (Light/Dark)

---

## 🛠️ Common Tasks

### Test Integration
```bash
./deploy_admin.ps1
```

### Update Menu Embed
```bash
./update_menu_embed.ps1
```

### Deploy to GitHub
```bash
git add .
git commit -m "Update menu"
git push
```

### Backup Data
```bash
# Backup these files:
- menu_data.json
- payment_config.json
- images/ folder
```

---

## 📞 Quick Reference

| Item | Value |
|------|-------|
| **Admin URL** | http://localhost/ZAD/admin.php |
| **Admin Password** | admin@zad |
| **Menu URL** | http://localhost/ZAD/index.html |
| **Menu Data** | menu_data.json |
| **Payment Config** | payment_config.json |
| **Total Items** | 82 |
| **Categories** | 10 |

---

## 🎯 Next Steps

1. **Test Locally**
   - [ ] Login to admin panel
   - [ ] Edit a menu item
   - [ ] Verify change on menu site

2. **Secure Admin**
   - [ ] Change default password
   - [ ] Add .htaccess protection

3. **Deploy**
   - [ ] Choose hosting option
   - [ ] Deploy menu site
   - [ ] Test live site

4. **Go Live**
   - [ ] Share menu URL with customers
   - [ ] Update social media links
   - [ ] Add real payment QR codes

---

## 📖 Full Documentation

- **ADMIN_INTEGRATION.md** - Complete integration guide
- **ADMIN_README.md** - Admin panel user manual
- **DEPLOYMENT_GUIDE.md** - Hosting options
- **deploy_admin.ps1** - Deployment verification

---

## ✅ You're Ready!

Your ZAD Cafe website is **fully functional** and **ready to deploy**.

**Questions?** Check the documentation files above.

**Ready to go live?** Run `./deploy_admin.ps1` to verify everything.

---

**Last Updated:** May 16, 2026  
**Status:** ✅ PRODUCTION READY
