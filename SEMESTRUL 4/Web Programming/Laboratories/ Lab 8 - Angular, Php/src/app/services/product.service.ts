import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, catchError, tap, throwError, map } from 'rxjs';
import { AppConfig } from '../app.config';

export interface Product { id: number; name: string; price: number; category_id: number; }

export interface PaginationInfo {
  currentPage: number;
  perPage: number;
  totalProducts: number;
  totalPages: number;
}

export interface ProductsResponse {
  products: Product[];
  pagination: PaginationInfo;
}

interface ProductResponse {
  status: string;
  data: {
    products: Product[];
    pagination: {
      currentPage: number;
      perPage: number;
      totalProducts: number;
      totalPages: number;
    };
  };
}

interface AddProductResponse {
  status: string;
  message: string;
  data?: {
    id: number;
    name: string;
    price: number;
    category_id: number;
  };
}

interface DeleteProductResponse {
  status: string;
  message: string;
}

interface UpdateProductResponse {
  status: string;
  message: string;
}

@Injectable({ providedIn: 'root' })
export class ProductService {
  private baseUrl = AppConfig.apiBase;

  constructor(private http: HttpClient) {
    console.log('ProductService initialized with baseUrl:', this.baseUrl);
  }

  getProducts(page: number = 1, categoryId?: number): Observable<ProductsResponse> { 
    const url = new URL(`${this.baseUrl}/get_products.php`);
    url.searchParams.set('page', page.toString());
    if (categoryId) {
      url.searchParams.set('category', categoryId.toString());
    }
    
    console.log('Fetching products from:', url.toString());
    return this.http.get<ProductResponse>(url.toString()).pipe(
      tap(response => console.log('Products received:', response)),
      map(response => ({
        products: response.data.products,
        pagination: response.data.pagination
      })),
      catchError(this.handleError)
    );
  }

  addProduct(product: Product): Observable<AddProductResponse> {
    const url = `${this.baseUrl}/add_product.php`;
    console.log('Adding product:', product);
    return this.http.post<AddProductResponse>(url, product).pipe(
      tap(response => console.log('Add product response:', response)),
      catchError(this.handleError)
    );
  }

  updateProduct(product: Product): Observable<UpdateProductResponse> {
    const url = `${this.baseUrl}/edit_product.php`;
    console.log('Updating product:', product);
    return this.http.post<UpdateProductResponse>(url, {
      id: product.id,
      name: product.name,
      price: product.price,
      category_id: product.category_id
    }).pipe(
      tap(response => console.log('Update product response:', response)),
      catchError(this.handleError)
    );
  }

  deleteProduct(id: number): Observable<DeleteProductResponse> {
    const url = `${this.baseUrl}/delete_product.php?id=${id}`;
    console.log('Deleting product:', id);
    return this.http.delete<DeleteProductResponse>(url).pipe(
      tap(response => console.log('Delete product response:', response)),
      catchError(this.handleError)
    );
  }

  private handleError(error: HttpErrorResponse) {
    console.error('An error occurred:', error);
    let errorMessage = 'An error occurred';
    if (error.error instanceof ErrorEvent) {
      // Client-side error
      errorMessage = error.error.message;
    } else {
      // Server-side error
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }
    return throwError(() => errorMessage);
  }
}