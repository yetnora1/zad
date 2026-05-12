<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ZAD Cafe - Telegram Bot Setup</title>
<style>
body{font-family:'Segoe UI',sans-serif;max-width:700px;margin:3rem auto;padding:0 1rem;background:#1a0f0a;color:#F5E6D3;line-height:1.7;}
h1{color:#E8784A;}h2{color:#D4A853;margin-top:2rem;}
.step{background:rgba(212,168,83,.1);border:1px solid rgba(212,168,83,.2);border-radius:12px;padding:1.5rem;margin:1rem 0;}
code{background:rgba(0,0,0,.3);padding:.2rem .5rem;border-radius:4px;color:#E8784A;font-size:.9rem;}
.chat-id{color:#00c853;font-size:1.5rem;font-weight:bold;margin:1rem 0;}
.warning{color:#E8784A;background:rgba(232,120,74,.1);padding:1rem;border-radius:8px;margin:1rem 0;}
</style>
</head>
<body>
<h1>🤖 ZAD Cafe Telegram Bot Setup</h1>

<div class="warning">
<strong>Step 1:</strong> Ask <code>@posthinker</code> to message your bot <code>@zad_cafe_bot</code> on Telegram. They should send any message like "Hello".
</div>

<div class="step">
<h2>Step 2: Verify Connection</h2>
<p>Once @posthinker has messaged the bot, the system will automatically resolve their username to a chat ID. No manual configuration needed!</p>

<?php
require_once 'telegram_config.php';
$chatId = resolveUsernameToChatId();
if ($chatId !== false) {
    echo "<div class='chat-id'>Connected to @posthinker (Chat ID: {$chatId})</div>";
    echo "<p>Everything is ready. Feedback messages will be sent to <strong>@posthinker</strong>.</p>";
} else {
    echo "<p style='color:#E8784A;'>@posthinker not found yet. Please ask them to message @zad_cafe_bot on Telegram and refresh this page.</p>";
}
?>
</div>

<div class="step">
<h2>Step 3: Test</h2>
<p>Go back to the main website, fill out the feedback form, and @posthinker will receive the message on Telegram!</p>
</div>

<p style="margin-top:2rem;text-align:center;"><a href="index.html" style="color:#E8784A;text-decoration:none;font-weight:600;">&larr; Back to ZAD Cafe</a></p>
</body>
</html>
