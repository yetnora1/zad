# Deploy ZAD Cafe to Vercel using CLI

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     ZAD CAFE - VERCEL DEPLOYMENT                   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "Installing Vercel CLI..." -ForegroundColor Yellow
npm install -g vercel

Write-Host ""
Write-Host "Deploying to Vercel..." -ForegroundColor Yellow
Write-Host ""

# Deploy to Vercel
vercel --prod

Write-Host ""
Write-Host "✨ Deployment complete! ✨" -ForegroundColor Green
Write-Host ""
Write-Host "Your website is now live on Vercel!" -ForegroundColor Cyan
Write-Host ""
