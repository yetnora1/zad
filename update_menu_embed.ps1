# PowerShell script to update embedded menu data in index.html

Write-Host "Reading menu_data.json..." -ForegroundColor Cyan
$menuJson = Get-Content -Path "menu_data.json" -Raw

Write-Host "Reading index.html..." -ForegroundColor Cyan
$htmlContent = Get-Content -Path "index.html" -Raw

# Find the menu data declaration pattern
$pattern = '(?s)(// Menu data loaded from menu_data\.json\s+const md=)(\{.*?\});'

# Minify the JSON (remove extra whitespace)
$menuJsonMinified = $menuJson -replace '\s+', ' ' -replace ':\s+', ':' -replace ',\s+', ',' -replace '\{\s+', '{' -replace '\s+\}', '}' -replace '\[\s+', '[' -replace '\s+\]', ']'

# Replace the menu data
if ($htmlContent -match $pattern) {
    Write-Host "Found menu data in index.html. Replacing..." -ForegroundColor Yellow
    $replacement = "`${1}$menuJsonMinified;"
    $newHtmlContent = $htmlContent -replace $pattern, $replacement
    
    # Write back to index.html
    Set-Content -Path "index.html" -Value $newHtmlContent -NoNewline
    Write-Host "Successfully updated menu data in index.html!" -ForegroundColor Green
    Write-Host "Menu data has been embedded with updated image paths." -ForegroundColor Green
} else {
    Write-Host "ERROR: Could not find menu data pattern in index.html" -ForegroundColor Red
    exit 1
}
