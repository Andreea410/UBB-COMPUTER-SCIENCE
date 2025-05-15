<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Add CORS headers
header('Access-Control-Allow-Origin: http://localhost:4200');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

header('Content-Type: application/json');

require_once __DIR__ . '/includes/databaseConnection.inc.php';

try {
    // Get JSON input
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);

    // Validate input
    if (!isset($data['id']) || !isset($data['name']) || !isset($data['price']) || !isset($data['category_id'])) {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
        exit();
    }

    if (!is_numeric($data['price']) || $data['price'] <= 0) {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Invalid price']);
        exit();
    }

    // Update product
    $stmt = $pdo->prepare("UPDATE Product SET name = ?, price = ?, category_id = ? WHERE id = ?");
    $stmt->execute([
        $data['name'],
        $data['price'],
        $data['category_id'],
        $data['id']
    ]);

    echo json_encode(['status' => 'success', 'message' => 'Product updated successfully']);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
