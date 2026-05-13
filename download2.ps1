$imgDir = "c:\xampp\htdocs\ZAD\images"
$ErrorActionPreference = 'Continue'

function Download-Image($name, $urls) {
    $filepath = Join-Path $imgDir $name
    if ((Test-Path $filepath) -and (Get-Item $filepath).Length -gt 15000) {
        Write-Host "SKIP $name (exists)" -ForegroundColor DarkGray
        return
    }
    foreach ($url in $urls) {
        try {
            $headers = @{"User-Agent"="Mozilla/5.0";"Referer"="https://unsplash.com/"}
            Invoke-WebRequest -Uri $url -OutFile $filepath -Headers $headers -TimeoutSec 20 -ErrorAction Stop
            $sz = (Get-Item $filepath).Length
            if ($sz -gt 10000) { Write-Host "OK $name ($([math]::Round($sz/1024))KB)" -ForegroundColor Green; return }
        } catch {}
    }
    Write-Host "FAIL $name" -ForegroundColor Red
}

# PASTA
Download-Image "pasta_sauce.jpg"     @("https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=600&h=400&fit=crop&q=85")
Download-Image "pasta_tuna.jpg"      @("https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=600&h=400&fit=crop&q=85")
Download-Image "pasta_chicken.jpg"   @("https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=600&h=400&fit=crop&q=85")
Download-Image "pasta_veg.jpg"       @("https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=600&h=400&fit=crop&q=85")

