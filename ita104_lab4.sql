CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2) CHECK (total_amount >= 0),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
);
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),

    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);
INSERT INTO customers (full_name, phone, email, address) VALUES
('Nguyễn Văn An', '0901111111', 'an@gmail.com', 'Hà Nội'),
('Trần Văn Bình', '0902222222', 'binh@gmail.com', 'Hà Nội'),
('Lê Văn Cường', '0903333333', 'cuong@gmail.com', 'Đà Nẵng');
INSERT INTO products (product_name, price, stock_quantity, category) VALUES
('Sữa Vinamilk', 32000, 50, 'Đồ uống'),
('Mì Hảo Hảo', 5000, 200, 'Thực phẩm'),
('Coca Cola', 10000, 100, 'Đồ uống'),
('Bánh Oreo', 12000, 60, 'Bánh kẹo'),
('Nước suối Aquafina', 7000, 80, 'Đồ uống');
INSERT INTO orders (customer_id, total_amount) VALUES
(1, 64000),
(2, 20000);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 32000),
(2, 2, 4, 5000);
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) UNIQUE
);
ALTER TABLE suppliers
ADD COLUMN email VARCHAR(100);
ALTER TABLE products
ADD COLUMN supplier_id INT;
ALTER TABLE products
ADD CONSTRAINT fk_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);
INSERT INTO suppliers (supplier_name, contact_phone, email) VALUES
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn');
UPDATE suppliers
SET contact_phone = '0911112222'
WHERE supplier_name = 'Công ty Thực phẩm Á Châu';
DELETE FROM products
WHERE product_name = 'Nước suối Aquafina';
CREATE TABLE test_table (
    id INT
);
ALTER TABLE suppliers
DROP COLUMN contact_phone;
DROP TABLE test_table;
