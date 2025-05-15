import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AppConfig } from '../app.config';

export interface Category { id: number; name: string; }

@Injectable({ providedIn: 'root' })
export class CategoryService {
  private url = `${AppConfig.apiBase}/get_categories.php`;
  constructor(private http: HttpClient) {}
  getCategories(): Observable<Category[]> { return this.http.get<Category[]>(this.url); }
}