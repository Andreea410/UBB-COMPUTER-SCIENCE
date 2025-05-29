<?php
require_once __DIR__ . '/includes/session.inc.php';
require_once __DIR__ . '/includes/databaseConnection.inc.php';

$sessionId = getCurrentSessionId();

$stmt = $pdo->prepare("
    SELECT Cart.product_id, Product.name, Product.price, Cart.quantity, Cart.session_id
    FROM Cart
    JOIN Product ON Cart.product_id = Product.id
    WHERE Cart.session_id = ?
");

$stmt->execute([$sessionId]);
$items = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html>
<head>
    <title>Session Check</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .info-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .cart-item {
            background: #f8f9fa;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="info-box">
        <h2>Session Information</h2>
        <p><strong>Your Session ID:</strong> <?php echo htmlspecialchars($sessionId); ?></p>
        <p><strong>PHP Session ID:</strong> <?php echo htmlspecialchars(session_id()); ?></p>
    </div>

    <div class="info-box">
        <h2>Your Cart Items</h2>
        <?php if (empty($items)): ?>
            <p>No items in cart</p>
        <?php else: ?>
            <?php foreach ($items as $item): ?>
                <div class="cart-item">
                    <p><strong>Product:</strong> <?php echo htmlspecialchars($item['name']); ?></p>
                    <p><strong>Price:</strong> $<?php echo number_format($item['price'], 2); ?></p>
                    <p><strong>Quantity:</strong> <?php echo $item['quantity']; ?></p>
                    <p><strong>Cart Session ID:</strong> <?php echo htmlspecialchars($item['session_id']); ?></p>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>

    <div class="info-box">
        <h2>Test Instructions</h2>
        <ol>
            <li>Open this page in two different browsers (e.g., Chrome and Firefox)</li>
            <li>Add items to cart in each browser</li>
            <li>Verify that each browser has its own separate cart</li>
            <li>The Session ID should be different for each browser</li>
        </ol>
        <p><a href="index.php">Go to Shop</a> | <a href="cart.php">View Cart</a></p>
    </div>
</body>
</html> 