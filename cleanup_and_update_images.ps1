# PowerShell script to update menu data with new images and delete old duplicates

Write-Host "=== ZAD Cafe Image Cleanup and Update ===" -ForegroundColor Cyan
Write-Host ""

# Define image mappings: old -> new (and files to delete)
$imageMappings = @{
    # Water images - use space versions
    "images/water_1l.jpg" = "images/1 litre water.jpg"
    "images/water_05l.jpg" = "images/0.5 litre water.jpg"
    "images/ambo.jpg" = "images/ambo water.jpg"
    
    # Juice images - use capitalized versions
    "images/juice_papaya.jpg" = "images/Papaya Juice.jpg"
    "images/juice_avocado.jpg" = "images/Avocado Juice.jpg"
    "images/juice_mango.jpg" = "images/Mango Juice.jpg"
    "images/juice_strawberry.jpg" = "images/Strawberry Juice.jpg"
    "images/juice_watermelon.jpg" = "images/Watermelon Juice.jpg"
    "images/juice_spritz.jpg" = "images/Spritz Juice.jpg"
    "images/juice_special.jpg" = "images/special juice.jpg"
    
    # Tea images - use space versions
    "images/ginger_tea.jpg" = "images/ginger tea.webp"
    "images/lemon_tea.jpg" = "images/lemon tea.jpg"
    "images/orange_tea.jpg" = "images/orange tea.jpg"
    "images/pineapple_tea.jpg" = "images/pineapple tea.jpg"
    "images/mango_tea.jpg" = "images/mango tea.jpg"
    "images/peanut_tea.jpg" = "images/peanut tea.jpg"
    "images/peanut_coffee.jpg" = "images/peanut with coffee.jpg"
    "images/special_tea.jpg" = "images/special tea large.jpg"
    
    # Sandwich - use tuna club sandwich with space
    "images/sw_tuna_club.jpg" = "images/tuna club sandwich.jpg"
    
    # Extras - use webp versions
    "images/foil.jpg" = "images/alumunium foil.webp"
    "images/takeaway_box.jpg" = "images/burger pizza box.webp"
    
    # Soft drinks - use space version
    "images/soft_drink.jpg" = "images/soft drinks.jpg"
    
    # Peanut ginger
    "images/peanut_ginger.jpg" = "images/ginger-peanut.jpg"
}

# Files to delete (old duplicates that are no longer needed)
$filesToDelete = @(
    "images/water_1l.jpg",
    "images/water_05l.jpg",
    "images/water.jpg",
    "images/sparkling.jpg",
    "images/juice_mix.jpg",
    "images/avocado_juice.jpg",
    "images/mango_juice.jpg",
    "images/watermelon.jpg",
    "images/ginger_tea.jpg",
    "images/lemon_tea.jpg",
    "images/orange_tea.jpg",
    "images/pineapple_tea.jpg",
    "images/mango_tea.jpg",
    "images/peanut_tea.jpg",
    "images/peanut_coffee.jpg",
    "images/peanut_milk.jpg",
    "images/special_tea.jpg",
    "images/foil.jpg",
    "images/soft_drink.jpg",
    "images/peanut_ginger.jpg",
    "images/pasta_tuna.jpg",
    "images/pasta_veg.jpg",
    "images/rice_chicken.jpg",
    "images/sandwich_club.jpg",
    "images/sandwich_egg.jpg",
    "images/sandwich_tuna.jpg",
    "images/sandwich_veg.jpg",
    "images/sw_egg.jpg",
    "images/sw_veg.jpg",
    "images/sw_veg2.jpg",
    "images/mayo.jpg",
    "images/ketchup.jpg",
    "images/tomato.jpg",
    "images/coffee.jpg",
    "images/latte.jpg",
    "images/espresso.jpg",
    "images/placeholder.jpg",
    "images/tropical_juice.jpg"
)

Write-Host "Step 1: Reading menu_data.json..." -ForegroundColor Yellow
$menuJson = Get-Content -Path "menu_data.json" -Raw

# Apply replacements
Write-Host "Step 2: Updating image paths in menu data..." -ForegroundColor Yellow
$updatedJson = $menuJson
foreach ($oldPath in $imageMappings.Keys) {
    $newPath = $imageMappings[$oldPath]
    $updatedJson = $updatedJson -replace [regex]::Escape($oldPath), $newPath
    Write-Host "  ✓ $oldPath -> $newPath" -ForegroundColor Green
}

# Save updated menu_data.json
Write-Host "Step 3: Saving updated menu_data.json..." -ForegroundColor Yellow
Set-Content -Path "menu_data.json" -Value $updatedJson -NoNewline
Write-Host "  ✓ menu_data.json updated" -ForegroundColor Green

# Update index.html with new menu data
Write-Host "Step 4: Updating index.html with new menu data..." -ForegroundColor Yellow
$htmlContent = Get-Content -Path "index.html" -Raw
$pattern = '(?s)(// Menu data loaded from menu_data\.json\s+const md=)(\{.*?\});'
$menuJsonMinified = $updatedJson -replace '\s+', ' ' -replace ':\s+', ':' -replace ',\s+', ',' -replace '\{\s+', '{' -replace '\s+\}', '}' -replace '\[\s+', '[' -replace '\s+\]', ']'

if ($htmlContent -match $pattern) {
    $replacement = "`${1}$menuJsonMinified;"
    $newHtmlContent = $htmlContent -replace $pattern, $replacement
    Set-Content -Path "index.html" -Value $newHtmlContent -NoNewline
    Write-Host "  ✓ index.html updated with new menu data" -ForegroundColor Green
} else {
    Write-Host "  ✗ ERROR: Could not find menu data pattern in index.html" -ForegroundColor Red
}

# Delete old duplicate files
Write-Host "Step 5: Deleting old duplicate image files..." -ForegroundColor Yellow
$deletedCount = 0
foreach ($file in $filesToDelete) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  ✓ Deleted: $file" -ForegroundColor Gray
        $deletedCount++
    }
}
Write-Host "  ✓ Deleted $deletedCount old image files" -ForegroundColor Green

Write-Host ""
Write-Host "=== Update Complete! ===" -ForegroundColor Cyan
Write-Host "✓ Menu data updated with new image paths" -ForegroundColor Green
Write-Host "✓ index.html re-embedded with updated data" -ForegroundColor Green
Write-Host "✓ $deletedCount old duplicate images deleted" -ForegroundColor Green
Write-Host ""
Write-Host "Next: Hard refresh your browser (Ctrl+Shift+R) to see changes" -ForegroundColor Yellow
