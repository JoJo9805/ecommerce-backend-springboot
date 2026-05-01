--USE master;
--GO
--ALTER DATABASE ecommerce_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE ecommerce_db;
--GO
--CREATE DATABASE ecommerce_db;
--GO
--IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ecommerce_db')
--BEGIN
--    CREATE DATABASE ecommerce_db;
--END
--GO

--USE ecommerce_db;
--GO

--CREATE TABLE roles (
--    roleid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    role_name NVARCHAR(50) NOT NULL
--);

--CREATE TABLE users (
--    userid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    full_name NVARCHAR(255) NOT NULL,
--    email NVARCHAR(255) UNIQUE NOT NULL,
--    password_hash NVARCHAR(255) NOT NULL,
--    phone NVARCHAR(20),
--    birthday DATE,
--    gender NVARCHAR(10),
--    follower_count INT DEFAULT 0,
--    status NVARCHAR(20) CHECK (status IN ('Active', 'Inactive')) DEFAULT 'Active',
--    last_login_date DATETIME,
--    roleid BIGINT,
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (roleid) REFERENCES roles(roleid)
--);

--CREATE TABLE address (
--    addressid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    userid BIGINT,
--    receiver_name NVARCHAR(255),
--    phone NVARCHAR(20),
--    province NVARCHAR(100),
--    district NVARCHAR(100),
--    ward NVARCHAR(100),
--    detail_address NVARCHAR(MAX),
--    is_default BIT DEFAULT 0,
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (userid) REFERENCES users(userid)
--);

--CREATE TABLE shop (
--    shopid BIGINT PRIMARY KEY,
--    shop_name NVARCHAR(255) NOT NULL,
--    description NVARCHAR(MAX),
--    rating DECIMAL(3,2) DEFAULT 0.0,
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (shopid) REFERENCES users(userid)
--);

--CREATE TABLE categories (
--    categoryid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    category_name NVARCHAR(255) NOT NULL,
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL
--);

--CREATE TABLE product (
--    productid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    product_name NVARCHAR(255) NOT NULL,
--    categoryid BIGINT,
--    shopid BIGINT,
--    description NVARCHAR(MAX),
--    brand NVARCHAR(100),
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (categoryid) REFERENCES categories(categoryid),
--    FOREIGN KEY (shopid) REFERENCES shop(shopid)
--);

--CREATE TABLE product_image (
--    imageid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    productid BIGINT,
--    image_url NVARCHAR(MAX) NOT NULL,
--    is_main BIT DEFAULT 0,
--    created_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (productid) REFERENCES product(productid)
--);

--CREATE TABLE product_variant (
--    variantid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    productid BIGINT,
--    size NVARCHAR(50),
--    price DECIMAL(15,2) NOT NULL,
--    color NVARCHAR(50),
--    status NVARCHAR(50),
--    stock_quantity INT DEFAULT 0,
--    sku NVARCHAR(100) UNIQUE,
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (productid) REFERENCES product(productid)
--);

--CREATE TABLE tags (
--    tagid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    tag_name NVARCHAR(100) NOT NULL UNIQUE
--);

--CREATE TABLE product_tag_map (
--    productid BIGINT,
--    tagid BIGINT,
--    PRIMARY KEY (productid, tagid),
--    FOREIGN KEY (productid) REFERENCES product(productid),
--    FOREIGN KEY (tagid) REFERENCES tags(tagid)
--);

--CREATE TABLE cart (
--    cartid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    userid BIGINT,
--    FOREIGN KEY (userid) REFERENCES users(userid)
--);

--CREATE TABLE cart_items (
--    cart_itemid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    cartid BIGINT,
--    variantid BIGINT,
--    quantity INT DEFAULT 1,
--    FOREIGN KEY (cartid) REFERENCES cart(cartid),
--    FOREIGN KEY (variantid) REFERENCES product_variant(variantid)
--);

--CREATE TABLE orders (
--    orderid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    buyerid BIGINT,
--    shopid BIGINT,
--    addressid BIGINT,
--    order_date DATETIME DEFAULT GETDATE(),
--    payment_status NVARCHAR(20) CHECK (payment_status IN ('Unpaid', 'Paid', 'Refunded')) DEFAULT 'Unpaid',
--    shipping_status NVARCHAR(20) CHECK (shipping_status IN ('Pending', 'Confirmed', 'Shipping', 'Completed', 'Cancelled')) DEFAULT 'Pending',
--    created_at DATETIME DEFAULT GETDATE(),
--    updated_at DATETIME DEFAULT GETDATE(),
--    FOREIGN KEY (buyerid) REFERENCES users(userid),
--    FOREIGN KEY (shopid) REFERENCES shop(shopid),
--    FOREIGN KEY (addressid) REFERENCES address(addressid)
--);

--CREATE TABLE order_items (
--    order_itemid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    orderid BIGINT,
--    variantid BIGINT,
--    quantity INT,
--    price DECIMAL(15,2),
--    FOREIGN KEY (orderid) REFERENCES orders(orderid),
--    FOREIGN KEY (variantid) REFERENCES product_variant(variantid)
--);

