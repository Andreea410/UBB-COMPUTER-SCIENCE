import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { provideHttpClient, withFetch } from '@angular/common/http';
import { provideAnimations } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

import { AppRoutes } from './app.routes';
import { ProductService } from './services/product.service';
import { CartService } from './services/cart.service';
import { CategoryService } from './services/category.service';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(AppRoutes, withComponentInputBinding()),
    provideHttpClient(withFetch()),
    provideAnimations(),
    importProvidersFrom(
      CommonModule,
      FormsModule
    ),
    ProductService,
    CartService,
    CategoryService
  ]
};

export const AppConfig = {
  apiBase: 'http://localhost/e-commerce'
};
