<?php
// Start the session if not already started
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Generate a unique session ID if not exists
if (!isset($_SESSION['cart_session_id'])) {
    $_SESSION['cart_session_id'] = bin2hex(random_bytes(32));
}

// Function to get current session ID
function getCurrentSessionId() {
    return $_SESSION['cart_session_id'];
}
?> 