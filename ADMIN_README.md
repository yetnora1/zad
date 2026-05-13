# ZAD Cafe Admin Panel

## 🎉 Installation Complete!

Your admin panel has been successfully created. Here's what was added:

### Files Created:
1. **admin.php** - The admin panel interface
2. **admin_api.php** - Backend API for managing data
3. **menu_data.json** - Menu items database (extracted from index.html)
4. **payment_config.json** - Payment methods configuration

---

## 🔐 Access the Admin Panel

**URL:** `http://localhost/ZAD/admin.php`

**Default Password:** `zad@admin2026`

⚠️ **IMPORTANT:** Change the password in `admin_api.php` line 11:
```php
define('ADMIN_PASSWORD', 'zad@admin2026'); // Change this!
```

---

## ✨ Features

### 📋 Menu Management
- **View all items** organized by category (Pasta, Rice, Sandwich, Burger, Pizza, etc.)
- **Add new items** with full details:
  - English & Amharic names
  - Price in Ethiopian Birr
  - Description
  - Image (with upload support)
  - Optional badge (e.g., "Chef's Pick")
  - Diet tags (Vegan, Gluten-Free, Spicy)
  - Nutrition info (Calories, Protein, Carbs, Fat)
- **Edit existing items** - click the edit button on any item
- **Delete items** - with confirmation prompt
- **Image upload** - upload new images directly from the admin panel

### 💳 Payment Methods
- **Telebirr Configuration:**
  - Phone number
  - Account name
  - Display hint
- **CBE Bank Configuration:**
  - Account number
  - Account name
  - Display hint

### 📊 Dashboard Stats
- Total menu items count
- Number of categories
- Average price
- System status

---

## 🚀 How to Use

### Adding a New Menu Item:
1. Login to admin panel
2. Click on the category section (e.g., "Pizza")
3. Click "Add Item" button
4. Fill in all required fields:
   - English name (required)
   - Amharic name (required)
   - Price (required)
   - Category (required)
   - Description (required)
   - Image path (required) - or upload a new image
5. Optionally add:
   - Badge text
   - Diet tags
   - Nutrition information
6. Click "Save Item"

### Editing an Item:
1. Find the item in its category
2. Click the edit button (pencil icon)
3. Modify the fields
4. Click "Save Item"

### Deleting an Item:
1. Find the item in its category
2. Click the delete button (trash icon)
3. Confirm deletion

### Updating Payment Methods:
1. Click "Payment Methods" tab
2. Update Telebirr and/or CBE details
3. Click "Save Payment Config"

### Uploading Images:
1. When adding/editing an item
2. Click "Choose File" under Image Path
3. Select an image (JPG, PNG, WebP, GIF - max 5MB)
4. Image will be uploaded to `/images/` folder
5. Path will be automatically filled

---

## 🔄 Integrating with Your Website

The menu data is now stored in `menu_data.json`. To use it in your main website (`index.html`), you have two options:

### Option 1: Load via JavaScript (Recommended)
Replace the hardcoded `md` object in `index.html` with:

```javascript
let md = {};
fetch('menu_data.json')
  .then(res => res.json())
  .then(data => {
    md = data;
    renderMenu();
    // ... rest of your initialization code
  });
```

### Option 2: PHP Include
Convert `index.html` to `index.php` and add at the top:
```php
<?php
$menuData = json_decode(file_get_contents('menu_data.json'), true);
?>
<script>
const md = <?php echo json_encode($menuData); ?>;
</script>
```

---

## 🔒 Security Notes

1. **Change the default password** immediately in `admin_api.php`
2. **Protect admin files** - Add to `.htaccess`:
   ```apache
   <Files "admin*.php">
     Order Allow,Deny
     Allow from 127.0.0.1
     Allow from ::1
   </Files>
   ```
3. **Use HTTPS** in production
4. **Backup regularly** - `menu_data.json` and `payment_config.json`
5. **Limit file upload size** - Already set to 5MB max

---

## 📁 File Structure

```
ZAD/
├── admin.php              # Admin panel UI
├── admin_api.php          # Backend API
├── menu_data.json         # Menu database
├── payment_config.json    # Payment settings
├── index.html             # Main website
├── images/                # Image folder
│   └── (98 images)
└── (other files)
```

---

## 🐛 Troubleshooting

### "Unauthorized" error
- Make sure you're logged in
- Check if session is working (enable sessions in php.ini)

### Images not uploading
- Check `/images/` folder permissions (should be writable)
- Verify file size is under 5MB
- Ensure file type is JPG, PNG, WebP, or GIF

### Changes not saving
- Check file permissions on `menu_data.json` and `payment_config.json`
- Look for PHP errors in browser console (F12)
- Check server error logs

### Can't access admin panel
- Verify PHP is running (XAMPP Apache + PHP)
- Check the URL: `http://localhost/ZAD/admin.php`
- Clear browser cache

---

## 📞 Support

For issues or questions:
1. Check browser console (F12) for JavaScript errors
2. Check PHP error logs in XAMPP
3. Verify all files have correct permissions

---

## 🎨 Customization

### Changing Colors:
Edit CSS variables in `admin.php`:
```css
:root {
  --primary: #E8784A;    /* Orange */
  --secondary: #D4A853;  /* Gold */
  --dark: #1a0f0a;       /* Dark brown */
  --light: #F5E6D3;      /* Light cream */
}
```

### Adding New Categories:
1. Add category to `$validCats` array in `admin_api.php` (line 68)
2. Add option in `admin.php` category dropdown (search for `<select id="itemCategory">`)
3. Initialize empty array in `menu_data.json`

---

## ✅ Quick Start Checklist

- [ ] Access admin panel at `http://localhost/ZAD/admin.php`
- [ ] Login with password: `zad@admin2026`
- [ ] Change default password in `admin_api.php`
- [ ] Test adding a new menu item
- [ ] Test editing an existing item
- [ ] Update payment methods
- [ ] Upload a test image
- [ ] Backup `menu_data.json` and `payment_config.json`

---

**Enjoy your new admin panel! 🎉**
