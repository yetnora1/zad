# ZAD Cafe - Admin Panel Deployment Script
# This script deploys the admin panel and verifies integration with the menu site

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     ZAD CAFE - ADMIN PANEL DEPLOYMENT             ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Step 1: Verify all required files exist
Write-Host "📋 Step 1: Verifying Files..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$requiredFiles = @(
    "admin.php",
    "admin_api.php",
    "menu_data.json",
    "payment_config.json",
    "index.html",
    "load_menu.js"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "  ✓ $file" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $file (MISSING)" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host ""
    Write-Host "❌ Some required files are missing!" -ForegroundColor Red
    Write-Host "Please ensure all files are present before deploying." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "✓ All required files present!" -ForegroundColor Green
Write-Host ""

# Step 2: Verify menu_data.json is valid JSON
Write-Host "📋 Step 2: Validating menu_data.json..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

try {
    $menuData = Get-Content "menu_data.json" -Raw | ConvertFrom-Json
    $totalItems = 0
    $categories = @()
    
    foreach ($prop in $menuData.PSObject.Properties) {
        $categories += $prop.Name
        $totalItems += $prop.Value.Count
    }
    
    Write-Host "  ✓ Valid JSON structure" -ForegroundColor Green
    Write-Host "  ✓ Categories: $($categories.Count)" -ForegroundColor Green
    Write-Host "  ✓ Total Items: $totalItems" -ForegroundColor Green
    Write-Host "  ✓ Categories: $($categories -join ', ')" -ForegroundColor Cyan
} catch {
    Write-Host "  ✗ Invalid JSON in menu_data.json" -ForegroundColor Red
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 3: Verify payment_config.json
Write-Host "📋 Step 3: Validating payment_config.json..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

try {
    $paymentData = Get-Content "payment_config.json" -Raw | ConvertFrom-Json
    Write-Host "  ✓ Valid JSON structure" -ForegroundColor Green
    
    if ($paymentData.telebirr) {
        Write-Host "  ✓ Telebirr config present" -ForegroundColor Green
    }
    if ($paymentData.cbe) {
        Write-Host "  ✓ CBE config present" -ForegroundColor Green
    }
} catch {
    Write-Host "  ✗ Invalid JSON in payment_config.json" -ForegroundColor Red
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 4: Check if XAMPP is running
Write-Host "📋 Step 4: Checking XAMPP Status..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$apacheRunning = Get-Process -Name "httpd" -ErrorAction SilentlyContinue
if ($apacheRunning) {
    Write-Host "  ✓ Apache is running" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Apache is not running" -ForegroundColor Yellow
    Write-Host "  Please start XAMPP Apache to test locally" -ForegroundColor Yellow
}

Write-Host ""

# Step 5: Test local URLs
Write-Host "📋 Step 5: Local Testing URLs..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$currentDir = (Get-Location).Path
$folderName = Split-Path -Leaf $currentDir

Write-Host "  📱 Menu Site:" -ForegroundColor Cyan
Write-Host "     http://localhost/$folderName/index.html" -ForegroundColor White
Write-Host ""
Write-Host "  🔐 Admin Panel:" -ForegroundColor Cyan
Write-Host "     http://localhost/$folderName/admin.php" -ForegroundColor White
Write-Host ""
Write-Host "  🔑 Admin Password: admin@zad" -ForegroundColor Yellow
Write-Host ""

# Step 6: Verify integration
Write-Host "📋 Step 6: Verifying Integration..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

# Check if index.html references menu_data.json
$indexContent = Get-Content "index.html" -Raw
if ($indexContent -match "menu_data\.json") {
    Write-Host "  ✓ index.html references menu_data.json" -ForegroundColor Green
} else {
    Write-Host "  ⚠ index.html may not be loading from menu_data.json" -ForegroundColor Yellow
}

# Check if load_menu.js exists and is referenced
if (Test-Path "load_menu.js") {
    if ($indexContent -match "load_menu\.js") {
        Write-Host "  ✓ load_menu.js is included in index.html" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ load_menu.js exists but not referenced in index.html" -ForegroundColor Yellow
    }
}

# Check if admin_api.php references menu_data.json
$adminApiContent = Get-Content "admin_api.php" -Raw
if ($adminApiContent -match "menu_data\.json") {
    Write-Host "  ✓ admin_api.php is wired to menu_data.json" -ForegroundColor Green
} else {
    Write-Host "  ✗ admin_api.php is NOT wired to menu_data.json" -ForegroundColor Red
}

Write-Host ""

# Step 7: Deployment options
Write-Host "📋 Step 7: Deployment Options..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""

Write-Host "⚠️  IMPORTANT: Admin Panel Deployment Notes" -ForegroundColor Yellow
Write-Host ""
Write-Host "The admin panel (admin.php) requires PHP support." -ForegroundColor White
Write-Host ""
Write-Host "Deployment Options:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. GitHub Pages (Menu Site Only)" -ForegroundColor White
Write-Host "   ✓ FREE hosting for menu site" -ForegroundColor Green
Write-Host "   ✗ Admin panel won't work (no PHP)" -ForegroundColor Red
Write-Host "   → Keep admin local or deploy separately" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Traditional PHP Hosting (Recommended)" -ForegroundColor White
Write-Host "   ✓ Full PHP support" -ForegroundColor Green
Write-Host "   ✓ Admin panel works perfectly" -ForegroundColor Green
Write-Host "   ✓ Menu site works perfectly" -ForegroundColor Green
Write-Host "   → Deploy all files together" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Hybrid Approach" -ForegroundColor White
Write-Host "   ✓ Menu site on GitHub Pages (FREE)" -ForegroundColor Green
Write-Host "   ✓ Admin panel on PHP hosting" -ForegroundColor Green
Write-Host "   → Requires CORS configuration" -ForegroundColor Gray
Write-Host ""

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""

# Step 8: Security checklist
Write-Host "🔒 Security Checklist:" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""
Write-Host "Before deploying to production:" -ForegroundColor White
Write-Host "  [ ] Change admin password in admin_api.php (line 14)" -ForegroundColor Yellow
Write-Host "  [ ] Add .htaccess to protect admin files" -ForegroundColor Yellow
Write-Host "  [ ] Enable HTTPS on production server" -ForegroundColor Yellow
Write-Host "  [ ] Backup menu_data.json and payment_config.json" -ForegroundColor Yellow
Write-Host "  [ ] Test all admin functions locally first" -ForegroundColor Yellow
Write-Host ""

# Step 9: Quick test
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""
$testChoice = Read-Host "Open admin panel in browser for testing? (Y/N)"

if ($testChoice -eq "Y" -or $testChoice -eq "y") {
    Write-Host ""
    Write-Host "Opening admin panel..." -ForegroundColor Cyan
    Start-Process "http://localhost/$folderName/admin.php"
    Start-Sleep -Seconds 2
    Write-Host "Opening menu site..." -ForegroundColor Cyan
    Start-Process "http://localhost/$folderName/index.html"
    Write-Host ""
    Write-Host "✓ Browsers opened!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Test the following:" -ForegroundColor Yellow
    Write-Host "  1. Login to admin panel (password: admin@zad)" -ForegroundColor White
    Write-Host "  2. Edit a menu item" -ForegroundColor White
    Write-Host "  3. Refresh the menu site to see changes" -ForegroundColor White
    Write-Host "  4. Verify the change appears on the menu site" -ForegroundColor White
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host ""
Write-Host "✅ Admin Panel Deployment Check Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📖 For detailed deployment instructions, see:" -ForegroundColor Gray
Write-Host "   - ADMIN_README.md (Admin panel guide)" -ForegroundColor White
Write-Host "   - DEPLOYMENT_GUIDE.md (Hosting options)" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Next Steps:" -ForegroundColor Yellow
Write-Host "   1. Test admin panel locally" -ForegroundColor White
Write-Host "   2. Change default password" -ForegroundColor White
Write-Host "   3. Choose hosting provider" -ForegroundColor White
Write-Host "   4. Deploy to production" -ForegroundColor White
Write-Host ""
