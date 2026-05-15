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

// Start loading immediately
loadMenuData();

// Export for use in other scripts
window.getMenuData = () => md;
window.isMenuLoaded = () => menuLoaded;
