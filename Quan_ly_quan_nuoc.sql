create database Quan_ly_Quan_nuoc
go

use Quan_ly_Quan_nuoc
go

CREATE TABLE Roles (
    role_ID INT PRIMARY KEY,
    role_Name NVARCHAR(50) UNIQUE NOT NULL
);


create table UserDN
(
	id int primary key ,
	ho_ten nvarchar(50) not null,
	ngay_sinh datetime not null,
	so_dien_thoai varchar(10) not null,
	ca_lam varchar(30) null,
	nameuser varchar(30) not null,
	pass nvarchar(30) not null,
	role_ID int not null
)

alter table UserDN add constraint ROLE_KN foreign key(role_ID) references Roles(role_ID)
on update cascade on delete cascade
drop table UserDN
ALTER TABLE UserDN DROP CONSTRAINT ROLE_KN;

create table danhmuc
(
	madanhmuc char(5) primary key,
	tendanhmuc nvarchar(30) not null
)


create table menu
(
	id int primary key,
	ten nvarchar(100) not null,
	gia float not null,
	madanhmuc char(5) not null
)
alter table menu add constraint KN_DM foreign key(madanhmuc) references danhmuc(madanhmuc)
on update cascade on delete cascade
create table ban
(
	idban int IDENTITY(1,1) primary key ,
	tenban nvarchar(30) not null,
	trangthai nvarchar(30) default N'Trống' not null --trong, || co nguoi
)

create table hoadon
(
	mahoadon INT IDENTITY(1,1) PRIMARY KEY,	
	ngaytao datetime not null,
	hinhthuc nvarchar(20) not null default '0',
	tinhtrang nvarchar(20) not null default '0',
	idban INT NULL, -- Khóa ngoại đến bảng tang (chỉ dùng khi "Uống tại quán")
	tongtien int 
)
alter table hoadon add CONSTRAINT FK_idban FOREIGN KEY (idban) REFERENCES ban(idban)
ON UPDATE CASCADE ON DELETE cascade,
    CONSTRAINT CHK_hinhthuc_idban CHECK (
        (hinhthuc = '0' AND idban IS NOT NULL)
        OR
        (hinhthuc = '1' AND idban IS NULL))


