# ZAD Cafe Website - Deployment Guide

## Current Status
✅ **Local Development:** Running on XAMPP at `http://localhost/ZAD`  
✅ **GitHub Repository:** https://github.com/yetnora1/zad.git  
✅ **Ready for Production:** All files optimized and tested  

---

## Deployment Options

### Option 1: Deploy to GitHub Pages (FREE) ⭐ Recommended for Static Site

**Best for:** Simple, free hosting for your menu website

#### Steps:

1. **Enable GitHub Pages:**
   - Go to https://github.com/yetnora1/zad
   - Click **Settings** → **Pages**
   - Under "Source", select **main** branch
   - Click **Save**

2. **Your Website Will Be Live At:**
   ```
   https://yetnora1.github.io/zad/
   ```

3. **Wait 2-5 minutes** for deployment to complete

#### Pros:
- ✅ Completely FREE
- ✅ Automatic HTTPS
- ✅ Fast CDN delivery
- ✅ Auto-deploys on git push

#### Cons:
- ❌ PHP files won't work (admin.php, subscribe.php, etc.)
- ❌ No database support
- ❌ Static content only

---

### Option 2: Deploy to Netlify (FREE) ⭐ Recommended

**Best for:** Fast, free hosting with forms and serverless functions

#### Steps:

1. **Go to Netlify:**
   - Visit https://www.netlify.com
   - Click **Sign up** (use GitHub account)

2. **Import Your Repository:**
   - Click **Add new site** → **Import an existing project**
   - Choose **GitHub**
   - Select **yetnora1/zad** repository

3. **Deploy Settings:**
   - Build command: (leave empty)
   - Publish directory: `/`
   - Click **Deploy site**

4. **Your Website Will Be Live At:**
   ```
   https://your-site-name.netlify.app
   ```

5. **Custom Domain (Optional):**
   - Go to **Domain settings**
   - Add your custom domain (e.g., zadcafe.com)

#### Pros:
- ✅ FREE hosting
- ✅ Automatic HTTPS
- ✅ Form handling (for feedback)
- ✅ Serverless functions
- ✅ Custom domain support
- ✅ Auto-deploys on git push

#### Cons:
- ❌ PHP files need conversion to serverless functions

---

### Option 3: Deploy to Vercel (FREE)

**Best for:** Modern hosting with serverless API support

#### Steps:

1. **Go to Vercel:**
   - Visit https://vercel.com
   - Click **Sign up** (use GitHub account)

2. **Import Repository:**
   - Click **Add New** → **Project**
   - Import **yetnora1/zad**
   - Click **Deploy**

3. **Your Website Will Be Live At:**
   ```
   https://zad.vercel.app
   ```

#### Pros:
- ✅ FREE hosting
- ✅ Automatic HTTPS
- ✅ Serverless functions
- ✅ Fast global CDN
- ✅ Custom domain support

---

### Option 4: Deploy to Traditional Web Hosting

**Best for:** Full PHP and MySQL support (for admin panel)

#### Recommended Hosting Providers in Ethiopia:

1. **Ethio Telecom Cloud**
   - Local Ethiopian hosting
   - PHP & MySQL support
   - ~500-1000 ETB/year

2. **HostGator** (International)
   - Reliable hosting
   - cPanel included
   - ~$3-5/month

3. **Bluehost** (International)
   - WordPress optimized
   - Free domain first year
   - ~$3-5/month

#### Deployment Steps:

1. **Get Hosting Account:**
   - Sign up for hosting
   - Get FTP credentials
   - Get database credentials

2. **Upload Files via FTP:**
   ```
   Use FileZilla or cPanel File Manager
   Upload all files from C:\xampp\htdocs\ZAD
   ```

3. **Setup Database:**
   - Create MySQL database in cPanel
   - Import your database (if you have one)
   - Update database credentials in PHP files

4. **Configure Domain:**
   - Point your domain to hosting
   - Update DNS settings
   - Wait 24-48 hours for propagation

---

## Quick Deploy: GitHub Pages (Easiest)

Since your website is mostly static (HTML, CSS, JS), GitHub Pages is the fastest option:

### Step-by-Step:

1. **Open Browser:**
   - Go to https://github.com/yetnora1/zad

2. **Enable Pages:**
   - Click **Settings** tab
   - Scroll to **Pages** section (left sidebar)
   - Under "Source": Select **main** branch
   - Click **Save**

3. **Wait 2-5 Minutes:**
   - GitHub will build and deploy your site
   - Refresh the page to see the URL

4. **Your Live Website:**
   ```
   https://yetnora1.github.io/zad/
   ```

5. **Test Everything:**
   - Menu displays correctly ✅
   - Images load ✅
   - Search works ✅
   - Language switch works ✅
   - Theme switch works ✅

---

## What Works on Each Platform

