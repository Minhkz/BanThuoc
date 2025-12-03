DROP DATABASE IF EXISTS medifresh;
CREATE DATABASE medifresh;
USE medifresh;

-- ROLES
CREATE TABLE roles (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    `name`          NVARCHAR(20) NOT NULL,
    `description`   TEXT
);

-- USERS
CREATE TABLE users (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(100) UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    `password`      VARCHAR(255),
    full_name       NVARCHAR(100) NOT NULL,
    address         NVARCHAR(255),
    phone           CHAR(15) UNIQUE,
    avatar          VARCHAR(1000) NULL,
    role_id         INT NOT NULL,
    created_date    DATETIME DEFAULT NOW(),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);


-- PRODUCTS
CREATE TABLE products (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    `name`          VARCHAR(150) NOT NULL,
    price           DOUBLE NOT NULL,
    detail_desc     TEXT NOT NULL,
    short_desc      NVARCHAR(600) NOT NULL,
    quantity        INT NOT NULL,
    sold            INT DEFAULT 0,
    image           VARCHAR(1000),
    is_new          BIT(1) DEFAULT 0,
    is_hot          BIT(1) DEFAULT 0,
    created_date    DATETIME DEFAULT NOW()
);


-- CARTS
CREATE TABLE carts (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL UNIQUE,
    `sum`           INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- CART_PRODUCT
CREATE TABLE cart_product (
    cart_id         INT,
    product_id      INT,
    quantity        INT NOT NULL,
    price           FLOAT,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id)    REFERENCES carts(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ORDERS
CREATE TABLE orders (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT DEFAULT NULL,
    total_price     DOUBLE,
    total_product   INT,
    `status`        NVARCHAR(50),
    created_date    DATETIME DEFAULT NOW(),
    updated_date    DATETIME DEFAULT NOW() ON UPDATE NOW(),
    FOREIGN KEY (user_id)    REFERENCES users(id)   ON DELETE SET NULL
);

-- ORDER_PRODUCT
CREATE TABLE order_product (
    order_id        INT,
    product_id      INT,
    quantity        INT NOT NULL,
    price           DOUBLE NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES orders(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)  ON DELETE CASCADE
);



