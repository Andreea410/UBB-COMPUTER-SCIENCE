<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
require_once __DIR__ . '/includes/databaseConnection.inc.php';

try {
    // Check if Cart table exists
    $stmt = $pdo->query("SHOW TABLES LIKE 'Cart'");
    $cartExists = $stmt->rowCount() > 0;

    if (!$cartExists) {
        // Create Cart table if it doesn't exist
        $pdo->exec("CREATE TABLE Cart (
            product_id INT NOT NULL,
            quantity INT NOT NULL DEFAULT 1,
            session_id VARCHAR(255) NOT NULL,
            PRIMARY KEY (product_id, session_id),
            FOREIGN KEY (product_id) REFERENCES Product(id)
        )");
        echo json_encode(['status' => 'success', 'message' => 'Cart table created successfully']);
        exit();
    }

    // Check if session_id column exists
    $stmt = $pdo->query("SHOW COLUMNS FROM Cart LIKE 'session_id'");
    $sessionColumnExists = $stmt->rowCount() > 0;

    if (!$sessionColumnExists) {
        // Disable foreign key checks
        $pdo->exec("SET FOREIGN_KEY_CHECKS=0");

        // Create temporary table with correct structure
        $pdo->exec("CREATE TABLE Cart_temp (
            product_id INT NOT NULL,
            quantity INT NOT NULL DEFAULT 1,
            session_id VARCHAR(255) NOT NULL,
            PRIMARY KEY (product_id, session_id),
            FOREIGN KEY (product_id) REFERENCES Product(id)
        )");

        // Copy existing data with a temporary session ID
        $tempSessionId = bin2hex(random_bytes(16));
        $pdo->exec("INSERT INTO Cart_temp (product_id, quantity, session_id)
                   SELECT product_id, quantity, '$tempSessionId' FROM Cart");

        // Drop old table and rename new one
        $pdo->exec("DROP TABLE Cart");
        $pdo->exec("RENAME TABLE Cart_temp TO Cart");

        // Re-enable foreign key checks
        $pdo->exec("SET FOREIGN_KEY_CHECKS=1");
        
        echo json_encode(['status' => 'success', 'message' => 'Cart table updated with session_id column']);
        exit();
    }

    echo json_encode(['status' => 'success', 'message' => 'Cart table is already up to date']);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString()
    ]);
}
?> 