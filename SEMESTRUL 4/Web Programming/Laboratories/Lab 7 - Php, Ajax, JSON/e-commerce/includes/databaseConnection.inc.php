<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$dsn = "mysql:host=localhost;dbname=e-commerce_database;charset=utf8mb4";
$db_username = "root";
$db_password = "";

try {
    $pdo = new PDO($dsn, $db_username, $db_password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::MYSQL_ATTR_FOUND_ROWS => true
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    die(json_encode([
        'status' => 'error',
        'message' => 'Database connection failed',
        'debug' => [
            'error' => $e->getMessage(),
            'code' => $e->getCode()
        ]
    ]));
}
?>
