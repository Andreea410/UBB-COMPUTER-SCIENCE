<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Add CORS headers
header('Access-Control-Allow-Origin: http://localhost:4200');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Credentials: true');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

header('Content-Type: application/json');

require_once __DIR__ . '/includes/session.inc.php';
require_once __DIR__ . '/includes/databaseConnection.inc.php';

// Get JSON input
$json = file_get_contents('php://input');
$data = json_decode($json, true);

if (!isset($data['product_id'])) {
    http_response_code(400);
    echo json_encode(['status' => 'error', 'message' => 'Product ID is required']);
    exit();
}

$product_id = $data['product_id'];
$session_id = getCurrentSessionId();

try {
    // First check if product exists
    $checkStmt = $pdo->prepare("SELECT id FROM Product WHERE id = ?");
    $checkStmt->execute([$product_id]);
    
    if (!$checkStmt->fetch()) {
        http_response_code(404);
        echo json_encode(['status' => 'error', 'message' => 'Product not found']);
        exit();
    }

    // Check if product is already in cart
    $checkCartStmt = $pdo->prepare("SELECT quantity FROM Cart WHERE product_id = ? AND session_id = ?");
    $checkCartStmt->execute([$product_id, $session_id]);
    $existingItem = $checkCartStmt->fetch();

    if ($existingItem) {
        // Update quantity if product already in cart
        $updateStmt = $pdo->prepare("UPDATE Cart SET quantity = quantity + 1 WHERE product_id = ? AND session_id = ?");
        $updateStmt->execute([$product_id, $session_id]);
    } else {
        // Insert new item if not in cart
        $insertStmt = $pdo->prepare("INSERT INTO Cart (product_id, quantity, session_id) VALUES (?, 1, ?)");
        $insertStmt->execute([$product_id, $session_id]);
    }

    echo json_encode([
        'status' => 'success',
        'message' => 'Product added to cart',
        'data' => ['product_id' => $product_id]
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
