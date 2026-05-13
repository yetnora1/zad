$h = @{'User-Agent'='Mozilla/5.0';'Referer'='https://pexels.com/'}
$dir = 'c:\xampp\htdocs\ZAD\images\'

$fixes = @{
  'juice_avocado.jpg'    = 'https://images.pexels.com/photos/3683053/pexels-photo-3683053.jpeg?auto=compress&cs=tinysrgb&w=600'
  'juice_strawberry.jpg' = 'https://images.pexels.com/photos/3551782/pexels-photo-3551782.jpeg?auto=compress&cs=tinysrgb&w=600'
  'shake_avocado.jpg'    = 'https://images.pexels.com/photos/3683053/pexels-photo-3683053.jpeg?auto=compress&cs=tinysrgb&w=600'
  'fetira.jpg'           = 'https://images.pexels.com/photos/2434295/pexels-photo-2434295.jpeg?auto=compress&cs=tinysrgb&w=600'
  'avatar1.jpg'          = 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=150'
  'avatar2.jpg'          = 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=150'
  'avatar3.jpg'          = 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=150'
}

foreach ($kv in $fixes.GetEnumerator()) {
    $name = $kv.Key
    $url  = $kv.Value
    $path = $dir + $name
    try {
        Invoke-WebRequest -Uri $url -OutFile $path -Headers $h -TimeoutSec 20 -EA Stop
        $sz = (Get-Item $path).Length
        Write-Host "OK $name ($([math]::Round($sz/1024))KB)" -ForegroundColor Green
    } catch {
        Write-Host "FAIL $name : $_" -ForegroundColor Red
    }
}
Write-Host "Done." -ForegroundColor Cyan
