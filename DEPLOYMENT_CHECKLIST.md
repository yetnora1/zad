# ZAD Cafe - Deployment Checklist ✅

## 🎯 Pre-Deployment Checklist

Use this checklist before deploying to production.

---

## 📋 Phase 1: Local Testing

### Admin Panel Testing
- [ ] Can access admin panel at `http://localhost/ZAD/admin.php`
- [ ] Can login with password `admin@zad`
- [ ] Can view all 82 menu items
- [ ] Can add a new menu item
- [ ] Can edit an existing menu item
- [ ] Can delete a menu item
- [ ] Can upload a product image
- [ ] Can upload Telebirr QR code
- [ ] Can upload CBE QR code
- [ ] Can update payment details
- [ ] Dashboard statistics display correctly

### Menu Site Testing
- [ ] Can access menu site at `http://localhost/ZAD/index.html`
- [ ] All 82 menu items display correctly
- [ ] All images load properly
- [ ] Search functionality works
- [ ] Category filtering works
- [ ] Language switch (English/Amharic) works
- [ ] Theme switch (Light/Dark) works
- [ ] Favorites system works
- [ ] Item modals open correctly
- [ ] Payment QR codes display
- [ ] Social media links work
- [ ] Mobile responsive design works

### Integration Testing
- [ ] Edit item in admin panel
- [ ] Refresh menu site
- [ ] Verify change appears on menu site
- [ ] Upload new image in admin
- [ ] Verify image appears on menu site
- [ ] Update payment QR in admin
- [ ] Verify QR appears on menu site

---

## 🔒 Phase 2: Security

### Password Security
- [ ] Changed default admin password in `admin_api.php` line 14
- [ ] Password is strong (12+ characters, mixed case, numbers, symbols)
- [ ] Password is documented securely (password manager)

### File Protection
- [ ] Created `.htaccess` to protect admin files
- [ ] Tested admin access restrictions
- [ ] Verified unauthorized access is blocked

### Data Backup
- [ ] Backed up `menu_data.json`
- [ ] Backed up `payment_config.json`
- [ ] Backed up `images/` folder
- [ ] Stored backups in secure location

### File Permissions (for Linux/Unix hosting)
- [ ] Set `menu_data.json` to 644
- [ ] Set `payment_config.json` to 644
- [ ] Set `images/` folder to 755
- [ ] Set admin files to 644

---

## 🌐 Phase 3: Hosting Setup

### Choose Deployment Option

**Option A: GitHub Pages (Menu Only)**
- [ ] Enabled GitHub Pages in repository settings
- [ ] Selected `main` branch as source
- [ ] Verified site is live at `https://yetnora1.github.io/zad/`
- [ ] Tested all menu functionality
- [ ] Noted: Admin panel stays local

**Option B: PHP Hosting (Full Integration)**
- [ ] Purchased PHP hosting account
- [ ] Received FTP credentials
- [ ] Received domain name
- [ ] Configured DNS settings

**Option C: Hybrid (Recommended)**
- [ ] Enabled GitHub Pages for menu site
- [ ] Keeping admin panel local
- [ ] Documented update workflow

---

## 📤 Phase 4: File Upload (PHP Hosting Only)

### Upload Files via FTP
- [ ] Connected to FTP server
- [ ] Uploaded `index.html`
- [ ] Uploaded `admin.php`
- [ ] Uploaded `admin_api.php`
- [ ] Uploaded `load_menu.js`
- [ ] Uploaded `menu_data.json`
- [ ] Uploaded `payment_config.json`
- [ ] Uploaded `telegram_config.php`
- [ ] Uploaded `send_feedback.php`
- [ ] Uploaded `subscribe.php`
- [ ] Uploaded entire `images/` folder (98 files)
- [ ] Uploaded `.htaccess` (if created)
- [ ] Uploaded `vercel.json` (if using Vercel)

### Verify File Structure
- [ ] All files in correct locations
- [ ] No missing files
- [ ] File permissions set correctly

---

## 🧪 Phase 5: Production Testing

### Menu Site Testing
- [ ] Access live menu site URL
- [ ] All pages load correctly
- [ ] All images display
- [ ] No broken links
- [ ] Search works
- [ ] Filters work
- [ ] Language switch works
- [ ] Theme switch works
- [ ] Mobile view works
- [ ] Tablet view works
- [ ] Desktop view works

### Admin Panel Testing (PHP Hosting Only)
- [ ] Access live admin panel URL
- [ ] Can login successfully
- [ ] Can view menu items
- [ ] Can add new item
- [ ] Can edit item
- [ ] Can delete item
- [ ] Can upload images
- [ ] Can upload QR codes
- [ ] Changes reflect on menu site

### Performance Testing
- [ ] Page load time < 3 seconds
- [ ] Images load quickly
- [ ] No console errors
- [ ] No PHP errors
- [ ] Search is responsive
- [ ] Smooth scrolling

---

## 🔐 Phase 6: SSL/HTTPS

