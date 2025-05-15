import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartService, CartItem } from '../../services/cart.service';

@Component({
  selector: 'app-cart-view',
  templateUrl: './cart-view.component.html',
  styleUrls: ['./cart-view.component.css'],
  standalone: true,
  imports: [CommonModule]
})
export class CartViewComponent implements OnInit {
  items: CartItem[] = [];
  total = 0;
  error: string | null = null;

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.loadCart();
  }

  loadCart(): void {
    this.error = null;
    this.cartService.getCart()
      .subscribe({
        next: (items) => {
          console.log('Cart items loaded:', items);
          this.items = items;
          this.calculateTotal();
        },
        error: (err) => {
          console.error('Error loading cart:', err);
          this.error = 'Failed to load cart items';
        }
      });
  }

  calculateTotal(): void {
    this.total = this.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
  }

  remove(item: CartItem): void {
    this.cartService.removeFromCart(item.product_id)
      .subscribe({
        next: () => {
          console.log('Item removed from cart');
          this.loadCart();
        },
        error: (err) => {
          console.error('Error removing item:', err);
          this.error = 'Failed to remove item from cart';
        }
      });
  }
}