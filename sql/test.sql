CREATE DATABASE QLBanHang
use QLBanHang

create table KhachHang
(
	MaKhachHang char(5) primary key,
	TenCongTy nvarchar(30) not null,
	TenGiaoDich nvarchar(30) not null,
	DiaChi char(20),
	Email char(20) not null,
	DienThoai int,
	Fax char(20),
	
)
create table NhanVien
(
	MaNhanVien char(5) primary key,
	Ho nvarchar(10) not null,
	Ten nvarchar(10) not null,
	NgaySinh datetime,
	NgayLamViec datetime,
	DiaChi char(20),
	DienThoai int,
	LuongCoBan int,
	PhuCap int,
)
create table DonDaThang
(
	SoHoaDon char(10) primary key,
	MaKhachHang char(5),
	MaNhanVien char(5),
	NgayDaThang datetime,
	NgayGiaoHang datetime,
	NgayChuyenHang datetime,
	NoiGiaoHang char(20),
	constraint DonDaThang_MaKhachHang foreign key(MaKhachHang) references KhachHang(MaKhachHang),
	constraint DonDaThang_MaNhanVien foreign key(MaNhanVien) references NhanVien(MaNhanVien),
)
create table NhaCungCap
(
	MaCongTy char(10) primary key,
	TenCongTy nvarchar(30) not null,
	TenGiaoDich nvarchar(30) not null,
	DiaChi char(20),
	Email char(20) not null,
	DienThoai int,
	Fax char(20),
)
create table LoaiHang
(
	MaLoaiHang char(5) primary key,
	TenLoaiHang nvarchar(30) not null,
)
create table MatHang 
(
	MaHang char(5) primary key,
	TenHang nvarchar(20) not null,
	MaCongTy char(10),
	MaLoaiHang char(5),
	SoLuong int,
	DonViTinh char(5),
	GiaHang int,
	constraint MatHang_MaCongTy foreign key (MaCongTy) references NhaCungCap(MaCongTy),
	constraint MatHang_MaLoaiHang foreign key (MaLoaiHang) references LoaiHang(MaLoaiHang),
)
create table ChiTietDatHang
(
	SoHoaDon char(10),
	MaHang char(5),
	GiaBan int,
	SoLuong int,
	MucGiamGia decimal(2,1),
	constraint kc1 primary key(SoHoaDon, MaHang),
	constraint ChiTietDatHang_SoHoaDon foreign key (SoHoaDon) references DonDaThang(SoHoaDon),
	constraint ChiTietDatHang_MaHang foreign key (MaHang) references MatHang(MaHang)
)

-- Các mặt hàng sau ngày 15 khi thêm vào CSDL sẽ được giảm giá 10%  , Thay vì thêm 10% vào trường giảm giá
-- thì có thể sử dụng các ràng buộc để tự động vào ngày 15 trở đi cột giảm giá sẽ 10% khi thêm mới sản phẩm

-- Hoặc khi Số lượng của sản phẩm khi thêm mới MẶC ĐỊNH = 1 , thì dùng ràng buộc để thực hiện việc này 

-- Hoặc thêm ràng buộc làm cho KHI THÊM MỚI 1 NHÂN VIÊN thì tuổi phải trên 18 , dưới 18 không được phép thêm vào . 


-- Tại sao lại phải thêm ràng buộc = 0 cho cột giảm giá , 
-- Tại vì khi bán hàng . có thể có những mặt hàng giảm giá , thì nhân viên nhập số % giảm giá => OK
-- Có những mặt hàng 0 giảm giá, Nếu không có ràng buộc và NV quên nhập 0 thì cột giảm giá sẽ rỗng giá trị
-- Bởi vì khách hàng thanh toán hóa đơn dựa theo cả % GIẢM GIÁ, phép toán bị lỗi * rỗng => Lỗi

/* Query 2.1 */

ALTER TABLE ChiTietDatHang 
ADD
CONSTRAINT default_chitietdathang_soluong
DEFAULT(1) FOR SoLuong,
CONSTRAINT default_chitietdathang_mucgiamgia
DEFAULT(0) FOR MucGiamGia