--CREATE TABLE payment_methods (
--    paymentid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    orderid BIGINT,
--    method NVARCHAR(100),
--    payment_date DATETIME,
--    amount DECIMAL(15,2),
--    FOREIGN KEY (orderid) REFERENCES orders(orderid)
--);

--CREATE TABLE shipping_units (
--    shipmentid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    orderid BIGINT,
--    shipping_method NVARCHAR(100),
--    shipping_fee DECIMAL(15,2),
--    tracking_number NVARCHAR(100),
--    shipped_date DATETIME,
--    delivery_date DATETIME,
--    FOREIGN KEY (orderid) REFERENCES orders(orderid)
--);

--CREATE TABLE reviews (
--    reviewid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    productid BIGINT,
--    userid BIGINT,
--    order_itemid BIGINT,
--    rating INT,
--    comment NVARCHAR(MAX),
--    review_date DATETIME DEFAULT GETDATE(),
--    is_fake BIT DEFAULT 0,
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL,
--    FOREIGN KEY (productid) REFERENCES product(productid),
--    FOREIGN KEY (userid) REFERENCES users(userid),
--    FOREIGN KEY (order_itemid) REFERENCES order_items(order_itemid)
--);

--CREATE TABLE vouchers (
--    voucherid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    voucher_type NVARCHAR(20) CHECK (voucher_type IN ('Shop', 'Platform', 'Shipping')),
--    discount_value DECIMAL(15,2),
--    start_date DATETIME,
--    end_date DATETIME,
--    status NVARCHAR(50),
--    updated_at DATETIME DEFAULT GETDATE(),
--    deleted_at DATETIME DEFAULT NULL
--);

--CREATE TABLE order_voucher (
--    orderid BIGINT,
--    voucherid BIGINT,
--    PRIMARY KEY (orderid, voucherid),
--    FOREIGN KEY (orderid) REFERENCES orders(orderid),
--    FOREIGN KEY (voucherid) REFERENCES vouchers(voucherid)
--);

--CREATE TABLE notifications (
--    notificationid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    senderid BIGINT NULL,
--    receiverid BIGINT,
--    type NVARCHAR(50) CHECK (type IN ('AI_Recommend', 'OrderUpdate', 'DirectMessage', 'SystemAlert')),
--    title NVARCHAR(255),
--    content NVARCHAR(MAX),
--    related_link NVARCHAR(255),
--    is_read BIT DEFAULT 0,
--    created_at DATETIME DEFAULT GETDATE(),
--    read_at DATETIME,
--    FOREIGN KEY (senderid) REFERENCES users(userid),
--    FOREIGN KEY (receiverid) REFERENCES users(userid)
--);

--CREATE TABLE user_activities (
--    activityid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    userid BIGINT,
--    productid BIGINT,
--    action_type NVARCHAR(20) CHECK (action_type IN ('View', 'Search', 'AddToCart', 'Click')),
--    timestamp DATETIME DEFAULT GETDATE(),
--    FOREIGN KEY (userid) REFERENCES users(userid),
--    FOREIGN KEY (productid) REFERENCES product(productid)
--);

--CREATE TABLE search_history (
--    searchid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    userid BIGINT,
--    keyword NVARCHAR(255),
--    created_at DATETIME DEFAULT GETDATE(),
--    FOREIGN KEY (userid) REFERENCES users(userid)
--);

--CREATE TABLE review_reports (
--    reportid BIGINT IDENTITY(1,1) PRIMARY KEY,
--    reviewid BIGINT,
--    reporterid BIGINT,
--    reason NVARCHAR(MAX),
--    created_at DATETIME DEFAULT GETDATE(),
--    FOREIGN KEY (reviewid) REFERENCES reviews(reviewid),
--    FOREIGN KEY (reporterid) REFERENCES users(userid)
--);

--CREATE TABLE review_metas (
--    reviewid BIGINT PRIMARY KEY,
--    ip_address NVARCHAR(50),
--    deviceid NVARCHAR(255),
--    FOREIGN KEY (reviewid) REFERENCES reviews(reviewid)
--);
--CREATE TABLE user_vouchers (
--    id BIGINT IDENTITY(1,1) PRIMARY KEY,
--    userid BIGINT,
--    voucherid BIGINT,
--    is_used BIT DEFAULT 0, -- 0: Chưa dùng, 1: Đã dùng
--    saved_at DATETIME DEFAULT GETDATE(),
--    FOREIGN KEY (userid) REFERENCES users(userid),
--    FOREIGN KEY (voucherid) REFERENCES vouchers(voucherid),
--    CONSTRAINT UQ_User_Voucher UNIQUE (userid, voucherid)
--);
--GO





----thêm sản phẩm mẫu để thêm
--USE ecommerce_db;
--GO

--IF NOT EXISTS (SELECT 1 FROM cart WHERE userid = 1)
--BEGIN
--    INSERT INTO cart (userid) VALUES (1);
--END
--GO

--INSERT INTO product_variant (productid, price, size, color, stock_quantity, sku, status)
--VALUES (1, 25000000, '15 inch', 'Silver', 50, 'LAPTOP-PRO-001', 'Active');
--GO

--INSERT INTO user_activities (userid, productid, action_type, timestamp)
--VALUES (1, 2, 'View', GETDATE());
--GO