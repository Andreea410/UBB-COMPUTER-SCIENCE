// src/main.ts
import { bootstrapApplication } from '@angular/platform-browser';
import { AppComponent } from './app/app.component';
import { appConfig } from './app/app.config';

console.log('Starting application bootstrap...');

bootstrapApplication(AppComponent, appConfig)
  .then(() => console.log('Application bootstrap successful'))
  .catch(err => console.error('Application bootstrap failed:', err));
