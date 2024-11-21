ALTER TABLE images ADD FOREIGN KEY (productId) REFERENCES Products(productId);

ALTER TABLE reviews ADD FOREIGN KEY (productId) REFERENCES Products(productId);

ALTER TABLE reviews ADD FOREIGN KEY (userId) REFERENCES Users(userId);

ALTER TABLE carts ADD FOREIGN KEY (productId) REFERENCES Products(productId);

ALTER TABLE carts ADD FOREIGN KEY (userId) REFERENCES Users(userId);

ALTER TABLE products ADD FOREIGN KEY (categoryId) REFERENCES categories(categoryId);

ALTER TABLE products ADD FOREIGN KEY (storeId) REFERENCES stores(storeId);

ALTER TABLE order_details ADD FOREIGN KEY (productId) REFERENCES Products(productId);

ALTER TABLE order_details ADD FOREIGN KEY (orderId) REFERENCES orders(orderId);

ALTER TABLE orders ADD FOREIGN KEY (storeId) REFERENCES stores(storeId);

ALTER TABLE orders ADD FOREIGN KEY (userId) REFERENCES users(userId);

ALTER TABLE stores ADD FOREIGN KEY (userId) REFERENCES users(userId);
