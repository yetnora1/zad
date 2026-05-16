# ZAD Cafe - System Architecture

## 🏗️ System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     ZAD CAFE SYSTEM                         │
└─────────────────────────────────────────────────────────────┘

┌──────────────────┐         ┌──────────────────┐
│   ADMIN PANEL    │         │    MENU SITE     │
│   (admin.php)    │         │  (index.html)    │
│                  │         │                  │
│  • Add Items     │         │  • View Menu     │
│  • Edit Items    │         │  • Search        │
│  • Delete Items  │         │  • Favorites     │
│  • Upload Images │         │  • Language      │
│  • Manage QR     │         │  • Theme         │
└────────┬─────────┘         └────────┬─────────┘
         │                            │
         │                            │
         ▼                            ▼
┌──────────────────┐         ┌──────────────────┐
│   ADMIN API      │         │  MENU LOADER     │
│ (admin_api.php)  │         │ (load_menu.js)   │
│                  │         │                  │
│  • CRUD Ops      │         │  • Fetch Data    │
│  • Auth          │         │  • Render Menu   │
│  • File Upload   │         │  • Search Logic  │
└────────┬─────────┘         └────────┬─────────┘
         │                            │
         │                            │
         └────────────┬───────────────┘
                      ▼
         ┌────────────────────────┐
         │   DATA LAYER           │
         │                        │
         │  menu_data.json        │
         │  payment_config.json   │
         │  images/               │
         └────────────────────────┘
```

---

## 🔄 Data Flow

### Admin Panel → Menu Site

```
1. Admin logs in
   ↓
2. Admin edits menu item
   ↓
3. admin_api.php validates data
   ↓
4. Data saved to menu_data.json
   ↓
5. Menu site loads updated data
   ↓
6. Customer sees new menu
```

### Customer View

```
1. Customer opens menu site
   ↓
2. load_menu.js fetches menu_data.json
   ↓
3. Menu rendered dynamically
   ↓
4. Customer can search, filter, favorite
   ↓
5. Customer sees payment QR codes
```

---

## 📁 File Structure

```
ZAD/
│
├── 🎨 FRONTEND (Customer-Facing)
│   ├── index.html              # Main menu site
│   ├── load_menu.js            # Dynamic menu loader
│   └── images/                 # Product images (98 files)
│
├── 🔐 BACKEND (Admin)
│   ├── admin.php               # Admin panel UI
│   ├── admin_api.php           # API endpoints
│   └── telegram_config.php     # Telegram integration
│
├── 💾 DATA
│   ├── menu_data.json          # Menu items database
│   └── payment_config.json     # Payment settings
│
├── 📝 DOCUMENTATION
│   ├── ADMIN_INTEGRATION.md    # Integration guide
│   ├── ADMIN_README.md         # Admin manual
│   ├── DEPLOYMENT_GUIDE.md     # Hosting guide
│   ├── QUICK_START.md          # Quick reference
│   └── SYSTEM_ARCHITECTURE.md  # This file
│
└── 🚀 DEPLOYMENT
    ├── deploy_admin.ps1        # Admin deployment
    ├── deploy.ps1              # General deployment
    └── vercel.json             # Vercel config
```

---

## 🔌 API Endpoints

### Admin API (admin_api.php)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `?action=login` | POST | Admin authentication |
| `?action=logout` | POST | End admin session |
| `?action=check` | GET | Check auth status |
| `?action=get_menu` | GET | Fetch menu data |
| `?action=save_menu` | POST | Update menu data |
| `?action=get_payment` | GET | Fetch payment config |
| `?action=save_payment` | POST | Update payment config |
| `?action=upload_qr` | POST | Upload QR code image |
| `?action=upload_image` | POST | Upload product image |

---

## 🗄️ Data Schema

### menu_data.json

```json
{
  "category_name": [
    {
      "n": "Item Name",
      "a": "Amharic Name",
      "p": 300,
      "d": "Description",
      "i": "images/item.jpg",
      "b": "Badge (optional)",
      "dt": ["v", "gf", "sp"],
      "nut": {
        "cal": 500,
        "pro": 20,
        "carb": 60,
        "fat": 15
      }
    }
  ]
}
```

### payment_config.json

```json
{
  "telebirr": {
    "phone": "+251912345678",
    "account_name": "ZAD Cafe",
    "hint": "Scan to pay",
    "qr_image": "images/telebirr_qr.png"
  },
  "cbe": {
    "account": "1000123456",
    "account_name": "ZAD Cafe",
    "hint": "Scan to pay",
    "qr_image": "images/cbe_qr.png"
  }
}
```

---

## 🔐 Security Architecture

### Authentication Flow

```
1. Admin enters password
   ↓
2. admin_api.php validates
   ↓
3. Session created (PHP)
   ↓
4. Session checked on each request
   ↓
