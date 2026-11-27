-- RevoShop - schema.sql
-- Jalankan ulang kapan saja: tabel lama dihapus dulu (anak dulu, induk belakangan).
DROP TABLE IF EXISTS payments, order_items, orders, products, categories, users CASCADE;

CREATE TABLE users (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES categories(id),
    seller_id   INTEGER NOT NULL REFERENCES users(id),
    name        VARCHAR(150) NOT NULL,
    description TEXT,
    price       NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock       INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    created_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL REFERENCES users(id),
    total      NUMERIC(10,2) NOT NULL CHECK (total >= 0),
    status     VARCHAR(20) NOT NULL DEFAULT 'pending'
               CHECK (status IN ('pending', 'paid', 'shipped', 'completed', 'cancelled')),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE order_items (
    id         SERIAL PRIMARY KEY,
    order_id   INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    price      NUMERIC(10,2) NOT NULL CHECK (price >= 0)  -- harga saat transaksi
);

-- Pilihan: ON DELETE RESTRICT
-- Alasan: payment adalah catatan keuangan. Kalau order dihapus dan payment ikut
-- terhapus (CASCADE), riwayat pembayaran hilang dan sulit diaudit. Dengan RESTRICT,
-- order yang sudah punya payment tidak bisa dihapus sebelum payment-nya ditangani.
CREATE TABLE payments (
    id       SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    amount   NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    method   VARCHAR(30) NOT NULL,
    paid_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id)
        REFERENCES orders(id) ON DELETE RESTRICT
);