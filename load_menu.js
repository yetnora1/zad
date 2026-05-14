/**
 * ZAD Cafe - Dynamic Menu Loader
 * This script loads menu data from menu_data.json instead of hardcoded data
 * 
 * USAGE: Include this script BEFORE the menu rendering code in index.html
 * Replace: const md = {...hardcoded data...}
 * With: <script src="load_menu.js"></script>
 */

let md = {};
let menuLoaded = false;

// Load menu data from JSON file
async function loadMenuData() {
    try {
        const response = await fetch('menu_data.json');
        if (!response.ok) {
            throw new Error('Failed to load menu data');
        }
        md = await response.json();
        menuLoaded = true;
        
        console.log('✅ Menu data loaded successfully from menu_data.json');
        console.log('📊 Total categories:', Object.keys(md).length);
        console.log('🍽️ Total items:', Object.values(md).reduce((sum, items) => sum + items.length, 0));
        
        return md;
    } catch (error) {
        console.error('❌ Error loading menu data:', error);
        alert('Failed to load menu. Please refresh the page.');
        return null;
    }
}

// Auto-load on page load
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadMenuData);
} else {
    loadMenuData();
}

// Export for use in other scripts
window.getMenuData = () => md;
window.isMenuLoaded = () => menuLoaded;