CREATE TABLE chitiethoadon (
    mahoadon INT NOT NULL,
    idmenu INT NOT NULL, -- Thay vì tenmon, lưu idmenu từ bảng menu
    soluong INT NOT NULL,
    gia INT NOT NULL,
 -- Tính toán total price trực tiếp
    CONSTRAINT FK_mahoadon FOREIGN KEY (mahoadon) REFERENCES hoadon(mahoadon)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_idmenu FOREIGN KEY (idmenu) REFERENCES menu(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

insert into Roles(role_ID, role_Name) values
(1, N'Quản lý'),
(2, N'Nhân viên')


SET IDENTITY_INSERT UserDN ON;
insert into UserDN (id, ho_ten, ngay_sinh, so_dien_thoai, ca_lam, nameuser, pass, role_ID) values
(1, N'Vũ Thành Minh','03-12-2005','0123456789', N'Ca 1', 'admin', '12',1),
(2, N'Vũ Thành Minh','03-12-2005','0123456789', N'Ca 1', 'a', '12',2)
SET IDENTITY_INSERT UserDN OFF;




INSERT INTO danhmuc (madanhmuc, tendanhmuc) VALUES 
('DM01',N'Cà phê'),
('DM02',N'Trà sữa'),
('DM03',N'Trà'),
('DM04',N'Sinh tố');

INSERT INTO menu (id, ten, gia, madanhmuc) VALUES
(00001, N'Cà phê sữa đá', 30000,'DM01'),
(00002, N'Cà phê đen nóng', 20000,'DM01'),
(00003, N'Cà phê sữa nóng', 25000,'DM01'),
(00004, N'Bạc xỉu', 35000,'DM01'),
(00005, N'Cà phê espresso', 40000,'DM01'),
(00006, N'Cà phê cappuccino', 45000,'DM01'),
(00007, N'Cà phê latte', 50000,'DM01'),
(00008, N'Cà phê mocha', 55000,'DM01'),
(00009, N'Cà phê macchiato', 45000,'DM01'),
(00010, N'Cà phê phin truyền thống', 25000,'DM01'),
(00011, N'Cà phê americano', 35000,'DM01'),
(00012, N'Cà phê caramel macchiato', 55000,'DM01'),
(00013, N'Cà phê cold brew', 25000,'DM01'),
(00014, N'Cà phê affogato', 40000,'DM01'),
(00015, N'Cà phê decaf', 40000,'DM01'),
(00016, N'Cà phê robusta đậm vị', 30000,'DM01'),
(00017, N'Cà phê arabica thơm', 50000,'DM01'),
(00018, N'Cà phê sữa tươi', 32000,'DM01'),
(00019, N'Cà phê dừa đá', 45000,'DM01'),
(00020, N'Cà phê trứng', 55000,'DM01')

INSERT INTO menu (id, ten, gia, madanhmuc) VALUES
(00021, N'Trà sữa matcha', 35000,'DM02'),
(00022, N'Trà sữa ô long', 35000,'DM02'),
(00023, N'Trà sữa việt quất', 30000,'DM02'),
(00024, N'Trà sữa thái xanh', 40000,'DM02'),
(00025, N'Trà sữa socola', 40000,'DM02'),
(00026, N'Trà sữa bạc hà', 45000,'DM02'),
(00027, N'Trà sữa hokkaido', 55000,'DM02'),
(00028, N'Trà sữa khoai môn', 50000,'DM02'),
(00029, N'Trà sữa caramel', 30000,'DM02'),
(00030, N'Trà sữa trân châu đường đen', 30000,'DM02')

INSERT INTO menu (id, ten, gia, madanhmuc) VALUES
(00031, N'Trà chanh', 32000,'DM03'),
(00032, N'Trà đen nóng', 30000,'DM03'),
(00033, N'Trà đào cam sả', 40000,'DM03'),
(00034, N'Trà chanh mật ong', 38000,'DM03'),
(00035, N'Trà gừng ấm', 35000,'DM03'),
(00036, N'Trà hoa cúc', 37000,'DM03'),
(00037, N'Trà táo quế', 42000,'DM03'),
(00038, N'Trà sen vàng', 45000,'DM03'),
(00039, N'Trà bạc hà', 39000,'DM03'),
(00040, N'Trà ô long', 35000,'DM03')

INSERT INTO menu (id, ten, gia, madanhmuc) VALUES
(00041, N'Sinh tố xoài', 45000,'DM04'),
(00042, N'Sinh tố dâu tây', 48000,'DM04'),
(00043, N'Sinh tố chuối', 40000,'DM04'),
(00044, N'Sinh tố mãng cầu', 52000,'DM04'),
(00045, N'Sinh tố dứa', 45000,'DM04'),
(00046, N'Sinh tố cà chua', 43000,'DM04'),
(00047, N'Sinh tố cam', 47000,'DM04'),
(00048, N'Sinh tố thanh long', 50000,'DM04'),
(00049, N'Sinh tố kiwi', 55000,'DM04'),
(00050, N'Sinh tố bơ', 50000,'DM04')

SET IDENTITY_INSERT ban ON;
insert into ban (idban, tenban, trangthai) values
(1, N'Bàn 1',N'Trống'),
(2, N'Bàn 2',N'Trống'),
(3, N'Bàn 3',N'Trống'),
(4, N'Bàn 4',N'Trống'),
(5, N'Bàn 5',N'Trống'),
(6, N'Bàn 6',N'Trống'),
(7, N'Bàn 7',N'Trống'),
(8, N'Bàn 8',N'Trống'),
(9, N'Bàn 9',N'Trống'),
(10, N'Bàn 10',N'Trống'),
(11, N'Bàn 11',N'Trống'),
(12, N'Bàn 12',N'Trống')
SET IDENTITY_INSERT ban OFF;

SELECT m.ten, m.gia, cthd.soluong, cthd.thanhtien
FROM menu m
JOIN chitiethoadon cthd ON m.id = cthd.idmenu
JOIN hoadon hd ON cthd.mahoadon = hd.mahoadon
WHERE hd.idban = 11 AND hd.tinhtrang = '0';


EXEC sp_help 'ban';

select * from Roles
select * from UserDN
select * from menu
select * from ban
select * from hoadon
select * from chitiethoadon

select m.ten, ct.soluong, ct.gia 
                from menu m inner join chitiethoadon ct on m.id = ct.idmenu
                where ct.mahoadon = 5


SELECT m.id, m.ten, m.gia, m.madanhmuc
from menu m join danhmuc d on m.madanhmuc = d.madanhmuc
where d.tendanhmuc = N'Cà phê'

SELECT * FROM menu WHERE ten LIKE '%Cà%';

SELECT * FROM ban

SELECT * FROM menu WHERE ten LIKE N'%đá%'

SELECT ct.idmenu, m.ten, SUM(ct.soluong) AS soluong
                        FROM menu m 
                        INNER JOIN chitiethoadon ct ON m.id = ct.idmenu 
                        INNER JOIN hoadon hd ON hd.mahoadon = ct.mahoadon
                        WHERE CAST(hd.ngaytao AS DATE) = CAST(GETDATE() AS DATE)
                        GROUP BY ct.idmenu, m.ten
                        ORDER BY SUM(ct.soluong) DESC

				select * from UserDN
SELECT ct.idmenu, m.ten, ct.soluong, (ct.soluong * m.gia) as gia
FROM ban b
INNER JOIN hoadon hd ON b.idban = hd.idban
INNER JOIN chitiethoadon ct ON ct.mahoadon = hd.mahoadon
INNER JOIN menu m ON m.id = ct.idmenu
WHERE b.idban = 8 and tinhtrang = '0'


DELETE FROM ban;
DBCC CHECKIDENT ('ban', RESEED, 0);