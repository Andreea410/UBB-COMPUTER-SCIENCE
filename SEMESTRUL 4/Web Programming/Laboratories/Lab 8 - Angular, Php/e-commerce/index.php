<!DOCTYPE html>
<html>
<head>
  <title>Product List</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 30px;
      background: #f9f9f9;
    }

    #products div {
      background: #fff;
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }

    .form-group label {
      width: 100px;
      font-weight: bold;
    }

    .form-group input {
      flex: 1;
      padding: 5px;
    }

    button {
      margin-right: 10px;
      padding: 7px 12px;
    }

    .modal {
      display: none;
      position: fixed;
      background: rgba(0, 0, 0, 0.4);
      top: 0; left: 0; right: 0; bottom: 0;
      justify-content: center;
      align-items: center;
    }

    .modal-content {
      background: white;
      padding: 20px;
      width: 350px;
      border-radius: 8px;
    }
  </style>
</head>
<body>

<h1>Products</h1>
<select id="categorySelect" onchange="loadProducts(1)">
  <option value="">All Categories</option>
</select>

<div id="products">Loading...</div>

<button onclick="prevPage()">Previous</button>
<button onclick="nextPage()">Next</button>
<a href="cart.php">View Cart</a>

<div class="modal" id="editModal">
  <div class="modal-content">
    <h3>Edit Product</h3>
    <div class="form-group">
      <label>Name:</label>
      <input type="text" id="editName">
    </div>
    <div class="form-group">
      <label>Price:</label>
      <input type="number" id="editPrice">
    </div>
    <button onclick="saveProduct()">Save</button>
    <button onclick="confirmDelete()">Delete</button>
    <button onclick="cancelEdit()">Cancel</button>
  </div>
</div>

<script>
  let selectedProductId = null;
  let currentPage = 1;

  async function loadCategories() {
    const res = await fetch('get_categories.php');
    const categories = await res.json();
    const select = document.getElementById('categorySelect');
    select.innerHTML = '<option value="">All Categories</option>';

    categories.forEach(cat => {
      const opt = document.createElement('option');
      opt.value = cat.id;
      opt.textContent = cat.name;
      select.appendChild(opt);
    });
  }

  async function loadProducts(page = 1) {
    try {
      const catId = document.getElementById('categorySelect').value;
      const res = await fetch(`get_products.php?page=${page}&category=${catId}`);
      const response = await res.json();
      
      if (response.status === 'error') {
        throw new Error(response.message);
      }

      const { products, pagination } = response.data;
      const container = document.getElementById('products');
      container.innerHTML = '';

      if (products.length === 0) {
        container.innerHTML = '<p>No products found.</p>';
        return;
      }

      products.forEach(p => {
        const div = document.createElement('div');
        div.innerHTML = `
          <h3>${p.name}</h3>
          <p>Price: $${p.price}</p>
          <p>Category: ${p.category_name}</p>
          <button onclick="openEdit(${p.id}, '${p.name}', ${p.price})">Edit</button>
          <button onclick="addToCart(${p.id})">Add to Cart</button>
        `;
        container.appendChild(div);
      });

      // Update pagination buttons
      document.querySelector('button[onclick="prevPage()"]').disabled = pagination.currentPage <= 1;
      document.querySelector('button[onclick="nextPage()"]').disabled = pagination.currentPage >= pagination.totalPages;
      
      currentPage = pagination.currentPage;
    } catch (error) {
      console.error('Error loading products:', error);
      document.getElementById('products').innerHTML = `<p style="color: red;">Error loading products: ${error.message}</p>`;
    }
  }

  async function addToCart(productId) {
  const res = await fetch('add_to_cart.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: `product_id=${productId}`
  });

  const data = await res.json();
  if (data.status === 'added') {
    alert("Product added to cart!");
  } else {
    alert("Failed to add to cart.");
  }
}

  window.onload = async () => {
    await loadCategories();
    await loadProducts();
  };

  function nextPage() {
  currentPage++;
  loadProducts(currentPage);
}

function prevPage() {
  if (currentPage > 1) {
    currentPage--;
    loadProducts(currentPage);
  }
}

  function openEdit(id, name, price) {
    selectedProductId = id;
    document.getElementById('editName').value = name;
    document.getElementById('editPrice').value = price;
    document.getElementById('editModal').style.display = 'flex';
  }

  async function saveProduct() {
    const name = document.getElementById('editName').value.trim();
    const price = parseFloat(document.getElementById('editPrice').value);

    if (!name) {
      alert('Product name is required.');
      return;
    }

    if (isNaN(price) || price <= 0) {
      alert('Price must be a positive number.');
      return;
    }

    const endpoint = selectedProductId ? 'edit_product.php' : 'insert_product.php';
    const body = selectedProductId
      ? `id=${selectedProductId}&name=${encodeURIComponent(name)}&price=${price}`
      : `name=${encodeURIComponent(name)}&price=${price}`;

    const response = await fetch(endpoint, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body
    });

    const data = await response.json();

    if (data.status === 'success' || data.status === 'inserted') {
      alert(selectedProductId ? 'Product updated successfully.' : 'Product added successfully.');
      document.getElementById('editModal').style.display = 'none';
      loadProducts(currentPage);
    } else {
      alert(data.message || 'Error occurred while saving.');
    }
  }

  async function confirmDelete() {
    const name = document.getElementById('editName').value.trim();
    if (!selectedProductId) {
      alert("Cannot delete. This product hasn't been saved yet.");
      return;
    }

    const confirmed = confirm(`Are you sure you want to delete "${name}"?`);
    if (!confirmed) return;

    const res = await fetch('delete_product.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: `id=${selectedProductId}`
    });

    const data = await res.json();
    if (data.status === 'deleted') {
      alert('Product deleted.');
      document.getElementById('editModal').style.display = 'none';
      loadProducts(currentPage);
    } else {
      alert(data.message || 'Error occurred while deleting.');
    }
  }

  function cancelEdit() {
    const confirmed = confirm("Discard changes?");
    if (confirmed) {
      document.getElementById('editModal').style.display = 'none';
    }
  }
</script>

</body>
</html>