### Enable HTTPS
- [ ] SSL certificate installed
- [ ] HTTPS enabled on hosting
- [ ] HTTP redirects to HTTPS
- [ ] Mixed content warnings resolved
- [ ] All resources load via HTTPS

### Test HTTPS
- [ ] Menu site loads via HTTPS
- [ ] Admin panel loads via HTTPS
- [ ] No security warnings
- [ ] Padlock icon shows in browser

---

## 📱 Phase 7: Mobile Testing

### Test on Real Devices
- [ ] iPhone (Safari)
- [ ] Android (Chrome)
- [ ] Tablet (iPad/Android)

### Mobile Functionality
- [ ] Menu displays correctly
- [ ] Images load properly
- [ ] Search works
- [ ] Modals open correctly
- [ ] QR codes are scannable
- [ ] Touch interactions work
- [ ] No horizontal scrolling
- [ ] Text is readable

---

## 🎨 Phase 8: Content Verification

### Menu Items
- [ ] All 82 items present
- [ ] All prices correct
- [ ] All descriptions accurate
- [ ] All images appropriate
- [ ] Amharic translations correct
- [ ] No typos or errors

### Payment Information
- [ ] Telebirr QR code is correct
- [ ] CBE QR code is correct
- [ ] Account details accurate
- [ ] QR codes are scannable

### Branding
- [ ] Logo displays correctly
- [ ] Colors match brand
- [ ] Fonts are consistent
- [ ] Social media links correct

---

## 📊 Phase 9: Analytics & Monitoring

### Setup Analytics (Optional)
- [ ] Google Analytics installed
- [ ] Tracking code added
- [ ] Goals configured
- [ ] Testing tracking

### Monitoring
- [ ] Uptime monitoring setup
- [ ] Error logging enabled
- [ ] Performance monitoring active

---

## 🚀 Phase 10: Go Live

### Final Checks
- [ ] All previous phases completed
- [ ] Backup created
- [ ] Team notified
- [ ] Documentation updated

### Launch
- [ ] DNS propagated (if custom domain)
- [ ] Site is live and accessible
- [ ] Admin panel accessible (if deployed)
- [ ] No critical errors

### Post-Launch
- [ ] Announced on social media
- [ ] Updated business cards/flyers
- [ ] Notified customers
- [ ] Monitored for issues

---

## 📞 Phase 11: Support & Maintenance

### Documentation
- [ ] Admin manual shared with team
- [ ] Update procedures documented
- [ ] Backup procedures documented
- [ ] Emergency contacts listed

### Training
- [ ] Staff trained on admin panel
- [ ] Update workflow explained
- [ ] Troubleshooting guide provided

### Maintenance Schedule
- [ ] Daily: Monitor access logs
- [ ] Weekly: Backup data files
- [ ] Monthly: Review security
- [ ] Quarterly: Update content

---

## 🐛 Troubleshooting

### Common Issues

**Issue: Admin panel not loading**
- [ ] Check PHP is enabled
- [ ] Verify file permissions
- [ ] Check error logs
- [ ] Test locally first

**Issue: Images not displaying**
- [ ] Verify image paths
- [ ] Check file permissions
- [ ] Test image URLs directly
- [ ] Clear browser cache

**Issue: Changes not appearing**
- [ ] Hard refresh (Ctrl+F5)
- [ ] Check menu_data.json updated
- [ ] Verify file permissions
- [ ] Clear server cache

**Issue: Can't login to admin**
- [ ] Verify password
- [ ] Check PHP sessions enabled
- [ ] Review error logs
- [ ] Test locally

---

## ✅ Deployment Complete

### Final Verification

- [ ] Menu site is live
- [ ] Admin panel is accessible
- [ ] All features working
- [ ] No critical errors
- [ ] Team is trained
- [ ] Documentation complete

### URLs to Share

**Menu Site:**
```
Production: ___________________________
```

**Admin Panel:**
```
Production: ___________________________
Password: ___________________________
```

---

## 📝 Notes

### Deployment Date
```
Date: ___________________________
Time: ___________________________
By: ___________________________
```

### Issues Encountered
```
1. ___________________________
2. ___________________________
3. ___________________________
```

### Resolutions
```
1. ___________________________
2. ___________________________
3. ___________________________
```

---

## 🎉 Success Criteria

Your deployment is successful when:

- ✅ Menu site loads in < 3 seconds
- ✅ All 82 items display correctly
- ✅ Admin panel is secure and functional
- ✅ Mobile experience is smooth
- ✅ No console errors
- ✅ No broken images
- ✅ Search works perfectly
- ✅ QR codes are scannable
- ✅ Team can update menu independently

---

**Checklist Version:** 1.0  
**Last Updated:** May 16, 2026  
**Status:** Ready for Use

---

## 📖 Related Documents

- **QUICK_START.md** - Quick reference guide
- **ADMIN_INTEGRATION.md** - Integration details
- **DEPLOYMENT_GUIDE.md** - Hosting options
- **SYSTEM_ARCHITECTURE.md** - Technical overview