| Feature | GitHub Pages | Netlify | Vercel | Traditional Hosting |
|---------|-------------|---------|--------|-------------------|
| HTML/CSS/JS | ✅ | ✅ | ✅ | ✅ |
| Images | ✅ | ✅ | ✅ | ✅ |
| Menu Display | ✅ | ✅ | ✅ | ✅ |
| Search | ✅ | ✅ | ✅ | ✅ |
| Favorites | ✅ | ✅ | ✅ | ✅ |
| PHP Files | ❌ | ⚠️ Convert | ⚠️ Convert | ✅ |
| MySQL Database | ❌ | ❌ | ❌ | ✅ |
| Admin Panel | ❌ | ⚠️ Needs work | ⚠️ Needs work | ✅ |
| Custom Domain | ✅ | ✅ | ✅ | ✅ |
| HTTPS | ✅ | ✅ | ✅ | ✅ |
| Cost | FREE | FREE | FREE | $3-10/month |

---

## Files That Need PHP/Database

These files won't work on static hosting (GitHub Pages):

- ❌ `admin.php` - Admin panel
- ❌ `admin_api.php` - Admin API
- ❌ `send_feedback.php` - Feedback form
- ❌ `subscribe.php` - Email subscription
- ❌ `setup_telegram.php` - Telegram setup

**Solutions:**
1. **Remove these features** (simplest)
2. **Convert to serverless functions** (Netlify/Vercel)
3. **Use traditional hosting** (full PHP support)

---

## Recommended Deployment Path

### For Your Current Website:

**Best Option: GitHub Pages** (FREE, 5 minutes)

**Why:**
- Your website is 95% static (menu, images, gallery)
- No critical PHP dependencies for main functionality
- Admin panel can be accessed locally via XAMPP
- FREE and instant deployment

**Steps:**
1. Enable GitHub Pages (see above)
2. Visit https://yetnora1.github.io/zad/
3. Test all features
4. Share the link with customers!

**Later (Optional):**
- Add custom domain (zadcafe.com)
- Move admin panel to separate hosting if needed
- Add serverless functions for forms

---

## Custom Domain Setup (Optional)

### If You Have a Domain (e.g., zadcafe.com):

#### For GitHub Pages:
1. Go to repository **Settings** → **Pages**
2. Enter your domain: `www.zadcafe.com`
3. Update DNS at your domain registrar:
   ```
   Type: CNAME
   Name: www
   Value: yetnora1.github.io
   ```

#### For Netlify/Vercel:
1. Go to **Domain settings**
2. Add custom domain
3. Follow DNS instructions provided

---

## Testing Checklist

After deployment, test these features:

- [ ] Website loads correctly
- [ ] All images display
- [ ] Menu categories work
- [ ] Search functionality works
- [ ] Language switch (English/Amharic)
- [ ] Theme switch (Light/Dark)
- [ ] Favorites feature
- [ ] Item modals open correctly
- [ ] Gallery lightbox works
- [ ] Payment QR codes display
- [ ] Social media links work
- [ ] Mobile responsive design
- [ ] All 82 menu items visible

---

## Deployment Commands

### If You Want to Deploy Manually:

```bash
# Already done - your code is on GitHub
git push origin main

# For GitHub Pages - enable in Settings

# For Netlify CLI (optional)
npm install -g netlify-cli
netlify deploy --prod

# For Vercel CLI (optional)
npm install -g vercel
vercel --prod
```

---

## Support & Maintenance

### Updating Your Live Website:

1. **Make changes locally** in XAMPP
2. **Test** at http://localhost/ZAD
3. **Commit changes:**
   ```bash
   git add .
   git commit -m "Update menu items"
   git push
   ```
4. **Auto-deploys** to your hosting (GitHub Pages/Netlify/Vercel)

### Updating Menu Items:

1. Edit `menu_data.json`
2. Run `./update_menu_embed.ps1`
3. Commit and push
4. Live in 2-5 minutes!

---

## Cost Comparison

| Platform | Monthly Cost | Annual Cost | Best For |
|----------|-------------|-------------|----------|
| GitHub Pages | FREE | FREE | Static sites |
| Netlify | FREE | FREE | Modern sites |
| Vercel | FREE | FREE | Modern sites |
| Traditional Hosting | $3-10 | $36-120 | Full PHP/MySQL |

---

## Next Steps

### Immediate (5 minutes):
1. ✅ Enable GitHub Pages
2. ✅ Test your live website
3. ✅ Share the link!

### Soon (1 hour):
1. ⏳ Get a custom domain (optional)
2. ⏳ Update social media links
3. ⏳ Add real payment QR codes

### Later (as needed):
1. ⏳ Setup analytics (Google Analytics)
2. ⏳ Add online ordering system
3. ⏳ Setup email notifications

---

## Need Help?

**Your website is ready to deploy!**

Choose GitHub Pages for the fastest, easiest deployment:
👉 https://github.com/yetnora1/zad/settings/pages

**Questions?**
- GitHub Pages: https://docs.github.com/pages
- Netlify: https://docs.netlify.com
- Vercel: https://vercel.com/docs

---

**Status:** ✅ READY FOR DEPLOYMENT  
**Recommended:** GitHub Pages (FREE, 5 minutes)  
**URL:** https://yetnora1.github.io/zad/ (after enabling)
