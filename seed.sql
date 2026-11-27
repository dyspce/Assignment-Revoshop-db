-- RevoShop - seed.sql (jalankan setelah schema.sql)

INSERT INTO users (name, email) VALUES
    ('Budi',  'budi@revoshop.test'),
    ('Siti',  'siti@revoshop.test'),
    ('Andi',  'andi@revoshop.test'),
    ('Dewi',  'dewi@revoshop.test'),
    ('Rina',  'rina@revoshop.test'),
    ('Joko',  'joko@revoshop.test');

INSERT INTO categories (name) VALUES
    ('Elektronik'),
    ('Fashion'),
    ('Buku'),
    ('Peralatan Rumah');

INSERT INTO products (category_id, seller_id, name, description, price, stock) VALUES
    (1, 1, 'Earphone Bluetooth',     'Earphone nirkabel, baterai 20 jam',   250000, 50),
    (1, 1, 'Power Bank 10000mAh',    'Fast charging, dua port USB',         180000, 40),
    (1, 2, 'Keyboard Mekanik',       'Switch blue, layout TKL',             750000, 15),
    (2, 2, 'Kaos Polos Katun',       'Bahan katun combed 30s',               65000, 100),
    (2, 1, 'Jaket Hoodie',           'Fleece tebal, tersedia M-XL',         275000, 30),
    (3, 2, 'Buku Belajar SQL',       'Panduan SQL untuk pemula',             95000, 25),
    (3, 1, 'Novel Fiksi Petualangan','Cetakan terbaru, 320 halaman',         85000, 35),
    (4, 2, 'Blender Mini',           'Kapasitas 600 ml',                    320000, 20),
    (4, 1, 'Set Panci Stainless',    'Isi 5 buah, tahan karat',             450000, 12),
    (1, 2, 'Mouse Wireless',         'Sensor optik 1600 DPI',               120000, 60);

INSERT INTO orders (user_id, total, status) VALUES
    (3, 380000, 'paid'),        -- order 1, Andi
    (4, 750000, 'shipped'),     -- order 2, Dewi
    (5, 275000, 'completed'),   -- order 3, Rina
    (3, 630000, 'pending'),     -- order 4, Andi
    (6, 395000, 'paid'),        -- order 5, Joko
    (4, 320000, 'cancelled');   -- order 6, Dewi

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
    (1, 1,  1, 250000),
    (1, 4,  2,  65000),
    (2, 3,  1, 750000),
    (3, 6,  2,  95000),
    (3, 7,  1,  85000),
    (4, 9,  1, 450000),
    (4, 2,  1, 180000),
    (5, 10, 1, 120000),
    (5, 5,  1, 275000),
    (6, 8,  1, 320000);

-- Order 2 dibayar dua kali (cicilan): 400000 + 350000 = 750000
INSERT INTO payments (order_id, amount, method, paid_at) VALUES
    (1, 380000, 'transfer bank', NOW() - INTERVAL '5 days'),
    (2, 400000, 'transfer bank', NOW() - INTERVAL '4 days'),
    (2, 350000, 'e-wallet',      NOW() - INTERVAL '3 days'),
    (3, 275000, 'e-wallet',      NOW() - INTERVAL '10 days'),
    (5, 395000, 'kartu kredit',  NOW() - INTERVAL '1 day');