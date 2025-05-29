<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Access-Control-Allow-Origin: http://localhost:4200');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

require_once __DIR__ . '/includes/databaseConnection.inc.php';

header('Content-Type: application/json');

try {
    $category = $_GET['category'] ?? null;
    $page = max(1, intval($_GET['page'] ?? 1));
    $perPage = 4;
    $offset = ($page - 1) * $perPage;

    if ($category) {
        $countStmt = $pdo->prepare("SELECT COUNT(*) FROM Product WHERE category_id = ?");
        $countStmt->execute([$category]);
    } else {
        $countStmt = $pdo->prepare("SELECT COUNT(*) FROM Product");
        $countStmt->execute();
    }
    $totalProducts = $countStmt->fetchColumn();

    if ($category) {
        $stmt = $pdo->prepare("SELECT p.*, c.name as category_name 
                              FROM Product p 
                              JOIN Category c ON p.category_id = c.id 
                              WHERE p.category_id = ? 
                              LIMIT " . intval($perPage) . " OFFSET " . intval($offset));
        $stmt->execute([$category]);
    } else {
        $stmt = $pdo->prepare("SELECT p.*, c.name as category_name 
                              FROM Product p 
                              JOIN Category c ON p.category_id = c.id 
                              LIMIT " . intval($perPage) . " OFFSET " . intval($offset));
        $stmt->execute();
    }

    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'status' => 'success',
        'data' => [
            'products' => $products,
            'pagination' => [
                'currentPage' => $page,
                'perPage' => $perPage,
                'totalProducts' => $totalProducts,
                'totalPages' => ceil($totalProducts / $perPage)
            ],
            'debug' => [
                'category' => $category,
                'offset' => $offset
            ]
        ]
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage(),
        'debug' => [
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]
    ]);
}
?>
