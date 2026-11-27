-- RevoShop - queries.sql

-- 1. WHERE + ORDER BY + LIMIT: 3 produk termahal milik Budi di bawah Rp500.000
SELECT u.name AS seller_name, p.name AS product_name, p.price, u.email
FROM products p
JOIN users u ON p.seller_id = u.id
WHERE u.name = 'Budi' AND p.price < 500000
ORDER BY p.price DESC
LIMIT 3;

-- 2. Pembeli beserta order yang sudah dibayar, total terbesar dulu
SELECT u.name AS buyer_name, u.email, o.total, o.status
FROM users u
JOIN orders o ON o.user_id = u.id
WHERE o.status = 'paid'
ORDER BY o.total DESC
LIMIT 5;

-- 3. JOIN users - orders - payments
SELECT u.name AS buyer_name, o.id AS order_id, o.total, o.status,
       pay.amount, pay.method, pay.paid_at
FROM users u
JOIN orders o   ON o.user_id = u.id
JOIN payments pay ON pay.order_id = o.id
ORDER BY o.id, pay.paid_at;

-- 4. Total penjualan per kategori
SELECT c.name AS category, SUM(oi.quantity * oi.price) AS total_sales
FROM order_items oi
JOIN products p   ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.name
ORDER BY total_sales DESC;

-- ============================================================
-- PENGUJIAN CONSTRAINT payments (hapus tanda -- untuk mencoba satu per satu)
-- ============================================================

-- Uji A: insert payment dengan order_id yang tidak ada
-- Hasil yang diharapkan: ERROR foreign key violation (fk_payments_order)
-- INSERT INTO payments (order_id, amount, method) VALUES (9999, 100000, 'transfer bank');

-- Uji B: hapus order yang sudah punya payment
-- Hasil yang diharapkan: ERROR karena ON DELETE RESTRICT
-- DELETE FROM orders WHERE id = 2;