<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Access-Control-Allow-Origin: http://localhost:4200');
header('Access-Control-Allow-Methods: GET, POST, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

header('Content-Type: application/json');

require_once __DIR__ . '/includes/databaseConnection.inc.php';

try {
    $id = null;
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        $id = isset($_GET['id']) ? intval($_GET['id']) : null;
    } else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $id = isset($_POST['id']) ? intval($_POST['id']) : null;
    }

    if (!$id) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Product ID is required'
        ]);
        exit();
    }

    $pdo->beginTransaction();

    try {
        $checkStmt = $pdo->prepare("SELECT id FROM Product WHERE id = ?");
        $checkStmt->execute([$id]);
        
        if (!$checkStmt->fetch()) {
            $pdo->rollBack();
            http_response_code(404);
            echo json_encode([
                'status' => 'error',
                'message' => 'Product not found'
            ]);
            exit();
        }

        $deleteCartStmt = $pdo->prepare("DELETE FROM Cart WHERE product_id = ?");
        $deleteCartStmt->execute([$id]);

        $deleteStmt = $pdo->prepare("DELETE FROM Product WHERE id = ?");
        $deleteStmt->execute([$id]);

        $pdo->commit();

        echo json_encode([
            'status' => 'success',
            'message' => 'Product deleted successfully'
        ]);

    } catch (Exception $e) {
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
