create database QLSach_31211024087;
use QLSach_31211024087;
create table TheLoai
(
	MaTL nchar(10) not null primary key,
	TenTL nchar(100)
);
create table NhaXB
(
	MaXB nchar(20) not null primary key,
	TenXB nchar(100),
	DiaChi nchar(200),
	SDT nchar(10),
	email nchar(200)
);
create table Sach
(
	MaSach nvarchar(10) not null primary key,
	TenSach nchar(100),
	SoTrang int,
	NgayXB date,
	MaTL nchar(10),
	MaXB nchar(20),
	foreign key(MaTL) references TheLoai(MaTL),
	foreign key(MaXB) references NhaXB(MaXB)
	
	/*Khóa ngoại tham chiếu về bảng TheLoai*/
)
create table TacGia
(
	MaTG nchar(20) not null primary key,
	TenTG nchar(100),
	DiaChi nchar(200),
	SDT nchar(10),
	email nchar(200)
);

CREATE TABLE Sach_TacGia
(
	MaTG nchar(20) not null ,

	MaSach nvarchar(10) not null,
	constraint PK_SACH_TACGIA primary key (MaTG, MaSach),

	FOREIGN KEY (MaTG) REFERENCES TacGia (MaTG),
	FOREIGN KEY (MaSach) REFERENCES Sach (MaSach),
);

/*Thay đổi kiểu dữ của TenSach lên nvarchar(200) ký tự */
alter table Sach
alter column TenSach nvarchar(200)

alter table TacGia
alter column TenTG nvarchar(100)

alter table TacGia
alter column DiaChi nvarchar(200)


create table KhachHang (
	MaKH nvarchar(10) not null primary key,
	HoKH nvarchar(100),
	TenKH nvarchar(100),
	Phone nvarchar(10),
	Email nvarchar(200)
)

CREATE TABLE NhanVien (
	MaNV NVARCHAR(10) NOT NULL PRIMARY KEY,
	HotenNV NVARCHAR(50),
	GT NVARCHAR(5),
	NS DATE,
	MaNVQL NVARCHAR(10)
	FOREIGN KEY (MaNVQL) REFERENCES NhanVien(MaNV)
);

create table DonDatHang (
	SoDH nvarchar(10) not null primary key,
	NgayDH datetime,
	TrangThaiDH int,
	MaKH nvarchar(10),
	NgayDuKienGiao datetime,
	NgayThucTeGiao datetime,
	MaNV nvarchar(10),
	foreign key (MaKH) references KhachHang(MaKH),
	foreign key (MaNV) references NhanVien(MaNV)
)
create table ChiTietDonHang (
	
	SoDH nvarchar(10),
	MaSach nvarchar(10),
	SoLuong int,
	GiaTien float,
	GiamGia float,
	primary key(SoDH,MaSach),
	foreign key (SoDH) references DonDatHang(SoDH),
	foreign key (MaSach) references Sach(MaSach) 
)
--Thêm mới dữ liệu vào bảng TheLoai
insert into TheLoai(MaTL,TenTL) values(N'TH',N'Tin học');
insert into TheLoai(MaTL,TenTL) values(N'KT',N'Kế toán');
insert into TheLoai(MaTL,TenTL) values(N'QTKD',N'Quản trị Kinh Doanh');
insert into TheLoai(MaTL,TenTL) values(N'TNN',N'Tài Nguyên Nước');
insert into TheLoai(MaTL,TenTL) values(N'KTMT',N'Kỹ thuật môi trường');

--Xem lại dữ liệu
select * from TheLoai

