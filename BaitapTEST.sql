CREATE TABLE KhachSan
(
	MaKS VARCHAR(10) NOT NULL,
	TenKS VARCHAR(30) NOT NULL,
	Diachi VARCHAR(50) NOT NULL,
	PRIMARY KEY (MaKS)
);

CREATE TABLE Khach
(
	Makhach VARCHAR(10) NOT NULL,
	Hoten VARCHAR(20) NOT NULL,
	Diachi VARCHAR(20) NOT NULL,
	PRIMARY KEY (Makhach)
);

CREATE TABLE Phong
(
	Sophong VARCHAR(10) NOT NULL,
	MaKS VARCHAR(10) NOT NULL,
	LoaiPhong VARCHAR(30) NOT NULL,
	Gia VARCHAR(10) NOT NULL,
	PRIMARY KEY (Sophong,MaKS),
	FOREIGN KEY (MaKS) REFERENCES KhachSan(MaKS)
);

CREATE TABLE DatPhong
(
	MaKS VARCHAR(10) NOT NULL,
	Makhach VARCHAR(10) NOT NULL,
	Ngaynhan TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Ngaytra DATETIME,
	Sophong VARCHAR(10) NOT NULL,
	PRIMARY KEY (MaKS, Makhach, Ngaynhan),
	FOREIGN KEY (Sophong) REFERENCES Phong(Sophong)
);

 -- drop table DatPhong, Phong, Khach, KhachSan;

INSERT INTO KhachSan (`MaKS`, `TenKS`, `Diachi`) VALUES
('KS001', 'TenKS001', 'Diachi001'),
('KS002', 'TenKS002', 'Diachi002'),
('KS003', 'TenKS003', 'Diachi003'),
('KS004', 'TenKS004', 'Diachi004');

INSERT INTO Khach (`Makhach`, `Hoten`, `Diachi`) VALUES
('MK001', 'KH001', 'DCKH001'),
('MK002', 'KH002', 'DCKH002'),
('MK003', 'KH003', 'DCKH003'),
('MK004', 'KH004', 'DCKH004');

INSERT INTO Phong (`Sophong`, `MaKS`, `LoaiPhong`, `Gia`) VALUES
('SP006', 'KS001', 'LP006', '6000'),
('SP003', 'KS001', 'LP003', '3000'),
('SP001', 'KS001', 'LP001', '1000'),
('SP001', 'KS002', 'LP002', '2000'),
('SP001', 'KS003', 'LP003', '3000'),
('SP001', 'KS004', 'LP004', '4000'),
('SP002', 'KS001', 'LP001', '1000'),
('SP003', 'KS002', 'LP002', '2000');

INSERT INTO DatPhong (`MaKS`, `Makhach`, `Ngaytra`, `Sophong`) VALUES
('KS001', 'MK001', NULL, 'SP002'),
('KS001', 'MK002', NULL, 'SP002'),
('KS002', 'MK003', NULL, 'SP001'),
('KS003', 'MK004', NULL, 'SP003');

-- Cau 1 :

SELECT Gia, LoaiPhong
FROM Phong INNER JOIN KhachSan ON Phong.`MaKS` = `KhachSan`.`MaKS`
WHERE `TenKS` = 'TenKS001'
GROUP BY LoaiPhong, Gia
-- Cau 2 :

SELECT Hoten 
FROM Khach INNER JOIN DatPhong ON Khach.`Makhach` = DatPhong.`Makhach`
	INNER JOIN KhachSan ON `DatPhong`.`MaKS` = `KhachSan`.`MaKS`
WHERE TenKS = 'TenKS001' AND `DatPhong`.`Ngaytra` IS NULL

/*
-- Cau 3 :
select *
from 
	(
		Select Phong.MaKS, Sophong
		from Phong inner join KhachSan on Phong.`MaKS` = KhachSan.`MaKS`
		where TenKS = 'TenKS001'
	) as table1
left join 
	(
		select *
		from DatPhong inner join Khach on DatPhong.`Makhach` = Khach.`Makhach`
	) as table2
on table1.MaKS = table2.MaKS
group by table1.Sophong
*/
-- Cau 4 :

SELECT table1.Sophong
FROM (	
	SELECT KhachSan.`MaKS`, Phong.`Sophong`
	FROM Phong INNER JOIN KhachSan ON Phong.`MaKS` = `KhachSan`.`MaKS`
	WHERE `TenKS` = 'TenKS001'
	) AS table1
LEFT JOIN DatPhong ON table1.Sophong = DatPhong.`Sophong`
WHERE DatPhong.`Makhach` IS NULL

-- Cau 5 :

SELECT KhachSan.`MaKS`, COUNT(Phong.`Sophong`) AS 'So Luong Phong'
FROM Phong INNER JOIN KhachSan ON Phong.`MaKS` = `KhachSan`.`MaKS`
WHERE `TenKS` = 'TenKS002'
GROUP BY KhachSan.`MaKS`

-- Cau 6 :

UPDATE Phong
SET Gia = Gia + Gia*0.05
WHERE Phong.`LoaiPhong` = 'LP001';
SELECT *
FROM Phong
WHERE Phong.`LoaiPhong` = 'LP001';

SELECT * FROM `KhachSan`;
SELECT * FROM `Khach`;
SELECT * FROM `Phong`;
SELECT * FROM `DatPhong`;










