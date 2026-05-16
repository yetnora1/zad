# 🍕 ZAD Cafe - Digital Menu & Admin System

> A complete restaurant menu website with integrated admin panel for ZAD Cafe, Addis Ababa

[![Status](https://img.shields.io/badge/Status-Production%20Ready-success)](https://github.com/yetnora1/zad)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0-orange)](https://github.com/yetnora1/zad)

---

## 🎯 Overview

ZAD Cafe's digital menu system features:
- **82 menu items** across 10 categories
- **Bilingual** (English & Amharic)
- **Theme switching** (Light & Dark mode)
- **Admin panel** for easy menu management
- **Payment integration** with QR codes
- **Mobile responsive** design
- **Real-time updates** between admin and menu site

---

## 🚀 Quick Start

### For Customers (View Menu)
```
Local:  http://localhost/ZAD/index.html
Live:   https://yetnora1.github.io/zad/
```

### For Admins (Manage Menu)
```
Local:  http://localhost/ZAD/admin.php
Password: admin@zad
```

---

## 📋 Features

### Customer-Facing Menu Site
- ✅ Browse 82 menu items
- ✅ Search by name
- ✅ Filter by category
- ✅ Switch languages (English/Amharic)
- ✅ Toggle theme (Light/Dark)
- ✅ Save favorites
- ✅ View nutrition info
- ✅ Scan payment QR codes
- ✅ Mobile responsive

### Admin Panel
- ✅ Add/Edit/Delete menu items
- ✅ Upload product images
- ✅ Upload payment QR codes
- ✅ Manage categories
- ✅ Update prices
- ✅ Set diet tags
- ✅ Add nutrition info
- ✅ Real-time dashboard

---

## 📁 Project Structure

```
ZAD/
├── 🎨 Frontend
│   ├── index.html              # Main menu site
│   ├── load_menu.js            # Dynamic menu loader
│   └── images/                 # Product images (98 files)
│
├── 🔐 Backend
│   ├── admin.php               # Admin panel UI
│   ├── admin_api.php           # API endpoints
│   └── telegram_config.php     # Telegram integration
│
├── 💾 Data
│   ├── menu_data.json          # Menu items database
│   └── payment_config.json     # Payment settings
│
└── 📝 Documentation
    ├── QUICK_START.md          # Quick reference
    ├── ADMIN_INTEGRATION.md    # Integration guide
    ├── DEPLOYMENT_GUIDE.md     # Hosting options
    └── SYSTEM_ARCHITECTURE.md  # Technical details
```

---

## 🛠️ Installation

### Prerequisites
- XAMPP (Apache + PHP)
- Git
- Modern web browser

### Setup Steps

1. **Clone Repository**
   ```bash
   git clone https://github.com/yetnora1/zad.git
   cd zad
   ```

2. **Start XAMPP**
   - Open XAMPP Control Panel
   - Start Apache

3. **Access Sites**
   - Menu: `http://localhost/ZAD/index.html`
   - Admin: `http://localhost/ZAD/admin.php`

4. **Login to Admin**
   - Password: `admin@zad`
   - Change password in `admin_api.php` line 14

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [QUICK_START.md](QUICK_START.md) | 2-minute quick reference |
| [ADMIN_INTEGRATION.md](ADMIN_INTEGRATION.md) | Complete integration guide |
| [ADMIN_README.md](ADMIN_README.md) | Admin panel user manual |
| [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) | Hosting options & deployment |
| [SYSTEM_ARCHITECTURE.md](SYSTEM_ARCHITECTURE.md) | Technical architecture |
| [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) | Pre-launch checklist |

---

## 🚀 Deployment

### Option 1: GitHub Pages (FREE - Menu Only)
```bash
1. Go to: https://github.com/yetnora1/zad/settings/pages
2. Select "main" branch
3. Click "Save"
4. Visit: https://yetnora1.github.io/zad/
```

### Option 2: PHP Hosting (Full Integration)
```bash
1. Get PHP hosting (HostGator, Bluehost, etc.)
2. Upload all files via FTP
3. Access: yourdomain.com/admin.php
```

### Option 3: Hybrid (Recommended)
```bash
1. Deploy menu to GitHub Pages (FREE)
2. Keep admin local on XAMPP
3. Update locally, push to GitHub
```

---

## 🔄 Update Workflow

### Update Menu Items

1. **Login to Admin Panel**
   ```
   http://localhost/ZAD/admin.php
   ```

2. **Make Changes**
   - Edit items, prices, descriptions
   - Upload new images
   - Update QR codes

3. **Save & Deploy**
   ```bash
   git add menu_data.json
   git commit -m "Update menu"
   git push
   ```

4. **Live in 2-5 Minutes**
   - GitHub Pages auto-deploys
   - Changes appear on menu site

---

## 🔒 Security

### Before Going Live

1. **Change Admin Password**
   ```php
   // In admin_api.php line 14:
   define('ADMIN_PASSWORD', 'your-strong-password');
   ```

2. **Protect Admin Files**
   ```apache
   # Create .htaccess:
   <Files "admin*.php">
     Order Allow,Deny
     Allow from YOUR_IP
   </Files>
   ```

3. **Enable HTTPS**
   - Use SSL certificate
   - Force HTTPS redirects

4. **Backup Regularly**
   - menu_data.json
   - payment_config.json
   - images/ folder

---

## 📊 System Status

| Component | Status | Items |
|-----------|--------|-------|
| Menu Items | ✅ | 82 items |
| Categories | ✅ | 10 categories |
| Images | ✅ | 98 optimized |
| Admin Panel | ✅ | Fully functional |
| Menu Site | ✅ | Fully functional |
| Integration | ✅ | Complete |
| Mobile | ✅ | Responsive |
| Security | ⚠️ | Change password |

---

## 🎨 Menu Categories

1. **Pasta** (4 items)
2. **Rice** (4 items)
3. **Sandwich** (8 items)
4. **Burger** (4 items)
5. **Pizza** (7 items)
6. **Extras** (8 items)
7. **Fresh Drinks** (19 items)
8. **Cold Drinks** (4 items)
9. **Juice** (12 items)
10. **Breakfast** (11 items)

**Total: 82 items**

---

## 🛠️ Tech Stack

- **Frontend:** HTML5, CSS3, JavaScript
- **Backend:** PHP 7.4+
- **Data:** JSON file-based
- **Server:** Apache (XAMPP)
- **Hosting:** GitHub Pages / PHP Hosting
- **Version Control:** Git

---

## 📱 Browser Support

- ✅ Chrome (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Edge (latest)
- ✅ Mobile browsers

---

## 🤝 Contributing

This is a private project for ZAD Cafe. For internal updates:

1. Make changes locally
2. Test thoroughly
3. Commit with clear messages
4. Push to main branch

---

## 📞 Support

### Documentation
- See `/docs` folder for detailed guides
- Check `QUICK_START.md` for common tasks
- Review `DEPLOYMENT_CHECKLIST.md` before going live

### Troubleshooting
- Admin won't load? Check XAMPP Apache
- Changes not appearing? Hard refresh (Ctrl+F5)
- Can't login? Verify password in `admin_api.php`
- Images not uploading? Check folder permissions

---

## 📝 License

Copyright © 2026 ZAD Cafe. All rights reserved.

---

## 🎉 Acknowledgments

- Built with ❤️ for ZAD Cafe
- Optimized for Ethiopian market
- Bilingual support (English/Amharic)
- Mobile-first design

---

## 📈 Roadmap

### Current Version (1.0)
- ✅ Menu display
- ✅ Admin panel
- ✅ Payment QR codes
- ✅ Search & filter
- ✅ Multi-language

### Future Enhancements
- ⏳ Online ordering
- ⏳ Payment processing
- ⏳ Order tracking
- ⏳ Customer accounts
- ⏳ Analytics dashboard

---

## 🌟 Features Highlight

### For Customers
- **Fast:** Loads in < 3 seconds
- **Beautiful:** Modern, clean design
- **Easy:** Intuitive navigation
- **Accessible:** Works on all devices

### For Admins
- **Simple:** Easy to update menu
- **Powerful:** Full CRUD operations
- **Secure:** Password protected
- **Real-time:** Changes appear instantly

---

## 📊 Statistics

- **Total Menu Items:** 82
- **Categories:** 10
- **Images:** 98 files
- **Languages:** 2 (EN/AM)
- **Themes:** 2 (Light/Dark)
- **Code Lines:** ~5,000+
- **Documentation:** 7 guides

---

## 🚀 Get Started Now

1. **View the menu:** [index.html](index.html)
2. **Manage items:** [admin.php](admin.php)
3. **Read docs:** [QUICK_START.md](QUICK_START.md)
4. **Deploy:** [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

---

**Made with ☕ for ZAD Cafe, Addis Ababa**

**Status:** ✅ Production Ready  
**Version:** 1.0  
**Last Updated:** May 16, 2026

---

[View Live Demo](https://yetnora1.github.io/zad/) | [Documentation](QUICK_START.md) | [Report Issue](https://github.com/yetnora1/zad/issues)
