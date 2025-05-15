<?php
require_once __DIR__ . '/includes/databaseConnection.inc.php';

try {
    // Add categories
    $pdo->exec("INSERT INTO Category (name) VALUES 
        ('Electronics'),
        ('Books'),
        ('Clothing')
    ON DUPLICATE KEY UPDATE name = VALUES(name)");

    // Get category IDs
    $electronics = $pdo->query("SELECT id FROM Category WHERE name = 'Electronics'")->fetchColumn();
    $books = $pdo->query("SELECT id FROM Category WHERE name = 'Books'")->fetchColumn();
    $clothing = $pdo->query("SELECT id FROM Category WHERE name = 'Clothing'")->fetchColumn();

    // Add products
    $stmt = $pdo->prepare("INSERT INTO Product (name, price, category_id) VALUES 
        ('Laptop', 999.99, ?),
        ('Smartphone', 499.99, ?),
        ('Novel', 19.99, ?),
        ('T-Shirt', 29.99, ?)
    ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), category_id = VALUES(category_id)");
    
    $stmt->execute([$electronics, $electronics, $books, $clothing]);

    echo "Test data added successfully!";
} catch (PDOException $e) {
    die("Error adding test data: " . $e->getMessage());
}
?> 