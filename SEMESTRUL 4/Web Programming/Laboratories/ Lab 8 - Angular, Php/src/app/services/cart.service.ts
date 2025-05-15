import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap, map, catchError } from 'rxjs';
import { AppConfig } from '../app.config';

export interface CartItem {
  product_id: number;
  quantity: number;
  name: string;
  price: number;
}

interface CartResponse {
  status: string;
  message?: string;
  data: {
    items: CartItem[];
    total: number;
  };
  debug?: any;
}

@Injectable({ providedIn: 'root' })
export class CartService {
  private base = AppConfig.apiBase;
  
  constructor(private http: HttpClient) {}
  
  getCart(): Observable<CartItem[]> { 
    return this.http.get<CartResponse>(`${this.base}/cart.php`, { withCredentials: true }).pipe(
      tap(response => {
        console.log('Raw cart response:', response);
        if (response.debug) {
          console.log('Debug information:', response.debug);
        }
        if (!response) {
          console.error('Cart response is null or undefined');
        } else if (!response.data) {
          console.error('Cart response missing data property:', response);
        } else if (!Array.isArray(response.data.items)) {
          console.error('Cart items is not an array:', response.data);
        }
      }),
      map(response => {
        if (response.status === 'success' && response.data && Array.isArray(response.data.items)) {
          console.log('Parsed cart items:', response.data.items);
          return response.data.items;
        }
        console.warn('Returning empty cart array due to invalid response structure');
        return [];
      }),
      catchError(error => {
        console.error('Error fetching cart:', error);
        throw error;
      })
    ); 
  }
  
  addToCart(id: number): Observable<CartResponse> { 
    console.log('Adding to cart:', id);
    return this.http.post<CartResponse>(`${this.base}/add_to_cart.php`, { product_id: id }, { withCredentials: true }).pipe(
      tap(response => console.log('Add to cart response:', response))
    ); 
  }
  
  removeFromCart(id: number): Observable<CartResponse> { 
    return this.http.post<CartResponse>(`${this.base}/remove_from_cart.php`, { product_id: id }, { withCredentials: true }); 
  }
}