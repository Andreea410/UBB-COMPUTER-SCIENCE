import { Routes } from '@angular/router';
import { ProductListComponent } from './components/product-list/product-list.component';
import { CartViewComponent } from './components/cart-view/cart-view.component';
import { AdminProductsComponent } from './components/admin-products/admin-products.component';

export const AppRoutes: Routes = [
  { path: '', component: ProductListComponent },
  { path: 'cart', component: CartViewComponent },
  { path: 'admin/products', component: AdminProductsComponent },
  { path: '**', redirectTo: '' }
];
