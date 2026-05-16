# ZAD Cafe - Deploy Script
# Usage: .\deploy.ps1 "commit message"

param(
    [string]$msg = "Update site"
)

$HOOK = "https://api.vercel.com/v1/integrations/deploy/prj_180bh7ohPsr3dzVC3U27AGYib6pz/zWqb7NxMOU"

Write-Host "📦 Staging changes..." -ForegroundColor Cyan
git add -A

Write-Host "💾 Committing: $msg" -ForegroundColor Cyan
git commit -m $msg

Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Cyan
git push origin main

Write-Host "⚡ Triggering Vercel deployment..." -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri $HOOK -Method POST
Write-Host "✅ Deployment triggered! Job ID: $($result.job.id)" -ForegroundColor Green
Write-Host "🌐 Site: https://zad-red.vercel.app" -ForegroundColor Green
Write-Host "🔧 Admin: https://zad-red.vercel.app/admin" -ForegroundColor Green