-- Cấu trúc 1 lệnh ràng buộc 
-- ADD CONSTRAINT Tên_Ràng_Buộc		Cú_Pháp_Điều_Kiện
-- Trước khi thêm ràng buộc 1 BẢNG nào đó ta phải ghi ALTER TABLE Tên_Bảng ADD ở trước
-- bảng chitietdathang trên có 2 ràng buộc

/* Query 2.2 */

ALTER TABLE DonDatHang
ADD
CONSTRAINT chk_dondathang_ngay
CHECK (NgayGiaoHang >= NgayDatHang AND NgayChuyenHang >= NgayDatHAng)


/* Query 2.3 */

ALTER TABLE NhanVien
ADD
CONSTRAINT chk_tuoi
CHECK (DATEDIFF(year, NgaySinh,NgayLamViec) BETWEEN 18 AND 60) -- BETWEEN A AND B . nằm trong khoảng từ A đến B


/* Query 3.1 */
SELECT * from NhaCungCap
SELECT TenHang from MatHang
/* Query 3.2 */
SELECT MaHang,TenHang As 'Tên Hàng',SoLuong from MatHang

/* Query 3.3 */
SELECT HO + Ten AS 'Họ và Tên',DiaChi,year(NgayLamViec) AS 'Năm làm việc' from NhanVien

/* Query 3.4 */
SELECT DiaChi,DienThoai from NhaCungCap Where TenGiaoDich = N'Sữa Vinamilk'

/* Query 3.5 */
SELECT MaHang,TenHang,GiaHang,SoLuong from MatHang 
	WHERE GiaHang > 100000
	AND
		SOLUONG < 50

/* Query 3.6 */
SELECT TENHANG,TENCONGTY From MatHang,NhaCungCap
	WHERE MatHang.MaCongTy = NhaCungCap.MaCongTy

/* Query 3.7 */
SELECT TENHANG,TENCONGTY From MatHang,NhaCungCap
	WHERE MatHang.MaCongTy = NhaCungCap.MaCongTy
	AND TENCONGTY = N'Bạn và tôi'

/* Query 3.8 */
SELECT DISTINCT TENCONGTY,DIACHI From LoaiHang,NhaCungCap,MatHang
	WHERE MatHang.MaCongTy = NhaCungCap.MaCongTy
		AND MatHang.MaLoaiHang = LoaiHang.MaLoaiHang
		AND TenLoaiHang = N'Đồng Hồ' -- Từ khóa Distinct : Khác Biệt
/* Query 3.11 */
SELECT Ho,Ten, luongcoban + PhuCap AS N'Lương' from NhanVien

/* Query 3.12 */
SELECT ChiTietDatHang.MAHANG,TENHANG,ChiTietDatHang.SOLUONG*GIABAN - ChiTietDatHang.SOLUONG*GIABAN*MUCGIAMGIA / 100 as N'Số Tiền'
	FROM MatHang,ChiTietDatHang
	WHERE MatHang.MaHang = ChiTietDatHang.MaHang
	AND SOHOADON = 3

/* Query 3.14 */
SELECT a.Ho,a.Ten,b.Ho,b.Ten,a.NgaySinh 
	From NhanVien a right join NhanVien b
	On a.NgaySinh = b.NgaySinh
	AND a.MaNhanVien <> b.MaNhanVien

/* Query 3.15 */
SELECT SoHoaDon,TenCongTy,TenGiaoDich,NoiGiaoHang
	From KhachHang,DonDatHang
	Where KhachHang.MaKhachHang = DonDaThang.MaKhachHang
	AND KhachHang.DiaChi = DonDaThang.NoiGiaoHang

/* Query 4.1 */
Update DonDaThang
Set NgayChuyenHang = NgayDaThang
where NgayChuyenHang is null

/* Query 4.2 */
Update MatHang
Set soluong = soluong * 2
from NhaCungCap
where NhaCungCap.MaCongTy = MatHang.MaCongTy
and TenCongTy = 'VINAMILK'

/* Query 4.3 */
Update DonDaThang
Set NoiGiaoHang = DiaChi 
from KhachHang
where DonDaThang.MaKhachHang = KhachHang.MaKhachHang
and NoiGiaoHang is null


