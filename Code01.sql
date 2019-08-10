CREATE DATABASE ghtk02

USE ghtk02;


CREATE TABLE giang_vien(
	gv_id  INT NOT NULL AUTO_INCREMENT, 
	ho_ten VARCHAR(100) NOT NULL,
	ngay_sinh DATE NOT NULL,
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified TIMESTAMP NOT NULL
                           DEFAULT CURRENT_TIMESTAMP 
                           ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (gv_id)
);
CREATE TABLE de_tai(
	dt_id INT NOT NULL AUTO_INCREMENT,
	ten_dt VARCHAR(100) NOT NULL,
	cap VARCHAR(50) NOT NULL ,
	ngay_hoan_thanh DATE NOT NULL,
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	kinh_phi INT,
	CHECK(kinh_phi>0),
	PRIMARY KEY(dt_id)
);



CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    CHECK (Age>=18)
);

CREATE TABLE S
(
	sid VARCHAR(10) NOT NULL,
	sname VARCHAR(50) NOT NULL,
	sstatus INT ,
	scity VARCHAR(30),
	PRIMARY KEY (sid)
)

CREATE TABLE P(
	pid VARCHAR(10) NOT NULL,
	pname VARCHAR(30),
	pcolor VARCHAR(30),
	pweight INT,
	pcity VARCHAR(30),
	PRIMARY KEY (pid)
)

CREATE TABLE SP
(
	sid VARCHAR(10) NOT NULL,
	pid VARCHAR(10) NOT NULL,
	qty INT,
	PRIMARY KEY (sid, pid)
)

INSERT INTO S (sid, sname, sstatus, scity) VALUES
('S1', 'Smith', 20, 'London'),
('S2', 'Jones', 10, 'Paris'),
('S3', 'Black', 30, 'Paris');

INSERT INTO P (`pid`, `pname`, `pcolor`, `pweight`, `pcity`)
VALUES ('P1', 'Nut', 'Red', 12, 'London'),
('P2', 'Bolt', 'Green', 17, 'Paris'),
('P3', 'Screw', 'blue', 17, 'Rom'),
('P4', 'Screw', 'Red', 14, 'London');

INSERT INTO SP (`sid`, `pid`, `qty`)
VALUES ('S1', 'P4', 900),
('S1', 'P1', 300),
('S1', 'P2', 200),
('S1', 'P3', 400),
('S2', 'P1', 300),
('S2', 'P2', 400),
('S3', 'P2', 200);





/*
1/ Đưa ra danh sách các mặt hàng màu đỏ 				|	OK
2/ Cho biết S# của các hãng cung ứng cả hai mặt hàng ‘P1’ và ‘P2’	|	OK
3/ Liệt kê S# của các hãng cung ứng cả hai mặt hàng ‘P1’ và ‘P2’	|	OK
4/ Đưa ra S# của các hang cung ứng ít nhất một mặt hàng màu đỏ		|	OK
5/ Đưa ra S# của các hang cung ứng tất cả các mặt hàng			|	OK
*/


-- cau 1
SELECT * FROM P WHERE pcolor = 'Red'

-- cau 2
SELECT table1.sid
FROM (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P1'
	) AS table1
INNER JOIN (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P2'
	) AS table2
ON table1.sid = table2.sid

-- cau 3
SELECT SP.`sid`, pcolor
FROM S INNER JOIN SP ON S.`sid` = SP.`sid` INNER JOIN P ON P.`pid` = SP.`pid`
WHERE pcolor = "Red"

-- cau 4:
SELECT table4.sid
FROM (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P1'
	) AS table1
INNER JOIN (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P2'
	) AS table2
ON table1.sid = table2.sid
INNER JOIN (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P3'
	) AS table3
ON table2.sid = table3.sid
INNER JOIN (
	SELECT SP.`sid`
	FROM SP
	WHERE SP.`pid` = 'P4'
	) AS table4
ON table3.sid = table4.sid

SELECT * FROM S;
SELECT * FROM P;
SELECT * FROM SP;

-- câu 4 : Cách khác
SELECT SP.sid 
FROM SP
GROUP BY SP.`sid`
HAVING COUNT(SP.sid) = (SELECT COUNT(pid) FROM P)


SELECT pid
FROM SP
GROUP BY pid
HAVING SUM(qty) = (
	SELECT MAX(qty)
	FROM(
		SELECT SUM(qty) AS qty
		FROM SP
		GROUP BY pid) AS table1
		)


SELECT SUM(SP.qty) AS col , SP.pid
FROM SP
GROUP BY SP.pid
HAVING SUM(SP.qty) >= ALL( SELECT SUM(qty) AS qty
		FROM SP
		GROUP BY pid);


SELECT SUM(SP.qty) t , SP.pid
FROM SP
GROUP BY SP.pid
HAVING t = MAX(t);


SELECT pid, AVG(qty), SUM(qty), COUNT(*) cnt
FROM SP
GROUP BY pid

SELECT S.`sid`, AVG(qty) AS TB , SUM(qty) AS sum_sid, COUNT(qty) AS cntQty
FROM S INNER JOIN SP ON S.`sid` = SP.`sid`
GROUP BY S.`sid`








