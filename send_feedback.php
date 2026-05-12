<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');

require_once 'telegram_config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$name = htmlspecialchars(trim($_POST['name'] ?? ''));
$phone = htmlspecialchars(trim($_POST['phone'] ?? ''));
$message = htmlspecialchars(trim($_POST['message'] ?? ''));
$lang = htmlspecialchars(trim($_POST['lang'] ?? 'en'));

if (empty($name) || empty($message)) {
    $errorMsg = $lang === 'am' ? 'ስም እና መልእክት ያስፈልጋሉ' : 'Name and message are required';
    echo json_encode(['success' => false, 'message' => $errorMsg]);
    exit;
}

$text = "📩 *New Feedback from ZAD Cafe Website*\n\n";
$text .= "👤 *Name:* $name\n";
$text .= "📞 *Phone:* " . ($phone ?: 'Not provided') . "\n";
$text .= "🌐 *Language:* " . ($lang === 'am' ? 'Amharic' : 'English') . "\n";
$text .= "💬 *Message:*\n$message";

$result = sendTelegramMessage($text);

if ($result && isset($result['ok']) && $result['ok'] === true) {
    $successMsg = $lang === 'am' ? 'አመሰግናለሁ! መልእክትዎ ተልኳል።' : 'Thank you! Your feedback has been sent.';
    echo json_encode(['success' => true, 'message' => $successMsg]);
} else {
    $errorMsg = $lang === 'am' ? 'መልእክት መላክ አልተቻለም። እባክዎ ቆይተው ይሞክሩ።' : 'Failed to send message. Please try again later.';
    if (isset($result['error'])) {
        $errorMsg .= ' (' . $result['error'] . ')';
    }
    echo json_encode(['success' => false, 'message' => $errorMsg]);
}
?>
