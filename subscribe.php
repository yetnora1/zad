<?php
require_once 'telegram_config.php';

header('Content-Type: application/json');

$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$lang = isset($_POST['lang']) ? $_POST['lang'] : 'en';

if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        'success' => false,
        'message' => $lang === 'am' ? 'የሚሠራ ኢሜል ያስገቡ' : 'Please enter a valid email address.'
    ]);
    exit;
}

$discountCode = 'ZADWELCOME';
$message = "*New Subscriber*\n\n";
$message .= "Email: `{$email}`\n";
$message .= "Language: {$lang}\n";
$message .= "Discount Code: `{$discountCode}`\n";
$message .= "Date: " . date('Y-m-d H:i:s') . "\n";

$result = sendTelegramMessage($message);

if ($result && isset($result['ok']) && $result['ok'] === true) {
    echo json_encode([
        'success' => true,
        'message' => $lang === 'am' ? 'አመሰግናለን! በመጀመሪያ ትዕዛዝዎ ላይ 10% ቅናሽ ያግኙ።' : 'Thank you! Enjoy 10% off your first order.'
    ]);
} else {
    $errorMsg = $result['error'] ?? 'Unknown error';
    echo json_encode([
        'success' => false,
        'message' => $lang === 'am' ? 'ማለፍ አልተቻለም። እባክዎ ትንሽ ቆዩና ይሞክሩ።' : 'Failed to subscribe. Please try again later.'
    ]);
}
?>
