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

try {
    $sessionId = getCurrentSessionId();
    
    // Debug information
    $debug = [
        'session_id' => $sessionId,
        'session_data' => $_SESSION,
    ];

    // Get cart items with product details
    $stmt = $pdo->prepare("
        SELECT c.product_id, c.quantity, p.name, p.price
        FROM Cart c
        JOIN Product p ON c.product_id = p.id
        WHERE c.session_id = ?
    ");
    $stmt->execute([$sessionId]);
    $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Add query debug info
    $debug['sql_query'] = $stmt->queryString;
    $debug['params'] = [$sessionId];
    $debug['raw_items'] = $items;

    // Calculate total
    $total = array_reduce($items, function($sum, $item) {
        return $sum + ($item['price'] * $item['quantity']);
    }, 0);

    echo json_encode([
        'status' => 'success',
        'data' => [
            'items' => $items,
            'total' => $total
        ],
        'debug' => $debug
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