/* Thêm dữ liệu bảng NhaXB */
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBTH',N'Nhà xuất bản tổng hợp',N'12 Hai Bà 
Trưng. Hà Nội','0245678612','nxbtonghop@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBGD',N'Nhà xuất bản giáo dục',N'14 Đống Đa. 
Hà Nội','0247646786','nxbgiaoduc@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBTK',N'Nhà xuất bản thống kê',N'1 Bình Trị
Đông. TPHCM','0285638613','nxbthongke@gmail.com');
insert into NhaXB(MaXB,TenXB,DiaChi,SDT,email) values(N'NXBKHKT',N'Nhà xuất bản khoa học kỹ thuật',N'13 
Võ Văn Tần, TPHCM','0285678614','nxbkhkt@gmail.com')

--xem lại nhà xuất bản
select * from NhaXB
--Insert Sách
SET DATEFORMAT dmy;
insert into Sach values(N'THDC',N'Tin học đại cương',N'20','01/01/2020',N'TH',N'NXBTH');
insert into Sach values(N'THVP',N'Tin học văn phòng',N'50','20/12/2020',N'TH',N'NXBTH');

select * from sach



insert into Sach values(N'THKT',N'Tin học văn phòng cho kế toán',N'60','12/12/2020',N'TH',N'NXBGD');
insert into Sach values(N'THCT',N'Tin học văn phòng cho công trình',N'30','24/11/2019',N'TH',N'NXBGD');
insert into Sach values(N'KTDC',N'kế toán đại cương',N'40','30/10/2019',N'KT',N'NXBGD');
insert into Sach values(N'QTKDNLKD',N'Nguyên lý kinh doanh',N'90','31/7/2019',N'QTKD',N'NXBTH');
insert into Sach values(N'QTKDTLKD',N'Triết lý kinh doanh',N'90','30/9/2018',N'QTKD',N'NXBTK');
insert into Sach values(N'TNNCTN',N'Cấp thoát nước',N'40','30/08/2017',N'TNN',N'NXBTK');
insert into Sach values(N'KTMTCB',N'Kỹ thuật môi trường cơ bản',N'20','20/08/2017',N'KTMT',N'NXBKHKT');
select * from sach
--insert tac gia
insert into TacGia values(N'001',N'Phạm Hữu Độ',N'Hà Nội','0988888888','huudo@gmail.com');
insert into TacGia values(N'002',N'Phạm An Bình',N'HCM','0988675555','anbinh@gmail.com');
insert into TacGia values(N'003',N'Viên An',N'HCM','0981222111','anvien@gmail.com');
insert into TacGia values(N'004',N'Viên Thanh Nhã',N'CT','0931222212','nhavien@gmail.com');
--xem lại Tác giả
select * from TacGia
--insert bảng sach_tacgia
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'THVP');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'KTDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'TNNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'001',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THDC');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'THVP');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'TNNCTN');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'QTKDNLKD');
insert into Sach_TacGia(MaTG,MaSach) values(N'002',N'KTMTCB');
insert into Sach_TacGia(MaTG,MaSach) values(N'003',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'THKT');
insert into Sach_TacGia(MaTG,MaSach) values(N'004',N'KTDC');

insert into KhachHang (MaKH,HoKH,TenKH,Phone,Email)
values ('001',N'Nguyễn Văn','An','098899999','an@gmail.com'),
		('002',N'Lưu Bình',N'Nguyên','0978977777','nguyen@gmail.com')
insert into KhachHang (MaKH,HoKH,TenKH,Phone,Email)
values ('003',N'Võ Văn','Anh','098899923','vananh@gmail.com'),
		('004',N'Lưu An',N'Nguyên','0978977766','nguyen@gmail.com')
insert into KhachHang (MaKH,HoKH,TenKH,Phone,Email)
values ('005',N'Lưu Bá','Ôn','0988999245','baon@tlu.edu.vn'),
		('006',N'Trần Thị',N'Nở','0978977776','thino@ueh.edu.vn')
insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000001' ,N'Viên Thanh NHã',N'Nam','1981-07-16') 
insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000002' ,N'Trần Thanh An ',N'Nam','1978-08-20') 
insert into NhanVien(MaNV,HotenNV,GT,NS) values (N'0000000003' ,N'Nguyễn Tâm Như',N'Nữ','1990-10-10')
SET DATEFORMAT dmy;
--insert dữ liệu vào DonDatHang	
insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao,MaNV) values (N'001','20-10-2022 08:00:00','1','001','21-10-2022 08:00:00','0000000001');
insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao,MaNV) values (N'002','20-11-2022 07:00:00','0','002','20-11-2022 09:00:00',NULL);
insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao,MaNV) values (N'003','20-12-2022 07:00:00','1','003','20-11-2022 09:00:00','0000000001');
insert into DonDatHang(SoDH,NgayDH,TrangThaiDH,MaKH,NgayDuKienGiao,MaNV) values (N'004','20-10-2022 09:30:00 ','0','004','25-10-2022 09:00:00',NULL);

--issert dữ liệu vào ChiTietDH
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('001',N'KTDC','10','30000','0.1');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('001',N'KTMTCB','5','20000','0.2');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('002',N'KTMTCB','2','40000','0.5');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('002',N'THKT','1','35000','0.4');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('002',N'KTDC','1','35000','0.4');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('003',N'THKT','1','35000','0.3');
insert into ChiTietDonHang(SoDH,MaSach,SoLuong,GiaTien,GiamGia) values('004',N'KTDC','1','35000','0.6');


--Xem lại tất cả các bảng 

select * from TheLoai;
select * from sach;
select * from TacGia;
select * from Sach_TacGia;
select * from NhaXB;
select * from NhanVien;
select * from KhachHang;
select * from DonDatHang;
select * from ChiTietDonHang;

