-- use master drop database CuaHangThuocTay

use master 
create database CuaHangThuocTay
go

use CuaHangThuocTay
go

create table NhaCungCap(
	MaNhaCungCap	char(15) primary key,
	TenNhaCungCap	nvarchar(200) not null
)

create table NhaSanXuat(
	MaNhaSanXuat	char(15) primary key,
	TenNhaSanXuat	nvarchar(200) not null
)

create table SanPham (
	MaSanPham		char(20) primary key,
	TenSanPham		nvarchar(200) not null,
	MaNhaSanXuat	char(15),
	ChiDinh			nvarchar(200) not null,
	DonViTinh		nvarchar(200) not null,
	SoLuongTon		int not null 
						check (SoLuongTon >= 0),
	MoTa			nvarchar(200),

	foreign key (MaNhaSanXuat) 
		references NhaSanXuat(MaNhaSanXuat)
			on update cascade
			on delete no action,
)


create table LoaiThuoc(
	MaLoai		char(20) primary key,
	TenLoai		nvarchar(200) not null,
	CongDung	nvarchar(200) not null
)

create table Thuoc(
	MaSanPham		char(20) primary key,
	TenThuoc		nvarchar(200) not null,
	MaLoai			char(20),
	ThanhPhanChinh	nvarchar(100) not null,
	DoTuoi			nvarchar(200),

	foreign key (MaSanPham) 
		references SanPham(MaSanPham)
			on update cascade
			on delete no action,

	foreign key ( MaLoai) 
		references LoaiThuoc(MaLoai)
			on update cascade
			on delete no action
)


create table DungCuYTe(
	MaSanPham		char(20) primary key,
	TenDungCuYTe	nvarchar(200),

	foreign key (MaSanPham) 
		references SanPham(MaSanPham)
			on update cascade
			on delete no action
)

create table GiaBan(
	MaSanPham	char(20),
	TuNgay		date not null,
	DenNgay		date not null,
	GiaBan		decimal(18,4) not null 
					check (GiaBan > 0.0),

	primary key(MaSanPham,TuNgay),

	foreign key (MaSanPham) 
		references SanPham(MaSanPham)
			on update cascade
			on delete no action,
)

create table TaiKhoan
(
	TenDangNhap		varchar(50) primary key,
	CMND			varchar(15) not null,
	HoTen			nvarchar(200) not null,
	MatKhau			nvarchar(50) not null 
						check (len(MatKhau) > 5),
	VaiTro			bit default 0, -- 0 la nhan vien, 1 la admin
	SDT				char(12) not null,
	Email			varchar(200)
)

create table HoaDonNhap(
	MaHoaDonNhap	char(15) primary key,
	TenDangNhap		varchar(50) not null,
	NgayNhap		date not null
						check (NgayNhap <= getdate()),
	MaNhaCungCap	char(15),
	TongTien		decimal(18,4) not null
						check (TongTien >= 0.0),
	MoTa			nvarchar(200),

	foreign key (MaNhaCungCap) 
		references NhaCungCap(MaNhaCungCap)
			on update cascade
			on delete no action,
	foreign key (TenDangNhap) 
		references TaiKhoan(TenDangNhap)
			on update cascade
			on delete no action
)

create table ChiTietHoaDonNhap
(
	MaHoaDonNhap	char(15),
	MaSanPham		char(20),
	SoLuong			int not null
						check (SoLuong > 0),
	DonGia			decimal(18,4)
						check (DonGia > 0),
	ThanhTien		decimal(18,4)
						check (ThanhTien >= 0),

	primary key( MaHoaDonNhap, MaSanPham),

	foreign key (MaHoaDonNhap) 
		references HoaDonNhap(MaHoaDonNhap)
			on update cascade
			on delete no action,

	foreign key (MaSanPham) 
		references SanPham(MaSanPham)
			on update cascade
			on delete no action
)

create table HoaDonBan
(
	MaHoaDonBan		char(15) primary key,
	TenDangNhap		varchar(50),
	NgayBan			date not null,
	TongTien		decimal(18,4) not null 
						check (TongTien >= 0),
	MoTa			nvarchar(200),

	foreign key (TenDangNhap)
		references TaiKhoan(TenDangNhap)
			on update cascade
			on delete no action
)

create table ChiTietHoaDonBan
(
	MaHoaDonBan char(15),
	MaSanPham	char(20) not null,
	SoLuong		int not null
					check (SoLuong > 0),
	DonGia		decimal(18,4) not null
					check (DonGia >= 0),
	ThanhTien	decimal(18,4) not null
					check (ThanhTien >= 0),

	primary key(MaHoaDonBan,MaSanPham),

	foreign key (MaHoaDonBan) 
		references HoaDonBan(MaHoaDonBan)
			on update cascade
			on delete no action,

	foreign key(MaSanPham) 
		references SanPham(MaSanPham)
			on update cascade
			on delete no action
)
