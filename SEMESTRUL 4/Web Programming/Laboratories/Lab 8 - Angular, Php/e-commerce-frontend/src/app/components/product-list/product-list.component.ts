import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ProductService, Product, PaginationInfo } from '../../services/product.service';
import { CartService } from '../../services/cart.service';
import { CategoryService, Category } from '../../services/category.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css'],
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class ProductListComponent implements OnInit {
  products: Product[] = [];
  categories: Category[] = [];
  selectedCat = 0;
  error: string | null = null;
  pagination: PaginationInfo = {
    currentPage: 1,
    perPage: 4,
    totalProducts: 0,
    totalPages: 0
  };

  constructor(
    private productService: ProductService,
    private categoryService: CategoryService,
    private cartService: CartService
  ) {
    console.log('ProductListComponent constructed');
  }

  ngOnInit(): void {
    console.log('ProductListComponent initialized');
    this.loadCategories();
    this.loadProducts();
  }

  loadCategories(): void {
    console.log('Loading categories...');
    this.categoryService.getCategories()
      .subscribe({
        next: (data) => {
          console.log('Categories loaded:', data);
          this.categories = data;
        },
        error: (err) => {
          console.error('Error loading categories:', err);
          this.error = 'Failed to load categories';
        }
      });
  }

  loadProducts(): void {
    console.log('Loading products...');
    this.productService.getProducts(this.pagination.currentPage, this.selectedCat)
      .subscribe({
        next: (data) => {
          console.log('Products loaded:', data);
          this.products = data.products;
          this.pagination = data.pagination;
        },
        error: (err) => {
          console.error('Error loading products:', err);
          this.error = 'Failed to load products';
        }
      });
  }

  onCategoryChange(catId: any): void {
    console.log('Category changed to:', catId);
    this.selectedCat = Number(catId);
    this.pagination.currentPage = 1; // Reset to first page when changing category
    this.loadProducts();
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

  addToCart(product: Product): void {
    console.log('Adding to cart:', product);
    this.cartService.addToCart(product.id)
      .subscribe({
        next: () => {
          alert(`${product.name} added to cart!`);
        },
        error: (err) => {
          console.error('Error adding to cart:', err);
          alert('Failed to add item to cart');
        }
      });
  }
}