--I. Viết các câu truy vấn
-- Bài 1
SELECT DISTINCT KH.MaKH,(KH.HoKH+' '+ KH.TenKH) AS 'Họ Và Tên', KH.Phone, KH.Email
FROM	dbo.KhachHang KH
WHERE	(KH.MaKH NOT IN
	(SELECT DISTINCT ddh.MaKH FROM dbo.DonDatHang ddh))
	AND KH.Email
	NOT LIKE '%@ueh.edu.vn'

-- Bài 2
SELECT	bang2.SoDH,bang2.ndh AS 'Ngày Đặt Hàng', SUM(ttt) AS 'Tổng thành tiền',SUM(ttgg)AS 'Tổng Tiền Giảm Giá',SUM(tt)AS 'Tổng thu'
FROM (	SELECT	ddh.SoDH,
		CONVERT(VARCHAR,ddh.NgayDH,105) AS ndh,
			ctdh.SoLuong*ctdh.GiaTien AS ttt,
			ctdh.SoLuong*ctdh.GiaTien*ctdh.GiamGia AS ttgg,
			ctdh.SoLuong*ctdh.GiaTien*(1-ctdh.GiamGia) AS tt
		FROM dbo.DonDatHang ddh, dbo.ChiTietDonHang ctdh, dbo.Sach s
		WHERE	(ddh.SoDH=ctdh.SoDH) AND
				(ddh.TrangThaiDH =1) AND
				(ctdh.MaSach=s.MaSach)
		) bang2
GROUP BY bang2.soDH,bang2.ndh
HAVING SUM(ttt)>200000

-- Bài 3
SELECT ChiTietDonHang.SoDH,CONVERT(VARCHAR,NgayDH,105) AS 'Ngày đặt hàng',TrangThaiDH,s.TenSach,(SoLuong*GiaTien) AS'Thành Tiền',(SoLuong*GiaTien*GiamGia)AS 'Tiền giảm giá'
FROM dbo.Sach s INNER JOIN dbo.ChiTietDonHang ON ChiTietDonHang.MaSach = s.MaSach INNER JOIN
dbo.DonDatHang ON	DonDatHang.SoDH = ChiTietDonHang.SoDH
WHERE (TrangThaiDH=0)

-- bài 4
SELECT tg.TenTG, COUNT(tg.TenTG) N'SL sách tác giả viết'
FROM dbo.TacGia tg JOIN dbo.Sach_TacGia stg
ON stg.MaTG = tg.MaTG
GROUP BY tg.TenTG
HAVING COUNT(tg.TenTG)>1

-- Bài 5
SELECT stg.MaTG,tg.TenTG,TenSach,SoTrang,NgayXB
FROM dbo.TacGia tg LEFT JOIN dbo.Sach_TacGia stg ON stg.MaTG = tg.MaTG
LEFT JOIN dbo.Sach ON	Sach.MaSach = stg.MaSach

-- bài 6
SELECT Sach_TacGia.MaTG, TenTG, Sach_TacGia.MaSach,TenSach,SoTrang,NgayXB
FROM dbo.Sach LEFT JOIN dbo.Sach_TacGia ON	Sach_TacGia.MaSach = Sach.MaSach
LEFT JOIN dbo.TacGia ON TacGia.MaTG = Sach_TacGia.MaTG

-- Bài 7
SELECT masach,tensach,[001],[002],[003],[004]
FROM (
	SELECT Sach.MaSach,TenSach,DonDatHang.SoDH,SoLuong
	FROM dbo.Sach INNER JOIN dbo.ChiTietDonHang ON ChiTietDonHang.MaSach = Sach.MaSach
	INNER JOIN dbo.DonDatHang ON DonDatHang.SoDH = ChiTietDonHang.SoDH)
	AS bangnguon
PIVOT
(SUM(soluong)
FOR	sodh IN ([001],[002],[003],[004])
)AS bangchuyen

--II. Viết hàm
-- Bài 1
create function TongDoanhThuHDGiamGia(@sodh nvarchar(10))
returns table
as
return
(
select CTDH.SoDH, sum(CTDH.Soluong * CTDH.GiaTien * (1 - CTDH.GiamGia)) N'Tổng doanh thu'
from ChiTietDonHang CTDH
where CTDH.SoDH = @sodh
group by CTDH.SoDH
)

select * 
from dbo.TongDoanhThuHDGiamGia('001')

-- Bài 2
create procedure deleteTG(@maTG char(10))
as
if (exists(select MaTG from TacGia where MaTG=@maTG))
	begin
			delete TacGia
			where MaTG = @maTG

			delete Sach_TacGia
			where MaTG = @maTG

			print N'Tác giả đã được xóa'
	end
else
	begin
		print N'Tác giả không tồn tại'
	end


insert into TacGia(MaTG, TenTG, DiaChi, SDT, email)
values ('007', N'Khánh Phú', 'Phú Yên', '0123456789', 'phulin@gmail.com')

exec deleteTG '007'