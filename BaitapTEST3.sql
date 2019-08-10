/*
Nhânviên(MSNV, Họtên, Tuổi, Lương) 
Phòng(MSP, TênPhòng, Địađiểm, Ngânquỹ, MSTrưởngphòng) 
Làmviệc (MSNV, MSP, Thờigian)
Hãy viết các truy vấn sau bằng SQL
	
*/
CREATE TABLE NhanVien
(
	MSNV VARCHAR(10) NOT NULL,
	Hoten VARCHAR(30) NOT NULL,
	Tuoi INT NOT NULL,
	Luong INT NOT NULL,
	PRIMARY KEY (MSNV)
);

CREATE TABLE PhongLV
(
	MSP VARCHAR(10) NOT NULL,
	Tenphong VARCHAR(20) NOT NULL,
	Diadiem VARCHAR(30) NOT NULL,
	Nganquy INT NOT NULL,
	MSTruongphong VARCHAR(10) NOT NULL,
	PRIMARY KEY (MSP),
	FOREIGN KEY (MSTruongphong) REFERENCES NhanVien(MSNV)
);


CREATE TABLE LamViec
(
	MSNV VARCHAR(10) NOT NULL,
	MSP VARCHAR(10) NOT NULL,
	Thoigian TIME NOT NULL,
	PRIMARY KEY (MSNV, MSP),
	FOREIGN KEY (MSNV) REFERENCES NhanVien(MSNV),
	FOREIGN KEY (MSP) REFERENCES PhongLV(MSP)
	
);
 -- drop table LamViec, PhongLV, NhanVien
INSERT INTO `NhanVien` VALUES
('NV0025','TenNV025',30,3500),
('NV0023','TenNV023',20,500),
('NV0024','TenNV024',20,500),
('NV007','TenNV07',20,500),
('NV008','TenNV08',20,500),
('NV009','TenNV09',20,500),
('NV0010','TenNV010',20,500),
('NV0011','TenNV011',20,500),
('NV0012','TenNV012',20,500),
('NV0013','TenNV013',20,500),
('NV0014','TenNV014',20,500),
('NV0015','TenNV015',20,500),
('NV0016','TenNV016',20,500),
('NV0017','TenNV017',20,500),
('NV0018','TenNV018',20,500),
('NV0019','TenNV019',20,500),
('NV0020','TenNV020',20,500),
('NV0021','TenNV021',20,500),
('NV0022','TenNV022',20,500),
('NV006','TenNV06',20,500), 
('NV001','TenNV01',21,1000),
('NV002','TenNV02',22,2000),
('NV003','TenNV03',23,3000),
('NV004','TenNV04',24,1000),
('NV005','TenNV05',25,2000);

INSERT INTO PhongLV VALUES
('P005','TenPhong005','DiaDiem005',2500,'NV003'),
('P004','TenPhong004','DiaDiem004',500,'NV003'),
('P003','TenPhong003','DiaDiem003',3000,'NV001'),
('P001','TenPhong001','DiaDiem001',2000,'NV001'),
('P002','TenPhong002','DiaDiem002',3000,'NV002');

INSERT INTO LamViec VALUES
('NV004','P004','09:00:00'),
('NV003','P005','09:00:00'),
('NV003','P004','09:00:00'),
('NV001','P003','09:00:00'),
('NV0025','P001','09:00:00'),
('NV0025','P002','09:00:00'),
('NV0023','P001','09:00:00'),
('NV0024','P001','09:00:00'),
('NV007','P001','09:00:00'),
('NV008','P001','09:00:00'),
('NV009','P001','09:00:00'),
('NV0010','P001','09:00:00'),
('NV0011','P001','09:00:00'),
('NV0012','P001','09:00:00'),
('NV0013','P001','09:00:00'),
('NV0014','P001','09:00:00'),
('NV0015','P001','09:00:00'),
('NV0016','P001','09:00:00'),
('NV0017','P001','09:00:00'),
('NV0018','P001','09:00:00'),
('NV0019','P001','09:00:00'),
('NV0020','P001','09:00:00'),
('NV0021','P001','09:00:00'),
('NV0022','P001','09:00:00'),
('NV006','P002','09:00:00'),
('NV006','P001','09:00:00'),
('NV001','P001','09:00:00'),
('NV003','P002','09:00:00'),
('NV002','P001','09:00:00'),
('NV004','P002','09:00:00'),
('NV005','P002','09:00:00');

-- Cau a : Đưa ra tên và tuổi của các nhân viên làm việc cho cả phòng Tổ chức và Kế hoạch

SELECT table1.Hoten, table1.Tuoi
FROM (
	SELECT NhanVien.`MSNV`, Hoten, Tuoi
	FROM `NhanVien` INNER JOIN `LamViec` ON `NhanVien`.`MSNV` = `LamViec`.`MSNV`
	INNER JOIN `PhongLV` ON `PhongLV`.`MSP` = `LamViec`.`MSP`
	WHERE `Tenphong` = 'TenPhong001'
	) AS table1