/* Query 4.4 */
Update KhachHang
set KhachHang.DiaChi = NhaCungCap.DiaChi,
	KhachHang.DienThoai = NhaCungCap.DienThoai,
	KhachHang.Email = NhaCungCap.Email,
	KhachHang.Fax = NhaCungCap.Fax
from NhaCungCap
where NhaCungCap.TenCongTy = KhachHang.TenCongTy
and NhaCungCap.TenGiaoDich = KhachHang.TenGiaoDich

/* Query 4.5 */
Update NhanVien
set LuongCoBan *= 1.5
where MaNhanVien in (
	select MaNhanVien from DonDaThang Inner join ChiTietDatHang
	on DonDaThang.SoHoaDon = ChiTietDatHang.SoHoaDon
	Where
	year(NgayDaThang) = 1998
	group by MaNhanVien
	having sum(SoLuong)>100
)

/* Query 4.6 
Nv1 : 200
Nv2 : 150
Nv3 : 150
Nv4 : 200
=> 2 thang NV ban dc nhieu nhat 
( Nhieu nhat 200 )

*/

Update NhanVien
set phucap = LuongCoBan/2
where MaNhanVien in (
	select MaNhanVien from DonDaThang inner join ChiTietDatHang
	on DonDaThang.SoHoaDon = ChiTietDatHang.SoHoaDon
	group by MaNhanVien
	having sum(SoLuong) >= all((
		select sum(SoLuong) from DonDaThang inner join ChiTietDatHang
		on DonDaThang.SoHoaDon = ChiTietDatHang.SoHoaDon
		group by MaNhanVien))
	
)

/* Query 4.7 */

Update NhanVien
set LuongCoBan = LuongCoBan * 0.75
Where MaNhanVien not in (Select MaNhanVien
from DonDaThang where MaNhanVien = DonDaThang.MaNhanVien)

/* Query 4.8 */

Update DonDaThang
SET SoTien = (SELECT sum(soluong*giaban*(1-mucgiamgia)) from ChiTietDatHang
	Where SoHoaDon = DonDaThang.SoHoaDon
	group by SoHoaDon)

ALTER TABLE DonDaThang
add SoTien int







/* Query 4.9 - Delete */
use QLBanHang
delete from NhanVien
where (year(getdate()) - year(NgayLamViec)) > 40 /* getdate() -> trả về ngày tháng năm hiện tại  */


/* Query 4.10 */

delete from DonDaThang
where year(NgayDatHang) < 2000


/* Query 4.11 */
delete from LoaiHang
where MaLoaiHang not in ( select MaLoaiHang from MatHang
					where MaLoaiHang = MatHang.MaLoaiHang )
/* Query 4.12 */
delete from KhachHang
where MaKhachHang not in (
	select MaKhachHang from DonDaThang
	where KhachHang.MaKhachHang = DonDaThang.MaKhachHang 
)

/* Query 4.13 */
delete from MatHang
where SoLuong = 0 And MaHang not in (
	Select MaHang from ChiTietDatHang where MaHang = ChiTietDatHang.MaHang
)

/* Query View 4.14 */
Create view ThuongNhanVien 
as select MaNhanVien , Ten, (case when (year(getdate()) - year(NgayLamViec)) >= 5 then 1000000
								  when (year(getdate()) - year(NgayLamViec)) >= 3 then 500000
								  else 100000 END) as N'Thưởng'
			from NhanVien


select * from NhanVien


Select * from ThuongNhanVien


insert into NhanVien values ('NV01','Nguyen Van','A','10/03/1998','10/03/2018','Address1','0336001860',700000,50000)
insert into NhanVien values ('NV02','Nguyen Van','B','10/03/1998','10/03/2018','Address1','0336001860',200000,50000)
insert into NhanVien values ('NV03','Nguyen Van','C','10/03/1998','10/03/2018','Address1','0336001860',300000,50000)
insert into NhanVien values ('NV04','Nguyen Van','D','10/03/1998','10/03/2018','Address1','0336001860',400000,50000)
insert into NhanVien values ('NV05','Nguyen Van','E','10/03/1998','10/03/2018','Address1','0336001860',600000,50000)

