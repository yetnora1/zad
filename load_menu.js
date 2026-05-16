/**
 * ZAD Cafe - Dynamic Menu Loader
 * This script loads menu data from menu_data.json instead of hardcoded data
 */

let md = {};
let menuLoaded = false;

// Load menu data from JSON file
async function loadMenuData() {
    try {
        console.log('🔄 Loading menu data from menu_data.json...');
        const response = await fetch('menu_data.json');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        md = await response.json();
        menuLoaded = true;
        
        console.log('✅ Menu data loaded successfully from menu_data.json');
        console.log('📊 Total categories:', Object.keys(md).length);
        console.log('🍽️ Total items:', Object.values(md).reduce((sum, items) => sum + items.length, 0));
        
        return md;
    } catch (error) {
        console.error('❌ Error loading menu data:', error);
        // If fetch fails (e.g. CORS from file:// protocol), we still need to stop the loader
        menuLoaded = true;
        return null;
    }
}

// Render menu function
function renderMenu(query = '') {
    if (!md || Object.keys(md).length === 0) {
        console.warn('Menu data not loaded yet');
        return;
    }
    
    const q = query.toLowerCase().trim();
    const categories = ['pasta', 'rice', 'sandwich', 'burger', 'pizza', 'extra', 'fresh', 'cold', 'juice', 'breakfast'];
    
    categories.forEach(cat => {
        const grid = document.getElementById(`${cat}-grid`);
        if (!grid) return;
        
        const items = md[cat] || [];
        const filtered = q ? items.filter(item => 
            item.n.toLowerCase().includes(q) || 
            item.a.includes(q) ||
            item.d.toLowerCase().includes(q)
        ) : items;
        
        grid.innerHTML = filtered.map(item => `
            <div class="menu-card" onclick="openItemModal('${cat}', '${item.n.replace(/'/g, "\\'")}')">
                ${item.b ? `<div class="badge">${item.b}</div>` : ''}
                <div class="card-image" style="background-image:url('${encodeURI(item.i)}')"></div>
                <div class="menu-info">
                    <h3 class="menu-name">${window.cl === 'en' ? item.n : item.a}</h3>
                    <p class="menu-desc">${item.d}</p>
                    ${item.dt ? `<div class="diet-tags">${item.dt.map(d => 
                        `<span class="diet-tag">${d === 'v' ? '🌱' : d === 'gf' ? '🌾' : '🌶️'}</span>`
                    ).join('')}</div>` : ''}
                    <div class="menu-footer">
                        <span class="menu-price">${item.p} Birr</span>
                        <button class="btn-fav" onclick="event.stopPropagation();toggleFavorite('${cat}','${item.n.replace(/'/g, "\\'")}')">
                            <i class="far fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
        
        // Hide section if no items match
        const section = grid.closest('section');
        if (section) {
            section.style.display = filtered.length > 0 ? 'block' : 'none';
        }
    });
}

// Render favorites function
function renderFavorites() {
    const favGrid = document.getElementById('fav-grid');
    if (!favGrid) return;
    
    const favs = JSON.parse(localStorage.getItem('zad-favorites') || '[]');
    
    if (favs.length === 0) {
        favGrid.innerHTML = '<p style="text-align:center;color:var(--mu);padding:2rem;">No favorites yet. Click the heart icon on any item to add it here.</p>';
        return;
    }
    
    const favItems = favs.map(fav => {
        const items = md[fav.cat] || [];
        return items.find(item => item.n === fav.name);
    }).filter(Boolean);
    
    favGrid.innerHTML = favItems.map((item, idx) => {
        const fav = favs[idx];
        return `
            <div class="menu-card" onclick="openItemModal('${fav.cat}', '${item.n.replace(/'/g, "\\'")}')">
                <div class="card-image" style="background-image:url('${encodeURI(item.i)}')"></div>
                <div class="menu-info">
                    <h3 class="menu-name">${window.cl === 'en' ? item.n : item.a}</h3>
                    <p class="menu-desc">${item.d}</p>
                    <div class="menu-footer">
                        <span class="menu-price">${item.p} Birr</span>
                        <button class="btn-fav active" onclick="event.stopPropagation();toggleFavorite('${fav.cat}','${item.n.replace(/'/g, "\\'")}')">
                            <i class="fas fa-heart"></i>
                        </button>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

// Render recent items function
function renderRecent() {
    const recentGrid = document.getElementById('recent-grid');
    if (!recentGrid) return;
    
    const recent = JSON.parse(localStorage.getItem('zad-recent') || '[]');
    
    if (recent.length === 0) {
        recentGrid.innerHTML = '<p style="text-align:center;color:var(--mu);padding:2rem;">No recently viewed items yet.</p>';
        return;
    }
    
    const recentItems = recent.slice(0, 6).map(rec => {
        const items = md[rec.cat] || [];
        return { ...items.find(item => item.n === rec.name), cat: rec.cat };
    }).filter(item => item.n);
    
    recentGrid.innerHTML = recentItems.map(item => `
        <div class="menu-card" onclick="openItemModal('${item.cat}', '${item.n.replace(/'/g, "\\'")}')">
            <div class="card-image" style="background-image:url('${encodeURI(item.i)}')"></div>
            <div class="menu-info">
                <h3 class="menu-name">${window.cl === 'en' ? item.n : item.a}</h3>
                <p class="menu-desc">${item.d}</p>
                <div class="menu-footer">
                    <span class="menu-price">${item.p} Birr</span>
                </div>
            </div>
        </div>
    `).join('');
}

// Start loading immediately
loadMenuData();

// Export for use in other scripts
window.getMenuData = () => md;
window.isMenuLoaded = () => menuLoaded;
window.renderMenu = renderMenu;
window.renderFavorites = renderFavorites;
window.renderRecent = renderRecent;
