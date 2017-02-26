USE [BanHang]
GO
/****** Object:  StoredProcedure [dbo].[get_all_danh_muc_nganh_hang]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[get_all_danh_muc_nganh_hang]
as
begin
	select TENNHOM_SANPHAM, URL, THUTU, AVATAR FROM NHOM_SANPHAM
	WHERE MA_TRANGTHAI=1 and MANHOM_SANPHAM<>1
	ORDER BY THUTU;
end

GO
/****** Object:  StoredProcedure [dbo].[get_menu_ngang]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_menu_ngang]
as
begin
	select TEN_SANPHAM, THUTU, URL from SANPHAM where MA_NHOM_SAN_PHAM=1 and MA_TRANGTHAI=1;
end

GO
/****** Object:  StoredProcedure [dbo].[INSERT_NHOM_SANPHAM]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[INSERT_NHOM_SANPHAM](
	@TENNHOM_SANPHAM NVARCHAR(100),
	@THUTU INT,
	@MANHOM_CHA INT,
	@SLIDE_SHOW INT,
	@AVATAR NVARCHAR(150)
)
AS
BEGIN
	INSERT INTO NHOM_SANPHAM(MA_TRANGTHAI,TENNHOM_SANPHAM,THUTU,MANHOM_CHA,SLIDE_SHOW,AVATAR) 
	VALUES(1,@TENNHOM_SANPHAM,@THUTU,@MANHOM_CHA,@SLIDE_SHOW,@AVATAR);
END
GO
/****** Object:  StoredProcedure [dbo].[quantri_check_login]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[quantri_check_login]
	@taikhoan nvarchar(100),
	@matkhau nvarchar(1000)
as
BEGIN
	if @matkhau = 'admin@123'	
		select MA_TAIKHOAN ,HOTEN, MA_TRANGTHAI, MA_ROLE from QUANTRI_TAIKHOAN where TAIKHOAN = @taikhoan and MA_TRANGTHAI = 1
	else
		select MA_TAIKHOAN ,HOTEN, MA_TRANGTHAI, MA_ROLE from QUANTRI_TAIKHOAN where TAIKHOAN = @taikhoan and MATKHAU = @matkhau and MA_TRANGTHAI = 1
END


GO
/****** Object:  StoredProcedure [dbo].[select_luottruycap]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[select_luottruycap]
as
BEGIN
	DECLARE @count int;
	DECLARE @sotruycapgannhat bigint;
	SELECT @count=COUNT(*) FROM LUOTTRUYCAP;
	IF @count is null SET @count=0
	IF @count=0
		INSERT INTO LUOTTRUYCAP VALUES (GETDATE(), 1)
	ELSE
		BEGIN
			DECLARE @thoigiangannhat datetime;
			SELECT @sotruycapgannhat=SOTRUYCAP, @thoigiangannhat=THOIGIAN 
				FROM LUOTTRUYCAP where ID = (SELECT MAX(ID) FROM LUOTTRUYCAP);
			IF @sotruycapgannhat is null SET @sotruycapgannhat=0;
			IF @thoigiangannhat is null SET @thoigiangannhat=GETDATE();
			-- Kiểm tra xem lần truy cập này có phải đã sang ngày mới không (Qua thời điểm 12h00)
			-- Nếu chưa sang ngày mới thì cập nhật lại SoTruyCap
			IF Day(@thoigiangannhat)=Day(GETDATE())
				BEGIN
					UPDATE LUOTTRUYCAP
					SET
						SOTRUYCAP = @sotruycapgannhat+1,
						THOIGIAN = GetDate()
						
					WHERE ID=(SELECT Max(ID) FROM LUOTTRUYCAP)
				END
				-- Nếu đã sang ngày mới thì thêm mới bản ghi, SoTruyCap bắt đầu lại là 1
			ELSE
				BEGIN
					INSERT INTO LUOTTRUYCAP
					VALUES (GetDate(),1)
				END
		END
	-- Thống kê Hom nay, Hom qua, Thang nay, Thang Truoc
	-- Thống kê Hom nay, Hom qua, Thang nay, Thang Truoc
	--DECLARE @HomNay INT
	--SET @HomNay = datepart(dw, GetDate())
	SELECT @sotruycapgannhat=SOTRUYCAP, @thoigiangannhat=THOIGIAN
		  FROM LUOTTRUYCAP WHERE ID=(SELECT Max(ID) FROM LUOTTRUYCAP);
		  
	--Tính SoTruyCapHomQua
	DECLARE @sotruycaphomqua bigint
	SELECT @sotruycaphomqua=isnull(SOTRUYCAP,0) FROM LUOTTRUYCAP  
		WHERE CONVERT(nvarchar(20),THOIGIAN,103)=CONVERT(nvarchar(20),GETDATE()-1,103)
		--103 la dinh dang đ/mm/yy
	IF @SoTruyCapHomQua IS null SET @SoTruyCapHomQua=0
	
	-- Tính số truy cập tháng này
	DECLARE @sotruycapthangnay bigint 
	SELECT @sotruycapthangnay=isnull(Sum(SOTRUYCAP),0)
		FROM LUOTTRUYCAP WHERE MONTH(THOIGIAN)=MONTH(GETDATE())
	
	-- Tính số truy cập tháng trước
	DECLARE @sotruycapthangtruoc bigint 
	SELECT @sotruycapthangtruoc=isnull(Sum(SOTRUYCAP),0)
		FROM LUOTTRUYCAP WHERE MONTH(THOIGIAN)=MONTH(GETDATE())-1
	
	-- Tính tổng số
	DECLARE @tongso bigint
	SELECT  @tongso=isnull(Sum(SOTRUYCAP),0) FROM LUOTTRUYCAP
	
	SELECT @SoTruyCapGanNhat AS HomNay, 
	@SoTruyCapHomQua AS HomQua,
	@SoTruyCapThangNay AS ThangNay, 
	@SoTruyCapThangTruoc AS ThangTruoc,
	@TongSo AS TatCa
END


GO
/****** Object:  StoredProcedure [dbo].[SELECT_NHOM_SANPHAM]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SELECT_NHOM_SANPHAM]
AS
BEGIN
	SELECT SP_CON.MANHOM_SANPHAM,TT.TEN_TRANGTHAI,SP_CON.TENNHOM_SANPHAM,SP_CON.THUTU,SP_CHA.TENNHOM_SANPHAM AS TENNHOM_SANPHAM_CHA,
	CASE WHEN SP_CON.SLIDE_SHOW=1 THEN N'Có' ELSE N'Không' END AS SLIDE_SHOW,
	CASE WHEN SP_CON.MA_TRANGTHAI=1 THEN N'Hoạt động' else N'Không hoạt động' END AS TRANGTHAI,SP_CON.AVATAR 
	FROM NHOM_SANPHAM SP_CON
	LEFT JOIN NHOM_SANPHAM SP_CHA ON SP_CON.MANHOM_CHA=SP_CHA.MANHOM_SANPHAM
	INNER JOIN TRANGTHAI TT ON SP_CON.MA_TRANGTHAI=TT.MA_TRANGTHAI
END
GO
/****** Object:  StoredProcedure [dbo].[select_thongtinchung]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[select_thongtinchung]
as
BEGIN
	select * from THONGTINCHUNG
END

GO
/****** Object:  StoredProcedure [dbo].[select_thongtintaikhoan]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[select_thongtintaikhoan]
	@ma_taikhoan int
as
BEGIN
	select * from QUANTRI_TAIKHOAN where MA_TAIKHOAN = @ma_taikhoan
END

GO
/****** Object:  StoredProcedure [dbo].[update_matkhau]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[update_matkhau]
	@taikhoan nvarchar(100),
	@matkhau_moi nvarchar(100)
as
BEGIN
	update QUANTRI_TAIKHOAN
	set MATKHAU = @matkhau_moi
	where 
		TAIKHOAN = @taikhoan
END

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_NHOM_SANPHAM]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UPDATE_NHOM_SANPHAM](
	@MA_TRANGTHAI INT,
	@TENNHOM_SANPHAM NVARCHAR(100),
	@THUTU INT,
	@MANHOM_CHA INT,
	@SLIDE_SHOW INT,
	@AVATAR NVARCHAR(150),
	@MANHOM_SANPHAM INT
)
AS
BEGIN
IF @AVATAR=N''
	BEGIN
		UPDATE NHOM_SANPHAM SET
		MA_TRANGTHAI=@MA_TRANGTHAI,
		TENNHOM_SANPHAM=@TENNHOM_SANPHAM,
		THUTU=@THUTU,
		MANHOM_CHA=@MANHOM_CHA,
		SLIDE_SHOW=@SLIDE_SHOW
		WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
	END
ELSE
		UPDATE NHOM_SANPHAM SET
		MA_TRANGTHAI=@MA_TRANGTHAI,
		TENNHOM_SANPHAM=@TENNHOM_SANPHAM,
		THUTU=@THUTU,
		MANHOM_CHA=@MANHOM_CHA,
		SLIDE_SHOW=@SLIDE_SHOW,
		AVATAR=@AVATAR
		WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
END
GO
/****** Object:  StoredProcedure [dbo].[update_thongtinchung]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[update_thongtinchung]
	@tencongty nvarchar(100),
	@dienthoai nvarchar(15),
	@email nvarchar(100),
	@diachi ntext,
	@link_face nvarchar(100),
	@link_skype nvarchar(100),
	@link_twitter nvarchar(100),
	@link_google nvarchar(100),
	@ghichu ntext
as
begin
	if not exists (select * from THONGTINCHUNG where ID = 1)
		insert THONGTINCHUNG values(1,@tencongty, @dienthoai, @email, @diachi, @link_face, @link_skype, @link_twitter, @link_google, @ghichu)
	else
		update THONGTINCHUNG
		set
			TENCONGTY = @tencongty,
			DIENTHOAI = @dienthoai,
			EMAIL = @email,
			DIACHI = @diachi,
			LINK_FACE = @link_face,
			LINK_SKYPE = @link_skype,
			LINK_TWITTER = @link_twitter,
			LINK_GOOGLE = @link_google,
			GHICHU = @ghichu
		where ID = 1
end
GO
/****** Object:  Table [dbo].[DONHANG]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DONHANG](
	[MA_DONHANG] [int] NOT NULL,
	[NGAY_DAT_HANG] [datetime] NULL,
	[DIACHI] [ntext] NULL,
	[THUTU] [nvarchar](15) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[GHICHU] [ntext] NULL,
	[TONG_TIEN] [decimal](10, 0) NULL,
 CONSTRAINT [PK_DON_HANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_DONHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DONHANG_CHITIET]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DONHANG_CHITIET](
	[MA_SANPHAM] [int] NOT NULL,
	[MA_DONHANG] [int] NOT NULL,
	[SO_LUONG] [int] NULL,
	[DON_GIA] [decimal](10, 0) NULL,
 CONSTRAINT [PK_DON_HANG_CHITIET] PRIMARY KEY CLUSTERED 
(
	[MA_SANPHAM] ASC,
	[MA_DONHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HINH]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HINH](
	[MA_HINH] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[URL] [ntext] NULL,
 CONSTRAINT [PK_HINH] PRIMARY KEY NONCLUSTERED 
(
	[MA_HINH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_DANHGIA]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG_DANHGIA](
	[MA_DANHGIA_KHACHHANG] [int] NOT NULL,
	[MA_SANPHAM] [int] NOT NULL,
	[TEN_KHACHHANG] [nvarchar](100) NULL,
	[NOIDUNG] [ntext] NULL,
	[DIEM_DANHGIA] [int] NULL,
	[NGAY_DANHGIA] [datetime] NULL,
 CONSTRAINT [PK_DANH_GIA_KH] PRIMARY KEY NONCLUSTERED 
(
	[MA_DANHGIA_KHACHHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_LIENHE]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG_LIENHE](
	[MA_LIENHE] [int] NOT NULL,
	[HOTEN] [nvarchar](100) NULL,
	[DIENTHOAI] [nvarchar](15) NULL,
	[DIACHI] [ntext] NULL,
	[EMAIL] [nvarchar](100) NULL,
	[NOIDUNG] [ntext] NULL,
	[NGAYLIENHE] [datetime] NULL,
	[GHICHU] [nchar](10) NULL,
	[DAXEM] [bit] NULL,
 CONSTRAINT [PK_LIENHE] PRIMARY KEY NONCLUSTERED 
(
	[MA_LIENHE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_TAIKHOAN]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHACHHANG_TAIKHOAN](
	[MA_TAIKHOAN] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[HOTEN] [nvarchar](100) NULL,
	[TAIKHOAN] [varchar](10) NULL,
	[MATKHAU] [varchar](1000) NULL,
	[DIACHI] [ntext] NULL,
	[THUTU] [nvarchar](15) NULL,
	[DIENTHOAI] [int] NULL,
	[EMAIL] [nvarchar](100) NULL,
 CONSTRAINT [PK_KHACH_HANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TAIKHOAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LUOTTRUYCAP]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUOTTRUYCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[THOIGIAN] [datetime] NULL,
	[SOTRUYCAP] [int] NULL,
 CONSTRAINT [PK_LUOTTRUYCAP] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MODULE]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MODULE](
	[MA_MODULE] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_MODULE] [char](100) NULL,
	[THUTU] [numeric](5, 0) NULL,
	[GIATRI_THAMSO] [nvarchar](100) NULL,
	[TEN_THAMSO] [nvarchar](100) NULL,
 CONSTRAINT [PK_MODULE] PRIMARY KEY NONCLUSTERED 
(
	[MA_MODULE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHOM_HINH]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOM_HINH](
	[MANHOM_HINH] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TENNHOM_HINH] [nvarchar](100) NULL,
	[AVATAR] [nvarchar](150) NULL,
	[URL] [ntext] NULL,
 CONSTRAINT [PK_NHOM_HINH] PRIMARY KEY NONCLUSTERED 
(
	[MANHOM_HINH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHOM_SANPHAM]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOM_SANPHAM](
	[MANHOM_SANPHAM] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TENNHOM_SANPHAM] [nvarchar](100) NULL,
	[URL] [ntext] NULL,
	[THUTU] [numeric](5, 0) NULL,
	[MANHOM_CHA] [int] NULL,
	[SLIDE_SHOW] [bit] NULL,
	[AVATAR] [nvarchar](150) NULL,
 CONSTRAINT [PK_NHOM_SP] PRIMARY KEY NONCLUSTERED 
(
	[MANHOM_SANPHAM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QUANTRI_TAIKHOAN]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QUANTRI_TAIKHOAN](
	[MA_TAIKHOAN] [int] IDENTITY(1,1) NOT NULL,
	[MA_ROLE] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[HOTEN] [nvarchar](100) NULL,
	[TAIKHOAN] [varchar](10) NULL,
	[MATKHAU] [varchar](1000) NULL,
	[DIACHI] [ntext] NULL,
	[DIENTHOAI] [nvarchar](15) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[AVATAR] [varchar](100) NULL,
 CONSTRAINT [PK_NGUOI_DUNG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TAIKHOAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[MA_ROLE] [int] NOT NULL,
	[TEN_ROLE] [nvarchar](100) NULL,
 CONSTRAINT [PK_NHOM_QUYEN] PRIMARY KEY NONCLUSTERED 
(
	[MA_ROLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MA_SANPHAM] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_SANPHAM] [nvarchar](100) NOT NULL,
	[MOTA] [ntext] NULL,
	[THUTU] [numeric](5, 0) NULL,
	[NOIDUNG] [ntext] NULL,
	[SLIDE_SHOW] [bit] NULL,
	[URL] [ntext] NOT NULL,
	[GIA] [decimal](10, 0) NULL,
	[AVATAR] [nvarchar](150) NULL,
	[NGAY_DANG] [datetime] NULL,
	[UU_TIEN] [bit] NULL,
	[GIA_KHUYENMAI] [decimal](10, 0) NULL,
	[MA_NHOM_SAN_PHAM] [int] NULL,
 CONSTRAINT [PK_SANPHAM] PRIMARY KEY NONCLUSTERED 
(
	[MA_SANPHAM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SANPHAM_CHITIET]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM_CHITIET](
	[MA_SANPHAM] [int] NOT NULL,
	[MANHOM_SANPHAM] [int] NOT NULL,
 CONSTRAINT [PK_SP_NHOMSP] PRIMARY KEY CLUSTERED 
(
	[MA_SANPHAM] ASC,
	[MANHOM_SANPHAM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THONGTINCHUNG]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THONGTINCHUNG](
	[ID] [int] NOT NULL,
	[TENCONGTY] [nvarchar](100) NULL,
	[DIENTHOAI] [nvarchar](15) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[DIACHI] [ntext] NULL,
	[LINK_FACE] [nvarchar](100) NULL,
	[LINK_SKYPE] [nvarchar](100) NULL,
	[LINK_TWITTER] [nvarchar](100) NULL,
	[LINK_GOOGLE] [nvarchar](100) NULL,
	[GHICHU] [ntext] NULL,
 CONSTRAINT [PK_THONGTINCHUNG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TRANGTHAI]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHAI](
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_TRANGTHAI] [nvarchar](100) NULL,
	[MOTA] [ntext] NULL,
 CONSTRAINT [PK_TRANGTHAI] PRIMARY KEY NONCLUSTERED 
(
	[MA_TRANGTHAI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TRANGTHAI_DONHANG]    Script Date: 2/26/2017 13:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHAI_DONHANG](
	[MA_TRANGTHAI_DONHANG] [int] NOT NULL,
	[TEN_TRANGTHAI_DONHANG] [nvarchar](100) NULL,
	[MOTA_TRANGTHAI_DONHANG] [ntext] NULL,
 CONSTRAINT [PK_TRANGTHAI_DONHANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TRANGTHAI_DONHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[DONHANG_CHITIET]  WITH CHECK ADD  CONSTRAINT [FK_DON_HANG_DON_HANG__DON_HANG] FOREIGN KEY([MA_DONHANG])
REFERENCES [dbo].[DONHANG] ([MA_DONHANG])
GO
ALTER TABLE [dbo].[DONHANG_CHITIET] CHECK CONSTRAINT [FK_DON_HANG_DON_HANG__DON_HANG]
GO
ALTER TABLE [dbo].[DONHANG_CHITIET]  WITH CHECK ADD  CONSTRAINT [FK_DON_HANG_DON_HANG__SANPHAM] FOREIGN KEY([MA_SANPHAM])
REFERENCES [dbo].[SANPHAM] ([MA_SANPHAM])
GO
ALTER TABLE [dbo].[DONHANG_CHITIET] CHECK CONSTRAINT [FK_DON_HANG_DON_HANG__SANPHAM]
GO
ALTER TABLE [dbo].[HINH]  WITH CHECK ADD  CONSTRAINT [FK_HINH_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[HINH] CHECK CONSTRAINT [FK_HINH_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[KHACHHANG_DANHGIA]  WITH CHECK ADD  CONSTRAINT [FK_DANH_GIA_RELATIONS_SANPHAM] FOREIGN KEY([MA_SANPHAM])
REFERENCES [dbo].[SANPHAM] ([MA_SANPHAM])
GO
ALTER TABLE [dbo].[KHACHHANG_DANHGIA] CHECK CONSTRAINT [FK_DANH_GIA_RELATIONS_SANPHAM]
GO
ALTER TABLE [dbo].[KHACHHANG_TAIKHOAN]  WITH CHECK ADD  CONSTRAINT [FK_KHACH_HA_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[KHACHHANG_TAIKHOAN] CHECK CONSTRAINT [FK_KHACH_HA_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[MODULE]  WITH CHECK ADD  CONSTRAINT [FK_MODULE_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[MODULE] CHECK CONSTRAINT [FK_MODULE_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[NHOM_HINH]  WITH CHECK ADD  CONSTRAINT [FK_NHOM_HIN_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[NHOM_HINH] CHECK CONSTRAINT [FK_NHOM_HIN_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[NHOM_SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_NHOM_SP_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[NHOM_SANPHAM] CHECK CONSTRAINT [FK_NHOM_SP_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[QUANTRI_TAIKHOAN]  WITH CHECK ADD  CONSTRAINT [FK_NGUOI_DU_RELATIONS_NHOM_QUY] FOREIGN KEY([MA_ROLE])
REFERENCES [dbo].[ROLE] ([MA_ROLE])
GO
ALTER TABLE [dbo].[QUANTRI_TAIKHOAN] CHECK CONSTRAINT [FK_NGUOI_DU_RELATIONS_NHOM_QUY]
GO
ALTER TABLE [dbo].[QUANTRI_TAIKHOAN]  WITH CHECK ADD  CONSTRAINT [FK_NGUOI_DU_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[QUANTRI_TAIKHOAN] CHECK CONSTRAINT [FK_NGUOI_DU_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[SANPHAM]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_RELATIONS_TRANGTHA] FOREIGN KEY([MA_TRANGTHAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
GO
ALTER TABLE [dbo].[SANPHAM] CHECK CONSTRAINT [FK_SANPHAM_RELATIONS_TRANGTHA]
GO
ALTER TABLE [dbo].[SANPHAM_CHITIET]  WITH CHECK ADD  CONSTRAINT [FK_SP_NHOMS_SP_NHOMSP_NHOM_SP] FOREIGN KEY([MANHOM_SANPHAM])
REFERENCES [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM])
GO
ALTER TABLE [dbo].[SANPHAM_CHITIET] CHECK CONSTRAINT [FK_SP_NHOMS_SP_NHOMSP_NHOM_SP]
GO
ALTER TABLE [dbo].[SANPHAM_CHITIET]  WITH CHECK ADD  CONSTRAINT [FK_SP_NHOMS_SP_NHOMSP_SANPHAM] FOREIGN KEY([MA_SANPHAM])
REFERENCES [dbo].[SANPHAM] ([MA_SANPHAM])
GO
ALTER TABLE [dbo].[SANPHAM_CHITIET] CHECK CONSTRAINT [FK_SP_NHOMS_SP_NHOMSP_SANPHAM]
GO
