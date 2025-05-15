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

    // Validate required fields
    if (!isset($data['name']) || !isset($data['price']) || !isset($data['category_id'])) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Missing required fields: name, price, and category_id are required'
        ]);
        exit();
    }

    // Validate data types
    if (!is_string($data['name']) || !is_numeric($data['price']) || !is_numeric($data['category_id'])) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Invalid data types: name must be string, price and category_id must be numeric'
        ]);
        exit();
    }

    // Start transaction
    $pdo->beginTransaction();

    try {
        // Check if category exists
        $checkCatStmt = $pdo->prepare("SELECT id FROM Category WHERE id = ?");
        $checkCatStmt->execute([$data['category_id']]);
        
        if (!$checkCatStmt->fetch()) {
            throw new Exception('Category not found');
        }

        // Insert the product
        $stmt = $pdo->prepare("INSERT INTO Product (name, price, category_id) VALUES (?, ?, ?)");
        $stmt->execute([
            $data['name'],
            $data['price'],
            $data['category_id']
        ]);

        $newProductId = $pdo->lastInsertId();

        // Commit transaction
        $pdo->commit();

        // Return success response
        echo json_encode([
            'status' => 'success',
            'message' => 'Product added successfully',
            'data' => [
                'id' => $newProductId,
                'name' => $data['name'],
                'price' => $data['price'],
                'category_id' => $data['category_id']
            ]
        ]);

    } catch (Exception $e) {
        // Rollback transaction on error
        $pdo->rollBack();
        throw $e;
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage(),
        'debug' => [
            'file' => $e->getFile(),
            'line' => $e->getLine(),
            'trace' => $e->getTraceAsString()
        ]
    ]);
}
?> 