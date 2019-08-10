
/*
1/	Đưa ra tên của những hãng có cung ứng ít nhất 1 mặt hàng màu đỏ?
2/	Đưa ra mã số của các hãng có cung ứng ít nhất 1 mặt hàng màu đỏ hoặc 1 mặt hàng màu xanh?
3/	Đưa ra mã số của hang có cung ứng ít nhất 1 mặt hàng màu đỏ và 1 mặt hàng màu xanh?
4/	Đưa ra mã số của hang cung ứng tất cả các mặt hàng màu đỏ?
5/	Đưa ra mã số của hang cung ứng tất cả các mặt hàng màu đỏ hoặc tất cả các mặt hàng màu xanh?
6/	Đưa ra mã số của mặt hàng được cung cấp bởi ít nhất hai hang cung ứng?	
*/

-- Cau 1:
-- Cach 1 :
SELECT TenNCC
FROM NCC INNER JOIN CungCap ON NCC.`MSNCC` = CungCap.`MSNCC`
INNER JOIN MatHang ON CungCap.`MSMH` = MatHang.`MSMH`
WHERE MatHang.`Mausac`='Mau01'
GROUP BY TenNCC

-- Cach 2 :
SELECT NCC.

-- Cau 2:
SELECT CungCap.`MSNCC`
FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`
WHERE MatHang.`Mausac` = 'Mau01' OR MatHang.`Mausac`='Mau02'
GROUP BY CungCap.`MSNCC`

-- Cau 3 :

SELECT table2.MSNCC
FROM (
	SELECT CungCap.`MSNCC`
	FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`	
	WHERE MatHang.`Mausac` = 'Mau01'
	) AS table1
INNER JOIN 
	(
	SELECT CungCap.`MSNCC`
	FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`	
	WHERE MatHang.`Mausac` = 'Mau02'
	) AS table2
ON table1.MSNCC = table2.MSNCC
GROUP BY table2.MSNCC

-- Cau 4 :
-- Chỉ đúng với trường hợp 1 : 1
SELECT CungCap.`MSNCC`
FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`
WHERE MatHang.`Mausac` = 'Mau01' 
GROUP BY CungCap.`MSNCC`
HAVING COUNT(CungCap.`MSNCC`) >= 
	(
		SELECT COUNT(*)
		FROM MatHang
		WHERE Mausac = 'Mau01'
	)
	
-- Cau 5 :

SELECT CungCap.`MSNCC`
FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`
WHERE MatHang.`Mausac` = 'Mau01' 
GROUP BY CungCap.`MSNCC`
HAVING COUNT(CungCap.`MSNCC`) >= 
	(
		SELECT COUNT(*)
		FROM MatHang
		WHERE Mausac = 'Mau01'
	)
UNION
SELECT CungCap.`MSNCC`
FROM MatHang INNER JOIN CungCap ON MatHang.`MSMH` = CungCap.`MSMH`
WHERE MatHang.`Mausac` = 'Mau02' 
GROUP BY CungCap.`MSNCC`
HAVING COUNT(CungCap.`MSNCC`) >= 
	(
		SELECT COUNT(*)
		FROM MatHang
		WHERE Mausac = 'Mau02'
	)

-- Cau 6 :
-- Cach 1
SELECT CungCap.MSMH
FROM NCC INNER JOIN CungCap ON NCC.`MSNCC` = CungCap.`MSNCC`
INNER JOIN MatHang ON CungCap.`MSMH` = MatHang.`MSMH`
GROUP BY CungCap.MSMH
HAVING COUNT(CungCap.MSMH) >=2

-- Cach 2
SELECT MSMH
FROM CungCap
GROUP BY MSMH
HAVING COUNT(MSMH) >= 2

SELECT * FROM NCC;
SELECT * FROM MatHang;
SELECT * FROM CungCap;