5. Unauthorized requests rejected
```

### Security Layers

```
┌─────────────────────────────────┐
│  Layer 1: Password Protection   │
│  - Strong password required     │
│  - Session-based auth           │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  Layer 2: Input Validation      │
│  - Sanitize all inputs          │
│  - Validate file types          │
│  - Check file sizes             │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  Layer 3: File Permissions      │
│  - Restrict write access        │
│  - Protect sensitive files      │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  Layer 4: HTTPS (Production)    │
│  - Encrypted connections        │
│  - Secure data transfer         │
└─────────────────────────────────┘
```

---

## 🌐 Deployment Architecture

### Option 1: Local Development

```
┌──────────────────┐
│   XAMPP Server   │
│   (localhost)    │
│                  │
│  • Apache        │
│  • PHP           │
│  • File System   │
└──────────────────┘
```

### Option 2: GitHub Pages (Menu Only)

```
┌──────────────────┐         ┌──────────────────┐
│  Local XAMPP     │         │  GitHub Pages    │
│  (Admin Panel)   │         │  (Menu Site)     │
│                  │         │                  │
│  • Edit Menu     │────────▶│  • Serve HTML    │
│  • Upload Images │  Push   │  • Serve JSON    │
│  • Manage Data   │         │  • Serve Images  │
└──────────────────┘         └──────────────────┘
```

### Option 3: Full PHP Hosting

```
┌──────────────────────────────────┐
│      PHP Hosting Server          │
│                                  │
│  ┌────────────┐  ┌────────────┐ │
│  │   Admin    │  │    Menu    │ │
│  │   Panel    │  │    Site    │ │
│  └────────────┘  └────────────┘ │
│         │              │         │
│         └──────┬───────┘         │
│                ▼                 │
│         ┌────────────┐           │
│         │    Data    │           │
│         │   Layer    │           │
│         └────────────┘           │
└──────────────────────────────────┘
```

---

## 📊 Performance Optimization

### Frontend Optimization

```
• Minified CSS (inline)
• Optimized images (WebP, compressed)
• Lazy loading for images
• Efficient search algorithm
• Local storage for favorites
• Cached theme preference
```

### Backend Optimization

```
• JSON file-based (no database overhead)
• Session-based auth (fast)
• Direct file operations
• Minimal API calls
• Efficient file uploads
```

---

## 🔄 Integration Points

### 1. Menu Data Integration

```
Admin Panel ──┐
              ├──▶ menu_data.json ──▶ Menu Site
Load Menu.js ─┘
```

### 2. Payment Integration

```
Admin Panel ──▶ payment_config.json ──▶ Menu Site
                                         (QR Codes)
```

### 3. Image Integration

```
Admin Panel ──▶ images/ folder ──▶ Menu Site
(Upload)                          (Display)
```

---

## 🧪 Testing Architecture

### Local Testing

```
1. XAMPP Running
   ↓
2. Access admin.php
   ↓
3. Make changes
   ↓
4. Verify in menu_data.json
   ↓
5. Refresh index.html
   ↓
6. Confirm changes visible
```

### Production Testing

```
1. Deploy to hosting
   ↓
2. Test admin login
   ↓
3. Test CRUD operations
   ↓
4. Test image uploads
   ↓
5. Test menu site display
   ↓
6. Test on mobile devices
```

---

## 📈 Scalability

### Current Capacity

- **Menu Items:** Unlimited (JSON-based)
- **Images:** Limited by disk space
- **Categories:** 10 (expandable)
- **Concurrent Users:** Depends on hosting

### Future Enhancements

```
Possible Upgrades:
├── Database (MySQL/PostgreSQL)
├── CDN for images
├── Caching layer (Redis)
├── API rate limiting
├── Multi-admin support
├── Order management system
└── Analytics dashboard
```

---

## 🔧 Maintenance

### Regular Tasks

```
Daily:
  • Monitor admin access
  • Check error logs

Weekly:
  • Backup menu_data.json
  • Backup payment_config.json
  • Backup images folder

Monthly:
  • Update PHP version
  • Review security
  • Optimize images
  • Clean unused files
```

---

## 📞 System Status

| Component | Status | Notes |
|-----------|--------|-------|
| Admin Panel | ✅ | Fully functional |
| Menu Site | ✅ | Fully functional |
| Integration | ✅ | Complete |
| Data Layer | ✅ | JSON-based |
| Images | ✅ | 98 files optimized |
| Payment QR | ✅ | Ready for upload |
| Security | ⚠️ | Change default password |
| Deployment | 🟡 | Ready for production |

---

## 🎯 System Capabilities

### What It Can Do

- ✅ Manage 82+ menu items
- ✅ 10 categories
- ✅ Multi-language (English/Amharic)
- ✅ Theme switching (Light/Dark)
- ✅ Search functionality
- ✅ Favorites system
- ✅ Payment QR codes
- ✅ Image uploads
- ✅ Real-time updates
- ✅ Mobile responsive

### What It Cannot Do (Yet)

- ❌ Online ordering
- ❌ Payment processing
- ❌ User accounts
- ❌ Order tracking
- ❌ Inventory management
- ❌ Analytics dashboard

---

**System Version:** 1.0  
**Last Updated:** May 16, 2026  
**Status:** ✅ PRODUCTION READY
