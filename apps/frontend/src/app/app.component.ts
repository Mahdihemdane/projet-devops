import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { RouterOutlet } from '@angular/router';

interface Product {
  id?: number;
  name: string;
  price: number;
}

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'ChuZone POC Full-Stack';
  products: Product[] = [];

  constructor(private http: HttpClient) { }

  ngOnInit() {
    this.fetchProducts();
  }

  fetchProducts() {
    this.http.get<Product[]>('http://localhost:8080/api/products').subscribe({
      next: (data) => this.products = data,
      error: (err) => console.error('Error fetching products', err)
    });
  }
}