INNER JOIN 
     (
	SELECT NhanVien.`MSNV`, Hoten, Tuoi
	FROM `NhanVien` INNER JOIN `LamViec` ON `NhanVien`.`MSNV` = `LamViec`.`MSNV`
	INNER JOIN `PhongLV` ON `PhongLV`.`MSP` = `LamViec`.`MSP`
	WHERE `Tenphong` = 'TenPhong002'
	)AS table2
ON table1.MSNV = table2.MSNV
-- Cách 2 : Join 2 Bảng LamViec vs PhongLV => MaNV sau do mới join với Bảng NhanVien
-- Cau b : Với mỗi phòng với trên 20 nhân viên, hãy đưa ra mã số phong và số nhân viên làm trong phòng đó 

SELECT MSP, COUNT(MSNV) AS 'SoLuongNV'
FROM LamViec
GROUP BY MSP
HAVING SoLuongNV > 20

-- Cau c : Đưa ra tên của các nhân viên mà lương của họ cao hơn cả ngân quỹ của tất cả các phòng mà nhân viên đó làm việc 

SELECT *
FROM (
	SELECT NhanVien.`MSNV`, Hoten
	FROM `NhanVien` INNER JOIN `LamViec` ON `NhanVien`.`MSNV` = `LamViec`.  `MSNV`
	INNER JOIN `PhongLV` ON `PhongLV`.`MSP` = `LamViec`.`MSP`
	WHERE Luong > Nganquy 
	GROUP BY NhanVien.`MSNV`
) AS result1 
WHERE result1.MSNV NOT IN (
	SELECT NhanVien.`MSNV`
	FROM `NhanVien` INNER JOIN `LamViec` ON `NhanVien`.`MSNV` = `LamViec`.`MSNV`
	INNER JOIN `PhongLV` ON `PhongLV`.`MSP` = `LamViec`.`MSP`
	WHERE Luong < Nganquy 
	GROUP BY NhanVien.`MSNV`
)
-- Cau d : Đưa ra mã số trưởng phòng của những người trưởng phòng mà các phòng họ quản lý đều có ngân quỹ > 1,000,000

SELECT result1.MSTruongphong
FROM (
	SELECT PhongLV.`MSTruongphong`
	FROM LamViec INNER JOIN PhongLV ON LamViec.`MSP` = PhongLV.`MSP`
	WHERE PhongLV.`Nganquy` > 1000
	GROUP BY PhongLV.`MSTruongphong`
) AS result1
WHERE result1.MSTruongphong NOT IN 
(
	SELECT table2.MSTruongphong
	FROM (
		SELECT PhongLV.`MSP`, PhongLV.`MSTruongphong`, PhongLV.`Nganquy`
		FROM LamViec INNER JOIN PhongLV ON LamViec.`MSP` = PhongLV.`MSP`
		WHERE PhongLV.`Nganquy` > 1000
		GROUP BY PhongLV.`MSP`
	) AS table1
	RIGHT JOIN 
	(
		SELECT PhongLV.`MSP`, PhongLV.`MSTruongphong`
		FROM PhongLV
	) AS table2
	ON table1.MSP = table2.MSP
	WHERE table1.MSTruongphong IS NULL
	GROUP BY table2.MSTruongphong
)

-- Cach 2 :

SELECT result1.MSTruongphong
FROM (
	SELECT PhongLV.`MSTruongphong`
	FROM LamViec INNER JOIN PhongLV ON LamViec.`MSP` = PhongLV.`MSP`
	WHERE PhongLV.`Nganquy` > 1000
	GROUP BY PhongLV.`MSTruongphong`
) AS result1
WHERE result1.MSTruongphong NOT IN 
(
	SELECT PhongLV.`MSTruongphong`
	FROM LamViec INNER JOIN PhongLV ON LamViec.`MSP` = PhongLV.`MSP`
	WHERE PhongLV.`Nganquy` < 1000
	GROUP BY PhongLV.`MSP`
)


-- Cau e : Đưa ra tên của người trưởng phòng mà phòng đó có ngân quỹ lớn nhất

SELECT Hoten 
FROM NhanVien INNER JOIN PhongLV ON NhanVien.`MSNV` = PhongLV.`MSTruongphong`
WHERE PhongLV.`Nganquy` = (
	SELECT MAX(`Nganquy`)
	FROM PhongLV
)

-- Cau f Nếu một người có thể quản lý nhiều phòng, người đó có quyền kiểm soát ngân quỹ của tất cả các phògn đó. 
-- Hãy đưa ra mã số của người trưởng phòng mà tổng số ngân quỹ được kiểm soát bởi người đó > 5,000,000

SELECT MSTruongphong, SUM(Nganquy) AS 'Tien'
FROM PhongLV
GROUP BY MSTruongphong
HAVING Tien > 4000

SELECT * FROM NhanVien;
SELECT * FROM PhongLV;
SELECT * FROM LamViec;
















