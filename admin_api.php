<?php
/**
 * ZAD Cafe Admin API
 * Handles CRUD for menu items and payment config
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: same-origin');

// ── Auth ──────────────────────────────────────────────────────────────────────
session_start();

define('ADMIN_PASSWORD', 'admin@zad'); // Change this!
define('MENU_FILE',    __DIR__ . '/menu_data.json');
define('PAYMENT_FILE', __DIR__ . '/payment_config.json');

function jsonResponse($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data);
    exit;
}

function requireAuth() {
    if (empty($_SESSION['admin_logged_in'])) {
        jsonResponse(['ok' => false, 'error' => 'Unauthorized'], 401);
    }
}

function readJson($file) {
    if (!file_exists($file)) return null;
    $raw = file_get_contents($file);
    return json_decode($raw, true);
}

function writeJson($file, $data) {
    $json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    return file_put_contents($file, $json) !== false;
}

// ── Router ────────────────────────────────────────────────────────────────────
$action = $_GET['action'] ?? $_POST['action'] ?? '';

switch ($action) {

    // ── Login ─────────────────────────────────────────────────────────────────
    case 'login':
        $raw = file_get_contents('php://input');
        $data = json_decode($raw, true);
        $pw = $data['password'] ?? $_POST['password'] ?? '';
        if ($pw === ADMIN_PASSWORD) {
            $_SESSION['admin_logged_in'] = true;
            jsonResponse(['ok' => true]);
        }
        jsonResponse(['ok' => false, 'error' => 'Wrong password'], 401);

    // ── Logout ────────────────────────────────────────────────────────────────
    case 'logout':
        session_destroy();
        jsonResponse(['ok' => true]);

    // ── Check session ─────────────────────────────────────────────────────────
    case 'check':
        jsonResponse(['ok' => !empty($_SESSION['admin_logged_in'])]);

    // ── Get menu ──────────────────────────────────────────────────────────────
    case 'get_menu':
        requireAuth();
        $menu = readJson(MENU_FILE);
        jsonResponse(['ok' => true, 'data' => $menu]);

    // ── Save full menu (used after edits) ─────────────────────────────────────
    case 'save_menu':
        requireAuth();
        $raw = file_get_contents('php://input');
        $menu = json_decode($raw, true);
        if (!is_array($menu)) {
            jsonResponse(['ok' => false, 'error' => 'Invalid JSON'], 400);
        }
        // Sanitize
        $clean = [];
        $validCats = ['pasta','rice','sandwich','burger','pizza','extra','fresh','cold','juice','breakfast'];
        foreach ($validCats as $cat) {
            $clean[$cat] = [];
            if (!isset($menu[$cat])) continue;
            foreach ($menu[$cat] as $item) {
                $entry = [
                    'n' => htmlspecialchars(trim($item['n'] ?? ''), ENT_QUOTES, 'UTF-8'),
                    'a' => trim($item['a'] ?? ''),
                    'p' => (int)($item['p'] ?? 0),
                    'd' => htmlspecialchars(trim($item['d'] ?? ''), ENT_QUOTES, 'UTF-8'),
                    'i' => trim($item['i'] ?? ''),
                ];
                if (!empty($item['b'])) $entry['b'] = htmlspecialchars(trim($item['b']), ENT_QUOTES, 'UTF-8');
                if (!empty($item['dt']) && is_array($item['dt'])) {
                    $entry['dt'] = array_values(array_intersect($item['dt'], ['v','gf','sp']));
                }
                if (!empty($item['nut']) && is_array($item['nut'])) {
                    $entry['nut'] = [
                        'cal'  => (int)($item['nut']['cal']  ?? 0),
                        'pro'  => (int)($item['nut']['pro']  ?? 0),
                        'carb' => (int)($item['nut']['carb'] ?? 0),
                        'fat'  => (int)($item['nut']['fat']  ?? 0),
                    ];
                }
                if ($entry['n']) $clean[$cat][] = $entry;
            }
        }
        if (writeJson(MENU_FILE, $clean)) {
            jsonResponse(['ok' => true]);
        }
        jsonResponse(['ok' => false, 'error' => 'Failed to write file'], 500);

    // ── Get payment config ────────────────────────────────────────────────────
    case 'get_payment':
        requireAuth();
        $cfg = readJson(PAYMENT_FILE);
        jsonResponse(['ok' => true, 'data' => $cfg]);

    // ── Save payment config ───────────────────────────────────────────────────
    case 'save_payment':
        requireAuth();
        $raw = file_get_contents('php://input');
        $cfg = json_decode($raw, true);
        if (!is_array($cfg)) {
            jsonResponse(['ok' => false, 'error' => 'Invalid JSON'], 400);
        }
        // Preserve existing qr_image paths if not overridden
        $existing = readJson(PAYMENT_FILE) ?? [];
        $clean = [
            'telebirr' => [
                'phone'        => htmlspecialchars(trim($cfg['telebirr']['phone']        ?? ''), ENT_QUOTES, 'UTF-8'),
                'account_name' => htmlspecialchars(trim($cfg['telebirr']['account_name'] ?? ''), ENT_QUOTES, 'UTF-8'),
                'hint'         => htmlspecialchars(trim($cfg['telebirr']['hint']         ?? ''), ENT_QUOTES, 'UTF-8'),
                'qr_image'     => $existing['telebirr']['qr_image'] ?? '',
            ],
            'cbe' => [
                'account'      => htmlspecialchars(trim($cfg['cbe']['account']      ?? ''), ENT_QUOTES, 'UTF-8'),
                'account_name' => htmlspecialchars(trim($cfg['cbe']['account_name'] ?? ''), ENT_QUOTES, 'UTF-8'),
                'hint'         => htmlspecialchars(trim($cfg['cbe']['hint']         ?? ''), ENT_QUOTES, 'UTF-8'),
                'qr_image'     => $existing['cbe']['qr_image'] ?? '',
            ],
        ];
        if (writeJson(PAYMENT_FILE, $clean)) {
            jsonResponse(['ok' => true]);
        }
        jsonResponse(['ok' => false, 'error' => 'Failed to write file'], 500);

    // ── Upload QR code image ──────────────────────────────────────────────────
    case 'upload_qr':
        requireAuth();
        $provider = trim($_POST['provider'] ?? '');
        if (!in_array($provider, ['telebirr', 'cbe'])) {
            jsonResponse(['ok' => false, 'error' => 'Invalid provider'], 400);
        }
        if (empty($_FILES['qr_image'])) {
            jsonResponse(['ok' => false, 'error' => 'No file uploaded'], 400);
        }
        $file = $_FILES['qr_image'];
        $allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
        if (!in_array($file['type'], $allowed)) {
            jsonResponse(['ok' => false, 'error' => 'Only JPG, PNG, WebP, GIF allowed'], 400);
        }
        if ($file['size'] > 5 * 1024 * 1024) {
            jsonResponse(['ok' => false, 'error' => 'File too large (max 5MB)'], 400);
        }
        $ext  = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        $name = $provider . '_qr.' . $ext;
        $dest = __DIR__ . '/images/' . $name;
        if (move_uploaded_file($file['tmp_name'], $dest)) {
            // Update payment_config.json with new qr_image path
            $cfg = readJson(PAYMENT_FILE) ?? [];
            $cfg[$provider]['qr_image'] = 'images/' . $name;
            writeJson(PAYMENT_FILE, $cfg);
            jsonResponse(['ok' => true, 'path' => 'images/' . $name]);
        }
        jsonResponse(['ok' => false, 'error' => 'Upload failed'], 500);

    // ── Upload image ──────────────────────────────────────────────────────────
    case 'upload_image':
        requireAuth();
        if (empty($_FILES['image'])) {
            jsonResponse(['ok' => false, 'error' => 'No file uploaded'], 400);
        }
        $file = $_FILES['image'];
        $allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
        if (!in_array($file['type'], $allowed)) {
            jsonResponse(['ok' => false, 'error' => 'Only JPG, PNG, WebP, GIF allowed'], 400);
        }
        if ($file['size'] > 5 * 1024 * 1024) {
            jsonResponse(['ok' => false, 'error' => 'File too large (max 5MB)'], 400);
        }
        $ext  = pathinfo($file['name'], PATHINFO_EXTENSION);
        $name = 'img_' . time() . '_' . bin2hex(random_bytes(4)) . '.' . strtolower($ext);
        $dest = __DIR__ . '/images/' . $name;
        if (move_uploaded_file($file['tmp_name'], $dest)) {
            jsonResponse(['ok' => true, 'path' => 'images/' . $name]);
        }
        jsonResponse(['ok' => false, 'error' => 'Upload failed'], 500);

    default:
        jsonResponse(['ok' => false, 'error' => 'Unknown action'], 400);
}
?>
