CREATE TABLE tbluser(
	userid VARCHAR(10) NOT NULL,
	username VARCHAR(50) NOT NULL,
	pasword VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	regency INT DEFAULT 2,
	deletelogic INT DEFAULT 1,
	PRIMARY KEY (userid)
)
 CREATE TABLE tblpaper(
	paperid VARCHAR(10) NOT NULL,
	papername VARCHAR(50) NOT NULL,
	papercontent VARCHAR(50) NOT NULL,
	papericon VARCHAR(50) NOT NULL,
	paperphoto VARCHAR(50) NOT NULL,
	created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	deletelogic INT DEFAULT 1,
	PRIMARY KEY (paperid)
 )
 
 CREATE TABLE tblcomment(
	userid VARCHAR(10) NOT NULL,
	paperid VARCHAR(10) NOT NULL,
	commentid VARCHAR(10) NOT NULL,
	usercmt VARCHAR(50) NOT NULL,
	created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	deletelogic INT DEFAULT 1,	
	PRIMARY KEY (userid)
 )
 
INSERT INTO tbluser (userid, username, pasword, email) VALUE
('user0003', 'quang1', 'quang1', 'quang@ghtk.org'), 

INSERT INTO tbluser (userid, username, pasword, email, regency) VALUE
('user0001', 'admin', 'admin', 'admin@ghtk.org', 1)p
 
 INSERT INTO tblpaper (paperid, papername, papercontent, papericon, paperphoto) VALUE 
 ('pp0001', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0002', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0003', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0004', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0005', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0006', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0007', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paer/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0008', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp0009', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00010', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00011', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00012', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00013', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00014', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00015', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 ('pp00016', 'Why learn python ?', '../paperdata/papper0001.txt', '../image/paper/ppicon0001.png', '../image/paper/ppimage0001.png'),
 
 
 -- drop table tblcomment;
 SELECT papername, papercontent, papericon, paperphoto, created_time FROM tblpaper WHERE paperid = 'pp0001';
 
 SELECT * FROM tbluser;
 SELECT papername, papericon, created_time FROM tblpaper WHERE papername LIKE '% %' LIMIT 5
 
SELECT userid, regency FROM tbluser WHERE username = 'admin' AND pasword = 'admin';

