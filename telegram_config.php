<?php
// Feedback is sent to Telegram username @posthinker
// The bot resolves the username to a chat_id automatically.
// @posthinker must message @zad_cafe_bot first so the bot can see them.

define('BOT_TOKEN', '8796906586:AAEbACDB_jXZ9v_UGl1L5oZTfPs5mV6Pc3U');
define('TARGET_USERNAME', 'posthinker'); // without the @
define('CHAT_ID_CACHE', __DIR__ . '/chat_id_cache.txt');

function getCachedChatId() {
    if (file_exists(CHAT_ID_CACHE)) {
        $cid = trim(file_get_contents(CHAT_ID_CACHE));
        if (is_numeric($cid)) return $cid;
    }
    return false;
}

function cacheChatId($chatId) {
    file_put_contents(CHAT_ID_CACHE, $chatId);
}

function resolveUsernameToChatId() {
    $cached = getCachedChatId();
    if ($cached !== false) return $cached;

    $url = "https://api.telegram.org/bot" . BOT_TOKEN . "/getUpdates";
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) return false;

    $data = json_decode($response, true);
    if (!$data || !$data['ok'] || empty($data['result'])) return false;

    foreach ($data['result'] as $update) {
        $from = $update['message']['from'] ?? ($update['callback_query']['from'] ?? null);
        if ($from && isset($from['username']) && strtolower($from['username']) === strtolower(TARGET_USERNAME)) {
            $chatId = $from['id'];
            cacheChatId($chatId);
            return $chatId;
        }
    }
    return false;
}

function sendTelegramMessage($message) {
    $chatId = resolveUsernameToChatId();
    if ($chatId === false) {
        return ['ok' => false, 'error' => 'Could not find @' . TARGET_USERNAME . '. Please ask them to message @zad_cafe_bot first.'];
    }

    $url = "https://api.telegram.org/bot" . BOT_TOKEN . "/sendMessage";
    $data = [
        'chat_id' => $chatId,
        'text' => $message,
        'parse_mode' => 'Markdown'
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) {
        return ['ok' => false, 'error' => $error];
    }

    return json_decode($response, true);
}
?>
