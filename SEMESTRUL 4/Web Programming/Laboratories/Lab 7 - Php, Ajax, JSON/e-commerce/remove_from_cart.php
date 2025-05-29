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
    $stmt = $pdo->prepare("DELETE FROM Cart WHERE product_id = ? AND session_id = ?");
    $stmt->execute([$product_id, $session_id]);

    echo json_encode([
        'status' => 'success',
        'message' => 'Product removed from cart'
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
