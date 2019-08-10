CREATE TABLE categories
(
	categoryID VARCHAR(10) NOT NULL,
	categoryName VARCHAR(20) NOT NULL,
	PRIMARY KEY (categoryID)
);

CREATE TABLE customers
(
	customerID VARCHAR(10) NOT NULL,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	address VARCHAR(50),
	city VARCHAR(10) NOT NULL,
	county VARCHAR(20),
	email VARCHAR(20) NOT NULL,
	phone VARCHAR(20),
	creditcardtype VARCHAR(20),
	creditcard VARCHAR(20),
	creditcardexpiration VARCHAR(20),
	username VARCHAR(20) NOT NULL,
	`password` VARCHAR(20) NOT NULL,
	age VARCHAR(20) NOT NULL,
	income VARCHAR(20),
	gender INT NOT NULL,
	PRIMARY KEY (customerID)
);

CREATE TABLE orders
(
	orderID VARCHAR(10) NOT NULL,
	customerID VARCHAR(10) NOT NULL,
	orderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	netamount VARCHAR(20),
	tax VARCHAR(20),
	totalamount VARCHAR(10) NOT NULL,
	PRIMARY KEY (orderID),
	FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

CREATE TABLE products
(
	prodID VARCHAR(10) NOT NULL,
	categoryID VARCHAR(10) NOT NULL,
	title VARCHAR(20) NOT NULL,
	actor VARCHAR(20) NOT NULL,
	price VARCHAR(10) NOT NULL,
	special VARCHAR(20) ,
	PRIMARY KEY (prodID),
	FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);


CREATE TABLE orderlines
(
	orderlineID VARCHAR(10) NOT NULL,
	orderID VARCHAR(10) NOT NULL,
	prodID VARCHAR(10) NOT NULL,
	quantity VARCHAR(10),
	orderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (orderlineID, orderID),
	FOREIGN KEY (prodID) REFERENCES products(prodID),
	FOREIGN KEY (orderID) REFERENCES orders(orderID)
);

INSERT INTO categories VALUES
(1,'loai 1'),
(2,'loai 2'),
(3,'loai 3'),
(4,'loai 4');

INSERT INTO customers VALUES
(6,'Manh','Quang','lai cach','hai duong','viet nam','phamtrong@gmail.com','123456','agribank','123456',NOW(),'trong','123',22,'123321',1),
(1,'pham','trong','lai cach','hai duong','viet nam','phamtrong@gmail.com','123456','agribank','123456',NOW(),'trong','123',22,'123321',1),
(2,'pham2','trong2','lai cach2','hai duong2','viet nam2','phamtrong2@gmail.com','123456','agribank2','123456',NOW(),'trong2','123',22,'123321',1),
(3,'pham3','trong3','lai cach3','hai duong3','viet nam3','phamtrong3@gmail.com','123456','agribank3','123456',NOW(),'trong3','123',22,'123321',1),
(4,'pham4','trong4','lai cach4','hai duong4','viet nam4','phamtrong4@gmail.com','123456','agribank4','123456',NOW(),'trong4','123',22,'123321',1);

INSERT INTO orders (`orderID`, `customerID`, `netamount`, `tax`, `totalamount`) VALUES
(1,1,20,'123',80),
(2,2,20,'123',80),
(3,3,20,'123',80),
(4,4,20,'123',80);

INSERT INTO products VALUES
(6,2,'abc','abc',40,'db'),
(5,2,'abc','abc',40,'db'),
(1,1,'abc','abc',20,'db'),
(2,2,'abc2','abc2',20,'db'),
(3,3,'abc3','abc3',20,'db'),
(4,4,'abc4','abc4',20,'db');

INSERT INTO orderlines VALUES
(2,1,5,10,NOW()),
(1,1,1,20,NOW()),
(2,2,1,20,NOW()),
(3,1,4,20,NOW()),
(4,2,2,20,NOW()),
(5,1,3,20,NOW());



-- Cau 1 : Đưa ra danh sách phân loại sản phẩm categoryName

SELECT prodID , `categoryName`
FROM `products` INNER JOIN `categories` 
ON `products`.`categoryID` = `categories`.`categoryID`
GROUP BY `categories`.`categoryName`

-- Cau 2 : Đưa ra danh sách các loại sản phẩm và số thuộc từng loại.

SELECT `categoryName`, COUNT(prodID) AS 'So Luong SP tung loai'
FROM `products` INNER JOIN `categories` 
ON `products`.`categoryID` = `categories`.`categoryID`
GROUP BY `categories`.`categoryName`

-- Cau 3 : Đưa ra danh sách các nước có khách hàng.

SELECT `county`
FROM `customers`
GROUP BY county

-- Cau 4 : Đưa ra danh sách khách hàng chưa đặt hàng.

SELECT customers.`customerID`, customers.`firstname`, customers.`lastname`
FROM `customers` LEFT JOIN orders
ON `customers`.`customerID` = orders.`customerID`
WHERE orderID IS NULL

-- Cau 5 : Thống kê tổng số lượng sản phẩm đặt trong ngày 2019-06-27

SELECT SUM(`quantity`) AS 'Tong So Luong' 
FROM `orderlines`
WHERE DATE(`orderDate`) = '2019-6-27'
-- cach toi uu
SELECT SUM(`quantity`) AS 'Tong So Luong' 
FROM `orderlines`
WHERE '2019-6-27' <= x and x < '2019-6-28' 

-- format : DATETIME : yyyy-MM-dd HH:mm:ss.SSS
-- Cau 6 : Đưa ra danh sách các sản phẩm được đặt hàng nhiều nhất

SELECT prodID, SUM(quantity) AS 'So Luong Dat SP MAX'
FROM orderlines
GROUP BY prodID
HAVING SUM(quantity) = (
		SELECT SUM(quantity)
		FROM orderlines
		GROUP BY prodID
		ORDER BY SUM(quantity) DESC
		LIMIT 1
	)

SELECT prodID, SUM(quantity) AS 'So Luong Dat SP MAX'
FROM orderlines
GROUP BY prodID
HAVING SUM(quantity) = MAX(
		SELECT SUM(quantity)
		FROM orderlines
		GROUP BY prodID
	)

-- Cau 7 : Đưa ra mặt hàng có giá đắt nhất

SELECT prodID, price
FROM `products`
WHERE price = (
		SELECT MAX(price)
		FROM products
	)

-- Cau 8 : Đưa ra thông tin products của các mặt hàng bán được với số lượng ít nhất.

SELECT `products`.`prodID`, `categoryID`, `title`, `actor`, price, SUM(quantity) AS 'Total products min'
FROM `products` INNER JOIN `orderlines`
ON `products`.`prodID` = `orderlines`.`prodID`
GROUP BY `orderlines`.`prodID`
HAVING SUM(quantity) = (
		SELECT SUM(quantity)
		FROM orderlines
		GROUP BY `orderlines`.`prodID`
		ORDER BY SUM(quantity)
		LIMIT 1
	)

SELECT `products`.`prodID`, `categoryID`, `title`, `actor`, price, SUM(quantity) AS 'Total products min'
FROM `products` INNER JOIN `orderlines`
ON `products`.`prodID` = `orderlines`.`prodID`
GROUP BY `orderlines`.`prodID`
HAVING SUM(quantity) <= MIN(
		SELECT SUM(quantity)
		FROM orderlines
		GROUP BY `orderlines`.`prodID`
	)

-- Cau 9 : Đưa ra thông tin products các mắt hàng bán được nhiều nhất trong năm 2019

SELECT `products`.`prodID`, `categoryID`, `title`, `actor`, price, SUM(quantity) AS 'Total products max', `orderDate`
FROM `products` INNER JOIN `orderlines`
ON `products`.`prodID` = `orderlines`.`prodID`
WHERE YEAR(orderDate) = '2019' 
GROUP BY `orderlines`.`prodID`
HAVING SUM(quantity) = (
		SELECT SUM(quantity)
		FROM orderlines
		WHERE YEAR(orderDate) = '2019'
		GROUP BY `orderlines`.`prodID`
		ORDER BY SUM(quantity) DESC
		LIMIT 1
	)

SELECT `products`.`prodID`, `categoryID`, `title`, `actor`, price, SUM(quantity) AS 'Total products max', `orderDate`
FROM `products` INNER JOIN `orderlines`
ON `products`.`prodID` = `orderlines`.`prodID`
WHERE x >= '2019-01-01' and x < '2020-01-01'
GROUP BY `orderlines`.`prodID`
HAVING SUM(quantity) = MAX(
		SELECT SUM(quantity)
		FROM orderlines
		WHERE YEAR(orderDate) = '2019'
		GROUP BY `orderlines`.`prodID`
	)

SELECT * FROM `categories`;
SELECT * FROM `customers`;
SELECT * FROM `orders`;
SELECT * FROM `orderlines`;
SELECT * FROM `products`;
