<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
require_once __DIR__ . '/includes/databaseConnection.inc.php';

try {
    $results = [];
    
    // Check if Cart table exists
    $stmt = $pdo->query("SHOW TABLES LIKE 'Cart'");
    $results['cart_table_exists'] = $stmt->rowCount() > 0;

    if ($results['cart_table_exists']) {
        // Get Cart table structure
        $stmt = $pdo->query("DESCRIBE Cart");
        $results['cart_structure'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Get number of records in Cart
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM Cart");
        $results['total_cart_items'] = $stmt->fetch()['count'];

        // Get sample of cart contents
        $stmt = $pdo->query("
            SELECT c.*, p.name, p.price 
            FROM Cart c 
            JOIN Product p ON c.product_id = p.id 
            LIMIT 5
        ");
        $results['sample_cart_items'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Check if session_id column exists and its properties
        $stmt = $pdo->query("SHOW COLUMNS FROM Cart LIKE 'session_id'");
        $sessionColumn = $stmt->fetch(PDO::FETCH_ASSOC);
        $results['session_id_column'] = $sessionColumn;
    }

    echo json_encode([
        'status' => 'success',
        'data' => $results
    ], JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
?> 