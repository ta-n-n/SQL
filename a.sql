-- Create database sales_management
DROP DATABASE IF EXISTS `sales_management`;

CREATE DATABASE `sales_management` CHARACTER
SET
    utf8mb4 COLLATE utf8mb4_unicode_ci;

USE sales_management;

-- Create table Khách hàng
DROP TABLE IF EXISTS `customers`;

CREATE TABLE
    `customers` (
        `customer_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_name` VARCHAR(50),
        `trading_name` VARCHAR(20),
        `address` VARCHAR(50),
        `email` VARCHAR(30),
        `phone` VARCHAR(15),
        `fax` VARCHAR(15)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Nhà cung cấp
DROP TABLE IF EXISTS `suppliers`;

CREATE TABLE
    `suppliers` (
        `company_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_name` VARCHAR(50),
        `trading_name` VARCHAR(20),
        `address` VARCHAR(50),
        `phone` VARCHAR(15),
        `fax` VARCHAR(15),
        `email` VARCHAR(30)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Loại Hàng
DROP TABLE IF EXISTS `product_types`;

CREATE TABLE
    `product_types` (
        `product_type_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `product_type_name` VARCHAR(30)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Sản phẩm
DROP TABLE IF EXISTS `products`;

CREATE TABLE
    `products` (
        `product_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `company_id` BIGINT NOT NULL,
        `product_type_id` BIGINT NOT NULL,
        `product_name` VARCHAR(30),
        `quantity` INT,
        `unit` VARCHAR(10),
        `price` NUMERIC(10, 2),
        CONSTRAINT FK_products_type_id FOREIGN KEY (`product_type_id`) REFERENCES product_types (`product_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_products_company_id FOREIGN KEY (`company_id`) REFERENCES suppliers (`company_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Nhân viên
DROP TABLE IF EXISTS `employees`;

CREATE TABLE
    `employees` (
        `employee_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `last_name` VARCHAR(40),
        `first_name` VARCHAR(10),
        `birthday` DATE,
        `start_date` DATETIME,
        `address` VARCHAR(60),
        `phone` VARCHAR(15),
        `base_salary` DECIMAL(10, 2),
        `allowance` DECIMAL(10, 2)
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Đơn đặt hàng
DROP TABLE IF EXISTS `orders`;

CREATE TABLE
    `orders` (
        `order_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `customer_id` BIGINT NOT NULL,
        `employee_id` BIGINT NOT NULL,
        `order_date` DATETIME,
        `delivery_date` DATETIME,
        `shipping_date` DATETIME,
        `shipping_address` VARCHAR(80),
        CONSTRAINT FK_orders_customer_id FOREIGN KEY (`customer_id`) REFERENCES customers (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_orders_employee_id FOREIGN KEY (`employee_id`) REFERENCES employees (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Create table Chi tiết đơn hàng
DROP TABLE IF EXISTS `order_details`;

CREATE TABLE
    `order_details` (
        `order_id` BIGINT NOT NULL,
        `product_id` BIGINT NOT NULL,
        `selling_price` DECIMAL(15, 2),
        `quantity` DOUBLE,
        `discount_amount` DECIMAL(15, 2),
        CONSTRAINT PK_order_details_order_id_product_id PRIMARY KEY (`order_id`, `product_id`),
        CONSTRAINT FK_order_details_order_id FOREIGN KEY (`order_id`) REFERENCES orders (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_order_details_product_id FOREIGN KEY (`product_id`) REFERENCES products (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = UTF8MB4_UNICODE_CI;


USE sales_management;

-- Create table Khách hàng
INSERT INTO `customers` VALUES(1, 'Công ty sữa Việt Nam', 'VINAMILK', 'Hà Nội', 'vinamilk@vietnam.com', '04-891135', '');
INSERT INTO `customers` VALUES(2, 'Công ty may mặc Việt Tiến', 'VIETTIEN', 'Sài Gòn', 'viettien@vietnam.com', '08-808803', '');
INSERT INTO `customers` VALUES(3, 'Tổng công ty thực phẩm dinh dưỡng NUTRIFOOD', 'NUTRIFOOD', 'Sài Gòn', 'nutrifood@vietnam.com', '08-809890', '');
INSERT INTO `customers` VALUES(4, 'Công ty điện máy Hà Nội', 'MACHANOI', 'Hà Nội', 'machanoi@vietnam.om', '04-898399', '');
INSERT INTO `customers` VALUES(5, 'Hãng hàng không Việt Nam', 'VIETNAMAIRLINES', 'Sài Gòn', 'vietnamairlines@vietnam.com', '08-888888', '');
INSERT INTO `customers` VALUES(6, 'Công ty dụng cụ học sinh MIC','MIC', 'Hà Nội', 'mic@vietnam.com', '04-804408', '');

-- Create table Nhà cung cấp
INSERT INTO `suppliers` VALUES(1, 'Công ty sữa Việt Nam', 'VINAMILK', 'Hà Nội', '04-891135', '', 'vinamilk@vietnam.com');
INSERT INTO `suppliers` VALUES(2, 'Công ty may mặc Việt Tiến', 'VIETTIEN', 'Sài Gòn', '08-808803', '', 'viettien@vietnam.com');
INSERT INTO `suppliers` VALUES(3, 'Siêu thị Coop-mart', 'COOPMART', 'Quy Nhơn', '056-888666', '', 'coopmart@vietnam.com');
INSERT INTO `suppliers` VALUES(4, 'Công ty máy tính Quang Vũ', 'QUANGVU', 'Quy Nhơn', '056-888777', '', 'quangvu@vietnam.com');
INSERT INTO `suppliers` VALUES(5, 'Nội thất Đài Loan Dafuco', 'DAFUCO', 'Quy Nhơn', '056-888111', '', 'dafuco@vietnam.com');
INSERT INTO `suppliers` VALUES(6, 'Công ty sản xuất dụng cụ học sinh Golden', 'GOLDEN', 'Quy Nhơn', '056-891135', '', 'golden@vietnam.com');

-- Create table Loại Hàng
INSERT INTO `product_types` VALUES(1, 'Thực phẩm');
INSERT INTO `product_types` VALUES(2, 'Ðiện tử');
INSERT INTO `product_types` VALUES(3, 'May mặc');
INSERT INTO `product_types` VALUES(4, 'Nội thất');
INSERT INTO `product_types` VALUES(5, 'Dụng cụ học tập');

-- Create table Sản phẩm
INSERT INTO `products` VALUES(1, 1, 1, 'Sửa hộp XYZ', 10, 'Hộp', 4000);
INSERT INTO `products` VALUES(2, 1, 1, 'Sửa XO', 12, 'Hộp', 180000);
INSERT INTO `products` VALUES(3, 1, 1, 'Sửa tươi Vinamilk không đường', 5000, 'Hộp', 3500);
INSERT INTO `products` VALUES(4, 3, 1, 'Táo', 12, 'Ký', 12000);
INSERT INTO `products` VALUES(5, 3, 1, 'Cà chua', 15, 'Ký', 5000);
INSERT INTO `products` VALUES(6, 3, 1, 'Bánh AFC', 100, 'Hộp', 3000);
INSERT INTO `products` VALUES(7, 3, 1, 'Mì tôm A-One', 150, 'Thùng', 40000);
INSERT INTO `products` VALUES(8, 2, 3, 'Đồng phục công sở nữ', 140, 'Bộ', 340000);
INSERT INTO `products` VALUES(9, 2, 3, 'Veston nam', 30, 'Bộ', 500000);
INSERT INTO `products` VALUES(10, 2, 3, 'Áo sơ mi nam', 20, 'Cái', 75000);
INSERT INTO `products` VALUES(11, 4, 2, 'LCD Nec', 10, 'Cái', 3100000);
INSERT INTO `products` VALUES(12, 4, 2, 'Ổ cứng 80GB', 20, 'Cái', 800000);
INSERT INTO `products` VALUES(13, 4, 2, 'Bàn phím Mitsumi', 20 , 'Cái', 150000);
INSERT INTO `products` VALUES(14, 4, 2, 'Tivi LCD', 10, 'Cái', 20000000);
INSERT INTO `products` VALUES(15, 4, 2, 'Máy tính xách tay NEC', 60, 'Cái', 18000000);
INSERT INTO `products` VALUES(16, 5, 4, 'Bàn ghế ăn', 20, 'Bộ', 1000000);
INSERT INTO `products` VALUES(17, 5, 4, 'Bàn ghế Salon', 20, 'Bộ', 150000);
INSERT INTO `products` VALUES(18, 6, 5, 'Vở học sinh cao cấp', 20000 , 'Ram', 48000);
INSERT INTO `products` VALUES(19, 6, 5, 'Viết bi học sinh', 2000 , 'Cây', 2000);
INSERT INTO `products` VALUES(20, 6, 5, 'Hộp màu tô', 2000 , 'Hộp', 7500);
INSERT INTO `products` VALUES(21, 6, 5, 'Viết mực cao cấp', 2000 , 'Cây', 20000);
INSERT INTO `products` VALUES(22, 6, 5, 'Viết chì 2B', 2000 , 'Cây', 3000);
INSERT INTO `products` VALUES(23, 6, 5, 'Viết chì 4B', 2000 , 'Cây', 6000);

-- Create table Nhân viên
INSERT INTO `employees` VALUES(1, 'Đậu Tố', 'Anh', '1986-07-03','2020-01-03 00:00:00', 'Quy Nhơn', '056-647995', 10000000, 1000000);
INSERT INTO `employees` VALUES(2, 'Lê Thị Bích', 'Hoa', '1986-05-20','2020-01-03 00:00:00', 'An Khê', '', 9000000, 1000000);
INSERT INTO `employees` VALUES(3, 'Ông Hoàng', 'Hải', '1987-08-11','2020-01-03 00:00:00', 'Đà Nẵng', '0905-611725', 12000000, 0);
INSERT INTO `employees` VALUES(4, 'Trần Nguyễn Đức', 'Hoàng', '1986-09-04','2020-01-03 00:00:00', 'Quy Nhơn', '', 11000000, 0);
INSERT INTO `employees` VALUES(5, 'Nguyễn Hoài', 'Phong', '1986-06-14', '2020-01-03 00:00:00', 'Quy Nhơn', '056-891135', 13000000, 0);
INSERT INTO `employees` VALUES(6, 'Trương Thị Thế', 'Quang', '1987-06-17', '2020-01-03 00:00:00', 'Ayunpa', '0979-792176', 10000000, 500000);
INSERT INTO `employees` VALUES(7, 'Nguyễn Đức', 'Thắng', '1984-09-13', '2020-01-03 00:00:00', 'Phù Mỹ', '0955-593893', 1200000,0);
INSERT INTO `employees` VALUES(8, 'Nguyễn Minh', 'Đăng', '1987-12-29', '2020-01-03 00:00:00', 'Quy Nhơn','0905-779919', 14000000, 0);
INSERT INTO `employees` VALUES(9, 'Hồ Thị Phương', 'Mai', '1987-09-14', '2020-01-03 00:00:00', 'Tây Sơn', '', 9000000, 500000);

-- Create table Đơn đặt hàng
INSERT INTO `orders` VALUES(1, 1, 1, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(2, 1, 2, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(3, 2, 3, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(4, 3, 4, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(5, 4, 5, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(6, 5, 8, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(7, 6, 9, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Hà Nội');
INSERT INTO `orders` VALUES(8, 2, 6, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');
INSERT INTO `orders` VALUES(9, 3, 7, '2025-09-20 00:00:00', '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Sài Gòn');

-- Create table Chi tiết đơn hàng
INSERT INTO `order_details` VALUES(9, 18, 48000, 1000, 0);
INSERT INTO `order_details` VALUES(9, 19, 2000, 1000, 0);
INSERT INTO `order_details` VALUES(9, 20, 7500, 1000, 0);
INSERT INTO `order_details` VALUES(8, 14, 20000000, 2, 1000000);
INSERT INTO `order_details` VALUES(7, 3, 3000, 200, 0);
INSERT INTO `order_details` VALUES(4, 8, 340000, 80, 10000);
INSERT INTO `order_details` VALUES(5, 3, 3000, 1000, 0);
INSERT INTO `order_details` VALUES(6, 15, 18000000, 20, 1000000);
INSERT INTO `order_details` VALUES(6, 11, 3100000, 2, 100000);
INSERT INTO `order_details` VALUES(3, 8, 340000, 30, 10000);
INSERT INTO `order_details` VALUES(3, 9, 500000, 30, 20000);
INSERT INTO `order_details` VALUES(2, 9, 500000, 20, 20000);
INSERT INTO `order_details` VALUES(2, 8, 340000, 30, 10000);
INSERT INTO `order_details` VALUES(1, 1, 4000, 5, 0);
INSERT INTO `order_details` VALUES(1, 2, 180000, 5, 5000);
INSERT INTO `order_details` VALUES(1, 3, 12000, 5, 0);
INSERT INTO `order_details` VALUES(1, 6, 3000, 50, 0);
INSERT INTO `order_details` VALUES(1, 7, 40000,100, 0);

 
 -- 1.	Cho biết danh sách các đối tác cung cấp hàng cho công ty
 Select*from customers;
 Select*from employees;
 Select*from orders;
 Select*from order_details;
 Select*from products;
 Select*from product_types;
 Select*from suppliers;
-- 2.	Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty
SELECT product_id,product_name,quantity FROM products;
-- 3.	Họ tên, địa chỉ và năm bắt đầu làm việc của các nhân viên trong cty
SELECT last_name,first_name,start_date FROM employees;
-- 4.	Địa chỉ, điện thoại của nhà cung cấp có tên giao dịch VINAMILK
SELECT company_name,address,phone,trading_name FROM customers WHERE trading_name="VINAMILK";
-- 5.	Mã và tên của các mặt hàng có giá trị lớn hơn 100000 và số lượng hiện có ít hơn 50
SELECT product_id,product_name FROM products WHERE quantity<50 AND price >100000;
-- 6.	Cho biết mỗi mặt hàng trong công ty do ai cung cấp
SELECT products.product_name,suppliers.company_name FROM products INNER JOIN suppliers ON  products.company_id=suppliers.company_id;
-- 7.	Công ty Việt Tiến đã cung cấp những mặt hàng nào
SELECT products.product_name,suppliers.company_name FROM products INNER JOIN suppliers ON  products.company_id=suppliers.company_id WHERE company_name="Công ty may mặc Việt Tiến";
-- 8.	Loại hàng thực phẩm do những công ty nào cung cấp, địa chỉ của công ty đó
SELECT distinct product_types.product_type_name, suppliers.company_name, suppliers.address
FROM products INNER JOIN product_types ON  products.product_type_id = product_types.product_type_id
				  INNER JOIN suppliers ON products.company_id = suppliers.company_id;
-- 9.	Những khách hàng nào (tên giao dịch) đã đặt mua mặt hàng sữa hộp của công ty
SELECT distinct product_types.product_type_name, suppliers.company_name, suppliers.address
FROM products INNER JOIN product_types ON  products.product_type_id = product_types.product_type_id
				  INNER JOIN suppliers ON products.company_id = suppliers.company_id;
-- 10.	Đơn đặt hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao hàng là ở đâu
-- 11.	Hãy cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu (lương = lương cơ bản + phụ cấp)
-- 12.	Trong đơn đặt hàng số 3 đặt mua những mạt hàng nào và số tiền mà khách hàng phải trả cho mỗi mặt hàng là bao nhiêu(số tiền phải trả = số lượng x giá bán – số lượng x giá bán x mức giảm giá / 100)
-- 13.	Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng cho công ty (tức là có cùng tên giao dịch)
-- 14.	Trong công ty có những nhân viên nào có cùng ngày sinh
-- 15.	Những đơn hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những đơn đó là của công ty nào
-- 16.	Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và nhà cung cấp hàng cho công ty
-- 17.	Những mặt hàng nào chưa từng được khách hàng đặt mua
-- 18.	Những nhân viên nào của công ty chưa từng lập hóa đơn đặt hàng nào
-- 19.	Những nhân viên nào của công ty có lương cơ bản cao nhất
-- 20.	Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu
-- 21.	Trong năm 2025 những mặt hàng nào đặt mua đúng mộ lần
-- 22.	Mỗi khách hàng phải bỏ ra bao nhiêu tiền để đặt mua hàng của công ty
-- 23.	Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu chưa hề lập hóa đơn nào thì cho kết quả là 0)
-- 24.	Tổng số tiền hàng mà công ty thu được trong mỗi tháng của năm 2025 (thời gian được tính theo ngày đặt hàng)
-- 25.	Tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2025
-- 26.	Số lượng hàng còn lại của mỗi mặt hàng mà công ty đã có (tổng số lượng hàng hiện có và đã bán)
-- 27.	Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng bán được của mhữmg nhân viên này là bao nhiêu
-- 28.	Đơn đặt hàng nào có số lượng hàng được đặt mua ít nhất
-- 29.	Số tiền nhiều nhất mà khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu
-- 30.	Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền của đơn đặt hàng
-- 31.	Mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng của mỗi loại và tổng số lượng của tất cả các mặt hàng hiện có trong cty
-- 32.	Thống kê trong năm 2025 mỗi một mặt hàng trong mỗi tháng và trong cả năm bán được với số lượng bao nhiêu (Yêu cầu kết quả hiểu thị dưới dạng bảng, hai cột đầu là mã hàng, tên hàng, các cột còn lại tương ứng từ tháng 1 đến tháng 12 và cả năm. Như vậy mỗi dòng trong kết quả cho biết số lượng hàng bán được mỗi tháng và trong cả năm của mỗi mặt hàng

