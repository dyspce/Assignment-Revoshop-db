# RevoShop - Database Schema

Skema database PostgreSQL untuk toko online RevoShop (Checkpoint 1, Backend Development).

## Tabel
`users`, `categories`, `products`, `orders`, `order_items`, `payments`

## Setup lokal

1. Install PostgreSQL dan pastikan service berjalan.
2. Buat database:
   ```bash
   psql -U postgres -c "CREATE DATABASE revoshop;"
   ```
3. Jalankan file SQL berurutan:
   ```bash
   psql -U postgres -d revoshop -f schema.sql
   psql -U postgres -d revoshop -f seed.sql
   psql -U postgres -d revoshop -f queries.sql
   ```
4. Cek hasilnya:
   ```bash
   psql -U postgres -d revoshop -c "\dt"
   ```

`schema.sql` bisa dijalankan ulang kapan saja karena menghapus tabel lama terlebih dahulu.

## ERD

```mermaid
erDiagram
    users ||--o{ products : "seller_id"
    users ||--o{ orders : "user_id"
    categories ||--o{ products : "category_id"
    orders ||--o{ order_items : "order_id"
    products ||--o{ order_items : "product_id"
    orders ||--o{ payments : "order_id"

    users {
        int id PK
        varchar name
        varchar email
        timestamp created_at
    }
    categories {
        int id PK
        varchar name
    }
    products {
        int id PK
        int category_id FK
        int seller_id FK
        varchar name
        text description
        numeric price
        int stock
        timestamp created_at
    }
    orders {
        int id PK
        int user_id FK
        numeric total
        varchar status
        timestamp created_at
    }
    order_items {
        int id PK
        int order_id FK
        int product_id FK
        int quantity
        numeric price
    }
    payments {
        int id PK
        int order_id FK
        numeric amount
        varchar method
        timestamp paid_at
    }
```
