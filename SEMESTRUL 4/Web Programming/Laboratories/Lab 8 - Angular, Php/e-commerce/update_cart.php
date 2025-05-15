<?php
require_once __DIR__ . '/includes/session.inc.php';
require_once __DIR__ . '/includes/databaseConnection.inc.php';

$productId = $_POST['product_id'];
$action = $_POST['action'];
$sessionId = getCurrentSessionId();

try {
    if ($action === 'increase') {
        $stmt = $pdo->prepare("UPDATE Cart SET quantity = quantity + 1 WHERE product_id = ? AND session_id = ?");
        $stmt->execute([$productId, $sessionId]);
    } else if ($action === 'decrease') {
        // First get current quantity
        $stmt = $pdo->prepare("SELECT quantity FROM Cart WHERE product_id = ? AND session_id = ?");
        $stmt->execute([$productId, $sessionId]);
        $quantity = $stmt->fetchColumn();

        if ($quantity <= 1) {
            // Remove item if quantity would become 0
            $stmt = $pdo->prepare("DELETE FROM Cart WHERE product_id = ? AND session_id = ?");
            $stmt->execute([$productId, $sessionId]);
        } else {
            // Decrease quantity
            $stmt = $pdo->prepare("UPDATE Cart SET quantity = quantity - 1 WHERE product_id = ? AND session_id = ?");
            $stmt->execute([$productId, $sessionId]);
        }
    }

    echo json_encode(['status' => 'success']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?> 