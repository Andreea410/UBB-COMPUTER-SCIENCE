import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ProductService, Product, PaginationInfo } from '../../services/product.service';
import { CategoryService, Category } from '../../services/category.service';

@Component({
  selector: 'app-admin-products',
  templateUrl: './admin-products.component.html',
  styleUrls: ['./admin-products.component.css'],
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class AdminProductsComponent implements OnInit {
  products: Product[] = [];
  categories: Category[] = [];
  editMode = false;
  newProduct: Product = {
    id: 0,
    name: '',
    price: 0,
    category_id: 0
  };
  pagination: PaginationInfo = {
    currentPage: 1,
    perPage: 4,
    totalProducts: 0,
    totalPages: 0
  };

  constructor(
    private productService: ProductService,
    private categoryService: CategoryService
  ) {}

  ngOnInit(): void {
    this.loadProducts();
    this.loadCategories();
  }

  loadProducts(): void {
    this.productService.getProducts(this.pagination.currentPage)
      .subscribe(data => {
        this.products = data.products;
        this.pagination = data.pagination;
      });
  }

  loadCategories(): void {
    this.categoryService.getCategories()
      .subscribe(data => this.categories = data);
  }

  getCategoryName(categoryId: number): string {
    const category = this.categories.find(c => c.id === categoryId);
    return category ? category.name : 'Unknown';
  }

  editProduct(product: Product): void {
    this.editMode = true;
    this.newProduct = { ...product };
  }

  cancelEdit(): void {
    this.editMode = false;
    this.newProduct = {
      id: 0,
      name: '',
      price: 0,
      category_id: 0
    };
  }

  saveProduct(): void {
    if (this.newProduct.name && this.newProduct.price > 0 && this.newProduct.category_id > 0) {
      if (this.editMode) {
        this.productService.updateProduct(this.newProduct)
          .subscribe(() => {
            this.loadProducts();
            this.cancelEdit();
          });
      } else {
        this.productService.addProduct(this.newProduct)
          .subscribe(() => {
            this.loadProducts();
            this.cancelEdit();
          });
      }
    }
  }

  deleteProduct(id: number): void {
    if (confirm('Are you sure you want to delete this product?')) {
      this.productService.deleteProduct(id)
        .subscribe(() => this.loadProducts());
    }
  }

  nextPage(): void {
    if (this.pagination.currentPage < this.pagination.totalPages) {
      this.pagination.currentPage++;
      this.loadProducts();
    }
  }

  prevPage(): void {
    if (this.pagination.currentPage > 1) {
      this.pagination.currentPage--;
      this.loadProducts();
    }
  }
}