select * from NhaCungCap

insert into NhaCungCap values ('NCC01','Nha CC 1','NCC01','Address NCC 1','NCC1@gmail.com','156436134','543512425')
insert into NhaCungCap values ('NCC02','Nha CC 2','NCC02','Address NCC 2','NCC2@gmail.com','156436134','543512425')
insert into NhaCungCap values ('NCC03','Nha CC 3','NCC03','Address NCC 3','NCC3@gmail.com','156436134','543512425')
insert into NhaCungCap values ('NCC04','Nha CC 4','NCC04','Address NCC 4','NCC4@gmail.com','156436134','543512425')


select * from LoaiHang

insert into LoaiHang values ('LH01',N'Quần')
insert into LoaiHang values ('LH02',N'Áo')
insert into LoaiHang values ('LH03',N'Đồ uống')
insert into LoaiHang values ('LH04',N'Đồ ăn')
insert into LoaiHang values ('LH05',N'Hoa quả')

select * from MatHang

insert into MatHang values ('MH01',N'Quần thể thao','NCC01','LH01',50,'Cai',150000)
insert into MatHang values ('MH02',N'Quần không đùi','NCC03','LH01',50,'Cai',180000)
insert into MatHang values ('MH03',N'Quần đùi','NCC02','LH01',50,'Cai',170000)
insert into MatHang values ('MH04',N'Áo không sơ mi','NCC04','LH02',50,'Cai',120000)
insert into MatHang values ('MH05',N'Cũng là sơ my nhưng y dài','NCC03','LH02',50,'Cai',140000)
insert into MatHang values ('MH06',N'Áo sơ mi','NCC02','LH02',50,'Cai',250000)
insert into MatHang values ('MH07',N'sữa vinamilk','NCC03','LH03',50,'Cai',170000)
insert into MatHang values ('MH08',N'sữa ông thọ','NCC04','LH03',50,'Cai',160000)
insert into MatHang values ('MH09',N'sữa bà thọ','NCC04','LH03',50,'Cai',155000)
insert into MatHang values ('MH10',N'Phở tôm kobe','NCC01','LH04',50,'Cai',55000)
insert into MatHang values ('MH11',N'Phở gà kobe','NCC02','LH04',50,'Cai',220000)
insert into MatHang values ('MH12',N'Phở bò kobe','NCC03','LH04',50,'Cai',440000)

select * from KhachHang

insert into KhachHang values ('KH01','NCC 01','NCC01','Address 2','emailkh@gmail.com','5341513','543543654')
insert into KhachHang values ('KH02','NCC 04','NCC04','Address 2','emailkh@gmail.com','5341513','543543654')
insert into KhachHang values ('KH03','NCC 03','NCC03','Address 2','emailkh@gmail.com','5341513','543543654')
insert into KhachHang values ('KH04','NCC 02','NCC02','Address 2','emailkh@gmail.com','5341513','543543654')

select * from DonDaThang

insert into DonDaThang values ('HD01','KH01','NV01','07-10-2019','08-10-2019','09-10-2019','Address',0)
insert into DonDaThang values ('HD02','KH02','NV02','07-10-2019','08-10-2019','09-10-2019','Address',0)
insert into DonDaThang values ('HD03','KH03','NV03','07-10-2019','08-10-2019','09-10-2019','Address',0)
insert into DonDaThang values ('HD04','KH03','NV03','07-10-2019','08-10-2019','09-10-2019','Address',0)

select * from ChiTietDatHang

insert into ChiTietDatHang values ('HD01','MH01','225000',5,0)
insert into ChiTietDatHang values ('HD01','MH02','250000',5,0)
insert into ChiTietDatHang values ('HD01','MH03','270000',5,0)
insert into ChiTietDatHang values ('HD01','MH04','290000',5,0)

insert into ChiTietDatHang values ('HD02','MH10','535000',5,0)
insert into ChiTietDatHang values ('HD02','MH09','250000',5,0)
insert into ChiTietDatHang values ('HD02','MH07','170000',5,0)

insert into ChiTietDatHang values ('HD03','MH07','250000',5,0)