# RICE
Download-Image "rice_tuna.jpg"       @("https://images.unsplash.com/photo-1512058564366-18510be2db19?w=600&h=400&fit=crop&q=85")
Download-Image "rice_chicken.jpg"    @("https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "rice_sauce.jpg"      @("https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600&h=400&fit=crop&q=85")
Download-Image "rice_veg.jpg"        @("https://images.unsplash.com/photo-1516714435131-44d6b64dc6a2?w=600&h=400&fit=crop&q=85")

# SANDWICH
Download-Image "sw_club.jpg"         @("https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=600&h=400&fit=crop&q=85")
Download-Image "sw_tuna.jpg"         @("https://images.pexels.com/photos/1199957/pexels-photo-1199957.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "sw_tuna_club.jpg"    @("https://images.pexels.com/photos/2253643/pexels-photo-2253643.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "sw_egg_chips.jpg"    @("https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&h=400&fit=crop&q=85")
Download-Image "sw_egg.jpg"          @("https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=600&h=400&fit=crop&q=85")
Download-Image "sw_veg.jpg"          @("https://images.unsplash.com/photo-1509722747041-616f39b57569?w=600&h=400&fit=crop&q=85")
Download-Image "sw_veg2.jpg"         @("https://images.pexels.com/photos/1647163/pexels-photo-1647163.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "chips.jpg"           @("https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=600&h=400&fit=crop&q=85")

# BURGER
Download-Image "burger_normal.jpg"   @("https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&h=400&fit=crop&q=85")
Download-Image "burger_double.jpg"   @("https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=600&h=400&fit=crop&q=85")
Download-Image "burger_special.jpg"  @("https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=600&h=400&fit=crop&q=85")
Download-Image "burger_cheese.jpg"   @("https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=600&h=400&fit=crop&q=85")

# PIZZA
Download-Image "pizza_special.jpg"   @("https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&h=400&fit=crop&q=85")
Download-Image "pizza_normal.jpg"    @("https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&h=400&fit=crop&q=85")
Download-Image "pizza_margherita.jpg"@("https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=600&h=400&fit=crop&q=85")
Download-Image "pizza_chicken.jpg"   @("https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&h=400&fit=crop&q=85")
Download-Image "pizza_tuna.jpg"      @("https://images.pexels.com/photos/3944311/pexels-photo-3944311.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "pizza_veg.jpg"       @("https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?w=600&h=400&fit=crop&q=85")

# EXTRAS
Download-Image "mayo.jpg"            @("https://images.unsplash.com/photo-1628689469838-524a4a973b8e?w=600&h=400&fit=crop&q=85")
Download-Image "ketchup.jpg"         @("https://images.unsplash.com/photo-1472476443507-c7a5948772fc?w=600&h=400&fit=crop&q=85")
Download-Image "bread.jpg"           @("https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&h=400&fit=crop&q=85")
Download-Image "injera.jpg"          @("https://images.pexels.com/photos/4110467/pexels-photo-4110467.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "tea_cup.jpg"         @("https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&h=400&fit=crop&q=85")
Download-Image "juice_cup.jpg"       @("https://images.unsplash.com/photo-1546171753-97d7676e4602?w=600&h=400&fit=crop&q=85")
Download-Image "takeaway_box.jpg"    @("https://images.pexels.com/photos/4393021/pexels-photo-4393021.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "foil.jpg"            @("https://images.pexels.com/photos/4198019/pexels-photo-4198019.jpeg?auto=compress&cs=tinysrgb&w=600")

# FRESH DRINKS - Ethiopian coffee culture
Download-Image "tea.jpg"             @("https://images.unsplash.com/photo-1571934811356-5cc061b6821f?w=600&h=400&fit=crop&q=85")
Download-Image "coffee_eth.jpg"      @("https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&h=400&fit=crop&q=85")
Download-Image "milk.jpg"            @("https://images.unsplash.com/photo-1550583724-b2692b85b150?w=600&h=400&fit=crop&q=85")
Download-Image "milk_coffee.jpg"     @("https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&h=400&fit=crop&q=85")
Download-Image "milk_peanut.jpg"     @("https://images.pexels.com/photos/1028714/pexels-photo-1028714.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "cappuccino.jpg"      @("https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=600&h=400&fit=crop&q=85")
Download-Image "hot_choc.jpg"        @("https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=600&h=400&fit=crop&q=85")
Download-Image "macchiato.jpg"       @("https://images.unsplash.com/photo-1485808191679-5f86510681a2?w=600&h=400&fit=crop&q=85")
Download-Image "macchiato_fast.jpg"  @("https://images.pexels.com/photos/374885/pexels-photo-374885.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "macchiato_dbl.jpg"   @("https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600&h=400&fit=crop&q=85")
Download-Image "peanut_tea.jpg"      @("https://images.pexels.com/photos/1417945/pexels-photo-1417945.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "peanut_ginger.jpg"   @("https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=600&h=400&fit=crop&q=85")
Download-Image "peanut_coffee.jpg"   @("https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "ginger_tea.jpg"      @("https://images.pexels.com/photos/2108845/pexels-photo-2108845.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "lemon_tea.jpg"       @("https://images.pexels.com/photos/1493080/pexels-photo-1493080.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "spris.jpg"           @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "special_tea.jpg"     @("https://images.pexels.com/photos/3786756/pexels-photo-3786756.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "orange_tea.jpg"      @("https://images.pexels.com/photos/1028714/pexels-photo-1028714.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "pineapple_tea.jpg"   @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "mango_tea.jpg"       @("https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&w=600")

# COLD DRINKS
Download-Image "soft_drink.jpg"      @("https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=600&h=400&fit=crop&q=85")
Download-Image "water_1l.jpg"        @("https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=600&h=400&fit=crop&q=85")
Download-Image "water_05l.jpg"       @("https://images.pexels.com/photos/327090/pexels-photo-327090.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "ambo.jpg"            @("https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg?auto=compress&cs=tinysrgb&w=600")

# JUICE - Ethiopian style thick fresh juices
Download-Image "juice_papaya.jpg"    @("https://images.pexels.com/photos/3652143/pexels-photo-3652143.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_avocado.jpg"   @("https://images.pexels.com/photos/1343498/pexels-photo-1343498.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_mango.jpg"     @("https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_strawberry.jpg"@("https://images.pexels.com/photos/1536882/pexels-photo-1536882.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_watermelon.jpg"@("https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_special.jpg"   @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_spritz.jpg"    @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "shake_avocado.jpg"   @("https://images.pexels.com/photos/1343498/pexels-photo-1343498.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "shake_strawberry.jpg"@("https://images.pexels.com/photos/3625372/pexels-photo-3625372.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_avo_straw.jpg" @("https://images.pexels.com/photos/1132558/pexels-photo-1132558.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_wm_sp.jpg"     @("https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "juice_fasting.jpg"   @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")

# BREAKFAST - Ethiopian style
Download-Image "chechebsa.jpg"       @("https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "chechebsa_sp.jpg"    @("https://images.pexels.com/photos/2474661/pexels-photo-2474661.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "fetira.jpg"          @("https://images.pexels.com/photos/2434295/pexels-photo-2434295.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "fetira_sp.jpg"       @("https://images.pexels.com/photos/1275680/pexels-photo-1275680.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "egg_stew.jpg"        @("https://images.pexels.com/photos/824635/pexels-photo-824635.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "scrambled_eggs.jpg"  @("https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&h=400&fit=crop&q=85")
Download-Image "ful.jpg"             @("https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "ful_special.jpg"     @("https://images.pexels.com/photos/1640773/pexels-photo-1640773.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "ful_avocado.jpg"     @("https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "eggs_avocado.jpg"    @("https://images.pexels.com/photos/566566/pexels-photo-566566.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "tomato_slices.jpg"   @("https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=600")

# GALLERY / HERO
Download-Image "hero_bg.jpg"         @("https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=1400&h=900&fit=crop&q=85")
Download-Image "cafe_interior.jpg"   @("https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&h=600&fit=crop&q=85")
Download-Image "cafe_coffee.jpg"     @("https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&h=600&fit=crop&q=85")
Download-Image "cafe_latte.jpg"      @("https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600&h=600&fit=crop&q=85")
Download-Image "cafe_food.jpg"       @("https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&h=600&fit=crop&q=85")
Download-Image "coffee_beans.jpg"    @("https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&h=600&fit=crop&q=85")

# SEASONAL SPECIALS
Download-Image "honey_latte.jpg"     @("https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=600&h=400&fit=crop&q=85")
Download-Image "tropical_juice.jpg"  @("https://images.pexels.com/photos/3407777/pexels-photo-3407777.jpeg?auto=compress&cs=tinysrgb&w=600")
Download-Image "avocado_toast.jpg"   @("https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&h=400&fit=crop&q=85")

# TESTIMONIAL AVATARS
Download-Image "avatar1.jpg"         @("https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop&q=85")
Download-Image "avatar2.jpg"         @("https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&q=85")
Download-Image "avatar3.jpg"         @("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&q=85")

# PLACEHOLDER fallback
Download-Image "placeholder.jpg"     @("https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&h=400&fit=crop&q=85")

Write-Host "`nAll downloads complete!" -ForegroundColor Cyan
$count = (Get-ChildItem $imgDir | Where-Object {$_.Length -gt 10000}).Count
Write-Host "Valid images in directory: $count" -ForegroundColor Green
