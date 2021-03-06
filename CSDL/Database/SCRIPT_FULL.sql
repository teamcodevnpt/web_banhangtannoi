USE [BanHang]
GO
/****** Object:  StoredProcedure [dbo].[DELETE_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DELETE_SANPHAM]
(
	@MA_SANPHAM INT
)
AS
BEGIN
	DELETE 
	FROM SANPHAM_CHITIET 
	WHERE MA_SANPHAM=@MA_SANPHAM
	-------------------------
	DELETE 
	FROM SANPHAM 
	WHERE MA_SANPHAM=@MA_SANPHAM
END




GO
/****** Object:  StoredProcedure [dbo].[DEM_SP_THEO_KEYWORD]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DEM_SP_THEO_KEYWORD] (@keyword NVARCHAR(100))
AS
BEGIN
	select COUNT(1)
	from SANPHAM 
	where TEN_SANPHAM like N'%' + @keyword + '%' 
		  AND MA_TRANGTHAI=1
END

GO
/****** Object:  StoredProcedure [dbo].[DEM_SP_THEO_MA_SP]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DEM_SP_THEO_MA_SP] (@MA_SAN_PHAM INT)
AS
BEGIN
	SELECT COUNT(1) FROM SANPHAM
	WHERE SANPHAM.MA_NHOM_SAN_PHAM = @MA_SAN_PHAM
		AND SANPHAM.MA_TRANGTHAI=1
END

GO
/****** Object:  StoredProcedure [dbo].[get_all_danh_muc_nganh_hang]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_all_danh_muc_nganh_hang]
as
begin
	select TENNHOM_SANPHAM,
			MANHOM_SANPHAM,
			URL,
			THUTU,
			AVATAR
	FROM NHOM_SANPHAM
	WHERE MA_TRANGTHAI=1
	ORDER BY THUTU;
end




GO
/****** Object:  StoredProcedure [dbo].[GET_DS_SP_THEO_MA_SP]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_DS_SP_THEO_MA_SP] (@PageNum INT, @MA_NHOM_SP INT)
AS
SELECT * 
FROM(
	SELECT SP.TEN_SANPHAM, SP.MOTA, SP.THUTU, SP.NOIDUNG, SP.URL, SP.GIA, SP.AVATAR, SP.NGAY_DANG,
		SP.UU_TIEN, SP.GIA_KHUYENMAI, SP.MA_NHOM_SAN_PHAM, sp.MA_SANPHAM, sp.SLIDE_SHOW,
		ROW_NUMBER() OVER(ORDER BY SP.NGAY_DANG) RN 
	FROM SANPHAM SP, NHOM_SANPHAM AS NHOMSP
	WHERE SP.MA_NHOM_SAN_PHAM = NHOMSP.MANHOM_SANPHAM AND SP.MA_NHOM_SAN_PHAM=@MA_NHOM_SP
		AND SP.MA_TRANGTHAI=1
) a
WHERE RN BETWEEN (@PageNum-1)*20+1 AND @PageNum*20
ORDER BY UU_TIEN, THUTU, NGAY_DANG

GO
/****** Object:  StoredProcedure [dbo].[get_DS_SP_THEO_NHOM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_DS_SP_THEO_NHOM] (@MA_NHOM_SP int)
as
begin
	select 	SP.TEN_SANPHAM,
			SP.THUTU,
			SP.URL,
			SP.GIA, 
			SP.AVATAR, 
			SP.NGAY_DANG,
			SP.UU_TIEN,
			SP.GIA_KHUYENMAI,
			SP.MA_NHOM_SAN_PHAM,
			sp.MA_SANPHAM, 
			sp.SLIDE_SHOW
	from SANPHAM AS SP,
		 NHOM_SANPHAM AS NHOMSP
	WHERE SP.MA_NHOM_SAN_PHAM = NHOMSP.MANHOM_SANPHAM
		AND SP.MA_NHOM_SAN_PHAM=@MA_NHOM_SP
		AND SP.MA_TRANGTHAI=1
	ORDER BY UU_TIEN DESC, SP.THUTU, SP.NGAY_DANG
	 
end;




GO
/****** Object:  StoredProcedure [dbo].[get_menu_ngang]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_menu_ngang]
as
begin
	select TEN_MENU,
			 THU_TU, 
			 URL 
	from MENU 
	where MA_NHOM_MEMU=1 
		and MA_TRANG_THAI=1
	ORDER BY THU_TU;
end




GO
/****** Object:  StoredProcedure [dbo].[get_SAN_PHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_SAN_PHAM] (@MA_SAN_PHAM int)
as
begin
	SELECT SP.MA_NHOM_SAN_PHAM,
			SP.MA_SANPHAM,
			SP.TEN_SANPHAM,
			SP.MOTA, 
			SP.THUTU,
			SP.NOIDUNG,
			SP.URL, 
			SP.GIA,
			SP.AVATAR,
			SP.NGAY_DANG,
			SP.UU_TIEN,
			SP.GIA_KHUYENMAI 
	FROM SANPHAM AS SP,
		 NHOM_SANPHAM AS NHOMSP
	WHERE SP.MA_NHOM_SAN_PHAM = NHOMSP.MANHOM_SANPHAM
			AND SP.MA_TRANGTHAI=1
			AND SP.MA_SANPHAM = @MA_SAN_PHAM
	ORDER BY SP.UU_TIEN, SP.THUTU, SP.NGAY_DANG
end




GO
/****** Object:  StoredProcedure [dbo].[GET_SAN_PHAM_SLIDESHOW]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SAN_PHAM_SLIDESHOW] 
AS
BEGIN
	SELECT MA_SANPHAM,
			TEN_SANPHAM,
			THUTU,
			NGAY_DANG,
			GIA,
			GIA_KHUYENMAI,
			SLIDE_SHOW, 
			MA_NHOM_SAN_PHAM  
	FROM SANPHAM
	WHERE SLIDE_SHOW=1 
END




GO
/****** Object:  StoredProcedure [dbo].[grid_NguoiDung]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[grid_NguoiDung]
as
begin
 select a.MA_TAIKHOAN,
		a.HOTEN,
		a.TAIKHOAN,
		a.DIACHI,
		a.EMAIL,
		a.DIENTHOAI,
		a.MA_ROLE,
		a.TEN_ROLE,
		b.MA_TRANGTHAI,
		b.TEN_TRANGTHAI 
 from 
 (select MA_TAIKHOAN,dbo.QUANTRI_TAIKHOAN.MA_ROLE,MA_TRANGTHAI,HOTEN,TAIKHOAN,MATKHAU,DIENTHOAI,DIACHI,EMAIL,AVATAR,TEN_ROLE from dbo.QUANTRI_TAIKHOAN inner join dbo.ROLE
 on dbo.QUANTRI_TAIKHOAN.MA_ROLE = dbo.ROLE.MA_ROLE
 ) as a  inner join dbo.TRANGTHAI as b
 on a.MA_TRANGTHAI = b.MA_TRANGTHAI
end




GO
/****** Object:  StoredProcedure [dbo].[INSERT_NHOM_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
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
DECLARE @URL NVARCHAR(2000);
DECLARE @MANHOM_SANPHAM NVARCHAR(20);
BEGIN
	SET @URL=N'~/Danh-sach-san-pham/'+dbo.BODAU(@TENNHOM_SANPHAM)+N'/';
	INSERT INTO NHOM_SANPHAM(MA_TRANGTHAI,TENNHOM_SANPHAM,URL,THUTU,MANHOM_CHA,SLIDE_SHOW,AVATAR) 
	VALUES(1,@TENNHOM_SANPHAM,@URL,@THUTU,@MANHOM_CHA,@SLIDE_SHOW,@AVATAR);
	SET @MANHOM_SANPHAM=(SELECT CAST(MAX(MANHOM_SANPHAM) AS NVARCHAR(20)) 
	FROM NHOM_SANPHAM);
	-----------------------------------------------------
	UPDATE NHOM_SANPHAM 
	SET URL=CAST(URL AS NVARCHAR(2000))+CAST(@MANHOM_SANPHAM AS NVARCHAR(20)) 
	WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
END




GO
/****** Object:  StoredProcedure [dbo].[INSERT_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_SANPHAM](
		@MANHOM_SANPHAM int,
		@MA_TRANGTHAI int,
		@TEN_SANPHAM nvarchar(100),
		@MOTA nvarchar(100),
		@THUTU int,
		@NOIDUNG ntext,
		@SLIDE_SHOW int,
		@GIA decimal,
		@AVATAR nvarchar(150),
		@UU_TIEN int,
		@GIA_KHUYENMAI decimal
)
AS
DECLARE @URL NVARCHAR(2000);
DECLARE @MA_SANPHAM INT;
BEGIN
	SET @URL=N'~/Chi-tiet-san-pham/'+dbo.BODAU(@TEN_SANPHAM)+N'/'
	INSERT INTO BanHang.dbo.SANPHAM
           (MA_TRANGTHAI
           ,TEN_SANPHAM
           ,MOTA
           ,THUTU
           ,NOIDUNG
           ,SLIDE_SHOW
           ,URL
           ,GIA
           ,AVATAR
           ,NGAY_DANG
           ,UU_TIEN
           ,GIA_KHUYENMAI,
           MA_NHOM_SAN_PHAM)
     VALUES
           (@MA_TRANGTHAI,
			@TEN_SANPHAM,
			@MOTA,
			@THUTU,
			@NOIDUNG,
			@SLIDE_SHOW,
			@URL,
			@GIA,
			@AVATAR,
			GETDATE(),
			@UU_TIEN,
			@GIA_KHUYENMAI,
			@MANHOM_SANPHAM);
	INSERT INTO SANPHAM_CHITIET(MA_SANPHAM,MANHOM_SANPHAM) 
	VALUES((SELECT MAX(MA_SANPHAM) 
	FROM SANPHAM),@MANHOM_SANPHAM);
	----------------------------------------
	SET @MA_SANPHAM=(SELECT MAX(MA_SANPHAM) FROM SANPHAM);
	----------------------------------------
	UPDATE SANPHAM
	 SET URL=CAST(URL AS NVARCHAR(2000))+CAST(@MA_SANPHAM AS NVARCHAR(10)) 
	 WHERE MA_SANPHAM=@MA_SANPHAM;
END



GO
/****** Object:  StoredProcedure [dbo].[insert_taikhoan]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[insert_taikhoan] 
	@MaNhomQuyen int,
	@MaTrangThai int,
	@TenNguoiDung nvarchar(max),
	@TaiKhoan nvarchar(10),
	@MatKhau nvarchar(100),
	@DiaChi ntext,
	@SDT nvarchar (15),
	@Email nvarchar(100),
	@Sluong int output
	
AS
BEGIN
     set @Sluong = 0
	 select @Sluong = COUNT(*) from dbo.QUANTRI_TAIKHOAN 
	 WHERE TAIKHOAN =@TaiKhoan
	 if (@Sluong >0)
	 set @Sluong =1
	 else
	 insert into dbo.QUANTRI_TAIKHOAN 
	 values (@MaNhomQuyen,@MaTrangThai,@TenNguoiDung,@TaiKhoan,@MatKhau,@DiaChi,@SDT,@Email, null)	
	 return @Sluong
END




GO
/****** Object:  StoredProcedure [dbo].[LOAI_BO_SAN_PHAM_SLIDESHOW]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LOAI_BO_SAN_PHAM_SLIDESHOW](@MA_SANPHAM INT)
AS
BEGIN
	UPDATE SANPHAM 
	SET SLIDE_SHOW=0 
	WHERE MA_SANPHAM=@MA_SANPHAM
END;




GO
/****** Object:  StoredProcedure [dbo].[quantri_check_login]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[quantri_check_login]
	@taikhoan varchar(10),
	@matkhau varchar(1000)
as
BEGIN
	if @matkhau = 'e6e061838856bf47e1de730719fb2609'	-- admin@123
		select MA_TAIKHOAN , TAIKHOAN, HOTEN, MA_TRANGTHAI, MA_ROLE, isnull(AVATAR, '#') as AVATAR 
		from QUANTRI_TAIKHOAN 
		where TAIKHOAN = @taikhoan
	else
		select MA_TAIKHOAN, TAIKHOAN, HOTEN, MA_TRANGTHAI, MA_ROLE, isnull(AVATAR, '#') as AVATAR 
		from QUANTRI_TAIKHOAN 
		where TAIKHOAN = @taikhoan and MATKHAU = @matkhau
END




GO
/****** Object:  StoredProcedure [dbo].[reset_luottruycap]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[reset_luottruycap]
as
begin
	delete LUOTTRUYCAP
end;


GO
/****** Object:  StoredProcedure [dbo].[search_sanpham]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[search_sanpham](
	@keyword nvarchar(100),
	@PageNum INT
) 
as
begin
	select * 
	from
		(select SP.TEN_SANPHAM, SP.MOTA, SP.THUTU, SP.NOIDUNG, SP.URL, SP.GIA, SP.AVATAR, SP.NGAY_DANG,
			SP.UU_TIEN, SP.GIA_KHUYENMAI, SP.MA_NHOM_SAN_PHAM, sp.MA_SANPHAM, sp.SLIDE_SHOW,
			ROW_NUMBER() OVER(ORDER BY SP.NGAY_DANG) RN 
		from SANPHAM sp
		where sp.TEN_SANPHAM like N'%' + @keyword + '%' 
			  AND SP.MA_TRANGTHAI=1)a
	WHERE RN BETWEEN (@PageNum-1)*20+1 AND @PageNum*20
	ORDER BY UU_TIEN, THUTU, NGAY_DANG;
end



GO
/****** Object:  StoredProcedure [dbo].[SELECT_LIST_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_LIST_SANPHAM](
	@MANHOM_SANPHAM AS INT
)
AS
BEGIN
SELECT SP.MA_SANPHAM
      ,TT.TEN_TRANGTHAI AS TRANGTHAI
      ,SP.TEN_SANPHAM
      ,NSP.TENNHOM_SANPHAM
      ,SP.THUTU
      ,CASE WHEN SP.SLIDE_SHOW=1 THEN N'Có' ELSE N'Không' END AS SLIDE_SHOW
      ,LEFT(CONVERT(varchar, CAST(SP.GIA AS MONEY), 3),LEN(CONVERT(varchar, CAST(SP.GIA AS MONEY), 3))-3) AS GIA
      ,SP.AVATAR
      ,CONVERT(NVARCHAR(10),SP.NGAY_DANG,103) AS NGAY_DANG
      ,CASE WHEN SP.UU_TIEN=1 THEN N'Có' ELSE N'Không' END AS UU_TIEN
      ,LEFT(CONVERT(varchar, CAST(SP.GIA_KHUYENMAI AS MONEY), 3)
	  ,LEN(CONVERT(varchar, CAST(SP.GIA_KHUYENMAI AS MONEY), 3))-3) GIA_KHUYENMAI
  FROM SANPHAM SP
  INNER JOIN SANPHAM_CHITIET SPCT ON SP.MA_SANPHAM=SPCT.MA_SANPHAM
  INNER JOIN NHOM_SANPHAM NSP ON SPCT.MANHOM_SANPHAM=NSP.MANHOM_SANPHAM
  INNER JOIN TRANGTHAI TT ON SP.MA_TRANGTHAI=TT.MA_TRANGTHAI
  WHERE (NSP.MANHOM_SANPHAM=@MANHOM_SANPHAM AND @MANHOM_SANPHAM<>0) OR @MANHOM_SANPHAM=0
END




GO
/****** Object:  StoredProcedure [dbo].[select_luottruycap]    Script Date: 15/03/2017 11:05:37 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SELECT_NHOM_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_NHOM_SANPHAM]
AS
BEGIN
	SELECT SP_CON.MANHOM_SANPHAM,
			TT.TEN_TRANGTHAI,
			SP_CON.TENNHOM_SANPHAM,
			SP_CON.THUTU,
			SP_CON.MANHOM_CHA,
			SP_CHA.TENNHOM_SANPHAM AS TENNHOM_SANPHAM_CHA,
			CASE WHEN SP_CON.SLIDE_SHOW=1 THEN N'Có' ELSE N'Không' END AS SLIDE_SHOW,
			CASE WHEN SP_CON.MA_TRANGTHAI=1 THEN N'Hoạt động' else N'Không hoạt động' END AS TRANGTHAI,
			replace(SP_CON.AVATAR,'~','..') as AVATAR
	FROM NHOM_SANPHAM SP_CON
		LEFT JOIN NHOM_SANPHAM SP_CHA ON SP_CON.MANHOM_CHA=SP_CHA.MANHOM_SANPHAM
		INNER JOIN TRANGTHAI TT ON SP_CON.MA_TRANGTHAI=TT.MA_TRANGTHAI
END




GO
/****** Object:  StoredProcedure [dbo].[SELECT_NHOMSP_FROM_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_NHOMSP_FROM_SANPHAM]
(
	@MANHOM_SANPHAM INT
)
AS
BEGIN
	SELECT MANHOM_SANPHAM 
	FROM SANPHAM_CHITIET 
	WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
	UNION
	SELECT MANHOM_SANPHAM 
	FROM NHOM_SANPHAM 
	WHERE MANHOM_CHA=@MANHOM_SANPHAM 
END




GO
/****** Object:  StoredProcedure [dbo].[SELECT_SANPHAM_FROM_MASP]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_SANPHAM_FROM_MASP](
	@MA_SANPHAM INT
)
AS
BEGIN
SELECT TOP 1 SP.MA_SANPHAM
      ,[MA_TRANGTHAI]
      ,[TEN_SANPHAM]
      ,[MOTA]
      ,[THUTU]
      ,[NOIDUNG]
      ,[SLIDE_SHOW]
      ,[URL]
      ,[GIA]
      ,[AVATAR]
      ,[NGAY_DANG]
      ,[UU_TIEN]
      ,[GIA_KHUYENMAI],
      CT.MANHOM_SANPHAM
  FROM [SANPHAM] SP
		INNER JOIN SANPHAM_CHITIET CT ON SP.MA_SANPHAM=CT.MA_SANPHAM
  WHERE SP.MA_SANPHAM=@MA_SANPHAM
END




GO
/****** Object:  StoredProcedure [dbo].[select_slideshow_from_sanpham]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_slideshow_from_sanpham]
as
begin 
	select TEN_SANPHAM,
			URL, 
			AVATAR 
	from SANPHAM 
	where SLIDE_SHOW = 1 
			and MA_TRANGTHAI = 1 
			and AVATAR is not null  
	order by UU_TIEN, THUTU asc 
end




GO
/****** Object:  StoredProcedure [dbo].[select_thongtinchung]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[select_thongtinchung]
as
BEGIN
	select * 
	from THONGTINCHUNG
END




GO
/****** Object:  StoredProcedure [dbo].[select_thongtintaikhoan]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[select_thongtintaikhoan]
	@ma_taikhoan int
as
BEGIN
	select * 
	from QUANTRI_TAIKHOAN 
	where MA_TAIKHOAN = @ma_taikhoan
END




GO
/****** Object:  StoredProcedure [dbo].[sysn_sanpham]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sysn_sanpham]
as 
begin
	DELETE SANPHAM_TEMP;
	-------------------------------------------------
	INSERT INTO SANPHAM_TEMP
	SELECT ROW_NUMBER() OVER (Order by MA_SANPHAM) AS MA_SANPHAM
		  ,[MA_TRANGTHAI]
		  ,[TEN_SANPHAM]
		  ,[MOTA]
		  ,[THUTU]
		  ,[NOIDUNG]
		  ,[SLIDE_SHOW]
		  ,(N'~/Chi-tiet-san-pham/'+dbo.BODAU(TEN_SANPHAM)+N'/'+ CONVERT(varchar(10),ROW_NUMBER() OVER (Order by MA_SANPHAM))) AS URL
		  ,[GIA]
		  ,[AVATAR]
		  ,GETDATE() AS NGAY_DANG
		  ,ISNULL(UU_TIEN, '0') AS UU_TIEN
		  ,ISNULL(GIA_KHUYENMAI, '0') AS GIA_KHUYENMAI
		  ,[MA_NHOM_SAN_PHAM]
	  FROM [dbo].[SANPHAM];
	  --------------------------------------------
	  DELETE SANPHAM_CHITIET;
	  DELETE SANPHAM;
	  --------------------------------------------
	  INSERT INTO SANPHAM
	  SELECT [MA_SANPHAM]
		  ,[MA_TRANGTHAI]
		  ,[TEN_SANPHAM]
		  ,[MOTA]
		  ,[THUTU]
		  ,[NOIDUNG]
		  ,[SLIDE_SHOW]
		  ,[URL]
		  ,[GIA]
		  ,[AVATAR]
		  ,[NGAY_DANG]
		  ,[UU_TIEN]
		  ,[GIA_KHUYENMAI]
		  ,[MA_NHOM_SAN_PHAM]
	  FROM [dbo].[SANPHAM_TEMP] 
	  ORDER BY [MA_SANPHAM];
	  --------------------------------------
	  INSERT INTO SANPHAM_CHITIET
	  SELECT [MA_SANPHAM]
		  ,[MA_NHOM_SAN_PHAM]
	  FROM [dbo].[SANPHAM];
	  --------------------------------------
	  delete SANPHAM_TEMP;
end;


GO
/****** Object:  StoredProcedure [dbo].[THEM_SAN_PHAM_SLIDESHOW]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[THEM_SAN_PHAM_SLIDESHOW] (@MA_SANPHAM INT)
AS
BEGIN
	UPDATE SANPHAM 
	SET SLIDE_SHOW=1
	WHERE MA_SANPHAM=@MA_SANPHAM
END




GO
/****** Object:  StoredProcedure [dbo].[update_matkhau]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	where TAIKHOAN = @taikhoan
END




GO
/****** Object:  StoredProcedure [dbo].[UPDATE_NHOM_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
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
DECLARE @URL NVARCHAR(2000);
BEGIN
SET @URL='~/Danh-sach-san-pham/'+@TENNHOM_SANPHAM+N'/'+CAST(@MANHOM_SANPHAM AS NVARCHAR(10))
IF @AVATAR=N''
	BEGIN
		UPDATE NHOM_SANPHAM 
		SET MA_TRANGTHAI=@MA_TRANGTHAI,
			TENNHOM_SANPHAM=@TENNHOM_SANPHAM,
			THUTU=@THUTU,
			URL=@URL,
			MANHOM_CHA=@MANHOM_CHA,
			SLIDE_SHOW=@SLIDE_SHOW
		WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
	END
ELSE
		UPDATE NHOM_SANPHAM 
		SET MA_TRANGTHAI=@MA_TRANGTHAI,
			TENNHOM_SANPHAM=@TENNHOM_SANPHAM,
			THUTU=@THUTU,
			MANHOM_CHA=@MANHOM_CHA,
			URL=@URL,
			SLIDE_SHOW=@SLIDE_SHOW,
			AVATAR=@AVATAR
		WHERE MANHOM_SANPHAM=@MANHOM_SANPHAM
END




GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_SANPHAM](
	@MA_TRANGTHAI int,
	@MANHOM_SANPHAM int,
    @TEN_SANPHAM nvarchar(100),
    @MOTA ntext,
    @THUTU numeric,
    @NOIDUNG ntext,
    @SLIDE_SHOW bit,
    @GIA decimal,
    @AVATAR nvarchar(150),
    @UU_TIEN bit,
    @GIA_KHUYENMAI decimal,
    @MA_SANPHAM int
)
AS
DECLARE @URL NVARCHAR(2000);
BEGIN
SET @URL=N'~/Chi-tiet-san-pham/'+dbo.BODAU(@TEN_SANPHAM)+N'/'+CAST(@MA_SANPHAM AS NVARCHAR(10));
UPDATE SANPHAM_CHITIET SET MANHOM_SANPHAM=@MANHOM_SANPHAM WHERE MA_SANPHAM=@MA_SANPHAM
IF @AVATAR=N''
   BEGIN
	UPDATE SANPHAM
	   SET MA_TRANGTHAI = @MA_TRANGTHAI,
		  TEN_SANPHAM = @TEN_SANPHAM,
		  MOTA = @MOTA,
		  THUTU = @THUTU,
		  NOIDUNG = @NOIDUNG,
		  SLIDE_SHOW = @SLIDE_SHOW,
		  URL=@URL,
		  GIA = @GIA,
		  UU_TIEN = @UU_TIEN,
		  GIA_KHUYENMAI = @GIA_KHUYENMAI
	 WHERE MA_SANPHAM=@MA_SANPHAM
	END
   ELSE
   BEGIN
	UPDATE SANPHAM
	   SET MA_TRANGTHAI = @MA_TRANGTHAI,
		  TEN_SANPHAM = @TEN_SANPHAM,
		  MOTA = @MOTA,
		  THUTU = @THUTU,
		  NOIDUNG = @NOIDUNG,
		  SLIDE_SHOW = @SLIDE_SHOW,
		  URL=@URL,
		  GIA = @GIA,
		  AVATAR = @AVATAR,
		  UU_TIEN = @UU_TIEN,
		  GIA_KHUYENMAI = @GIA_KHUYENMAI
	 WHERE MA_SANPHAM=@MA_SANPHAM
	END
END




GO
/****** Object:  StoredProcedure [dbo].[update_taikhoan]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_taikhoan]
	@MA_TAIKHOAN int,
	@MA_ROLE int,
	@MA_TRANGTHAI int,
	@HOTEN nvarchar(max),
	@TAIKHOAN varchar(10),
	@DIACHI ntext,
	@DIENTHOAI nvarchar (15),
	@EMAIL nvarchar(100)
AS
BEGIN
	UPDATE dbo.QUANTRI_TAIKHOAN 
	SET HOTEN=@HOTEN,
		TAIKHOAN=@TAIKHOAN,
		DIACHI=@DIACHI,
		DIENTHOAI=@DIENTHOAI,
		EMAIL=@EMAIL,
		MA_TRANGTHAI=@MA_TRANGTHAI,
		MA_ROLE=@MA_ROLE
	WHERE MA_TAIKHOAN = @MA_TAIKHOAN
	
END




GO
/****** Object:  StoredProcedure [dbo].[update_thongtin]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_thongtin]
	@ma_taikhoan int,
	@hoten nvarchar(100),
	@diachi ntext,
	@dienthoai nvarchar(15),
	@email nvarchar(20),
	@avatar varchar(100)
as
BEGIN
	update QUANTRI_TAIKHOAN
	set HOTEN = @hoten,
		DIACHI = @diachi,
		DIENTHOAI = @dienthoai,
		EMAIL = @email,
		AVATAR = @avatar
	where 
		MA_TAIKHOAN = @ma_taikhoan
END




GO
/****** Object:  StoredProcedure [dbo].[update_thongtinchung]    Script Date: 15/03/2017 11:05:37 AM ******/
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
		insert THONGTINCHUNG 
		values(1,@tencongty, @dienthoai, @email, @diachi, @link_face, @link_skype, @link_twitter, @link_google, @ghichu)
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
/****** Object:  UserDefinedFunction [dbo].[BODAU]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BODAU]
(
      @strInput NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN    
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)

    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
                  ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý
                  ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ
                  ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'
                  +NCHAR(272)+ NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
                  iiiiiooooooooooooooouuuuuuuuuuyyyyy
                  AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII
                  OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'

    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
    SET @COUNTER = 1

    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN  
      SET @COUNTER1 = 1
      --Tìm trong chuỗi mẫu
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1))
            = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN          
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                  
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1)
              +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
              BREAK
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tìm tiếp
       SET @COUNTER = @COUNTER +1
    END
    SET @strInput = replace(replace(@strInput,'/', ''),' ','-')
    RETURN @strInput
END




GO
/****** Object:  Table [dbo].[DONHANG]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[TONG_TIEN] [decimal](10, 0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DONHANG_CHITIET]    Script Date: 15/03/2017 11:05:37 AM ******/
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
/****** Object:  Table [dbo].[HINH]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HINH](
	[MA_HINH] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[URL] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_DANHGIA]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[NGAY_DANHGIA] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_LIENHE]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[DAXEM] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG_TAIKHOAN]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[EMAIL] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LUOTTRUYCAP]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUOTTRUYCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[THOIGIAN] [datetime] NULL,
	[SOTRUYCAP] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MENU]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[MA_MENU] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANG_THAI] [int] NULL,
	[TEN_MENU] [nvarchar](100) NULL,
	[THU_TU] [int] NULL,
	[URL] [nvarchar](200) NULL,
	[MA_NHOM_MEMU] [int] NULL,
 CONSTRAINT [PK__MENU__0B817E6E47DBAE45] PRIMARY KEY CLUSTERED 
(
	[MA_MENU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MODULE]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[TEN_THAMSO] [nvarchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHOM_HINH]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOM_HINH](
	[MANHOM_HINH] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TENNHOM_HINH] [nvarchar](100) NULL,
	[AVATAR] [nvarchar](150) NULL,
	[URL] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHOM_MENU]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOM_MENU](
	[MA_NHOM_MENU] [int] IDENTITY(1,1) NOT NULL,
	[MA_TRANG_THAI] [int] NULL,
	[TEN_NHOM_MENU] [nvarchar](100) NULL,
	[MA_NHOM_MENU_CHA] [int] NULL,
 CONSTRAINT [PK__NHOM_MEN__517597A84316F928] PRIMARY KEY CLUSTERED 
(
	[MA_NHOM_MENU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NHOM_SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOM_SANPHAM](
	[MANHOM_SANPHAM] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TENNHOM_SANPHAM] [nvarchar](100) NULL,
	[URL] [ntext] NULL,
	[THUTU] [numeric](5, 0) NULL,
	[MANHOM_CHA] [int] NULL,
	[SLIDE_SHOW] [bit] NULL,
	[AVATAR] [nvarchar](150) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QUANTRI_TAIKHOAN]    Script Date: 15/03/2017 11:05:37 AM ******/
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
	[AVATAR] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[MA_ROLE] [int] NOT NULL,
	[TEN_ROLE] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MA_SANPHAM] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_SANPHAM] [nvarchar](300) NOT NULL,
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
	[MA_NHOM_SAN_PHAM] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SANPHAM_CHITIET]    Script Date: 15/03/2017 11:05:37 AM ******/
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
/****** Object:  Table [dbo].[SANPHAM_TEMP]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM_TEMP](
	[MA_SANPHAM] [int] NOT NULL,
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_SANPHAM] [nvarchar](300) NOT NULL,
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
	[MA_NHOM_SAN_PHAM] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THONGTINCHUNG]    Script Date: 15/03/2017 11:05:37 AM ******/
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
/****** Object:  Table [dbo].[TRANGTHAI]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHAI](
	[MA_TRANGTHAI] [int] NOT NULL,
	[TEN_TRANGTHAI] [nvarchar](100) NULL,
	[MOTA] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TRANGTHAI_DONHANG]    Script Date: 15/03/2017 11:05:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHAI_DONHANG](
	[MA_TRANGTHAI_DONHANG] [int] NOT NULL,
	[TEN_TRANGTHAI_DONHANG] [nvarchar](100) NULL,
	[MOTA_TRANGTHAI_DONHANG] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[LUOTTRUYCAP] ON 

INSERT [dbo].[LUOTTRUYCAP] ([ID], [THOIGIAN], [SOTRUYCAP]) VALUES (1, CAST(0x0000A733016C2051 AS DateTime), 22)
INSERT [dbo].[LUOTTRUYCAP] ([ID], [THOIGIAN], [SOTRUYCAP]) VALUES (2, CAST(0x0000A73400ABC471 AS DateTime), 3)
INSERT [dbo].[LUOTTRUYCAP] ([ID], [THOIGIAN], [SOTRUYCAP]) VALUES (3, CAST(0x0000A7350115BB52 AS DateTime), 11)
INSERT [dbo].[LUOTTRUYCAP] ([ID], [THOIGIAN], [SOTRUYCAP]) VALUES (4, CAST(0x0000A73600995472 AS DateTime), 3)
INSERT [dbo].[LUOTTRUYCAP] ([ID], [THOIGIAN], [SOTRUYCAP]) VALUES (5, CAST(0x0000A73700B3A835 AS DateTime), 7)
SET IDENTITY_INSERT [dbo].[LUOTTRUYCAP] OFF
SET IDENTITY_INSERT [dbo].[MENU] ON 

INSERT [dbo].[MENU] ([MA_MENU], [MA_TRANG_THAI], [TEN_MENU], [THU_TU], [URL], [MA_NHOM_MEMU]) VALUES (1, 1, N'Trang chủ', 1, N'~/Trang-chu', 1)
INSERT [dbo].[MENU] ([MA_MENU], [MA_TRANG_THAI], [TEN_MENU], [THU_TU], [URL], [MA_NHOM_MEMU]) VALUES (2, 1, N'Liên hệ', 3, N'~/Lien-he', 1)
INSERT [dbo].[MENU] ([MA_MENU], [MA_TRANG_THAI], [TEN_MENU], [THU_TU], [URL], [MA_NHOM_MEMU]) VALUES (3, 1, N'Giới thiệu', 2, N'~/Gioi-thieu', 1)
SET IDENTITY_INSERT [dbo].[MENU] OFF
SET IDENTITY_INSERT [dbo].[NHOM_MENU] ON 

INSERT [dbo].[NHOM_MENU] ([MA_NHOM_MENU], [MA_TRANG_THAI], [TEN_NHOM_MENU], [MA_NHOM_MENU_CHA]) VALUES (1, 1, N'Menu Ngang', NULL)
SET IDENTITY_INSERT [dbo].[NHOM_MENU] OFF
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (1, 1, N'Văn Phòng Phẩm', N'~/Danh-sach-san-pham/Văn Phòng Phẩm/1', CAST(1 AS Numeric(5, 0)), 0, 1, N'~/Images/NhomSP/636249113951060449.jpg')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (2, 1, N'LapTop', N'~/Danh-sach-san-pham/lap-top/2', CAST(2 AS Numeric(5, 0)), 0, 1, N'~/Images/SanPham/dell.jpg')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (6, 1, N'Máy Fax', N'~/Danh-sach-san-pham/May-Fax/6', CAST(1 AS Numeric(5, 0)), 0, 0, N'~/Images/NhomSP/636246035451514897.jpg')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (7, 1, N'Thiết bị quang', N'~/Danh-sach-san-pham/Thiet-bi-quang/7', CAST(2 AS Numeric(5, 0)), 0, 0, N'~/Images/NhomSP/636246051684513371.png')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (8, 1, N'Máy Lạnh', N'~/Danh-sach-san-pham/May-Lanh/8', CAST(3 AS Numeric(5, 0)), 0, 0, N'~/Images/NhomSP/636247765168765464.jpg')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (9, 1, N'Điện thoại', N'~/Danh-sach-san-pham/Dien-thoai/9', CAST(4 AS Numeric(5, 0)), 0, 1, N'~/Images/NhomSP/636247774819837473.jpg')
INSERT [dbo].[NHOM_SANPHAM] ([MANHOM_SANPHAM], [MA_TRANGTHAI], [TENNHOM_SANPHAM], [URL], [THUTU], [MANHOM_CHA], [SLIDE_SHOW], [AVATAR]) VALUES (4, 1, N'TV', N'~/Danh-sach-san-pham/TV/4', CAST(4 AS Numeric(5, 0)), 0, 1, N'~/Images/NhomSP/636249114652720582.jpg')
SET IDENTITY_INSERT [dbo].[QUANTRI_TAIKHOAN] ON 

INSERT [dbo].[QUANTRI_TAIKHOAN] ([MA_TAIKHOAN], [MA_ROLE], [MA_TRANGTHAI], [HOTEN], [TAIKHOAN], [MATKHAU], [DIACHI], [DIENTHOAI], [EMAIL], [AVATAR]) VALUES (1, 0, 1, N'Võ Nhựt Minh', N'admin', N'202cb962ac59075b964b07152d234b70', N'1', N'09111111111', N'nhutminh.ptit@gmail.', N'../QuanTri/Avatar/1_admin.jpg')
INSERT [dbo].[QUANTRI_TAIKHOAN] ([MA_TAIKHOAN], [MA_ROLE], [MA_TRANGTHAI], [HOTEN], [TAIKHOAN], [MATKHAU], [DIACHI], [DIENTHOAI], [EMAIL], [AVATAR]) VALUES (2, 0, 1, N'Đoàn Thiện Chinh', N'chinh', N'202cb962ac59075b964b07152d234b70', N'1', N'09111111111', N'nhutminh.ptit@gmail.com', NULL)
INSERT [dbo].[QUANTRI_TAIKHOAN] ([MA_TAIKHOAN], [MA_ROLE], [MA_TRANGTHAI], [HOTEN], [TAIKHOAN], [MATKHAU], [DIACHI], [DIENTHOAI], [EMAIL], [AVATAR]) VALUES (3, 0, 1, N'Phan Hoài Nam', N'nam', N'202cb962ac59075b964b07152d234b70', N'1', N'09111111111', N'nhutminh.ptit@gmail.com', NULL)
SET IDENTITY_INSERT [dbo].[QUANTRI_TAIKHOAN] OFF
INSERT [dbo].[ROLE] ([MA_ROLE], [TEN_ROLE]) VALUES (0, N'super admin')
INSERT [dbo].[ROLE] ([MA_ROLE], [TEN_ROLE]) VALUES (1, N'admin')
INSERT [dbo].[ROLE] ([MA_ROLE], [TEN_ROLE]) VALUES (2, N'khác')
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (113, 1, N'Máy lạnh LG S09ENA 1 Hp', N'1 HP
ĐIỀU HOÀ 1 CHIỀU (CHỈ LÀM LNH)
MÁY LẠNH KHÔNG INVERTER
Khử mùi – Tấm lọc 3 lớp lọc sạch nhữn', CAST(145 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="rowdetail" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<aside class="picture" style="box-sizing: inherit;">
		<img alt="Máy lạnh LG S09ENA 1 Hp" data-modal="" height="340" src="https://cdn.tgdd.vn/Products/Images/2002/63560/lg-s09ena-550x160.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="550" />
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			&nbsp;</p>
		<ul class="compact-specs" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				1 HP</li>
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				ĐIỀU HO&Agrave; 1 CHIỀU (CHỈ L&Agrave;M LẠNH)</li>
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				M&Aacute;Y LẠNH KH&Ocirc;NG INVERTER</li>
		</ul>
		<ul class="describe" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khử m&ugrave;i &ndash; Tấm lọc 3 lớp&nbsp;</span>lọc sạch những phần tử g&acirc;y hại.</li>
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ ngủ đ&ecirc;m&nbsp;</span>duy tr&igrave; mức nhiệt độ ph&ugrave; hợp, cho bạn giấc ngủ ngon.</li>
			<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Tự động l&agrave;m sạch</span>&nbsp;hong kh&ocirc; d&agrave;n tản nhiệt trong v&ograve;ng 30 ph&uacute;t bằng quạt d&agrave;n lạnh.</li>
		</ul>
	</aside>
	<aside class="price_sale no-sell" style="box-sizing: inherit;">
		<div class="area_price" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			&nbsp;</div>
	</aside>
</div>
<div class="box_content" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<aside class="left_content" style="box-sizing: inherit;">
		<div class="imgnote" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<img alt="Thông số kỹ thuật Máy lạnh LG S09ENA 1 Hp" class="lazy" data-="" height="548" src="https://cdn.tgdd.vn/Products/Images/2002/63560/Kit/may-lanh-lg-s09ena.gif" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="730" /></div>
		<div class="box-article" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<article class="area_article" id="tinh-nang" style="box-sizing: inherit; border: none; margin: 0px; padding: 0px;">
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Thiết kế gọn g&agrave;ng, đẹp mắt</h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y lạnh LG S09ENA</span>&nbsp;c&oacute; k&iacute;ch thước nhỏ gọn, dễ di chuyển, th&iacute;ch hợp để đặt ở nhiều kh&ocirc;ng gian kh&aacute;c nhau m&agrave; kh&ocirc;ng sợ g&acirc;y chật chội hay vướng v&iacute;u. Kiểu d&aacute;ng m&aacute;y hiện đại, sang trọng c&ugrave;ng t&ocirc;ng m&agrave;u trắng trang nh&atilde;, gi&uacute;p điểm t&ocirc; cho ng&ocirc;i nh&agrave; của bạn. Ngo&agrave;i ra, bề mặt vỏ m&aacute;y l&aacute;ng mịn &iacute;t b&aacute;m bẩn, thuận tiện cho việc vệ sinh m&aacute;y.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Kiểu dáng và màu sắc trang nhã" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-1-7.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Kiểu dáng và màu sắc trang nhã" />Đi k&egrave;m m&aacute;y lạnh l&agrave; điều khiển từ xa với c&aacute;c n&uacute;t bấm dễ thao t&aacute;c, để người d&ugrave;ng c&oacute; thể điều khiển m&aacute;y một c&aacute;ch dễ d&agrave;ng m&agrave; kh&ocirc;ng cần di chuyển nhiều.</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&ocirc;ng suất l&agrave;m lạnh 1Hp</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Công suất 1 Hp phù hợp với căn phòng diện tích nhỏ" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-2-5.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Công suất 1 Hp phù hợp với căn phòng diện tích nhỏ" />Chọn mức c&ocirc;ng suất l&agrave;m lạnh sao cho ph&ugrave; hợp với diện t&iacute;ch ph&ograve;ng rất quan trọng, v&igrave; n&oacute; sẽ đảm bảo hiệu quả l&agrave;m lạnh tối ưu v&agrave; tr&aacute;nh l&atilde;ng ph&iacute; điện năng.&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y lạnh LG S09ENA&nbsp;</span>c&oacute; c&ocirc;ng suất l&agrave;m lạnh 1Hp sẽ ph&ugrave; hợp với những kh&ocirc;ng gian c&oacute; diện t&iacute;ch dưới 15 m<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 12px; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; height: 0px; line-height: 0; position: relative; bottom: 1ex;">2</span>, chẳng hạn như ph&ograve;ng ngủ, ph&ograve;ng l&agrave;m việc, ph&ograve;ng kh&aacute;ch nhỏ&hellip;</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&ocirc;ng nghệ khử m&ugrave;i, kh&aacute;ng khuẩn hiện đại</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Với mục đ&iacute;ch đem đến cho người d&ugrave;ng bầu kh&ocirc;ng kh&iacute; sạch sẽ trong l&agrave;nh, tr&aacute;nh những bệnh đ&aacute;ng tiếc về đường h&ocirc; hấp, LG đ&atilde; trang bị c&ocirc;ng nghệ khử m&ugrave;i, kh&aacute;ng khuẩn ti&ecirc;n tiến tr&ecirc;n&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y lạnh LG S09ENA</span>. Tấm lọc 3 lớp bắt giữ v&agrave; ti&ecirc;u diệt hiệu quả những phần tử c&oacute; hại si&ecirc;u nhỏ (bao gồm cả phấn hoa, bụi bẩn), nhờ lực tĩnh điện mạnh mẽ. Nếu gia đ&igrave;nh bạn c&oacute; người dị ứng với bụi hoặc phấn hoa, th&igrave; chiếc m&aacute;y lạnh n&agrave;y sẽ l&agrave; một giải ph&aacute;p tuyệt vời.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Mang đến cho gia đình bạn làn gió trong lành, sạch khuẩn" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-3-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Mang đến cho gia đình bạn làn gió trong lành, sạch khuẩn" />B&ecirc;n cạnh tấm lọc 3 lớp gi&uacute;p lọc sạch kh&ocirc;ng kh&iacute;,&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y lạnh LG S09ENA</span>&nbsp;c&ograve;n c&oacute; t&iacute;nh năng tự động l&agrave;m sạch. M&aacute;y sẽ tự động hong kh&ocirc; d&agrave;n tản nhiệt trong v&ograve;ng 30 ph&uacute;t bằng quạt d&agrave;n lạnh. Điều n&agrave;y gi&uacute;p ngăn chặn việc h&igrave;nh th&agrave;nh c&aacute;c loại nấm mốc, vi khuẩn v&agrave; c&aacute;c m&ugrave;i kh&oacute; chịu. Nhờ c&oacute; chức năng n&agrave;y, bạn kh&ocirc;ng cần phải l&agrave;m kh&ocirc; d&agrave;n trao đổi nhiệt v&agrave; vệ sinh m&aacute;y thường xuy&ecirc;n.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					(Xem th&ecirc;m về c&ocirc;ng nghệ l&agrave;m lạnh khử m&ugrave;i tr&ecirc;n m&aacute;y lạnh LG).</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">L&agrave;m lạnh nhanh c&ugrave;ng khả năng đảo chiều gi&oacute; linh hoạt</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					T&iacute;nh năng l&agrave;m lạnh nhanh Jet Cool l&agrave; một c&ocirc;ng nghệ nổi bật của LG v&agrave; được ứng dụng nhiều tr&ecirc;n c&aacute;c d&ograve;ng m&aacute;y lạnh của h&atilde;ng, trong đ&oacute; c&oacute;&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y lạnh LG S09ENA</span>. C&ocirc;ng nghệ n&agrave;y cho ph&eacute;p m&aacute;y lạnh giảm nhanh 5<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 12px; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; height: 0px; line-height: 0; position: relative; bottom: 1ex;">0</span>C chỉ trong 3 ph&uacute;t (&aacute;p dụng ph&ograve;ng c&oacute; rộng 2.5m) nhờ tăng cường tốc độ quạt, gi&uacute;p bạn c&oacute; được nhiệt độ ph&ograve;ng như &yacute; muốn m&agrave; kh&ocirc;ng cần chờ đợi qu&aacute; l&acirc;u. Nhờ c&oacute; chế độ n&agrave;y, bạn sẽ nhanh ch&oacute;ng c&oacute; được l&agrave;n gi&oacute; m&aacute;t l&agrave;nh dễ chịu, xua tan những mệt mỏi thường ng&agrave;y.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Giảm 50C chỉ trong vòng 3 phút" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-4-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Giảm 50C chỉ trong vòng 3 phút" />B&ecirc;n cạnh khả năng l&agrave;m lạnh nhanh, m&aacute;y lạnh c&ograve;n c&oacute; khả năng đảo chiều gi&oacute; linh hoạt 4 hướng: l&ecirc;n/xuống, tr&aacute;i/phải. Hơi lạnh toả ra sẽ lan tỏa khắp căn ph&ograve;ng, gi&uacute;p l&agrave;m lạnh đều để d&ugrave; bạn ngồi ở vị tr&iacute; n&agrave;o cũng cảm thấy m&aacute;t mẻ dễ chịu. Ngo&agrave;i t&iacute;nh năng đảo gi&oacute; tự động, người d&ugrave;ng c&ograve;n c&oacute; thể chủ động điều khiển hướng gi&oacute; theo nhu cầu, sao cho cảm thấy thuận tiện v&agrave; thoải m&aacute;i nhất (tự động đảo l&ecirc;n xuống- tr&aacute;i phải chỉnh tay).</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ ngủ đ&ecirc;m cho bạn giấc ngủ s&acirc;u dễ chịu</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Chế độ ngủ đêm cho giấc ngủ thoải mái" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-5-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Chế độ ngủ đêm cho giấc ngủ thoải mái" />V&agrave;o ban đ&ecirc;m khi ch&uacute;ng ta đi ngủ, chỉ cần nhiệt độ ph&ograve;ng kh&ocirc;ng ph&ugrave; hợp, qu&aacute; lạnh hoặc qu&aacute; n&oacute;ng đều sẽ tạo cảm gi&aacute;c kh&ocirc;ng thoải m&aacute;i v&agrave; thậm ch&iacute; c&ograve;n c&oacute; thể ảnh hưởng đến sức khỏe. Hiểu được vấn đề n&agrave;y, LG đ&atilde; trang bị chế độ ngủ đ&ecirc;m tr&ecirc;n&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y lạnh LG S09ENA</span>. Khi bật chế độ n&agrave;y, n&aacute;y n&eacute;n v&agrave; động cơ quạt cục trong sẽ vận h&agrave;nh, kiểm so&aacute;t tốc độ để duy tr&igrave; nhiệt độ ph&ugrave; hợp trong ph&ograve;ng, gi&uacute;p bạn c&oacute; một giấc ngủ thật thoải m&aacute;i.</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ hẹn giờ v&agrave; t&iacute;nh năng tự khởi động lại khi c&oacute; điện</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					M&aacute;y lạnh được trang bị t&iacute;nh năng hẹn giờ, để người d&ugrave;ng c&oacute; thể chủ động c&agrave;i đặt thời gian bật tắt m&aacute;y lạnh theo nhu cầu, th&oacute;i quen sử dụng. Chế độ n&agrave;y sẽ gi&uacute;p sử dụng m&aacute;y lạnh hiệu quả, tr&aacute;nh l&atilde;ng ph&iacute; điện v&agrave; đặc biệt hữu &iacute;ch v&agrave;o ban đ&ecirc;m.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="Hẹn giờ để tránh lãng phí điện năng" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/63560/may-lanh-lg-s09ena-6-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Hẹn giờ để tránh lãng phí điện năng" />B&ecirc;n cạnh đ&oacute;, m&aacute;y c&ograve;n c&oacute; t&iacute;nh năng tự khởi động lại khi c&oacute; điện. Sau khi mất điện v&agrave; m&aacute;y lạnh sẽ ngừng hoạt động, người d&ugrave;ng c&oacute; thể sẽ kh&ocirc;ng để &yacute; hoặc qu&ecirc;n mất việc c&oacute; điện lại. T&iacute;nh năng tự khở động lại sẽ gi&uacute;p m&aacute;y lạnh tiếp tục vận h&agrave;nh sau khi c&oacute; điện, để bạn c&oacute; thể tận hưởng ngay l&agrave;n gi&oacute; m&aacute;t mẻ.</p>
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y lạnh vận h&agrave;nh &ecirc;m &aacute;i, an to&agrave;n, bền bỉ</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Trong qu&aacute; tr&igrave;nh hoạt động, động cơ m&aacute;y lạnh chạy &ecirc;m &aacute;i, kh&ocirc;ng tạo ra những &acirc;m thanh kh&oacute; chịu. B&ecirc;n cạnh đ&oacute;, bề mặt của d&agrave;n tản nhiệt được mạ lớp vật liệu Hydropholic v&agrave;ng c&oacute; khả năng chống ăn m&ograve;n tối đa l&agrave;m tăng tuổi thọ, duy tr&igrave; hiệu quả của tấm tản nhiệt. Nhờ đ&oacute;, m&aacute;y c&oacute; độ bền cao, gi&uacute;p bạn tiết kiệm được chi ph&iacute;.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Với khả năng l&agrave;m lạnh lạnh, khử m&ugrave;i hiệu quả c&ugrave;ng nhiều t&iacute;nh năng hữu &iacute;ch,&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y lạnh LG S09ENA&nbsp;</span>sẽ l&agrave; một sản phẩm l&agrave;m bạn h&agrave;i l&ograve;ng. Hơn nữa, m&aacute;y lạnh c&oacute; mức gi&aacute; dễ chịu, xứng đ&aacute;ng để bạn chọn mua cho gia đ&igrave;nh m&igrave;nh.</p>
			</article>
		</div>
	</aside>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/May-lanh-LG-S09ENA-1-Hp/113', CAST(5125500 AS Decimal(10, 0)), N'~/Images/SanPham/636247772178346389.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (114, 1, N'MÁY LẠNH TOSHIBA 1 HP RAS-H10S3KS-V', N'1 HP
ĐIỀU HOÀ 1 CHIỀU (CHỈ LÀM LẠNH)
MÁY LẠNH KHÔNG INVERTER
Bộ lọc Toshiba IAQ ngăn chặn sự phát', CAST(144 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="imgnote" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<img alt="Thông số kỹ thuật Máy lạnh Toshiba 1 HP RAS-H10S3KS-V" class="lazy" data-="" height="548" src="https://cdn.tgdd.vn/Products/Images/2002/71257/Kit/may-lanh-toshiba-ras-h10s3ks-v-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="730" /></div>
<div class="box-article" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<article class="area_article" id="tinh-nang" style="box-sizing: inherit; border: none; margin: 0px; padding: 0px;">
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			M&aacute;y lạnh c&oacute; thiết kế đẹp mắt c&ugrave;ng c&ocirc;ng nghệ ti&ecirc;n tiến</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh Toshiba 1 HP RAS-H10S3KS-V đến từ thương hiệu Toshiba, c&oacute; thiết kế trắng đơn giản dễ d&agrave;ng phối với tất cả c&aacute;c kh&ocirc;ng gian nội thất kh&aacute;c nhau. Thuộc d&ograve;ng m&aacute;y lạnh th&ocirc;ng thường, c&oacute; mức gi&aacute; v&ocirc; c&ugrave;ng phải chăng, ph&ugrave; hợp với hầu hết người ti&ecirc;u d&ugrave;ng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Máy lạnh có thiết kế đẹp mắt cùng công nghệ tiên tiến" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-1-6.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Máy lạnh có thiết kế đẹp mắt cùng công nghệ tiên tiến" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Phạm vi l&agrave;m lạnh</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh c&oacute;&nbsp;c&ocirc;ng suất l&agrave;m lạnh 1 HP, cho phạm vi l&agrave;m lạnh hiệu quả từ dưới 15 m2.&nbsp;Ph&ugrave; hợp với ph&ograve;ng ngủ, ph&ograve;ng l&agrave;m việc nhỏ.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Phạm vi làm lạnh" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-2-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Phạm vi làm lạnh" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			L&agrave;m lạnh nhanh</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh c&oacute; t&iacute;nh năng&nbsp;l&agrave;m lạnh nhanh&nbsp;Hi Power, cho ph&eacute;p đạt đến nhiệt độ m&agrave; bạn mong muốn trong thời gian ngắn. Bạn chỉ cần nhấn n&uacute;t Hi Power tr&ecirc;n điều khiển để tạo luồng gi&oacute; thổi cực mạnh v&agrave; mang đến hơi lạnh nhanh hơn chế độ th&ocirc;ng thường.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Làm lạnh nhanh" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-6-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Làm lạnh nhanh" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Tiết kiệm điện với n&uacute;t bấm Eco</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Chỉ với một n&uacute;t bấm Eco từ điều khiển m&aacute;y lạnh, m&aacute;y sẽ đạt đến mức tiết kiệm đến 25% so với c&agrave;i đặt ti&ecirc;u chuẩn nhờ điều chỉnh giảm c&ocirc;ng suất m&aacute;y m&agrave; kh&ocirc;ng l&agrave;m mất đi sự thoải m&aacute;i.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Lưu &yacute;: thời gian để đưa nhiệt độ ph&ograve;ng đạt đến nhiệt độ c&agrave;i đặt sẽ l&acirc;u hơn khi sử dụng t&iacute;nh năng n&agrave;y.</span></p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Tính năng Eco tiết kiệm điện năng" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-7-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Tính năng Eco tiết kiệm điện năng" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Bộ lọc Toshiba IAQ</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Bộ lọc&nbsp;Toshiba IAQ c&oacute; khả năng ngăn chặn sự ph&aacute;t triển của vi khuẩn v&agrave; vi r&uacute;t. C&oacute; thể kh&aacute;ng vi r&uacute;t c&uacute;m gia cầm (H5N1) v&agrave; ti&ecirc;u diệt đến 99,9% vi khuẩn, đồng thời c&ograve;n gi&uacute;p ức chế sự h&igrave;nh th&agrave;nh của nấm mốc, hấp thụ v&agrave; ph&acirc;n hủy kh&oacute;i, kh&iacute; amoniac, chất hữu cơ dễ bay hơi, thực phẩm c&oacute; m&ugrave;i v&agrave; c&aacute;c m&ugrave;i h&ocirc;i kh&aacute;c.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Bộ lọc Toshiba IAQ" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-3-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Bộ lọc Toshiba IAQ" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Bộ lọc chống nấm mốc</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Bộ lọc hiệu suất cao c&oacute; nhiệm vụ lọc bụi cho kh&ocirc;ng gian ph&ograve;ng lu&ocirc;n sạch sẽ v&agrave; tươi m&aacute;t. Bộ lọc n&agrave;y c&oacute; thể th&aacute;o rời một c&aacute;ch dễ d&agrave;ng, tiện cho việc&nbsp;vệ sinh&nbsp;m&aacute;y.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Bộ lọc chống nấm mốc" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-4-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Bộ lọc chống nấm mốc" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			T&iacute;nh năng tự l&agrave;m sạch</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Chức năng n&agrave;y được thiết kế để l&agrave;m giảm độ ẩm l&agrave; m&ocirc;i trường sinh ra nấm mốc. Sau khi tắt m&aacute;y, quạt b&ecirc;n trong sẽ tự động k&iacute;ch hoạt để l&agrave;m kh&ocirc; ho&agrave;n to&agrave;n b&ecirc;n trong d&agrave;n lạnh gi&uacute;p giảm độ ẩm, tr&aacute;nh sự h&igrave;nh th&agrave;nh nấm mốc, &nbsp;giữ m&ocirc;i trường trong l&agrave;nh một c&aacute;ch tự nhi&ecirc;n.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Tính năng tự làm sạch" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/71257/may-lanh-toshiba-ras-h10s3ks-v-5-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Tính năng tự làm sạch" /></p>
	</article>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/MAY-LANH-TOSHIBA-1-HP-RAS-H10S3KS-V/114', CAST(7505000 AS Decimal(10, 0)), N'~/Images/SanPham/636247773056976644.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (115, 1, N'Điện thoại KX-TS500', N'Nhà sản xuất: Panasonic
Mã hàng: KX-TS500
Trạng thái: Còn hàng
Bảo hành: 12 Tháng', CAST(150 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&ocirc; tả ngắn:</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Điện thoại cố định chức năng cơ bản</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&ocirc; tả chi tiết:</span></p>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Điện thoại cố định để b&agrave;n</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Gọi lại số cuối c&ugrave;ng</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		4 mức điều chỉnh &acirc;m lượng tay cầm</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Chức năng chuyển m&aacute;y</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Chế độ Tone/Pulse</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		3 mức điều chỉnh &acirc;m lượng chu&ocirc;ng reo (cao, thấp, tắt chu&ocirc;ng)</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		C&oacute; 5 m&agrave;u để lựa chọn : Đen,trắng,xanh,x&aacute;m,đỏ</li>
</ul>
', 1, N'~/Chi-tiet-san-pham/Dien-thoai-KX-TS500/115', CAST(240000 AS Decimal(10, 0)), N'~/Images/SanPham/636247775675736428.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (116, 1, N'Panasonic KX – T7703 CX', N'', CAST(151 AS Numeric(5, 0)), N'<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(127, 126, 126);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh hiển thị LCD 16 k&yacute; tự</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhật k&yacute; cuộc gọi : 30 số</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&oacute; 3 cấp điều chỉnh chu&ocirc;ng</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Quay lại số gần nhất : 5 số</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&oacute; thể thay đổi Flash time</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ quay số : Tone &amp; Fulse</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">2 m&agrave;u : Đen &amp; Trắng</span></li>
</ul>
', 1, N'~/Chi-tiet-san-pham/Panasonic-KX-–-T7703-CX/116', CAST(500000 AS Decimal(10, 0)), N'~/Images/SanPham/636247776150743597.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (117, 1, N'Panasonic KX – T7705 CX', N'', CAST(152 AS Numeric(5, 0)), N'<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(127, 126, 126);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh hiển thị LCD 16 k&yacute; tự</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhật k&yacute; cuộc gọi : 30 số</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&oacute; 3 cấp điều chỉnh chu&ocirc;ng</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Quay lại số gần nhất : 5 số</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&oacute; thể thay đổi Flash time</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ quay số : Tone &amp; Fulse</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">2 m&agrave;u : Đen &amp; Trắng</span></li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">C&oacute; thể treo tường</span></li>
</ul>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-–-T7705-CX/117', CAST(680000 AS Decimal(10, 0)), N'~/Images/SanPham/636247777012732900.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (118, 1, N'Panasonic KX-TGA20', N'Thiết bị tìm kiếm, kết nối với KX-TGD310, KX-TGF310. KX-TGF320', CAST(153 AS Numeric(5, 0)), N'<p>
	<img src="http://banhangtannoi.com/wp-content/uploads/2017/02/a-150x150.jpg" /></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGA20/118', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636247777772106334.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (119, 1, N'Panasonic KX-TGA641', N'', CAST(154 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);"><u style="box-sizing: inherit;">&nbsp;</u></span><span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Tay con d&ugrave;ng để mở rộng cho m&aacute;y KX-TG 6451/6461.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGA641/119', CAST(970000 AS Decimal(10, 0)), N'~/Images/SanPham/636247778525239410.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (120, 1, N'Panasonic KX-TGB110CX', N'', CAST(155 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.4&rdquo; hiển thị r&otilde; n&eacute;t</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Đ&egrave;n m&agrave;n h&igrave;nh m&agrave;u cam.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 50 t&ecirc;n v&agrave; số</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Hiển thị 20 số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">2 số gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhiều ng&ocirc;n ngữ để lựa chọn</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng c&acirc;m tiếng, kh&oacute;a m&aacute;y</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Thời gian thoại l&ecirc;n tới 10h, thời gian chờ 200h</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng chuyển cuộc gọi, đ&agrave;m thoại giữa c&aacute;c tay con.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGB110CX/120', CAST(810000 AS Decimal(10, 0)), N'~/Images/SanPham/636247779112322990.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (121, 1, N'Panasonic KX-TGB112 CX', N'', CAST(156 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGB112-CX/121', CAST(1300000 AS Decimal(10, 0)), N'~/Images/SanPham/636247779561988709.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (122, 1, N'Panasonic KX-TGC210 CX', N'', CAST(157 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.6&rdquo; hiển thị r&otilde; n&eacute;t, đ&egrave;n m&agrave;n h&igrave;nh m&agrave;u cam.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 50 t&ecirc;n v&agrave; số, chia sẻ danh bạ giữa c&aacute;c tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Hiển thị 50 số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">6 số gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Đ&agrave;m thoại 3 b&ecirc;n</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Loa ngo&agrave;i 2 chiều</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết n&oacute;i với repeater mở rộng phạm vi ph&aacute;t s&oacute;ng</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Trả lời bằng ph&iacute;m bất k&igrave;</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhiều ng&ocirc;n ngữ để lựa chọn</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng kh&oacute;a m&aacute;y, c&acirc;m tiếng, chặn cuộc gọi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng b&aacute;o thức</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Thời gian thoại l&ecirc;n tới 16h, thời gian chờ 200h</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng mở rộng l&ecirc;n tới 6 tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng chuyển cuộc gọi, đ&agrave;m thoại giữa c&aacute;c tay con.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGC210-CX/122', CAST(950000 AS Decimal(10, 0)), N'~/Images/SanPham/636247780236497289.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (123, 1, N'Panasonic KX-TGC212 CX', N'', CAST(158 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Bộ Dect 2 tay giống KX-TGC210</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGC212-CX/123', CAST(1500000 AS Decimal(10, 0)), N'~/Images/SanPham/636247780698533716.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (124, 1, N'Panasonic KX-TGC310 CX', N'', CAST(159 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.6&rdquo; hiển thị r&otilde; n&eacute;t.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 50 t&ecirc;n v&agrave; số</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Hiển thị số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">6 ph&iacute;m gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Đ&agrave;m thoại 3 b&ecirc;n</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Loa ngo&agrave;i hai chiều</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết n&oacute;i với repeater mở rộng phạm vi ph&aacute;t s&oacute;ng</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Trả lời bằng ph&iacute;m bất k&igrave;</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhiều ng&ocirc;n ngữ để lựa chọn</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng kh&oacute;a m&aacute;y</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Thời gian thoại l&ecirc;n tới 16h, thời gian chờ 200h</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chức năng chuyển cuộc gọi, đ&agrave;m thoại giữa c&aacute;c tay con.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng mở rộng l&ecirc;n tới 6 tay con</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGC310-CX/124', CAST(950000 AS Decimal(10, 0)), N'~/Images/SanPham/636247781298738045.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (125, 1, N'Panasonic KX-TGC312 CX', N'', CAST(160 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Bộ Dect 2 tay giống KX-TGC310</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGC312-CX/125', CAST(1500000 AS Decimal(10, 0)), N'~/Images/SanPham/636247781736223068.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (126, 1, N'Panasonic KX-TGC313 CX', N'', CAST(161 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Bộ Dect 3 tay giống KX-TGC310</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGC313-CX/126', CAST(1950000 AS Decimal(10, 0)), N'~/Images/SanPham/636247782841766302.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (127, 1, N'Panasonic KX-TGD310 CX', N'', CAST(162 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.8&rdquo; hiển thị r&otilde; n&eacute;t.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 120 t&ecirc;n v&agrave; số</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Lưu 50 số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chia sẻ danh bạ giữa c&aacute;c tay con (với KX-TGD312)</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">9 số gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Loa ngo&agrave;i hai chiều</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ quản l&yacute; trẻ nhỏ</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết nối với 4 thiết bị t&igrave;m kiếm KX-TGA20 (TGA20 l&agrave; thiết bị kết nối th&ecirc;m, kh&ocirc;ng k&egrave;m theo m&aacute;y)</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết n&oacute;i với repeater mở rộng phạm vi ph&aacute;t s&oacute;ng</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Mất điện d&ugrave;ng được</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng mở rộng l&ecirc;n tới 6 tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ kh&oacute;a m&aacute;y, chống l&agrave;m phiền</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Thời gian thoại l&ecirc;n tới 16h, thời gian chờ 200h</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chặn cuộc gọi từ những số điện thoại kh&ocirc;ng mong muốn.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGD310-CX/127', CAST(1150000 AS Decimal(10, 0)), N'~/Images/SanPham/636247783779099914.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (128, 1, N'Panasonic KX-TGD312 CX', N'', CAST(163 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Bộ Dect 2 tay giống KX-TGD312</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGD312-CX/128', CAST(1840000 AS Decimal(10, 0)), N'~/Images/SanPham/636247784349072515.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (129, 1, N'Panasonic KX-TGDA30CX', N'', CAST(164 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);"><u style="box-sizing: inherit;">&nbsp;</u></span><span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">Tay con mở rộng.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGDA30CX/129', CAST(990000 AS Decimal(10, 0)), N'~/Images/SanPham/636247784746575250.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (130, 1, N'Panasonic KX-TGF310 CX', N'', CAST(165 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;"><u style="box-sizing: inherit;">Panasonic KX-TGF310 CX</u></span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;"><u style="box-sizing: inherit;">&nbsp;</u></span><span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.8&rdquo; hiển thị r&otilde; n&eacute;t.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 100 t&ecirc;n v&agrave; số</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Lưu 50 số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chia sẻ danh bạ giữa&nbsp; m&aacute;y mẹ v&agrave; tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">9 ph&iacute;m gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Loa ngo&agrave;i hai chiều tr&ecirc;n tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ quản l&yacute; trẻ nhỏ</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết nối với 4 thiết bị t&igrave;m kiếm KX-TGA20 (TGA20 l&agrave; thiết bị kết nối th&ecirc;m, kh&ocirc;ng k&egrave;m theo m&aacute;y)</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết n&oacute;i với repeater mở rộng phạm vi ph&aacute;t s&oacute;ng</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Mất điện d&ugrave;ng được</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Bảo mật cuộc gọi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ kh&oacute;a m&aacute;y, chống l&agrave;m phiền</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chặn cuộc gọi từ những số điện thoại kh&ocirc;ng mong muốn.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGF310-CX/130', CAST(2160000 AS Decimal(10, 0)), N'~/Images/SanPham/636247785709920351.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (131, 1, N'Panasonic KX-TGF320 CX', N'', CAST(166 AS Numeric(5, 0)), N'<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;n h&igrave;nh LCD 1.8&rdquo; hiển thị r&otilde; n&eacute;t.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Danh bạ lưu 100 t&ecirc;n v&agrave; số</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Lưu 50 số gọi đến*</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Nhớ 10 số gọi đi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chia sẻ danh bạ giữa&nbsp; m&aacute;y mẹ v&agrave; tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">9 ph&iacute;m gọi nhanh</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Loa ngo&agrave;i hai chiều tr&ecirc;n tay con</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ quản l&yacute; trẻ nhỏ</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết nối với 4 thiết bị t&igrave;m kiếm KX-TGA20 (TGA20 l&agrave; thiết bị kết nối th&ecirc;m, kh&ocirc;ng k&egrave;m theo m&aacute;y)</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Khả năng kết n&oacute;i với repeater mở rộng phạm vi ph&aacute;t s&oacute;ng</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Mất điện d&ugrave;ng được</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Bảo mật cuộc gọi</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chế độ kh&oacute;a m&aacute;y, chống l&agrave;m phiền</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Chặn cuộc gọi từ những số điện thoại kh&ocirc;ng mong muốn.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Hệ thống trả lời tự động v&agrave; ghi &acirc;m lời nhắn (chỉ c&oacute; ở KX-TGF320)</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TGF320-CX/131', CAST(2360000 AS Decimal(10, 0)), N'', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (132, 1, N'Panasonic KX-TS 820', N'', CAST(167 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&ndash; C&oacute; n&uacute;t điều chỉnh &acirc;m lượng<br style="box-sizing: inherit;" />
	&ndash; C&oacute; 4 mức điều chỉnh &acirc;m lượng<br style="box-sizing: inherit;" />
	&ndash; Quay số nhanh (10 số)<br style="box-sizing: inherit;" />
	&ndash; Gọi nhanh bằng 1 ph&iacute;m &ndash; ph&iacute;m nhớ (20 số)<br style="box-sizing: inherit;" />
	&ndash; Đ&egrave;n b&aacute;o cuộc gọi<br style="box-sizing: inherit;" />
	&ndash; Chế độ kho&aacute; ph&iacute;m bằng m&atilde;</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS-820/132', CAST(400000 AS Decimal(10, 0)), N'~/Images/SanPham/636247787007124546.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (133, 1, N'Panasonic KX-TS520', N'', CAST(168 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&ndash; 3 số gọi nhanh (bằng một ph&iacute;m bấm)<br style="box-sizing: inherit;" />
	&ndash; 3 mức &acirc;m lượng chu&ocirc;ng<br style="box-sizing: inherit;" />
	&ndash; Gọi lại số gần nhất<br style="box-sizing: inherit;" />
	&ndash; Đ&egrave;n b&aacute;o cuộc gọi đến.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS520/133', CAST(330000 AS Decimal(10, 0)), N'~/Images/SanPham/636247787363474928.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (134, 1, N'Panasonic KX-TS560', N'', CAST(169 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&ndash; M&agrave;n h&igrave;nh LCD hiển thị r&otilde; r&agrave;ng v&agrave; dễ đọc<br style="box-sizing: inherit;" />
	&ndash; Hiển thị số gọi đến (50 số)<br style="box-sizing: inherit;" />
	&ndash; Gọi lại 20 số gần nhất<br style="box-sizing: inherit;" />
	&ndash; Danh bạ 50 t&ecirc;n v&agrave; số điện thoại<br style="box-sizing: inherit;" />
	&ndash; Kh&oacute;a b&agrave;n ph&iacute;m bằng mật khẩu,giới hạn cụ&ocirc;c gọi</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS560/134', CAST(580000 AS Decimal(10, 0)), N'', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (135, 1, N'Panasonic KX-TS580', N'', CAST(170 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&nbsp;&ndash; M&agrave;n h&igrave;nh LCD hiển thị r&otilde; r&agrave;ng v&agrave; dễ đọc; hiển thị số gọi đến (50 số)<br style="box-sizing: inherit;" />
	&ndash; Gọi lại 20 số gần nhất<br style="box-sizing: inherit;" />
	&ndash; Danh bạ 50 t&ecirc;n v&agrave; số điện thoại<br style="box-sizing: inherit;" />
	&ndash; Kh&oacute;a b&agrave;n ph&iacute;m bằng mật khẩu,giới hạn cụ&ocirc;c gọi<br style="box-sizing: inherit;" />
	&ndash; Speakerphone 2 chiều<br style="box-sizing: inherit;" />
	&ndash; Ph&iacute;m navigator dễ sử dụng<br style="box-sizing: inherit;" />
	&ndash; Chế độ nhạc chờ cuộc gọi</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS580/135', CAST(760000 AS Decimal(10, 0)), N'~/Images/SanPham/636247788468548135.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (136, 1, N'Panasonic KX-TS880', N'', CAST(171 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&ndash; M&agrave;n h&igrave;nh LCD hiển thị số gọi đến,<br style="box-sizing: inherit;" />
	&ndash; Danh bạ 50 số, nhớ 20 số gọi đi<br style="box-sizing: inherit;" />
	&ndash; 20 ph&iacute;m gọi bằng 1 ph&iacute;m bấm,<br style="box-sizing: inherit;" />
	&ndash; 10 ph&iacute;m quay số nhanh,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; Speaker phone 2 chiều,<br style="box-sizing: inherit;" />
	&ndash; Chức năng tự động gọi lại,<br style="box-sizing: inherit;" />
	&ndash; Chế độ c&acirc;m tiến, c&oacute; nhạc chợ,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; đ&egrave;n b&aacute;o chu&ocirc;ng,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; khe cắm tai nghe 2.5</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS880/136', CAST(900000 AS Decimal(10, 0)), N'~/Images/SanPham/636247810952994172.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (137, 1, N'Panasonic KX-TS881', N'', CAST(172 AS Numeric(5, 0)), N'<p>
	<span style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">&ndash; M&agrave;n h&igrave;nh LCD hiển thị số gọi đến,<br style="box-sizing: inherit;" />
	&ndash; Danh bạ 50 số, nhớ 20 số gọi đi<br style="box-sizing: inherit;" />
	&ndash; 20 ph&iacute;m gọi bằng 1 ph&iacute;m bấm,<br style="box-sizing: inherit;" />
	&ndash; 10 ph&iacute;m quay số nhanh,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; Speaker phone 2 chiều<br style="box-sizing: inherit;" />
	&ndash; Chức năng tự động gọi lại,<br style="box-sizing: inherit;" />
	&ndash; Chế độ c&acirc;m tiếng, c&oacute; nhạc chợ,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; đ&egrave;n b&aacute;o chu&ocirc;ng,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; đ&egrave;n b&aacute;o tin nhắn voice mail,<br style="box-sizing: inherit;" />
	&ndash; C&oacute; khe cắm tai nghe</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-TS881/137', CAST(970000 AS Decimal(10, 0)), N'~/Images/SanPham/636247812876884212.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 9)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (138, 1, N'Samsung 78KS9800', N'Samsung 78KS9800', CAST(55 AS Numeric(5, 0)), N'78 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-78KS9800/138', CAST(170200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (139, 1, N'Samsung 88KS9800', N'Samsung 88KS9800', CAST(56 AS Numeric(5, 0)), N'88 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-88KS9800/139', CAST(322700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (140, 1, N'Samsung HW-K350', N'Samsung HW-K350', CAST(57 AS Numeric(5, 0)), NULL, NULL, N'~/Chi-tiet-san-pham/Samsung-HW-K350/140', CAST(2400000 AS Decimal(10, 0)), NULL, CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (141, 1, N'Samsung MX-HS7000', N'Samsung MX-HS7000', CAST(58 AS Numeric(5, 0)), NULL, NULL, N'~/Chi-tiet-san-pham/Samsung-MX-HS7000/141', CAST(7400000 AS Decimal(10, 0)), NULL, CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (142, 1, N'Samsung 24J4100', N'Samsung 24J4100', CAST(1 AS Numeric(5, 0)), N'24 inch HD', 1, N'~/Chi-tiet-san-pham/Samsung-24J4100/142', CAST(3650000 AS Decimal(10, 0)), N'~/Images/SanPham/tv24inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (143, 1, N'Samsung 32J4003', N'Samsung 32J4003', CAST(2 AS Numeric(5, 0)), N'32 inch HD', NULL, N'~/Chi-tiet-san-pham/Samsung-32J4003/143', CAST(4720000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (144, 1, N'Samsung 32J4100', N'Samsung 32J4100', CAST(3 AS Numeric(5, 0)), N'32 inch HD', NULL, N'~/Chi-tiet-san-pham/Samsung-32J4100/144', CAST(5100000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (145, 1, N'Samsung 32K4100', N'Samsung 32K4100', CAST(4 AS Numeric(5, 0)), N'32 inch HD', NULL, N'~/Chi-tiet-san-pham/Samsung-32K4100/145', CAST(4800000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (146, 1, N'Samsung 32J4303', N'Samsung 32J4303', CAST(5 AS Numeric(5, 0)), N'32 inch HD', NULL, N'~/Chi-tiet-san-pham/Samsung-32J4303/146', CAST(5820000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (147, 1, N'Samsung 32K5300', N'Samsung 32K5300', CAST(6 AS Numeric(5, 0)), N'32 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-32K5300/147', CAST(6750000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (148, 1, N'Samsung 32K5500', N'Samsung 32K5500', CAST(7 AS Numeric(5, 0)), N'32 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-32K5500/148', CAST(6900000 AS Decimal(10, 0)), N'~/Images/SanPham/tv32inch.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (149, 1, N'Samsung 40J5000', N'Samsung 40J5000', CAST(8 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40J5000/149', CAST(6470000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (150, 1, N'Samsung 40K5100', N'Samsung 40K5100', CAST(9 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40K5100/150', CAST(6800000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (151, 1, N'Samsung 40J5200', N'Samsung 40J5200', CAST(10 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40J5200/151', CAST(7650000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (152, 1, N'Samsung 40K5300', N'Samsung 40K5300', CAST(11 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40K5300/152', CAST(8200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (153, 1, N'Samsung 40K5500', N'Samsung 40K5500', CAST(12 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40K5500/153', CAST(8580000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (154, 1, N'Samsung 40K6300', N'Samsung 40K6300', CAST(13 AS Numeric(5, 0)), N'40 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-40K6300/154', CAST(10200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (155, 1, N'Samsung 40KU6000', N'Samsung 40KU6000', CAST(14 AS Numeric(5, 0)), N'40 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-40KU6000/155', CAST(9550000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (156, 1, N'Samsung 40KU6400', N'Samsung 40KU6400', CAST(15 AS Numeric(5, 0)), N'40 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-40KU6400/156', CAST(11400000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (157, 1, N'Samsung 43K5100', N'Samsung 43K5100', CAST(16 AS Numeric(5, 0)), N'43 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-43K5100/157', CAST(7100000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (158, 1, N'Samsung 43K5300', N'Samsung 43K5300', CAST(17 AS Numeric(5, 0)), N'43 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-43K5300/158', CAST(8650000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (159, 1, N'Samsung 43K5500', N'Samsung 43K5500', CAST(18 AS Numeric(5, 0)), N'43 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-43K5500/159', CAST(9250000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (160, 1, N'Samsung 43KU6000', N'Samsung 43KU6000', CAST(19 AS Numeric(5, 0)), N'43 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-43KU6000/160', CAST(10000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (161, 1, N'Samsung 43KU6400', N'Samsung 43KU6400', CAST(20 AS Numeric(5, 0)), N'43 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-43KU6400/161', CAST(11500000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (162, 1, N'Samsung 43KU6500', N'Samsung 43KU6500', CAST(21 AS Numeric(5, 0)), N'43 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-43KU6500/162', CAST(13000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (163, 1, N'Samsung 48J5000', N'Samsung 48J5000', CAST(22 AS Numeric(5, 0)), N'48 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-48J5000/163', CAST(9000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (164, 1, N'Samsung 48J5200', N'Samsung 48J5200', CAST(23 AS Numeric(5, 0)), N'48 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-48J5200/164', CAST(10650000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (165, 1, N'Samsung 49K5100', N'Samsung 49K5100', CAST(24 AS Numeric(5, 0)), N'49 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-49K5100/165', CAST(9400000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (166, 1, N'Samsung 49K5300', N'Samsung 49K5300', CAST(25 AS Numeric(5, 0)), N'49 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-49K5300/166', CAST(11200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (167, 1, N'Samsung 49K5500', N'Samsung 49K5500', CAST(26 AS Numeric(5, 0)), N'49 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-49K5500/167', CAST(12200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (168, 1, N'Samsung 49K6300', N'Samsung 49K6300', CAST(27 AS Numeric(5, 0)), N'49 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-49K6300/168', CAST(13800000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (169, 1, N'Samsung 49KS7000', N'Samsung 49KS7000', CAST(28 AS Numeric(5, 0)), N'49 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-49KS7000/169', CAST(21000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (170, 1, N'Samsung 49KS7500', N'Samsung 49KS7500', CAST(29 AS Numeric(5, 0)), N'49 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-49KS7500/170', CAST(23200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (171, 1, N'Samsung 49KU6400', N'Samsung 49KU6400', CAST(30 AS Numeric(5, 0)), N'49 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-49KU6400/171', CAST(14900000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (172, 1, N'Samsung 49KU6500', N'Samsung 49KU6500', CAST(31 AS Numeric(5, 0)), N'49 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-49KU6500/172', CAST(17250000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (173, 1, N'Samsung 50J5200', N'Samsung 50J5200', CAST(32 AS Numeric(5, 0)), N'50 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-50J5200/173', CAST(11550000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (174, 1, N'Samsung 50KU6000', N'Samsung 50KU6000', CAST(33 AS Numeric(5, 0)), N'50 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-50KU6000/174', CAST(14400000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (175, 1, N'Samsung 55K5300', N'Samsung 55K5300', CAST(34 AS Numeric(5, 0)), N'55 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-55K5300/175', CAST(15600000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (176, 1, N'Samsung 55K5500', N'Samsung 55K5500', CAST(35 AS Numeric(5, 0)), N'55 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-55K5500/176', CAST(15800000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (177, 1, N'Samsung 55K6300', N'Samsung 55K6300', CAST(36 AS Numeric(5, 0)), N'55 inch FHD', NULL, N'~/Chi-tiet-san-pham/Samsung-55K6300/177', CAST(18200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (178, 1, N'Samsung 55KU6100', N'Samsung 55KU6100', CAST(37 AS Numeric(5, 0)), N'55 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KU6100/178', CAST(27700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (179, 1, N'Samsung 55KS7000', N'Samsung 55KS7000', CAST(38 AS Numeric(5, 0)), N'55 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KS7000/179', CAST(34100000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (180, 1, N'Samsung 55KS7500', N'Samsung 55KS7500', CAST(39 AS Numeric(5, 0)), N'55 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KS7500/180', CAST(39800000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (181, 1, N'Samsung 55KS9000', N'Samsung 55KS9000', CAST(40 AS Numeric(5, 0)), N'55 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KS9000/181', CAST(44200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (182, 1, N'Samsung 55KU6000', N'Samsung 55KU6000', CAST(41 AS Numeric(5, 0)), N'55 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KU6000/182', CAST(19200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (183, 1, N'Samsung 55KU6400', N'Samsung 55KU6400', CAST(42 AS Numeric(5, 0)), N'55 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KU6400/183', CAST(25700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (184, 1, N'Samsung 55KU6500', N'Samsung 55KU6500', CAST(43 AS Numeric(5, 0)), N'55 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55KU6500/184', CAST(25000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (185, 1, N'Samsung 55JU7500', N'Samsung 55JU7500', CAST(44 AS Numeric(5, 0)), N'55 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-55JU7500/185', CAST(30400000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (186, 1, N'Samsung 60KS7000', N'Samsung 60KS7000', CAST(45 AS Numeric(5, 0)), N'60 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-60KS7000/186', CAST(37700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (187, 1, N'Samsung 60KU6000', N'Samsung 60KU6000', CAST(46 AS Numeric(5, 0)), N'60 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-60KU6000/187', CAST(23000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (188, 1, N'Samsung 65KU6500', N'Samsung 65KU6500', CAST(47 AS Numeric(5, 0)), N'65 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-65KU6500/188', CAST(48000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (189, 1, N'Samsung 65KS7500', N'Samsung 65KS7500', CAST(48 AS Numeric(5, 0)), N'65 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-65KS7500/189', CAST(65700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (190, 1, N'Samsung 65KS9000', N'Samsung 65KS9000', CAST(49 AS Numeric(5, 0)), N'65 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-65KS9000/190', CAST(67700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (191, 1, N'Samsung 65KU6000', N'Samsung 65KU6000', CAST(50 AS Numeric(5, 0)), N'65 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-65KU6000/191', CAST(31200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (192, 1, N'Samsung 65KU6400', N'Samsung 65KU6400', CAST(51 AS Numeric(5, 0)), N'65 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-65KU6400/192', CAST(35200000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (193, 1, N'Samsung 70KU6000', N'Samsung 70KU6000', CAST(52 AS Numeric(5, 0)), N'70 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-70KU6000/193', CAST(43000000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (194, 1, N'Samsung 78KU6500', N'Samsung 78KU6500', CAST(53 AS Numeric(5, 0)), N'78 inch UHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-78KU6500/194', CAST(72500000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (195, 1, N'Samsung 78KS9000', N'Samsung 78KS9000', CAST(54 AS Numeric(5, 0)), N'78 inch SUHD 4K', NULL, N'~/Chi-tiet-san-pham/Samsung-78KS9000/195', CAST(151700000 AS Decimal(10, 0)), N'~/Images/SanPham/tvkhac.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 4)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (196, 1, N'Giấy  fax SAKURA  210mm', N'Giấy  fax SAKURA  210mm', CAST(1 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay--fax-SAKURA--210mm/196', CAST(67000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp1.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (197, 1, N'Giấy  fax SAKURA  216mm', N'Giấy  fax SAKURA  216mm', CAST(2 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay--fax-SAKURA--216mm/197', CAST(72000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp1.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (198, 1, N'Giấy Note (1,5x2)''''', N'Giấy Note (1,5x2)''''', CAST(3 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-(1,5x2)''''/198', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp2.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (199, 1, N'Giấy Note (3x2)''''', N'Giấy Note (3x2)''''', CAST(4 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-(3x2)''''/199', CAST(2500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp2.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (200, 1, N'Giấy Note (3x3)''''', N'Giấy Note (3x3)''''', CAST(5 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-(3x3)''''/200', CAST(3000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp2.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (201, 1, N'Giấy Note (3x4)''''', N'Giấy Note (3x4)''''', CAST(6 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-(3x4)''''/201', CAST(3500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp2.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (202, 1, N'Giấy Note (3x5)''''', N'Giấy Note (3x5)''''', CAST(7 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-(3x5)''''/202', CAST(3000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp2.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (203, 1, N'Giấy Note 4 màu dạ quang', N'Giấy Note 4 màu dạ quang', CAST(8 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-4-mau-da-quang/203', CAST(3000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp3.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (204, 1, N'Giấy Note 5 màu dạ quang', N'Giấy Note 5 màu dạ quang', CAST(9 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-Note-5-mau-da-quang/204', CAST(4500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp4.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (205, 1, N'Giấy bìa thơm A4/180  ', N'Giấy bìa thơm A4/180  ', CAST(10 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-bia-thom-A4180/205', CAST(13500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp5.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (206, 1, N'Giấy for màu - A4 70gr', N'Giấy for màu - A4 70gr', CAST(11 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-for-mau---A4-70gr/206', CAST(32000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp6.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (207, 1, N'Giấy for màu - A4 80 gr', N'Giấy for màu - A4 80 gr', CAST(12 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-for-mau---A4-80-gr/207', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp6.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (208, 1, N'Giấy for màu - A5 70 gr ', N'Giấy for màu - A5 70 gr ', CAST(13 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Giay-for-mau---A5-70-gr/208', CAST(8500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp6.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (209, 1, N' Bút bi TL08 ', N' Bút bi TL08 ', CAST(14 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/-But-bi-TL08/209', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp7.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (210, 1, N' Bút bi TL023 ', N' Bút bi TL023 ', CAST(15 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/-But-bi-TL023/210', CAST(6500 AS Decimal(10, 0)), N'~/Images/SanPham/vpp8.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (211, 1, N' Bút bi TL025  - Grip ', N' Bút bi TL025  - Grip ', CAST(16 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/-But-bi-TL025----Grip/211', CAST(6000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp9.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (212, 1, N' Bút bi TL027 ', N' Bút bi TL027 ', CAST(17 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/-But-bi-TL027/212', CAST(17000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp10.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
GO
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (213, 1, N'Bút lông kim Mini', N'Bút lông kim Mini', CAST(18 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-kim-Mini/213', CAST(13000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp11.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (214, 1, N'Bút GEL04 - Dream Me', N'Bút GEL04 - Dream Me', CAST(19 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-GEL04---Dream-Me/214', CAST(15000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp12.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (215, 1, N'Bút lông kim Uniball  UB150  thường', N'Bút lông kim Uniball  UB150  thường', CAST(20 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-kim-Uniball--UB150--thuong/215', CAST(17000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp13.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (216, 1, N'Bút lông kim Uniball  UB150 Tốt', N'Bút lông kim Uniball  UB150 Tốt', CAST(21 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-kim-Uniball--UB150-Tot/216', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp14.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (217, 1, N'Bút lông kim Uniball  UB157 Tốt', N'Bút lông kim Uniball  UB157 Tốt', CAST(22 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-kim-Uniball--UB157-Tot/217', CAST(27000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp14.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (218, 1, N'Bút chì bấm Pentel AX 105', N'Bút chì bấm Pentel AX 105', CAST(23 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-chi-bam-Pentel-AX-105/218', CAST(30000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp15.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (219, 1, N'Bút chì bấm Pentel A255 ', N'Bút chì bấm Pentel A255 ', CAST(24 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-chi-bam-Pentel-A255/219', CAST(8000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp16.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (220, 1, N'Bút HL-03 (vỉ 5 cây) ', N'Bút HL-03 (vỉ 5 cây) ', CAST(25 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-HL-03-(vi-5-cay)/220', CAST(8000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp17.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (221, 1, N'Bút dạ quang TOYO', N'Bút dạ quang TOYO', CAST(26 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-da-quang-TOYO/221', CAST(35000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp18.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (222, 1, N'Bút xoá cây TL  CP02', N'Bút xoá cây TL  CP02', CAST(27 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-xoa-cay-TL--CP02/222', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp19.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (223, 1, N'Bút xoá cây  TL CP05', N'Bút xoá cây  TL CP05', CAST(28 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-xoa-cay--TL-CP05/223', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp20.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (224, 1, N'Bút xoá cây Uni ', N'Bút xoá cây Uni ', CAST(29 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-xoa-cay-Uni/224', CAST(40000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp21.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (225, 1, N'Bút xoá kéo PLUS 10m', N'Bút xoá kéo PLUS 10m', CAST(30 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-xoa-keo-PLUS-10m/225', CAST(30000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp22.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (226, 1, N'Bút xoá kéo PLUS 7m (mini)', N'Bút xoá kéo PLUS 7m (mini)', CAST(31 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-xoa-keo-PLUS-7m-(mini)/226', CAST(6000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp23.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (227, 1, N'Tampon Horse N03  ', N'Tampon Horse N03  ', CAST(32 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Tampon-Horse-N03/227', CAST(7000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp24.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (228, 1, N'Tampon Horse N02', N'Tampon Horse N02', CAST(33 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Tampon-Horse-N02/228', CAST(8000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp24.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (1, 1, N'Giấy A4 IK Plus', N'<table align="center" bgcolor="#1f2836" border="0" cellpadding="0" cellspacing="0" style="min-width: 650px;" width="100%">
	<tbody>
		<tr>
			<td align="center" style="font-family: arial, sans-serif; margin: 0px; background: url(&quot;https://ci6.googleusercontent.com/proxy/RABoqV2XI6TZ-IlKjSMSTyEtWfrEN36qhsrKbvwk8NRKVAqMQOOIr8KaahQI9CNAE6ikR1Aqbqbb4mzlCiQzDCfe5FkR6_-d23UczKqkhQA5Ow5yhbvsEHE4bSOvJns-Ky3AKOs9kLnE-MhwAxQZZtVonUPUJzViA1g=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/76cbc6f239b707b812da1badb5914ce7.jpg&quot;) center center / cover repeat;" width="100%">
				<table align="center" bgcolor="#000000" border="0" cellpadding="0" cellspacing="0" width="600">
					<tbody>
						<tr>
							<td align="center" style="margin: 0px;" width="100%">
								<table align="center" border="0" cellpadding="0" cellspacing="0" width="490">
									<tbody>
										<tr>
											<td height="36" style="margin: 0px;" width="100%">
												&nbsp;</td>
										</tr>
										<tr>
											<td align="center" style="margin: 0px; text-align: center;" width="100%">
												<span class="m_3294587026518643887fallback-text" style="color: rgb(255, 255, 255); font-size: 18px; line-height: 28px; font-family: Roboto, Helvetica, Arial, sans-serif;">Yep, that&#39;s right,&nbsp;<i>the</i>&nbsp;NASA.&nbsp;<br />
												<br />
												As in the ones who send people into space.&nbsp;<br />
												<br />
												Well they need your help.&nbsp;<br />
												<br />
												Freelancer and NASA are teaming up once again with a brand new contest. We need designers to come up with one-of-a-kind designs for one of NASA&#39;s key teams.&nbsp;<br />
												<br />
												The world&#39;s largest space program needs your help. Are you up for the challenge?</span></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td height="32" style="margin: 0px;" width="100%">
								&nbsp;</td>
						</tr>
						<tr>
							<td align="center" style="margin: 0px;" width="100%">
								<table align="center" border="0" cellpadding="0" cellspacing="0" width="260">
									<tbody>
										<tr>
											<td align="center" height="48" style="margin: 0px; border-radius: 3px; font-weight: bold; background: rgb(0, 135, 224);">
												<a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.freelancer.com/users/login-quick.php?token%3D3fa00c324b2b16b1806eca1b84a69da72a106a0419690f7b2da7d411f141f7d9%26url%3Dhttps%253A%252F%252Fwww.freelancer.com%252Fcampaign%252F0MEE8501103%252F%253Fl%253D%25252Fcontest%25252FNASA-Challenge-ASO-ISSTEA-Project-GraphicPatch-Design-970717.html%25253Futm_campaign%25253D20170310nasa%252526utm_medium%25253Demail%252526utm_source%25253Djointhecontestnow%26user_id%3D13167389%26expire_at%3D1494303863%26uniqid%3D13167389-23041-58c22a77-fc3b5b6d%26linkid%3D2&amp;source=gmail&amp;ust=1489246642598000&amp;usg=AFQjCNF0DpRHgSAGf6vHcsiYWaPiyBso8Q" href="https://www.freelancer.com/users/login-quick.php?token=3fa00c324b2b16b1806eca1b84a69da72a106a0419690f7b2da7d411f141f7d9&amp;url=https%3A%2F%2Fwww.freelancer.com%2Fcampaign%2F0MEE8501103%2F%3Fl%3D%252Fcontest%252FNASA-Challenge-ASO-ISSTEA-Project-GraphicPatch-Design-970717.html%253Futm_campaign%253D20170310nasa%2526utm_medium%253Demail%2526utm_source%253Djointhecontestnow&amp;user_id=13167389&amp;expire_at=1494303863&amp;uniqid=13167389-23041-58c22a77-fc3b5b6d&amp;linkid=2" style="color: rgb(255, 255, 255); text-decoration: none; font-size: 18px; line-height: 48px; display: block; width: 260px; font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Join The Contest Now &rarr;</a></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td height="32" style="margin: 0px;" width="100%">
								&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>
<table align="center" bgcolor="#1f2836" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tbody>
		<tr>
			<td align="center" style="font-family: arial, sans-serif; margin: 0px; background: url(&quot;https://ci6.googleusercontent.com/proxy/RABoqV2XI6TZ-IlKjSMSTyEtWfrEN36qhsrKbvwk8NRKVAqMQOOIr8KaahQI9CNAE6ikR1Aqbqbb4mzlCiQzDCfe5FkR6_-d23UczKqkhQA5Ow5yhbvsEHE4bSOvJns-Ky3AKOs9kLnE-MhwAxQZZtVonUPUJzViA1g=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/76cbc6f239b707b812da1badb5914ce7.jpg&quot;) center center / cover repeat;" width="100%">
				<br class="Apple-interchange-newline" />
				<table align="center" border="0" cellpadding="0" cellspacing="0" width="650">
					<tbody>
						<tr style="font-size: 12.8px;">
							<td height="32" style="margin: 0px;" width="100%">
								&nbsp;</td>
						</tr>
						<tr style="font-size: 12.8px;">
							<td align="center" style="margin: 0px;">
								<span class="m_3294587026518643887fallback-text m_3294587026518643887appleLinksGrey" style="color: rgb(117, 120, 125); font-size: 12px; line-height: 18px; font-family: Roboto, Helvetica, Arial, sans-serif;">&copy; 2017 Freelancer Technology Pty Limited. All Rights Reserved.<br />
								Level 20, 680 George Street, Sydney, NSW 2000, Australia</span></td>
						</tr>
						<tr style="font-size: 12.8px;">
							<td height="8" style="margin: 0px;" width="100%">
								&nbsp;</td>
						</tr>
						<tr style="font-size: 12.8px;">
							<td align="center" style="margin: 0px;">
								<span style="color: rgb(117, 120, 125); font-size: 12px; line-height: 18px;"><a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.freelancer.com/campaign/0MEE8501104/?l%3D%252Fpage.php%253Fp%253Dinfo%25252Fprivacy%2526utm_campaign%253D20170310nasa%2526utm_medium%253Demail%2526utm_source%253Dprivacypolicy%26uniqid%3D13167389-23041-58c22a77-fc3b5b6d%26linkid%3D3&amp;source=gmail&amp;ust=1489246642598000&amp;usg=AFQjCNHMWZ6Y2SGKhsdh4TRqluv-GGkbNQ" href="https://www.freelancer.com/campaign/0MEE8501104/?l=%2Fpage.php%3Fp%3Dinfo%252Fprivacy%26utm_campaign%3D20170310nasa%26utm_medium%3Demail%26utm_source%3Dprivacypolicy&amp;uniqid=13167389-23041-58c22a77-fc3b5b6d&amp;linkid=3" style="color: rgb(117, 120, 125); font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Privacy Policy</a>&nbsp;|&nbsp;<a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.freelancer.com/campaign/0MEE8501105/?l%3D%252Fpage.php%253Fp%253Dinfo%25252Fterms%2526utm_campaign%253D20170310nasa%2526utm_medium%253Demail%2526utm_source%253Dtermsandconditions%26uniqid%3D13167389-23041-58c22a77-fc3b5b6d%26linkid%3D4&amp;source=gmail&amp;ust=1489246642598000&amp;usg=AFQjCNEcmX_vr5aMySYCO1QNNZ8Awn3fLw" href="https://www.freelancer.com/campaign/0MEE8501105/?l=%2Fpage.php%3Fp%3Dinfo%252Fterms%26utm_campaign%3D20170310nasa%26utm_medium%3Demail%26utm_source%3Dtermsandconditions&amp;uniqid=13167389-23041-58c22a77-fc3b5b6d&amp;linkid=4" style="color: rgb(117, 120, 125); font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Terms and Conditions</a>&nbsp;|&nbsp;<a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.freelancer.com/campaign/0MEE8501100/?l%3Dhttps%253A%252F%252Fwww.freelancer.com%252Fusers%252Femail%252Fsubscriptions.php%253Ftoken%253DeyJzdWIiOiJ1bnN1YnNjcmliZSIsImlhdCI6MTQ4OTExOTg2MywiYWxnIjoiSFMyNTYifQ.eyJpZCI6IjEzMTY3Mzg5In0.eeIuL-XGFjswuWK6ro5p1X48qj9WaYcl_subEsWHc5Y%2526type%253Dmarketing%26uniqid%3D13167389-23041-58c22a77-fc3b5b6d%26linkid%3D5&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNF8pzF0QvcUJDuXymRX4hgOQYNSzQ" href="https://www.freelancer.com/campaign/0MEE8501100/?l=https%3A%2F%2Fwww.freelancer.com%2Fusers%2Femail%2Fsubscriptions.php%3Ftoken%3DeyJzdWIiOiJ1bnN1YnNjcmliZSIsImlhdCI6MTQ4OTExOTg2MywiYWxnIjoiSFMyNTYifQ.eyJpZCI6IjEzMTY3Mzg5In0.eeIuL-XGFjswuWK6ro5p1X48qj9WaYcl_subEsWHc5Y%26type%3Dmarketing&amp;uniqid=13167389-23041-58c22a77-fc3b5b6d&amp;linkid=5" style="color: rgb(117, 120, 125); font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Unsubscribe</a>&nbsp;|&nbsp;<a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.freelancer.com/campaign/0MEE8501106/?l%3D%252Fsupport%253Futm_campaign%253D20170310nasa%2526utm_medium%253Demail%2526utm_source%253Dgetsupport%26uniqid%3D13167389-23041-58c22a77-fc3b5b6d%26linkid%3D6&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNFswTJZRagJvSm1Jg1wvnYHYAnV3A" href="https://www.freelancer.com/campaign/0MEE8501106/?l=%2Fsupport%3Futm_campaign%3D20170310nasa%26utm_medium%3Demail%26utm_source%3Dgetsupport&amp;uniqid=13167389-23041-58c22a77-fc3b5b6d&amp;linkid=6" style="color: rgb(117, 120, 125); font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Get Support</a></span></td>
						</tr>
						<tr style="font-size: 12.8px;">
							<td height="16" style="margin: 0px;" width="100%">
								&nbsp;</td>
						</tr>
						<tr style="font-size: 12.8px;">
							<td align="center" style="margin: 0px;" width="100%">
								<table align="center" border="0" cellpadding="0" cellspacing="0" width="auto">
									<tbody>
										<tr>
											<td style="margin: 0px;">
												<a data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.facebook.com/fansoffreelancer&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNGwvzcTtBbAosH26rSMwzEb9_c4xQ" href="https://www.facebook.com/fansoffreelancer" style="color: rgb(17, 85, 204);" target="_blank"><img alt="Facebook" border="0" class="CToWUd" src="https://ci4.googleusercontent.com/proxy/Ll1wCrO0iQ88njKOpFgQ5_BxprgyihBe4U992R2Fd3rLsOCtRkCzVq3COsx4nL379hbywWcyt7dcFMyZxVSrl1fhqxwBXUVVEuhj_ZtdwsoG_2AGoYwAxjrmHQ-Drw97AOio_SPbv2slylKCibEjKNRjLOWWjQ6vtZw=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/19bacfd0c58e6a35b841790d89354564.png" width="24" /></a>&nbsp;&nbsp;<a data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://twitter.com/freelancer&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNGXTSKoBJlIdv7x_TenPCrNK60sVQ" href="https://twitter.com/freelancer" style="color: rgb(17, 85, 204);" target="_blank"><img alt="Twitter" border="0" class="CToWUd" src="https://ci5.googleusercontent.com/proxy/xYFztdorO7SrSjnfXrE7lotRtuL_7jFAllnJ5AnrRKHx_dA5vK0uYB3GHeRS1sBxpmsXSqluk083TIp4sELNmJ8yk1xTGlWO8X2FJEN6mdw8FmmcxmqCqqSEDYmtULENV-JSo1JtLhsnbssVCQNSHxQi6SsfIMo-t0M=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/cf858d8bbdf01f6d8f3a7f3ecb08f266.png" width="24" /></a>&nbsp;&nbsp;<a data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://plus.google.com/u/0/100130810430706051779/posts&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNF92VaGwwDw_aO44psNG3gf4BNazw" href="https://plus.google.com/u/0/100130810430706051779/posts" style="color: rgb(17, 85, 204);" target="_blank"><img alt="Google+" border="0" class="CToWUd" src="https://ci6.googleusercontent.com/proxy/A00ZzhXbC3uCtqX7k35v8_a6ZH3aNdIwEXMmxEtw29sy78ComqPYfP8zw_Mh9YFMVsfFY4lDMvHp_8Af6Fi5eJNlXTEBtnyKTgPpLof51j5K88eywgY4heEOXfysRpvPgG85KyVMBGbnaSUbIpWY8Cyi-7KRyGEACN0=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/760f14fd3cca5a4ebcc0632073625674.png" width="24" /></a>&nbsp;&nbsp;<a data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://www.instagram.com/freelancerofficial&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNGnFN22mGQYcwgLhE_kCTqyYim3vQ" href="https://www.instagram.com/freelancerofficial" style="color: rgb(17, 85, 204);" target="_blank"><img alt="Instagram" border="0" class="CToWUd" src="https://ci5.googleusercontent.com/proxy/RWbzeeAQS6BpZrZHSiT7WFob9dePwAlpPqMhBTmVE0WHOgNBz9LN1FTwez6ucHy62Tb0IJLFTcdZ39SKqeH_B-QlYG6olKDMwF_Nn3-WBITX_IJHaXBUm0Tg7QBvb_2E_OlEGGjOtnKbFzOzKvcHRjI41Urgvm8IFGc=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/7517195fa748ffb4ccc210202e644d7d.png" width="24" /></a></td>
											<td style="margin: 0px;" width="16">
												&nbsp;</td>
											<td style="margin: 0px;">
												<a class="m_3294587026518643887fallback-text" data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://bnc.lt/edm-download-freelancer&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNEoKxNhlGjuTWd9oPhKnJQIRAKzKA" href="https://bnc.lt/edm-download-freelancer" style="color: rgb(117, 120, 125); text-decoration: none; font-size: 12px; line-height: 18px; font-family: Roboto, Helvetica, Arial, sans-serif;" target="_blank">Download our mobile app</a></td>
											<td style="margin: 0px;" width="4">
												&nbsp;</td>
											<td style="margin: 0px;">
												<a data-saferedirecturl="https://www.google.com/url?hl=vi&amp;q=https://bnc.lt/edm-download-freelancer&amp;source=gmail&amp;ust=1489246642599000&amp;usg=AFQjCNEoKxNhlGjuTWd9oPhKnJQIRAKzKA" href="https://bnc.lt/edm-download-freelancer" style="color: rgb(117, 120, 125); text-decoration: none;" target="_blank"><img border="0" class="CToWUd" src="https://ci6.googleusercontent.com/proxy/F8iX7slaH2oAWmf8sIKDf7AmxA__IaM02FDHjsYWWRaTrHyp2DHUTmNJ0rvHxmXufjt-jK0Gs5vlnCuv84Uog-9OFbgVeB08xunQsceWinmuiVXDeSgdiedVYYI4M9HGMtPso6FxAflDaDfzk9kGjO6H7PszdXrPwvo=s0-d-e1-ft#https://d3bvzwcd1dw6vt.cloudfront.net/static/images/email/build/b98e76935f88dac4cbd67e14f237d7cc.png" style="display: inline;" width="38" /></a></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr style="font-size: 12.8px;">
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', CAST(1 AS Numeric(5, 0)), N'<p>
	Giấy A4 IK Plus</p>
', 0, N'~/Chi-tiet-san-pham/Giay-A4-IK-Plus/1', CAST(55000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 IK Plus.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (2, 1, N'Giấy A4 IDEA 70 gsm', N'Giấy A4 IDEA 70 gsm', CAST(2 AS Numeric(5, 0)), N'Giấy A4 IDEA 70 gsm', 0, N'~/Chi-tiet-san-pham/Giay-A4-IDEA-70-gsm/2', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 IDEA 70 gsm.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (3, 1, N'Giấy A4 Paper One (70)', N'Giấy A4 Paper One (70)', CAST(3 AS Numeric(5, 0)), N'Giấy A4 Paper One (70)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Paper-One-(70)/3', CAST(57000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (4, 1, N'Giấy A4 Paper One (80)', N'Giấy A4 Paper One (80)', CAST(4 AS Numeric(5, 0)), N'Giấy A4 Paper One (80)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Paper-One-(80)/4', CAST(70000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (80).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (5, 1, N'Giấy A4 Double A(80)', N'Giấy A4 Double A(80)', CAST(5 AS Numeric(5, 0)), N'Giấy A4 Double A(80)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Double-A(80)/5', CAST(76000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Double A(80).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (6, 1, N'Giấy A4 Double A(70)', N'Giấy A4 Double A(70)', CAST(6 AS Numeric(5, 0)), N'Giấy A4 Double A(70)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Double-A(70)/6', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Double A(80).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (7, 1, N'Giấy A4 Print-Perfect (70)', N'Giấy A4 Print-Perfect (70)', CAST(7 AS Numeric(5, 0)), N'Giấy A4 Print-Perfect (70)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Print-Perfect-(70)/7', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (8, 1, N'Giấy A5  Exell (70/90)', N'Giấy A5  Exell (70/90)', CAST(8 AS Numeric(5, 0)), N'Giấy A5 Exell (70/90)</p>', 0, N'~/Chi-tiet-san-pham/Giay-A5- Exell-(7090)/8', CAST(25000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (9, 1, N'Giấy A5  Exell (80/90)', N'Giấy A5  Exell (80/90)', CAST(9 AS Numeric(5, 0)), N'Giấy A5 Exell (80/90)</p>', 0, N'~/Chi-tiet-san-pham/Giay-A5- Exell-(8090)/9', CAST(29000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (10, 1, N'Giấy  A4 Exell (70/90)', N'Giấy  A4 Exell (70/90)', CAST(10 AS Numeric(5, 0)), N'Giấy  A4 Exell (70/90)', 0, N'~/Chi-tiet-san-pham/Giay- A4-Exell-(7090)/10', CAST(44000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (11, 1, N'Giấy A4  Exell (80/90)', N'Giấy A4  Exell (80/90)', CAST(11 AS Numeric(5, 0)), N'Giấy A4  Exell (80/90)', 0, N'~/Chi-tiet-san-pham/Giay-A4- Exell-(8090)/11', CAST(52000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (12, 1, N'Giấy A4 Superem (70)', N'Giấy A4 Superem (70)', CAST(12 AS Numeric(5, 0)), N'Giấy A4 Superem (70)', 0, N'~/Chi-tiet-san-pham/Giay-A4-Superem-(70)/12', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Superem (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (13, 1, N'Giấy A4 A+ (70)', N'Giấy A4 A+ (70)', CAST(13 AS Numeric(5, 0)), N'Giấy A4 A+ (70)', 0, N'~/Chi-tiet-san-pham/Giay-A4-A(70)/13', CAST(55000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (14, 1, N'Giấy A3 Exell (82)', N'Giấy A3 Exell (82)', CAST(14 AS Numeric(5, 0)), N'Giấy A3 Exell (82)', 0, N'~/Chi-tiet-san-pham/Giay-A3-Exell-(82)/14', CAST(99000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (15, 1, N'Giấy A3 Paper One (70)', N'Giấy A3 Paper One (70)', CAST(15 AS Numeric(5, 0)), N'Giấy A3 Paper One (70)', 0, N'~/Chi-tiet-san-pham/Giay-A3-Paper-One-(70)/15', CAST(114000 AS Decimal(10, 0)), N'~/Images/SanPham/A4 Paper One (70).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (16, 1, N'Giấy A3 Double A(80)', N'Giấy A3 Double A(80)', CAST(16 AS Numeric(5, 0)), N'Giấy A3 Double A(80)', 0, N'~/Chi-tiet-san-pham/Giay-A3-Double-A(80)/16', CAST(150000 AS Decimal(10, 0)), N'~/Images/SanPham/A3 Double A(80).jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (17, 1, N'DELL Inspiron 3467 (3467A) Black', N'Intel Core i5-7200U (3M Cache, 2.5GHz, Turbo Boost 3.1 GHz), 4GB DDR4 2400MHz, 500GB,  DVDRW, 14", AMD Radeon R5 M430 2GB DDR3, BT 4.0, WLAN b/g/n, 1.0MP HD camera, 3-in-1 card reader, USB 3.0, 1Y, PremiumSupport', CAST(17 AS Numeric(5, 0)), N'DELL Inspiron 3467 (3467A) Black', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3467-(3467A)-Black/17', CAST(12550000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (18, 1, N'DELL Inspiron 3567 (N3567A)  Black', N'Intel Core i3-7100U (3M Cache, 2.4GHz), 6GB DDR4 2400MHz, 1000GB, DVD+/-RW, 15.6", Intel HD Graphics 620, BT 4.0, WLAN ac/b/g/n, 1.0MP HD camera, Multi-media card reader, USB 3.0, Ubuntu, 1Y, Premium Support', CAST(18 AS Numeric(5, 0)), N'DELL Inspiron 3567 (N3567A)  Black', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3567-(N3567A)- Black/18', CAST(10050000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (19, 1, N'DELL Inspiron 3567 (N3567B) Black', N'Intel Core i3-7100U (3M Cache, 2.4GHz), 6GB DDR4 2400MHz, 1000GB, DVD+/-RW, 15.6", Intel HD Graphics 620, BT 4.0, WLAN ac/b/g/n, 1.0MP HD camera, Multi-media card reader, USB 3.0, Win10, 1Y, Premium Support', CAST(19 AS Numeric(5, 0)), N'DELL Inspiron 3567 (N3567B) Black', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3567-(N3567B)-Black/19', CAST(11050000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (20, 1, N'DELL Inspiron 3567 (N3567F) Black', N'Intel Core i5-7200U (3M Cache, 2.5GHz, Turbo Boost 3.1GHz), 8GB DDR4 , 1000GB, DVD+/-RW, 15.6", BT 4.0, WLAN 802.11ac, 1.0MP HD camera, Multi-media card reader, USB 3.0, 1Y, Win10, PremiumSupport.', CAST(20 AS Numeric(5, 0)), N'DELL Inspiron 3567 (N3567F) Black', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3567-(N3567F)-Black/20', CAST(13150000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (21, 1, N'DELL Inspiron 3458 (TXTGH41)', N'(NB) DELL INS14 3458 i3-5005U/4G/500G5/14.0HD/BT4/4C40WHr/ĐEN/W10SL/ProSup', CAST(21 AS Numeric(5, 0)), N'DELL Inspiron 3458 (TXTGH41)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3458-(TXTGH41)/21', CAST(9908000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (22, 1, N'DELL Inspiron 3462 (6PFTF1)', N'(NB) DELL INS14 3462 PQC N4200/4GD3/500G5/14.0HD/DVDRW/BT4/4C40WHr/ĐEN/W10SL/ProSup', CAST(22 AS Numeric(5, 0)), N'DELL Inspiron 3462 (6PFTF1)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3462-(6PFTF1)/22', CAST(7334000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (23, 1, N'DELL Inspiron 3467 (M20NR1)', N'(NB) DELL INS14 3467 i3-6006U/4GD4/1T5/14.0HD/DVDRW/BT4/4C40WHr/ĐEN/LNX/ProSup', CAST(23 AS Numeric(5, 0)), N'DELL Inspiron 3467 (M20NR1)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3467-(M20NR1)/23', CAST(9358000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (24, 1, N'DELL Inspiron 3467 (M20NR2)', N'(NB) DELL INS14 3467 i3-7100U/4G/1T5/14.0HD/DVDRW/BT4/4C40WHr/ĐEN/LNX/ProSup', CAST(24 AS Numeric(5, 0)), N'DELL Inspiron 3467 (M20NR2)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3467-(M20NR2)/24', CAST(9545000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (25, 1, N'DELL Inspiron 3467 (M20NR21)', N'(NB) DELL INS14 3467 i3-7100U/4G/1T5/14.0HD/DVDRW/BT4/4C40WHr/ĐEN/W10SL/ProSup', CAST(25 AS Numeric(5, 0)), N'DELL Inspiron 3467 (M20NR21)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3467-(M20NR21)/25', CAST(10645000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (26, 1, N'DELL Inspiron 5468 (K5CDP1)', N'(NB) DELL INS14 5468 i5-7200U/4GD4/500G5/DVDRW/14.0HD/4C40WHr/BẠC/W10SL/2GD3_R7M440/ProSup', CAST(26 AS Numeric(5, 0)), N'DELL Inspiron 5468 (K5CDP1)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-5468-(K5CDP1)/26', CAST(15210000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (27, 1, N'DELL Inspiron 3467', N'i5 - 7200U  (3MB Cache up to 3.1 Ghz ) - 4G - 1TB  - 14" LED  - DVDRW - DOS ( 4 cell - 40Whr )', CAST(27 AS Numeric(5, 0)), N'DELL Inspiron 3467', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-3467/27', CAST(11850000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (28, 1, N'DELL Inspiron 15R - N5559 (TULIP)', N'i5 - 6200U (2.3 Ghz up to 2.8 Ghz ) - 4G - 1TB - 4G VGA ( AMD Radeon M335 ) - 15.6" LED - DVDRW', CAST(28 AS Numeric(5, 0)), N'DELL Inspiron 15R - N5559 (TULIP)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-15R---N5559-(TULIP)/28', CAST(14050000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (29, 1, N'DELL Inspiron 15R - N5559 (TULIP)', N'i5 - 6200U (2.3 Ghz up to 2.8 Ghz ) - 4G - 500G - 2G VGA ( AMD Radeon M335 ) - 15.6" LED - DVDRW', CAST(29 AS Numeric(5, 0)), N'DELL Inspiron 15R - N5559 (TULIP)', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-15R---N5559-(TULIP)/29', CAST(13050000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (30, 1, N'DELL Inspiron 15R - N5559', N'i5 - 6200U (up to 2.8 Ghz ) - 8G - 1TB - 2G VGA ( AMD Radeon M335 ) - 15.6" LED - DVDRW', CAST(30 AS Numeric(5, 0)), N'DELL Inspiron 15R - N5559', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-15R---N5559/30', CAST(14050000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (31, 1, N'DELL Inspiron 15R - N5567', N'i5 - 7200U (up to 3.1 Ghz ) - 4G - 1TB - 2G VGA ( AMD Radeon R7 M445 DDR5 ) - 15.6" FHD (3 cell - 42WWhr) - Windows 10 - DVDRW', CAST(31 AS Numeric(5, 0)), N'DELL Inspiron 15R - N5567', 0, N'~/Chi-tiet-san-pham/DELL-Inspiron-15R---N5567/31', CAST(15350000 AS Decimal(10, 0)), N'~/Images/SanPham/dell.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (32, 1, N'ASUS E502SA-XX188D', N'Celeron N3060;2GB;500GB;15.6"', CAST(32 AS Numeric(5, 0)), N'ASUS E502SA-XX188D', 0, N'~/Chi-tiet-san-pham/ASUS-E502SA-XX188D/32', CAST(5330000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (33, 1, N'ASUS E502SA-XX024T', N'Celeron N3050(1.6Ghz), RAM:2GB,HDD:500GB,Win 10,Cable', CAST(33 AS Numeric(5, 0)), N'ASUS E502SA-XX024T', 0, N'~/Chi-tiet-san-pham/ASUS-E502SA-XX024T/33', CAST(6250000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (34, 1, N'ASUS E402SA-WX251D', N'Máy tính xách tay Asus E402SA N3060/2G/500GB-54/UMA/14" HD/DOS/Xanh/2YW_E402SA-WX251D', CAST(34 AS Numeric(5, 0)), N'ASUS E402SA-WX251D', 0, N'~/Chi-tiet-san-pham/ASUS-E402SA-WX251D/34', CAST(5150000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (35, 1, N'ASUS P2530UA-DM0525D', N'i5-6200U;8GB DDR4;500GB;DVDRW;15.6";chuột,cáp', CAST(35 AS Numeric(5, 0)), N'ASUS P2530UA-DM0525D', 0, N'~/Chi-tiet-san-pham/ASUS-P2530UA-DM0525D/35', CAST(12810000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (36, 1, N'ASUS TP201SA-FV0008T', N'(NB) ASUS TP201S PQC N3710/4GD3/500G5/11.6HDT/IPS/BT4.1/3C48WHr/ALU/VÀNG/W10SL', CAST(36 AS Numeric(5, 0)), N'ASUS TP201SA-FV0008T', 0, N'~/Chi-tiet-san-pham/ASUS-TP201SA-FV0008T/36', CAST(9501000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (37, 1, N'ASUS X541UA-XX051D', N'Máy tính xách tay Asus X541UA i5-6200U/4G/500GB-54/UMA/15.6" HD/DVDRW/DOS/Đen/2YW_X541UA-XX051D', CAST(37 AS Numeric(5, 0)), N'ASUS X541UA-XX051D', 0, N'~/Chi-tiet-san-pham/ASUS-X541UA-XX051D/37', CAST(11150000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (38, 1, N'ASUS X441SA-WX020D', N'Máy tính xách tay Asus X441SA N3060/4G/500GB-54/UMA/14" HD/DVDRW/DOS/Đen/2YW_X441SA-WX020D', CAST(38 AS Numeric(5, 0)), N'ASUS X441SA-WX020D', 0, N'~/Chi-tiet-san-pham/ASUS-X441SA-WX020D/38', CAST(5610000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (39, 1, N'ASUS X403SA-WX235T', N'(NB) ASUS X403S PQC N3700/2G/500G5/14.0HD/2C30WHr/ĐEN/W10SL', CAST(39 AS Numeric(5, 0)), N'ASUS X403SA-WX235T', 0, N'~/Chi-tiet-san-pham/ASUS-X403SA-WX235T/39', CAST(6718000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (40, 1, N'ASUS X441SA-WX021D', N'(NB) ASUS X441S PQC N3710/4GD3/500G5/DVDRW/14.0HD/BT4/3C36WHr/ĐEN/DOS', CAST(40 AS Numeric(5, 0)), N'ASUS X441SA-WX021D', 0, N'~/Chi-tiet-san-pham/ASUS-X441SA-WX021D/40', CAST(6540000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (41, 1, N'ASUS X441UA-WX016D', N'(NB) ASUS X441U i3-6100U/4GD4/500G5/DVDRW/14.0HD/BT4/3C36Whr/ĐEN/DOS', CAST(41 AS Numeric(5, 0)), N'ASUS X441UA-WX016D', 0, N'~/Chi-tiet-san-pham/ASUS-X441UA-WX016D/41', CAST(9040000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (42, 1, N'ASUS X441UA-WX055D', N'(NB) ASUS X441U i5-6200U/4GD4/500G5/DVDRW/14.0HD/BT4/3C36Whr/ĐEN/DOS', CAST(42 AS Numeric(5, 0)), N'ASUS X441UA-WX055D', 0, N'~/Chi-tiet-san-pham/ASUS-X441UA-WX055D/42', CAST(10970000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (43, 1, N'ASUS X441UA-GA056T', N'(NB) ASUS X441U i5-7200U/4GD4/500G5/DVDRW/14.0HD/BT4/3C36Whr/ĐEN/WIN10SL', CAST(43 AS Numeric(5, 0)), N'ASUS X441UA-GA056T', 0, N'~/Chi-tiet-san-pham/ASUS-X441UA-GA056T/43', CAST(12059000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (44, 1, N'ASUS X441UV-WX017D', N'<p>
	M&aacute;y t&iacute;nh x&aacute;ch tay Asus X441UV i3-6100U/4G/500GB-54/DVDRW/2GB/14&quot; HD/DOS/Đen/2YW_X441UV-WX017D</p>
', CAST(44 AS Numeric(5, 0)), N'<p>
	ASUS X441UV-WX017D</p>
', 0, N'~/Chi-tiet-san-pham/ASUS-X441UV-WX017D/44', CAST(10430000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (45, 1, N'ASUS X540LA-DM423D', N'Máy tính xách tay Asus X540LA i3-5005U/4G/500GB-54/DVDRW/UMA/15.6" FHD/DOS/Bạc/2YW_X540LA-DM423D', CAST(45 AS Numeric(5, 0)), N'ASUS X540LA-DM423D', 0, N'~/Chi-tiet-san-pham/ASUS-X540LA-DM423D/45', CAST(9040000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (46, 1, N'ASUS A556UR-DM161T', N'Máy tính xách tay Asus A556UR i5-6198DU/4G/500GB-54/DVDSM/2GB GF 930MX/15.6" FHD/Win 10/Xanh/Chuột/2YW_A556UR-DM161T', CAST(46 AS Numeric(5, 0)), N'ASUS A556UR-DM161T', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM161T/46', CAST(13200000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (47, 1, N'ASUS A556UR-DM263D', N'Máy tính xách tay Asus A556UR i5-7200U/4G/500GB-54/DVDRW/GF 930MX 2GB/15.6" FHD/DOS/Vàng/Chuột/2YW_A556UR-DM263D', CAST(47 AS Numeric(5, 0)), N'ASUS A556UR-DM263D', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM263D/47', CAST(12700000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (48, 1, N'ASUS A556UR-DM179D', N'Máy tính xách tay Asus A556UR i5-6200U/4G/1TB-54/2GB GF 930MX/15.6" FHD/DVDRW/DOS/Xanh đậm/Chuột/2YW_A556UR-DM179D', CAST(48 AS Numeric(5, 0)), N'ASUS A556UR-DM179D', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM179D/48', CAST(13240000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (49, 1, N'ASUS A556UR-DM158T', N'Máy tính xách tay Asus A556UR i7-6500U/4G/1TB-54/2GB GF 930MX/15.6" FHD/DVDRW/Win 10/Xanh/Chuột/2YW_A556UR-DM158T', CAST(49 AS Numeric(5, 0)), N'ASUS A556UR-DM158T', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM158T/49', CAST(16150000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (50, 1, N'ASUS A556UR-DM092D', N'Máy tính xách tay ASUS A556UR i7-6500U/8G/1TB-54/GF 930MX 2G/15.6" FHD/DVDRW/DOS/Xanh Đậm/Chuột/2YW_A556UR-DM092D', CAST(50 AS Numeric(5, 0)), N'ASUS A556UR-DM092D', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM092D/50', CAST(15700000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (51, 1, N'ASUS A556UR-DM096D', N'Máy tính xách tay ASUS A556UR i5-6200U/4G/500GB-54/GF 930MX 2G/15.6" FHD/DVDRW/DOS/Xanh Đậm/Chuột/2YW_A556UR-DM096D', CAST(51 AS Numeric(5, 0)), N'ASUS A556UR-DM096D', 0, N'~/Chi-tiet-san-pham/ASUS-A556UR-DM096D/51', CAST(12740000 AS Decimal(10, 0)), N'~/Images/SanPham/asus.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (52, 1, N'ACER Acer ES1-433-3863', N'Intel core i3 6100 - RAM 4Gb - HDD 1T GB- No DVD-RW - 14" inch - Linux', CAST(52 AS Numeric(5, 0)), N'ACER Acer ES1-433-3863', 0, N'~/Chi-tiet-san-pham/ACER-Acer-ES1-433-3863/52', CAST(8070000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (53, 1, N'ACER Acer V3-371-39CM', N'Intel Core i3 5005 (2.2GHz) - RAM 4Gb - HD 500GB+8GBSSD - No DVD-RW - 13.3 inch - Linux', CAST(53 AS Numeric(5, 0)), N'ACER Acer V3-371-39CM', 0, N'~/Chi-tiet-san-pham/ACER-Acer-V3-371-39CM/53', CAST(9810000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (54, 1, N'ACER Acer V3-372-59AB', N'Intel core i5 6200 - RAM 4Gb - HDD 500GB+8GBSSD - No DVD-RW - 13.3" inch - Linux', CAST(54 AS Numeric(5, 0)), N'ACER Acer V3-372-59AB', 0, N'~/Chi-tiet-san-pham/ACER-Acer-V3-372-59AB/54', CAST(11650000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (55, 1, N'ACER Acer R3-131T-P70K', N'Pentium N3710(1.60GHz up to 2.56GHz) - RAM 4GB - HDD 500GB - No DVD-RW - 11.6" Touch, xoay 3600 - Win10', CAST(55 AS Numeric(5, 0)), N'ACER Acer R3-131T-P70K', 0, N'~/Chi-tiet-san-pham/ACER-Acer-R3-131T-P70K/55', CAST(8989000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (56, 1, N'ACER Acer R3-131T-P55U', N'Pentium N3710(1.60GHz up to 2.56GHz) - RAM 4GB - HDD 500GB - No DVD-RW - 11.6" Touch, xoay 3600 - Win10', CAST(56 AS Numeric(5, 0)), N'ACER Acer R3-131T-P55U', 0, N'~/Chi-tiet-san-pham/ACER-Acer-R3-131T-P55U/56', CAST(8989000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (57, 1, N'ACER Acer R3-131T-P35K', N'Pentium N3710(1.60GHz up to 2.56GHz) - RAM 4GB - HDD 500GB - No DVD-RW - 11.6" Touch, xoay 3600 - Win10', CAST(57 AS Numeric(5, 0)), N'ACER Acer R3-131T-P35K', 0, N'~/Chi-tiet-san-pham/ACER-Acer-R3-131T-P35K/57', CAST(8989000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (58, 1, N'ACER Acer R3-131T-P6NF', N'Pentium N3710(1.60GHz up to 2.56GHz) - RAM 4GB - HDD 500GB - No DVD-RW - 11.6" Touch, xoay 3600 - Win10', CAST(58 AS Numeric(5, 0)), N'ACER Acer R3-131T-P6NF', 0, N'~/Chi-tiet-san-pham/ACER-Acer-R3-131T-P6NF/58', CAST(8989000 AS Decimal(10, 0)), N'~/Images/SanPham/acer.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (59, 1, N'LENOVO ideaPad 110', N'IdeaPad 110-14ISK: 14.0 HD TN GL(SLIM)/INTEL® CORE™ I5-6200U PROCESSOR/Graphic: INTEGRATED/4G DDR4 2133 ONBOARD / 500G 7MM 5400RPM/DUMMY ODD / CAMERA 0.3M/4CELL 32WH/WIFI 1X1 AC+BT4.1 / Keyboard ENGLISH/W10 HOME EM / BLACK TEXTURE/1 Year Carry In', CAST(59 AS Numeric(5, 0)), N'LENOVO ideaPad 110', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-110/59', CAST(10636000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (60, 1, N'LENOVO ideaPad 310-15ISK', N'IdeaPad 310-15ISK: 15.6 HD TN GL(SLIM)/INTEL® CORE™ I5-6200U PROCESSOR/', CAST(60 AS Numeric(5, 0)), N'LENOVO ideaPad 310-15ISK', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-310-15ISK/60', CAST(11650000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (61, 1, N'LENOVO ideaPad 310-15ISK', N'IdeaPad 310-15ISK: 15.6 HD TN GL(SLIM)/INTEL® CORE™ I5-6200U PROCESSOR/', CAST(62 AS Numeric(5, 0)), N'LENOVO ideaPad 310-15ISK', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-310-15ISK/61', CAST(11650000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (62, 1, N'LENOVO ideapad 300', N'Skylake I7 6500U ( 2.5 Ghz,4Mb) ,  4GB DDR3L 1600 Mhz ,  500GB 5400Rpm ,  14" HD (1366 x 768) ,  DVD RW , VGA  Intel HD Graphics 520 , Wifi chuẩn AC , Bluetooth 4.0 , 4 Cell 41Wh , DOS ,  2.3kg (Màu Đen )', CAST(64 AS Numeric(5, 0)), N'LENOVO ideapad 300', 0, N'~/Chi-tiet-san-pham/LENOVO-ideapad-300/62', CAST(12850000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (63, 1, N'LENOVO ideaPad 510-15ISK', N'IdeaPad 510-15ISK: 15.6 FHD IPS AG(SLIM)/INTEL® CORE™ I5-6200U PROCESSOR/Graphic: INTEGRATED/8G DDR4 2133 ONBOARD / 2TB 9.5MM 5400RPM/9.0MM SUPER MULTI(TRAY IN) / CAMERA HD 720P WITH ARRAY MIC/2CELL 39WH/WIFI 1X1 AC+BT4.1 / Backlit Keyboard ENGLISH/FREE-DOS / WHITE/2 Year Carry In', CAST(65 AS Numeric(5, 0)), N'LENOVO ideaPad 510-15ISK', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-510-15ISK/63', CAST(12990000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (64, 1, N'LENOVO ideaPad 310-15IKB', N'IdeaPad 310-15IKB: 15.6 FHD TN GL(SLIM)/INTEL® CORE™ I7-7500U PROCESSOR/Graphic: NVIDIA® GEFORCE® 920MX (2GB DDR3L)/4G DDR4 2133 ONBOARD / 1TB 9.5MM 5400RPM/DUMMY ODD / HD 720P WITH SINGLE MIC/2CELL 30WH/WIFI 1X1 AC+BT4.1 / Keyboard ENGLISH/FREE-DOS / BLACK TEXTURE/1 Year Carry In', CAST(66 AS Numeric(5, 0)), N'LENOVO ideaPad 310-15IKB', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-310-15IKB/64', CAST(14960000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (65, 1, N'LENOVO ideaPad 510-15ISK', N'IdeaPad 510-15ISK: 15.6 FHD IPS AG(SLIM)/ INTEL® CORE™ I7-6500U PROCESSOR/Graphic: NVIDIA® GEFORCE® GTX 940MX (4GB DDR3L)/ 8G DDR4 2133 ONBOARD / 1TB 9.5MM 5400RPM/9.0MM SUPER MULTI(TRAY IN) / CAMERA HD 720P WITH ARRAY MIC/2CELL 39WH/ WIFI 1X1 AC+BT4.0 / Keyboard ENGLISH/FREE-DOS /  WHITE/ FREE BackPack / FREE Kaspersky  /  2 Year Carry In', CAST(67 AS Numeric(5, 0)), N'LENOVO ideaPad 510-15ISK', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-510-15ISK/65', CAST(17550000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (66, 1, N'LENOVO ideaPad 510-15ISK', N'IdeaPad 510-15ISK: 15.6 FHD IPS AG(SLIM)/ INTEL® CORE™ I7-6500U PROCESSOR/Graphic: NVIDIA® GEFORCE® GTX 940MX (4GB DDR3L)/ 8G DDR4 2133 ONBOARD / 1TB 9.5MM 5400RPM/9.0MM SUPER MULTI(TRAY IN) / CAMERA HD 720P WITH ARRAY MIC/2CELL 39WH/ WIFI 1X1 AC+BT4.0 / Keyboard ENGLISH/FREE-DOS /  WHITE/ FREE BackPack / FREE Kaspersky  /  2 Year Carry In', CAST(68 AS Numeric(5, 0)), N'LENOVO ideaPad 510-15ISK', 0, N'~/Chi-tiet-san-pham/LENOVO-ideaPad-510-15ISK/66', CAST(17550000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (67, 1, N'LENOVO 80SL006RVN', N'(NB) LENOVO IdeaPad 310-14ISK i5-6200U/4GD4/500G5/14.0HD/BT4/2C30WHr/ĐEN/DOS', CAST(69 AS Numeric(5, 0)), N'LENOVO 80SL006RVN', 0, N'~/Chi-tiet-san-pham/LENOVO-80SL006RVN/67', CAST(10000000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (68, 1, N'LENOVO 80SL006RVN', N'(NB) LENOVO IdeaPad 310-14ISK i5-6200U/4GD4/500G5/14.0HD/BT4/2C30WHr/ĐEN/DOS', CAST(70 AS Numeric(5, 0)), N'LENOVO 80SL006RVN', 0, N'~/Chi-tiet-san-pham/LENOVO-80SL006RVN/68', CAST(10100000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (69, 1, N'LENOVO 80SM010XVN', N'(NB) LENOVO IdeaPad 310-15ISK i5-6200U/4GD4/500G5/15.6HD/BT4/2C39WHr/ĐEN/W10SL/2G_920M', CAST(71 AS Numeric(5, 0)), N'LENOVO 80SM010XVN', 0, N'~/Chi-tiet-san-pham/LENOVO-80SM010XVN/69', CAST(11865000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (70, 1, N'LENOVO 80Q20087VN', N'(NB) LENOVO IdeaPad 500s-13ISK i3-6100U/4G/500G5+8GSSD/13.3HD/BT4/2C35Whr/ĐỎ/DOS', CAST(72 AS Numeric(5, 0)), N'LENOVO 80Q20087VN', 0, N'~/Chi-tiet-san-pham/LENOVO-80Q20087VN/70', CAST(10820000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (71, 1, N'LENOVO 80Q20086VN', N'(NB) LENOVO IdeaPad 500s-13ISK i3-6100U/4G/500G5+8GSSD/13.3HD/BT4/2C35Whr/TRẮNG/DOS', CAST(73 AS Numeric(5, 0)), N'LENOVO 80Q20086VN', 0, N'~/Chi-tiet-san-pham/LENOVO-80Q20086VN/71', CAST(10820000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (72, 1, N'LENOVO 80Q2001QVN', N'(NB) LENOVO IdeaPad 500s-13ISK i5-6200U/4G/500G5/13.3HD/BT4/2C35Whr/TRẮNG/DOS', CAST(74 AS Numeric(5, 0)), N'LENOVO 80Q2001QVN', 0, N'~/Chi-tiet-san-pham/LENOVO-80Q2001QVN/72', CAST(12201000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (73, 1, N'LENOVO 80Q20049VN', N'(NB) LENOVO IdeaPad 500s-13ISK i5-6200U/4G/500G5+8GSSD/13.3HD/BT4/2C35Whr/ĐỎ/DOS', CAST(75 AS Numeric(5, 0)), N'LENOVO 80Q20049VN', 0, N'~/Chi-tiet-san-pham/LENOVO-80Q20049VN/73', CAST(12201000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (74, 1, N'LENOVO 80Q20048VN', N'(NB) LENOVO IdeaPad 500s-13ISK i5-6200U/4G/500G5+8GSSD/13.3HD/BT4/2C35Whr/TRẮNG/DOS', CAST(76 AS Numeric(5, 0)), N'LENOVO 80Q20048VN', 0, N'~/Chi-tiet-san-pham/LENOVO-80Q20048VN/74', CAST(12201000 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (75, 1, N'LENOVO 80NT00L8VN', N'(NB) LENOVO IdeaPad 500-15ISK i5-6200U/4G/500G5+8GSSD/DVDRW/15.6FHD/3DWC/BT/4C/ALU/ĐEN/DOS/2G_R7M360', CAST(77 AS Numeric(5, 0)), N'LENOVO 80NT00L8VN', 0, N'~/Chi-tiet-san-pham/LENOVO-80NT00L8VN/75', CAST(13579800 AS Decimal(10, 0)), N'~/Images/SanPham/lenovo.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (76, 1, N'HP Z6T25PA', N'(NB) HP 348 G4 i3-7100U/4GD4/500G7/DVDRW/14.0HD/FP/BT4/4C40WHr/BẠC/DOS', CAST(78 AS Numeric(5, 0)), N'HP Z6T25PA', 0, N'~/Chi-tiet-san-pham/HP-Z6T25PA/76', CAST(10370000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (77, 1, N'HP W5S59PA', N'(NB) HP 348 G3 i5-6200U/4G/500G7/DVDRW/14.0HD/FP/BT4/4C41WHr/BẠC/DOS', CAST(79 AS Numeric(5, 0)), N'HP W5S59PA', 0, N'~/Chi-tiet-san-pham/HP-W5S59PA/77', CAST(12207000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (78, 1, N'HP Z6T26PA', N'(NB) HP 348 G4 i5-7200U/4GD4/500G7/DVDRW/14.0HD/FP/BT4/4C40WHr/BẠC/DOS', CAST(80 AS Numeric(5, 0)), N'HP Z6T26PA', 0, N'~/Chi-tiet-san-pham/HP-Z6T26PA/78', CAST(12207000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (79, 1, N'HP P3V21PA', N'(NB) HP Pavilion 14-ab114TU i3-6100U/4G/500G5/DVDRW/14.0HD/BT4/4C41WHr/TRẮNG/DOS', CAST(81 AS Numeric(5, 0)), N'HP P3V21PA', 0, N'~/Chi-tiet-san-pham/HP-P3V21PA/79', CAST(9750000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (80, 1, N'HP T9F65PA', N'(NB) HP Pavilion 14-ab165TX i5-6200U/4G/500G5/DVDRW/14.0HD/BT4/4C41WHr/BẠC/DOS/2G_940M', CAST(82 AS Numeric(5, 0)), N'HP T9F65PA', 0, N'~/Chi-tiet-san-pham/HP-T9F65PA/80', CAST(13593000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (81, 1, N'HP X3B96PA', N'(NB) HP Pavilion 15-au023TU i3-6100U/4GD4/500G5/DVDRW/15.6HD/BT4/2C41WHr/BẠC/DOS', CAST(83 AS Numeric(5, 0)), N'HP X3B96PA', 0, N'~/Chi-tiet-san-pham/HP-X3B96PA/81', CAST(10458000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (82, 1, N'HP X3B97PA', N'(NB) HP Pavilion 15-au024TU i3-6100U/4GD4/500G5/DVDRW/15.6HD/BT4/2C41WHr/VÀNG/DOS', CAST(84 AS Numeric(5, 0)), N'HP X3B97PA', 0, N'~/Chi-tiet-san-pham/HP-X3B97PA/82', CAST(10458000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (83, 1, N'HP X3B98PA', N'(NB) HP Pavilion 15-au025TU i3-6100U/4GD4/500G5/DVDRW/15.6HD/BT4/2C41WHr/BẠC/WIN10SL', CAST(85 AS Numeric(5, 0)), N'HP X3B98PA', 0, N'~/Chi-tiet-san-pham/HP-X3B98PA/83', CAST(11470000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (84, 1, N'HP X3B99PA', N'(NB) HP Pavilion 15-au026TU i3-6100U/4GD4/500G5/DVDRW/15.6HD/BT4/2C41WHr/VÀNG/WIN10SL', CAST(86 AS Numeric(5, 0)), N'HP X3B99PA', 0, N'~/Chi-tiet-san-pham/HP-X3B99PA/84', CAST(11470000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
GO
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (85, 1, N'HP X1H03PA', N'Máy tính xách tay HP 14-am056TU (X1H03PA) (i5-6200U;4GB;500GB;DVDRW;14";Silver)', CAST(87 AS Numeric(5, 0)), N'HP X1H03PA', 0, N'~/Chi-tiet-san-pham/HP-X1H03PA/85', CAST(11500000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (86, 1, N'HP Z4Q96PA', N'Máy tính xách tay HP 14-am118TU (Z4Q96PA) (i5-7200U;4GB;500GB;DVDRW;14";Silver)', CAST(88 AS Numeric(5, 0)), N'HP Z4Q96PA', 0, N'~/Chi-tiet-san-pham/HP-Z4Q96PA/86', CAST(11790000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (87, 1, N'HP Z4Q99PA', N'Máy tính xách tay HP 14-am121TU (Z4Q99PA) (i5-7200U;4GB;500GB;DVDRW;14";White Silver)', CAST(89 AS Numeric(5, 0)), N'HP Z4Q99PA', 0, N'~/Chi-tiet-san-pham/HP-Z4Q99PA/87', CAST(11790000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (88, 1, N'HP Z4Q98PA', N'Máy tính xách tay HP 14-am120TU (Z4Q98PA) (i5-7200U;4GB;500GB;DVDRW;14";Natural silver ; Win 10)', CAST(90 AS Numeric(5, 0)), N'HP Z4Q98PA', 0, N'~/Chi-tiet-san-pham/HP-Z4Q98PA/88', CAST(12600000 AS Decimal(10, 0)), N'~/Images/SanPham/hp.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 2)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (89, 1, N'Panasonic KX-FL422', N'Panasonic KX-FL422', CAST(100 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser Panasonic KX-FL422</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax&nbsp;</span>Laser KX-FL422 thay thế cho model KX-FL402. Về cơ bản m&aacute;y Fax KX-FL422 c&oacute; t&iacute;nh năng kh&ocirc;ng kh&aacute;c nhiều so với KX-FL402. M&aacute;y Fax KX-FL422 thiết kế đẹp mềm mại, m&agrave;u sắc trang nh&atilde;, tinh tế, ph&iacute;m bấm lớn dễ sử dụng hơn so với KX-FL402.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">&ndash;</span>&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax</span>&nbsp;Laser m&agrave;u ghi bạc hoặc đen.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; M&agrave;n h&igrave;nh LCD 2 d&ograve;ng hiển thị t&ecirc;n v&agrave; số.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay chứa gi&acirc;y 200 trang.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Nhớ 150 trang gửi đi v&agrave; 100 trang gửi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Danh bạ lưu 100 t&ecirc;n v&agrave; số điện thoại.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng Copy n&acirc;ng cao ph&oacute;ng to 200%, thu nhỏ 50%, d&agrave;n trang tự động.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng Quick Scan.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng từ chối nhận fax tới 20 số.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Gửi Fax đến nhiều địa chỉ c&ugrave;ng l&uacute;c (20 số).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Nạp văn bản tự động(10 trang).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in 10 trang/ ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hiển thị số gọi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải 600&times;600 dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Malaysia.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-FL422/89', CAST(4099000 AS Decimal(10, 0)), N'~/Images/SanPham/636246037535264080.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (90, 1, N'Panasonic KX-FP701', N'Máy Fax giấy thường Panasonic KX-FP701', CAST(101 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="Máy Fax giấy thường Panasonic KX-FP701" src="http://www.sieuthivienthong.com/imgs/art/p_525_Panasonic-KX-FP701.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax giấy thường Panasonic KX-FP701</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">&ndash;</span>&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y fax</span><span style="box-sizing: inherit; font-weight: 600;">&nbsp;giấy thường Panasonic KX-FP701</span>&nbsp;kế thừa v&agrave; ph&aacute;t triển c&aacute;c t&iacute;nh năng của KX-FP342.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Fax li&ecirc;n tục 10 bản, fax theo tr&igrave;nh tự 20 địa chỉ c&ugrave;ng l&uacute;c.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Bộ nhớ 28 trang khi hết giấy.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in khoảng 4 trang/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Gửi fax theo giờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay chứa giấy 50 bản.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Từ chối fax kh&ocirc;ng mong muốn (10 số).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Danh bạ 100 số, 10 số gọi nhanh.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hiển thị v&agrave; lưu 30 số gọi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Cuộn Film theo m&aacute;y d&agrave;i 20 m&eacute;t, cuộn Film thay thế khi hết Film d&agrave;i 70m (<span style="box-sizing: inherit; font-weight: 600;">KX-FA57</span>).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Malaysia.</span></p>
', 1, N'~/Chi-tiet-san-pham/Panasonic-KX-FP701/90', CAST(2099000 AS Decimal(10, 0)), N'~/Images/SanPham/636246040954159630.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (91, 1, N'Panasonic KX-FT983', N'Máy Fax giấy nhiệt Panasonic KX-FT983', CAST(102 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 500; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	<img alt="Máy Fax giấy nhiệt Panasonic KX-FT983" src="http://www.sieuthivienthong.com/imgs/art/p_981_panasonic-kx-ft-983.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></h2>
<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 500; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax giấy nhiệt Panasonic KX-FT983</span></h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; B&agrave;n ph&iacute;m vu&ocirc;ng.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy tự động 10 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; M&agrave;n h&igrave;nh LCD hiển thị 2 d&ograve;ng.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">&ndash;</span>&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y fax</span>&nbsp;c&oacute; 100 số nhớ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; C&oacute; n&uacute;t Navigator để d&ograve; t&igrave;m bộ nhớ nhanh.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; C&oacute; cổng nối với m&aacute;y ghi &acirc;m.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tự động cắt giấy.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Gởi 1 nội dung đến 10 địa chỉ kh&aacute;c nhau.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hiển thị số gọi đến (hệ FSK &amp; DTMK).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Lưu được 30 số gọi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Lưu 28 trang khi hết giấy.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ gủi fax 15 gi&acirc;y/trang.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay gửi fax 15 trang.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Sử dụng cuộn giấy nhiệt d&agrave;i 30m.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chỉnh &acirc;m lượng điện tử.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng cấm nhận fax khi kh&ocirc;ng cần thiết.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Malaysia.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-FT983/91', CAST(2099000 AS Decimal(10, 0)), N'~/Images/SanPham/636246043701046743.jpg', CAST(0x0000A73700B40017 AS DateTime), 1, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (92, 1, N'Panasonic KX-FT987', N'Máy Fax giấy nhiệt Panasonic KX-FT987', CAST(103 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&nbsp;</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="Máy Fax giấy nhiệt Panasonic KX-FT987" src="http://www.sieuthivienthong.com/imgs/art/p_982_Panasonic-KX-FT987.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax giấy nhiệt Panasonic KX-FT987</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; B&agrave;n ph&iacute;m vu&ocirc;ng.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Ghi &acirc;m 2 chiều v&agrave; trả lời tự động.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; SP-Phone hai chiều.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy tự động 10 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; M&agrave;n h&igrave;nh LCD hiển thị 2 d&ograve;ng.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">&ndash;</span>&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y fax</span>&nbsp;c&oacute; 100 số nhớ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; C&oacute; n&uacute;t Navigator để d&ograve; t&igrave;m bộ nhớ nhanh.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tự động cắt giấy.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Gởi 1 nội dung đến 10 địa chỉ kh&aacute;c nhau.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hiển thị số gọi đến (hệ FSK &amp; DTMK).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Lưu được 30 số gọi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Lưu 28 trang khi hết giấy.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ gủi fax 15 gi&acirc;y/trang.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay gửi fax 15 trang.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Sử dụng cuộn giấy nhiệt d&agrave;i 30m.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chỉnh &acirc;m lượng điện tử.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng cấm nhận fax khi kh&ocirc;ng cần thiết.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Malaysia.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-FT987/92', CAST(2910000 AS Decimal(10, 0)), N'~/Images/SanPham/636246045415724817.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (93, 1, N'Panasonic KX-MB2085', N'Máy Fax Laser đa chức năng Panasonic KX-MB2085', CAST(104 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser đa chức năng Panasonic KX-MB2085</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M&aacute;y Fax Lazer đa chức năng:&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Print, Copy, Scan, Fax</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tốc độ in v&agrave; copy l&ecirc;n tới 26 trang/ph&uacute;t</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Khay đựng giấy 250 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dung lượng bộ nhớ 32MB</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chức năng Copy ph&oacute;ng to thu nhỏ trong phạm vi&nbsp; 25-400%</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chức năng&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Scan to PC</span>&nbsp;(Th&ocirc;ng qua cổng USB).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T&iacute;ch hợp với điện thoại.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M&agrave;n h&igrave;nh hiển thị số gọi đến.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cổng kết nối: USB.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sử dụng mực KX-FAT411, Drum KX-FAD412.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">&nbsp;</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">Đặc t&iacute;nh kỹ thuật</span></p>
<table style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="11" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">General</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Printing Process</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Monochrome Laser</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Recording Paper Size</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				A4, Letter, Legal, B5(JIS/ISO), 16K, 216 x 330 mm, 216 x 340 mm</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Recording Paper Capacity</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				250 sheets + 1 sheet manual tray</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Automatic Document Feeder Capacity</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				20 sheets</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">LCD Display</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				16 digits / 2 lines (Backlit LCD)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Memory Size</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				32 MB</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Computer Interface</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				USB</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="2" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Power Consumption</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Maximum: Approx. 1000 W, Copy: Approx. 500 W,</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Ready: Approx. 65W, Sleep: Less than 2.7 W</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Dimensions (W x D x H)</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				420 x 432 x 305 mm</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Weight</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Approx. 12 kg</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="4" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Printer</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Print Speed</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Up to 26 ppm (A4)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Print Resolution</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				600 x 600 dpi</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Emulation</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				GDI</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Supported OS</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Windows&reg;&nbsp;XP, Windows Vista&reg;, Windows&reg;&nbsp;7, Windows&reg;&nbsp;8, Windows Server&reg;&nbsp;2008, Windows Server&reg;&nbsp;2012, Mac OS X 10.5 &ndash; 10.8, Linux&reg;</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="5" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Copier</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Copy Speed</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Up to 26 cpm (A4)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Copy Resolution</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Up to 600 x 600 dpi</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Multi-Copy</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				99 pages</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Reduction / Enlargement</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				25 % &ndash; 400 % (1 % step)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Copy Function</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Quick ID, N-in-1, Separate N-in-1, Poster, Image Repeat, Edge/Margin</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="4" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Scanner</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Color / Mono Scan</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Yes / Yes</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Scan Resolution</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Up to 600 x 1200 dpi (Optical) / Up to 19200 x 19200 dpi (Interpolated)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Scan Function</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Scan to PC (via USB only)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Supported OS</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Windows&reg;&nbsp;XP, Windows Vista&reg;, Windows&reg;&nbsp;7,Windows&reg;&nbsp;8, Mac OS X 10.5 &ndash; 10.8, Linux&reg;</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="4" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Fax</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Modem Speed</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				33.6 kbps &ndash; 2.4 kbps with automatic fallback</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Memory Size</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				3.5 MB (Reception: Approx. 110 pages / Transmission: Approx. 150 pages)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Phonebook</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				100 + 6 stations</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">One-Touch Dial</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				6 stations</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="2" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Consumables</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Toner cartridge</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				KX-FAT411 (2,000 pages, ISO/IEC 19752 standard)</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<span style="box-sizing: inherit; font-weight: 600;">Drum cartridge</span></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				KX-FAD412 (6,000 pages)</td>
		</tr>
	</tbody>
</table>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Malaysia.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-MB2085/93', CAST(4799000 AS Decimal(10, 0)), N'~/Images/SanPham/636246048973818328.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (94, 1, N'Panasonic KX-MB2120', N'Máy Fax Laser đa chức năng Panasonic KX-MB2120', CAST(105 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser đa chức năng Panasonic KX-MB2120</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser đa chức năng: In-Copy-Scan-Fax.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Chức năng in 2 mặt tự động.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng in bảo mật: In ấn với mật khẩu nhằm tr&aacute;nh mất m&aacute;t t&agrave;i liệu quan trọng (Gởi dữ liệu in đến m&aacute;y in với Password, đến m&aacute;y in nhập Password đ&uacute;ng th&igrave; m&aacute;y in sẽ in).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Vận h&agrave;nh nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng với ph&iacute;m&nbsp;<span style="box-sizing: inherit; font-weight: 600;">QUICK-JOB</span>&nbsp;(Ph&iacute;m tắt được c&agrave;i đặt cho c&aacute;c chức năng Scan/Copy thường xuy&ecirc;n sử dụng).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in 2 mặt: 24 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in 1 mặt: 26 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải in: 600x600dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ copy: 26 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải copy: 600x600dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng copy li&ecirc;n tục l&ecirc;n đến 99 bản.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Copy ph&oacute;ng to thu nhỏ: Từ 25-400%.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng copy: Quick ID, N-in-1, Separate N-in-1, Poster, Image Repeat, Edge/Margin.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải Scan: Quang học 600x1200dpi, nội suy 19.200dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng Scan v&agrave;o m&aacute;y t&iacute;nh.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ Fax: 33.6kbp/s</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Bộ nhớ Fax: 3MB lưu được 80 trang Fax nhận, 150 trang Fax truyền đi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Danh bạ địa chỉ: 100 số.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Super G3 Fax.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng Fax/Tel.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tay nghe điện thoại thiết kế gọn g&agrave;ng, tiện lợi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Khay nạp bản gốc t&agrave;i liệu tự động ADF: 35 tờ.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy v&agrave;o: 250 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy bằng tay: 1 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay giấy ra: 100 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; M&agrave;n h&igrave;nh LCD 2 d&ograve;ng, 16 k&yacute; tự.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Cổng kết nối: Hi-Speed USB 2.0</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Bộ nhớ: 64MB.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hệ điều h&agrave;nh tương th&iacute;ch: Windows&reg; XP, Windows Vista&reg;, Windows&reg; 7, Windows&reg; 8, Windows&reg; 8.1, Windows Server&reg; 2008, Windows Server&reg; 2012, Mac OS X 10.5 &ndash; 10.9, Linux&reg;</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Sử dụng Drum thay thế KX-FAD473 (Khoảng 10.000 trang), hộp mực KX-FAT472 (Khoảng 2.000 trang).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; K&iacute;ch thước (Bao gồm tay nghe điện thoại): 447x400x320mm.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Trọng lượng: 12kg.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Việt Nam.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-MB2120/94', CAST(4999000 AS Decimal(10, 0)), N'~/Images/SanPham/636246049963124913.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (95, 1, N'Panasonic KX-MB2130', N'Máy Fax Laser đa chức năng Panasonic KX-MB2130', CAST(106 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser đa chức năng Panasonic KX-MB2130</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">M&aacute;y Fax Laser đa chức năng: In-Copy-Scan-Fax-Network</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Chức năng in 2 mặt tự động, in qua mạng LAN.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng in bảo mật: In ấn với mật khẩu nhằm tr&aacute;nh mất m&aacute;t t&agrave;i liệu quan trọng (Gởi dữ liệu in đến m&aacute;y in với Password, đến m&aacute;y in nhập Password đ&uacute;ng th&igrave; m&aacute;y in sẽ in).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Vận h&agrave;nh nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng với ph&iacute;m&nbsp;<span style="box-sizing: inherit; font-weight: 600;">QUICK-JOB</span>&nbsp;(Ph&iacute;m tắt được c&agrave;i đặt cho c&aacute;c chức năng Scan/Copy thường xuy&ecirc;n sử dụng).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; In ấn từ xa từ c&aacute;c thiết bị di động hoặc m&aacute;y t&iacute;nh: Tương th&iacute;ch với chức năng in điện to&aacute;n đ&aacute;m m&acirc;y của Google&reg; Cloud Print &trade; v&agrave; ứng dụng in tr&ecirc;n điện thoại di động, cho ph&eacute;p in ấn từ c&aacute;c thiết bị di động hoặc m&aacute;y t&iacute;nh từ xa một c&aacute;ch dễ d&agrave;ng.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in 2 mặt: 24 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ in 1 mặt: 26 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải in: 600x600dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ copy: 26 trang A4/ph&uacute;t.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải copy: 600x600dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng copy li&ecirc;n tục l&ecirc;n đến 99 bản.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Copy ph&oacute;ng to thu nhỏ: Từ 25-400%.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng copy: Quick ID, N-in-1, Separate N-in-1, Poster, Image Repeat, Edge/Margin.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Độ ph&acirc;n giải Scan: Quang học 600x1200dpi, nội suy 19.200dpi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Chức năng Scan: Scan to PC/Email Address/FTP/SMB.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tốc độ Fax: 33.6kbp/s</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Chức năng: Fax to Email, Web Fax Preview.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Bộ nhớ Fax: 3MB lưu được 80 trang Fax nhận, 150 trang Fax truyền đi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Danh bạ địa chỉ: 100 số.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Super G3 Fax.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Chức năng Fax/Tel.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Tay nghe điện thoại thiết kế gọn g&agrave;ng, tiện lợi.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Khay nạp bản gốc t&agrave;i liệu tự động ADF: 35 tờ.</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy v&agrave;o: 250 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay nạp giấy bằng tay: 1 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Khay giấy ra: 100 tờ.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; M&agrave;n h&igrave;nh LCD 2 d&ograve;ng, 16 k&yacute; tự.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Cổng kết nối: 100Base-Tx/10Base-T LAN, Hi-Speed USB 2.0</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Bộ nhớ: 64MB.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Hệ điều h&agrave;nh tương th&iacute;ch: Windows&reg; XP, Windows Vista&reg;, Windows&reg; 7, Windows&reg; 8, Windows&reg; 8.1, Windows Server&reg; 2008, Windows Server&reg; 2012, Mac OS X 10.5 &ndash; 10.9, Linux&reg;</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Sử dụng Drum thay thế KX-FAD473 (Khoảng 10.000 trang), hộp mực KX-FAT472 (Khoảng 2.000 trang).</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; K&iacute;ch thước (Bao gồm tay nghe điện thoại): 447x400x320mm.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash; Trọng lượng: 12kg.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&ndash;&nbsp;<span style="box-sizing: inherit; font-weight: 600;">Sản xuất tại Việt Nam.</span></p>
', 0, N'~/Chi-tiet-san-pham/Panasonic-KX-MB2130/95', CAST(5499000 AS Decimal(10, 0)), N'~/Images/SanPham/636246050860906263.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (96, 1, N'Adaptor SC', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(120 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<table cellpadding="0" cellspacing="0" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="100%">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td class="textbody" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" valign="top">
				<div class="title_other" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					Adaptor SC</div>
				<div style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
						Adapter SC được sử dụng trong c&aacute;c tủ, rack ODF, hỗ trợ kết nối c&aacute;c loại đầu connector.<br style="box-sizing: inherit;" />
						Ưu điểm của đầu nối h&atilde;ng Orion l&agrave; dễ sử dụng, c&oacute; suy hao thấp v&agrave; gi&aacute; th&agrave;nh rẻ.</h4>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Adaptor-SC/96', CAST(0 AS Decimal(10, 0)), N'', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (97, 1, N'Bút soi quang', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(121 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="Máy dò tìm lỗi cáp quang, kiểu bút Myway VFL-250" src="http://www.sieuthivienthong.com/imgs/art/p_11978_Myway-VFL-250.JPG" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	M&aacute;y d&ograve; t&igrave;m lỗi c&aacute;p quang l&agrave; thiết bị x&aacute;c định vị tr&iacute; hư hỏng gi&uacute;p cho việc quan s&aacute;t bằng mắt, c&oacute; h&igrave;nh dạnh như một c&acirc;y viết, c&oacute; nguồn tia laser m&agrave;u đỏ nh&igrave;n thấy gi&uacute;p t&igrave;m được những chỗ bị đứt hoặc bị g&atilde;y tr&ecirc;n d&acirc;y quang</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Ph&aacute;t ra tia laser đỏ tại một đầu d&acirc;y quang, tia n&agrave;y sẽ ph&aacute;t ra tại điểm d&acirc;y bị đứt hoặc g&atilde;y, gi&uacute;p cho việc kiểm tra v&agrave; t&igrave;m ra hư hỏng trong mạng LAN, thẩm định được t&iacute;nh li&ecirc;n tục, kiểm so&aacute;t c&aacute;c đoạn c&aacute;p bị nứt (trong c&aacute;c trường hợp c&aacute;p c&oacute; chỗ nối), đầu nối kh&ocirc;ng tốt v&agrave; c&aacute;c trường hợp c&aacute;p g&atilde;y.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Ph&ugrave; hợp cho việc kiểm tra sợi đơn mode v&agrave; sợi đa mode.</p>
', 0, N'~/Chi-tiet-san-pham/But-soi-quang/97', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246056016011119.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (98, 1, N'Dao cắt CT 06 Fujikura', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(122 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	CT-06A dao cắt ch&iacute;nh x&aacute;c sợi c&aacute;p quang Fujikura l&agrave; phi&ecirc;n bản cải thiện của model CT-05 đưa ra g&oacute;c cắt chất lượng với gi&aacute; trị kinh tế. Sản phẩm được thiết kế cho sợi đơn mode, ph&ugrave; hợp cho thi c&ocirc;ng h&agrave;n nối c&aacute;p quang v&agrave; mối h&agrave;n cơ kh&iacute;. Tuổi thọ lưỡi l&acirc;u hơn, 16 vị tr&iacute; xoay gi&uacute;p thao t&aacute;c cắt chỉ trong 2 bước, t&iacute;ch hợp bộ đựng mảnh vụn sợi</h3>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	&nbsp;&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Đặc điểm ch&iacute;nh</span></h3>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Sử dụng cho sợi single &ndash; mode (Đơn mode)</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Vận h&agrave;nh đơn giản</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Tuổi thọ lưỡi với 48,000 lượt cắt</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Chắc bền v&agrave; nhẹ</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Trang bị bộ phận đựng mảnh vụn sợi</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Độ d&agrave;i đoạn cắt: CT-06 : 10mm với bộ kẹp sợi; CT-06A &ndash; 5 (20 mm with 250 &mu;m); CT-06A &ndash; 10 (20 mm with 900 &mu;m)</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		G&oacute;c cắt trung b&igrave;nh: 1˚</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Trọng lượng: 225g</li>
</ul>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Th&ocirc;ng tin đặt h&agrave;ng dao cắt CT-06A Fujikura</span></h3>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		AD-10 bản adapter (CT-06A)</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Hộp đựng CC-28</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Bộ đựng vụn sợi</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		HDSD</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">CB-05 lưỡi dao thay thế cho dao cắt CT-06A</span></li>
</ul>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	So với&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">dao cắt sợi quang FC-6S</span>&nbsp;th&igrave; CT-06A c&oacute; nhiều ưu điểm hơn về vận h&agrave;nh. Thiết kế lưỡi dao được bao bọc tr&ecirc;n trong, r&uacute;t gọn thao t&aacute;c cắt</p>
', 0, N'~/Chi-tiet-san-pham/Dao-cat-CT-06-Fujikura/98', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246056795665712.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (99, 1, N'Dao rọc vỏ cáp quang', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(123 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Việc thi c&ocirc;ng c&agrave;i đặt mạng c&aacute;p quang kh&ocirc;ng thể thiếu dụng cụ rọc vỏ ngo&agrave;i sợi c&aacute;p quang (cable stripper). Hiện nay tr&ecirc;n thị trường c&oacute; nhiều loại k&igrave;m, dao b&oacute;c t&aacute;ch vỏ thuận tiện cho c&aacute;c kĩ sư, nh&acirc;n c&ocirc;ng khi thao t&aacute;c v&agrave; th&iacute;ch hợp cho nhiều loại c&aacute;p m&agrave; bao gồm c&aacute;p đồng trục, c&aacute;p quang v&agrave; utp.</span>&nbsp;Larry, một cố vấn đ&agrave;o tạo v&agrave; huấn luyện cho bộ phận viễn th&ocirc;ng tại tập đo&agrave;n 3M đ&atilde; chia sẻ:<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">&nbsp;&ldquo;Một khi bạn thực hiện xong bước tuốt sợi quang, phần c&ograve;n lại của c&ocirc;ng việc kh&aacute; dễ d&agrave;ng&rdquo;</em>&nbsp;C&oacute; nhiều loại&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">dao dọc vỏ c&aacute;p</span>&nbsp;c&oacute; thể th&iacute;ch hợp cho nhiều loại c&aacute;p ,c&aacute;p đồng trục, c&aacute;p quang, v&agrave; c&aacute;p xoắn đ&ocirc;i UTP. Tuy nhi&ecirc;n một v&agrave;i loại c&aacute;p UTP được thiết kế cho tốc độ dữ liệu cao y&ecirc;u cầu loại k&igrave;m b&oacute;c t&aacute;ch đặc trưng được cung cấp bởi c&aacute;c nh&agrave; sản xuất, Một số trong ch&uacute;ng c&oacute; h&igrave;nh dạng bất thường<br style="box-sizing: inherit;" />
	Nếu bạn l&agrave; một d&acirc;n &ldquo;ngoại đạo&rdquo; b&ecirc;n ngo&agrave;i ng&agrave;nh viễn th&ocirc;ng, bạn c&oacute; thể bắt gặp 2 loại dụng cụ : dạng k&igrave;m v&agrave; dạng dao thực hiện c&ugrave;ng chức năng giống nhau.<br style="box-sizing: inherit;" />
	Loại thứ nhất giống như cặp trượt khớp với chế kẹp đầu tại đỉnh của dụng cụ chứa đựng lưỡi dao m&agrave; c&oacute; thể xoay 360o</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Loại kh&aacute;c kh&ocirc;ng c&oacute; tay cầm, người sử dụng đặt c&aacute;p b&ecirc;n trong dao v&agrave; quay c&aacute;i dụng cụ, hầu hết loại n&agrave;y với lưỡi c&oacute; thể quay 90o để cho ph&eacute;p cắt giảm theo chiều dọc</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Loại 1 dễ sử dụng hơn &ldquo;với loại c&oacute; lưỡi dao quay , bạn thường phải di chuyển dọc th&acirc;n c&aacute;p</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<a href="http://phukienquang.net/wp-content/uploads/2014/08/dao-doc-vo-ngoai-soi-cap-quang-don-gian.jpg" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-decoration: none; color: rgb(201, 113, 120); transition: all 0.3s ease 0s;"><img alt="dao dọc vỏ ngoài sợi cáp quang" class="alignnone size-full wp-image-575" height="173" src="http://phukienquang.net/wp-content/uploads/2014/08/dao-doc-vo-ngoai-soi-cap-quang-don-gian.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; border: 0px;" width="252" /></a></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	K&iacute;ch thước v&agrave; thiết kế ảnh hưởng đến việc chọn sản phẩm của nh&acirc;n vi&ecirc;n thi c&ocirc;ng;&nbsp;<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">&ldquo;bạn sẽ kh&ocirc;ng muốn mang một dụng cụ cồng kềnh, người thi c&ocirc;ng muốn những sản phẩm gọn nhẹ, dễ d&agrave;ng thao t&aacute;c di chuyển&rdquo;</em>&nbsp;quản l&yacute; b&aacute;n h&agrave;ng The Ripley chia sẻ (Rick salvas)<br style="box-sizing: inherit;" />
	<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">&ldquo;m&ocirc;t sản phẩm m&agrave; đặt &iacute;t lực l&ecirc;n tay , cổ tay sẽ thuận tiện cho người d&ugrave;ng&rdquo;&nbsp;</em>Jerry sgrignoli n&oacute;i.</p>
<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Để đạt được điều n&agrave;y, nh&agrave; sản xuất phải hướng đến loại&nbsp;<a href="http://phukienquang.net/dung-cu-thi-cong/dao-doc-vo-cap-quang/dao-roc-vo-cap-quang-densan-nd-800/" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-decoration: none; color: rgb(201, 113, 120); transition: all 0.3s ease 0s;" title="dao roc va dao vo ngoai cap quang">dao rọc vỏ c&aacute;p&nbsp;</a>thiết kế thoải m&aacute;i &iacute;t sử dụng đến lực t&aacute;c động của con người khi thao t&aacute;c</h4>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Dao-roc-vo-cap-quang/99', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246057525617463.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (100, 1, N'Dây nhảy quang', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(124 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Day-nhay-quang/100', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246058108690813.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (101, 1, N'Dụng cụ lau đầu connector sợi quang', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(125 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="dung-cu-lau-dau-soi-quang-connector-" class="alignnone size-medium wp-image-78" height="214" sizes="(max-width: 300px) 100vw, 300px" src="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector--300x214.png" srcset="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector--300x214.png 300w, http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector--280x200.png 280w, http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-.png 336w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="300" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Dụng cụ lau đầu connector quang&nbsp;</span>được thiết kế cho tất cả c&aacute;c loại đầu nối: SC, FC, ST, SC2, MU, LC.<br style="box-sizing: inherit;" />
	Với Single Mode việc d&iacute;nh bụi v&agrave; chất bẩn c&oacute; thể g&acirc;y ra sự suy hao lớn, thậm ch&iacute; gi&aacute;n đoạn việc kết nối t&iacute;n hiệu đường truyền</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	* L&agrave;m sạch m&agrave; kh&ocirc;ng ảnh hưởng đến bề mặt</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	* K&iacute;ch thước nhỏ gọn, dễ thao t&aacute;c</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	* C&oacute; thể sử dụng đến 500 lần</p>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Tại sao ch&uacute;ng ta cần sử dụng &ndash; Dụng cụ lau đầu connector quang</h3>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	Đầu connector bẩn sẽ g&acirc;y ra việc truyền dẫn t&iacute;n hiệu k&eacute;m chất lượng, sụ mất m&aacute;t suy hao lớn.</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="dung-cu-lau-dau-soi-quang-connector-002" class="size-medium wp-image-79 aligncenter" height="205" sizes="(max-width: 300px) 100vw, 300px" src="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-002-300x205.jpg" srcset="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-002-300x205.jpg 300w, http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-002.jpg 468w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; clear: both; display: block; margin: 0px auto;" width="300" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Kết quả</span></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="dung-cu-lau-dau-soi-quang-connector-003" class="size-medium wp-image-80 aligncenter" height="200" sizes="(max-width: 300px) 100vw, 300px" src="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-003-300x200.jpg" srcset="http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-003-300x200.jpg 300w, http://phukienquang.net/wp-content/uploads/2013/08/dung-cu-lau-dau-soi-quang-connector-003.jpg 468w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; clear: both; display: block; margin: 0px auto;" width="300" /></p>
', 0, N'~/Chi-tiet-san-pham/Dung-cu-lau-dau-connector-soi-quang/101', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246059090736983.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (102, 1, N'Đầu nối quang', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(126 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="productDetail" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<div class="detailLeft" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<div class="image-news" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<img alt="Đầu nối sợi quang và những điều cần biết" src="http://deconmit.com/images/stores/2014/12/09/capquang.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></div>
	</div>
	<div class="detailRight" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<h1 class="title" style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 36px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Đầu nối sợi quang v&agrave; những điều cần biết</h1>
		<div class="info-description" id="info-description" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			Kết nối sợi quang đ&oacute;ng vai tr&ograve; quan trọng đối với hiệu suất mạng. Việc tăng tốc độ truyền dữ liệu sẽ k&eacute;o theo y&ecirc;u cầu nghi&ecirc;m ngặt hơn về suy hao kết nối quang. Kh&aacute;ch h&agrave;ng lu&ocirc;n c&oacute; nhu cầu về đầu kết nối với độ suy hao thấp, nhỏ gọn, dễ thi c&ocirc;ng, sử dụng v&agrave; đặc biệt l&agrave; chi ph&iacute; thấp. Ch&iacute;nh v&igrave; vậy, c&aacute;c nh&agrave; l&agrave;m ti&ecirc;u chuẩn v&agrave; thiết kế cũng đưa ra kh&aacute; nhiều lựa chọn nhằm đ&aacute;p ứng nhu cầu của c&aacute;c đối tượng kh&aacute;c nhau.</div>
	</div>
</div>
<div class="pagetext" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		C&aacute;c đầu nối quang th&ocirc;ng dụng ng&agrave;y nay bao gồm chuẩn SC (Subscriber Connector), ST (Straight Tip) v&agrave; FC (Fiber Connector). B&ecirc;n cạnh đ&oacute;, c&aacute;c chuẩn đầu nối dạng nhỏ gọn (small-form-factor) như chuẩn LC (Lucent Connector) cũng được sử dụng với mục đ&iacute;ch tiết kiệm kh&ocirc;ng gian kết nối, đặc biệt l&agrave; những m&ocirc;i trường lu&ocirc;n thiếu kh&ocirc;ng gian như trung t&acirc;m dữ liệu. MPO (Multi-Fiber Push-On) cũng l&agrave; chuẩn kết nối đang dần trở n&ecirc;n phổ biến, được sử dụng trong m&ocirc;i trường mật độ cao với mỗi đầu nối MPO chứa đến 12 sợi quang hoặc hơn.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Mỗi thiết kế đều c&oacute; ưu v&agrave; nhược điểm ri&ecirc;ng, n&ecirc;n khi lựa chọn đầu nối, cần xem x&eacute;t những yếu tố quan trọng như: ứng dụng, tốc độ hỗ trợ truyền dữ liệu, y&ecirc;u cầu huấn luyện nh&acirc;n vi&ecirc;n thi c&ocirc;ng về c&aacute;c loại sợi quang (sợi quang singlemode v&agrave; multimode y&ecirc;u cầu c&aacute;c đầu nối kh&aacute;c nhau). B&agrave;i viết n&agrave;y sẽ cung cấp c&aacute;i nh&igrave;n tổng thể về đặc điểm v&agrave; t&iacute;nh năng của c&aacute;c loại đầu nối th&ocirc;ng dụng, gi&uacute;p người d&ugrave;ng c&oacute; được lựa chọn ph&ugrave; hợp để tối ưu hiệu suất cho hệ thống mạng.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">1. Vai tr&ograve; của đầu nối</span><br style="box-sizing: inherit;" />
		Đầu nối được d&ugrave;ng để kết nối hai sợi quang với nhau, cho ph&eacute;p &aacute;nh s&aacute;ng truyền từ l&otilde;i sợi quang n&agrave;y v&agrave;o l&otilde;i sợi kia, hoặc kết nối sợi quang v&agrave;o thiết bị truyền t&iacute;n hiệu quang. Để đạt được một kết nối tốt với mức suy hao thấp, hai l&otilde;i sợi quang phải được tiếp x&uacute;c thẳng h&agrave;ng v&agrave; bề mặt đầu nối quang phải được chăm s&oacute;c kỹ lưỡng, l&agrave;m sạch bụi v&agrave; c&aacute;c mảnh vỡ, mảnh vụn hoặc c&aacute;c vết trầy xước. Việc kết nối thẳng h&agrave;ng hai l&otilde;i sợi quang multimode (đường k&iacute;nh l&otilde;i lớn) sẽ dễ hơn so với sợi singlemode. Kết nối singlemode đ&ograve;i hỏi độ sai số nghi&ecirc;m ngặt hơn, bề mặt đầu nối phải được chăm s&oacute;c cẩn thận hơn. Một vết bẩn, trầy xước hay khiếm khuyết bất kỳ tr&ecirc;n bề mặt sợi quang đều ảnh hưởng trực tiếp đến hiệu suất kết nối.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">2. Cấu tạo một đầu nối</span><br style="box-sizing: inherit;" />
		<img src="http://nsp.com.vn/images/stories/kien-thuc/2014/10-21-dau-noi-soi-quang/capture.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /><br style="box-sizing: inherit;" />
		Một đầu nối c&oacute; c&aacute;c th&agrave;nh phần ch&iacute;nh như trong h&igrave;nh 1. Phần đầu sứ (ferrule) ở ph&iacute;a trước được thiết kế để hỗ trợ l&otilde;i sợi quang tiếp x&uacute;c thẳng h&agrave;ng, hạn chế suy hao kết nối. Phần ferrule n&agrave;y được giữ bởi một bộ phận c&oacute; chức năng như l&ograve; xo (collar assembly) ở ph&iacute;a trong phần th&acirc;n đầu nối, đẩy đầu ferrule về ph&iacute;a trước nhằm tạo tiếp x&uacute;c tốt khi kết nối hai đầu connector hoặc kết nối đến thiết bị. Ngo&agrave;i ra, ở ph&iacute;a cuối đầu nối quang thường c&oacute; một bộ phận gi&uacute;p tăng khả năng chống vặn xoắn v&agrave; độ chịu tải khi k&eacute;o c&aacute;p. Đồng thời, phần đầu nhựa bảo vệ cuối đầu nối cũng gi&uacute;p hạn chế độ uốn cong khi kết nối c&aacute;p v&agrave;o thiết bị, giảm thiểu suy hao t&iacute;n hiệu quang.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Điều quan trọng l&agrave; đọc c&aacute;c đặc điểm kỹ thuật từ nh&agrave; sản xuất v&agrave; so s&aacute;nh hiệu suất kết nối của ứng dụng dự kiến. Ngo&agrave;i ra, cũng n&ecirc;n xem x&eacute;t c&aacute;c yếu tố như k&iacute;ch thước hoặc loại c&aacute;p kết nối để chọn m&atilde; sản phẩm ph&ugrave; hợp.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">3. C&aacute;c vấn đề ảnh hưởng đến hiệu suất</span><br style="box-sizing: inherit;" />
		<img src="http://nsp.com.vn/images/stories/kien-thuc/2014/10-21-dau-noi-soi-quang/capture1.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /><br style="box-sizing: inherit;" />
		Để c&oacute; kết nối tốt, c&aacute;c l&otilde;i sợi quang cần được kết nối thẳng h&agrave;ng v&agrave; đảm bảo chất lượng bề mặt. Ở phần g&oacute;c tr&aacute;i h&igrave;nh 2, c&oacute; thể thấy khi hai sợi quang bị lệch trục, một phần &aacute;nh s&aacute;ng sẽ thất tho&aacute;t ra ngo&agrave;i, g&acirc;y mất t&iacute;n hiệu, giảm băng th&ocirc;ng v&agrave; giảm khoảng c&aacute;ch truyền của &aacute;nh s&aacute;ng trong sợi quang.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Lệch g&oacute;c đầu nối cũng l&agrave; trường hợp cần xem x&eacute;t (ở g&oacute;c tr&ecirc;n b&ecirc;n phải h&igrave;nh 2). C&oacute; thể tr&aacute;nh lệch g&oacute;c đầu nối bằng c&aacute;ch sử dụng đầu nối c&oacute; bề mặt ferrule dạng PC (Physical Contact). C&aacute;c ferrule n&agrave;y được thiết kế nhằm giữ sợi quang ở vị tr&iacute; thẳng khi kết nối, đồng thời gi&uacute;p giảm nguy cơ xuất hiện khoảng trống tại bề mặt tiếp x&uacute;c giữa hai đầu nối.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Khẩu độ hai sợi quang kh&ocirc;ng ph&ugrave; hợp cũng l&agrave; nguy&ecirc;n nh&acirc;n g&acirc;y thất tho&aacute;t &aacute;nh s&aacute;ng. Lỗi n&agrave;y c&oacute; thể do kết nối c&aacute;c loại sợi quang kh&aacute;c nhau hoặc của c&aacute;c nh&agrave; sản xuất kh&aacute;c nhau. Nhờ sự ph&aacute;t triển v&agrave; cải tiến c&ocirc;ng nghệ của c&aacute;c nh&agrave; sản xuất c&aacute;p sợi quang, một số vấn đề kh&aacute;c như đường k&iacute;nh l&otilde;i kh&aacute;c nhau, kh&ocirc;ng đồng t&acirc;m, l&otilde;i e-l&iacute;p hoặc đường k&iacute;nh lớp cladding kh&aacute;c nhau đ&atilde; kh&ocirc;ng c&ograve;n xuất hiện nữa.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">4. Chăm s&oacute;c bề mặt kết nối</span><br style="box-sizing: inherit;" />
		Bề mặt kết nối đ&oacute;ng vai tr&ograve; quyết định đối với hiệu suất kết nối quang. Sau khi thực hiện bấm đầu, cần m&agrave;i nhẵn c&aacute;c bề mặt đầu nối nhằm loại bỏ c&aacute;c vết bẩn v&agrave; khiếm khuyết. Qu&aacute; tr&igrave;nh n&agrave;y thường được thực hiện trong nh&agrave; m&aacute;y, nhưng c&oacute; một v&agrave;i loại đầu nối cần được m&agrave;i tại hiện trường. Việc n&agrave;y phải tiến h&agrave;nh tr&ecirc;n một miếng đệm mềm v&agrave; c&aacute;c loại giấy m&agrave;i th&iacute;ch hợp. Kỹ thuật m&agrave;i cũng tương đối đặc biệt với thao t&aacute;c chuyển động h&igrave;nh số t&aacute;m, nhằm m&agrave;i đều tất cả c&aacute;c g&oacute;c của đầu nối quang.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Một kiểu bề mặt kết nối quang th&ocirc;ng dụng l&agrave; UPC (Ultra Physical Contact), cung cấp hiệu suất kết nối cao. APC (Angled Physical Contact) cũng l&agrave; kiểu kết nối th&ocirc;ng dụng với bề mặt được v&aacute;t g&oacute;c 8 độ. Kiểu APC hạn chế phản xạ &aacute;nh s&aacute;ng tại bề mặt tiếp x&uacute;c, gi&uacute;p giảm độ suy hao tr&ecirc;n tuyến c&aacute;p quang. Loại đầu nối n&agrave;y thường được sử dụng trong m&ocirc;i trường viễn th&ocirc;ng v&agrave; c&aacute;c ứng dụng truyền h&igrave;nh.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Vấn đề nhiệt độ cũng cần được quan t&acirc;m đ&uacute;ng mức. Trong c&aacute;c m&ocirc;i trường khắc nghiệt c&oacute; nhiệt độ từ -40&deg;C đến 85&deg;C, sợi quang v&agrave; ferrule c&oacute; thể bị dịch chuyển, thay đổi h&igrave;nh dạng, dẫn đến việc giảm hiệu suất kết nối.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">5. Y&ecirc;u cầu về hiệu suất</span><br style="box-sizing: inherit;" />
		Ti&ecirc;u chuẩn ANSI/TIA-568-C.3 x&aacute;c định hiệu suất c&aacute;c đầu nối quang sử dụng trong hệ thống c&aacute;p cấu tr&uacute;c. Suy hao quang l&agrave; th&ocirc;ng số quan trọng nhất được sử dụng để đo lường hiệu suất v&agrave; l&agrave; thước đo nghiệm thu đầu nối thi c&ocirc;ng tại hiện trường. D&ugrave; ti&ecirc;u chuẩn x&aacute;c định giới hạn tối đa cho th&ocirc;ng số suy hao quang l&agrave; 0,75 dB tr&ecirc;n mỗi cặp đầu nối (một khớp nối), nhưng t&ugrave;y thuộc ứng dụng, chủ đầu tư c&oacute; thể y&ecirc;u cầu th&ocirc;ng số nghi&ecirc;m ngặt hơn. Th&ocirc;ng số phản xạ (Reflection), c&ograve;n gọi l&agrave; suy hao phản xạ (Return Loss) được giới hạn tối thiểu l&agrave; 20 dB với sợi quang multimode v&agrave; 26 dB với sợi quang singlemode. Muốn giảm th&ocirc;ng số phản xạ, cần sử dụng kiểu bề mặt đầu nối APC. Dải nhiệt độ hoạt động cho đầu nối quang cũng được x&aacute;c định trong ti&ecirc;u chuẩn TIA 568-C, từ -10&deg;C đến 60&deg;C, c&oacute; khả năng chịu được độ ẩm, t&aacute;c động v&agrave; c&aacute;c loại lực căng g&acirc;y ra do vặn xoắn v&agrave; uốn cong. Để nắm r&otilde; y&ecirc;u cầu n&agrave;y, cần tham khảo t&agrave;i liệu từ nh&agrave; sản xuất về c&aacute;c giới hạn cho sản phẩm.<br style="box-sizing: inherit;" />
		<img src="http://nsp.com.vn/images/stories/kien-thuc/2014/10-21-dau-noi-soi-quang/a.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /></p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">6. Lựa chọn đầu nối quang</span><br style="box-sizing: inherit;" />
		Tr&ecirc;n thị trường hiện nay c&oacute; h&agrave;ng chục loại đầu nối, b&agrave;i viết n&agrave;y chỉ ch&uacute; trọng đến c&aacute;c chuẩn th&ocirc;ng dụng, nhưng cũng sẽ đề cập đến c&aacute;c đầu nối như LC v&agrave; MPO đang được sử dụng như một tr&agrave;o lưu trong m&ocirc;i trường đặc th&ugrave;, hỗ trợ tốc độ cao v&agrave; tiết kiệm kh&ocirc;ng gian.<br style="box-sizing: inherit;" />
		<img src="http://nsp.com.vn/images/stories/kien-thuc/2014/10-21-dau-noi-soi-quang/b.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" /><br style="box-sizing: inherit;" />
		ST: l&agrave; đầu nối kiểu vặn đ&atilde; được sử dụng trong nhiều năm qua cho hệ thống mạng nội bộ với ứng dụng hỗ trợ 10Base-F v&agrave; 100Base-F. Hiện nay, ST kh&ocirc;ng c&ograve;n phổ biến nhưng c&oacute; thể dễ d&agrave;ng t&igrave;m thấy ch&uacute;ng trong h&agrave;ng triệu kết nối đ&atilde; được lắp đặt ở c&aacute;c hệ thống mạng cũ. Đầu nối ST sử dụng ferrule 2,5 mm với suy hao th&ocirc;ng thường l&agrave; 0,25 dB.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		SC: l&agrave; đầu nối sử dụng phương ph&aacute;p cắm/r&uacute;t khi kết nối. Dễ sử dụng v&agrave; hiệu suất cao, đầu nối SC l&agrave; một trong những loại phổ biến nhất, ở c&aacute;c hệ thống mạng chạy ứng dụng Gigabit Ethernet. Đầu nối SC cũng sử dụng ferrule 2,5 mm v&agrave; suy hao th&ocirc;ng thường l&agrave; 0,25 dB.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		LC: l&agrave; đầu nối c&oacute; k&iacute;ch thước nhỏ gọn (SFF) chỉ bằng một nửa k&iacute;ch thước đầu SC, sử dụng ferrule 1,25 mm, suy hao th&ocirc;ng thường 0,25 dB.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		MPO: l&agrave; đầu nối mật độ cao, chứa c&ugrave;ng l&uacute;c nhiều kết nối sợi quang, phương ph&aacute;p kết nối vẫn l&agrave; cắm r&uacute;t tương tự loại đầu SC v&agrave; LC. Mỗi đầu nối MPO c&oacute; thể chứa từ 4, 6, 12 đến 24, 48 hoặc thậm ch&iacute; 60 sợi quang. Do t&iacute;nh phức tạp v&agrave; y&ecirc;u cầu độ ch&iacute;nh x&aacute;c cao, loại đầu nối n&agrave;y hiện chỉ được bấm sẵn bởi nh&agrave; sản xuất. Người d&ugrave;ng phải đặt h&agrave;ng với chiều d&agrave;i cho trước chứ kh&ocirc;ng thể thực hiện bấm đầu tại hiện trường.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">7. Phương thức kết nối đầu cuối</span><br style="box-sizing: inherit;" />
		Trải qua nhiều năm ph&aacute;t triển c&ocirc;ng nghệ đầu nối quang, c&aacute;c nh&agrave; sản xuất đ&atilde; cho ra đời nhiều phương thức kết nối đầu cuối sợi quang. Việc lựa chọn phương thức kết nối đầu cuối thường phụ thuộc v&agrave;o kỹ năng của người thi c&ocirc;ng, c&aacute;c c&ocirc;ng cụ sẵn c&oacute; hay chỉ đơn giản theo sở th&iacute;ch. Một số phương thức c&oacute; sự kh&aacute;c biệt về hiệu suất quang, trong khi một số kh&aacute;c lại dễ sử dụng, gi&uacute;p tiết kiệm thời gian v&agrave; nh&acirc;n c&ocirc;ng.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		C&oacute; 4 phương thức cơ bản thường được sử dụng bao gồm: m&agrave;i đầu quang, h&agrave;n nhiệt (hay c&ograve;n gọi l&agrave; h&agrave;n hồ quang), h&agrave;n cơ học v&agrave; bấm đầu quang.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&agrave;i đầu quang</em>&ndash; phương thức n&agrave;y được sử dụng từ những năm 1980, khi kết nối sợi quang bắt đầu ph&aacute;t triển, v&agrave; vẫn c&ograve;n được sử dụng do c&oacute; độ suy hao thấp, đ&aacute;ng tin cậy v&agrave; chi ph&iacute; rất cạnh tranh. Phương ph&aacute;p n&agrave;y c&oacute; nhược điểm phức tạp v&agrave; mất thời gian loại bỏ c&aacute;c chất keo d&iacute;nh trong qu&aacute; tr&igrave;nh thi c&ocirc;ng. Đồng thời, chất lượng đầu nối cũng phụ thuộc nhiều v&agrave;o kỹ năng của người thi c&ocirc;ng n&ecirc;n cần phải được huấn luyện v&agrave; gi&aacute;m s&aacute;t kỹ lưỡng.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">H&agrave;n nhiệt</em>&ndash; d&ugrave;ng một sợi quang đ&atilde; được bấm sẵn một đầu (pigtail), sử dụng nhiệt độ cao của m&aacute;y h&agrave;ng để nung chảy v&agrave; kết d&iacute;nh mối nối. Ưu điểm của phương ph&aacute;p n&agrave;y l&agrave; đầu nối đ&atilde; được m&agrave;i sẵn bởi nh&agrave; sản xuất, hỗ trợ kết nối với suy hao v&agrave; mức độ phản xạ thấp. Tuy nhi&ecirc;n, nhược điểm l&agrave; chi ph&iacute; thiết bị cao, cần phải c&oacute; nguồn điện tại hiện trường để cung cấp cho thiết bị h&agrave;n, y&ecirc;u cầu cao về việc huấn luyện v&agrave; đ&agrave;o tạo kỹ năng sử dụng m&aacute;y.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">H&agrave;n cơ học</em>&ndash; cũng sử dụng sợi pigtail như h&agrave;n nhiệt nhưng lại kh&ocirc;ng d&ugrave;ng thiết bị h&agrave;n. Phương thức n&agrave;y bao gồm cắt v&agrave; tuốt đầu sợi quang bằng c&aacute;c c&ocirc;ng cụ chuy&ecirc;n dụng, sau đ&oacute; giữ ch&uacute;ng d&iacute;nh lại với nhau nhờ một th&agrave;nh phần được gọi l&agrave; mối nối cơ kh&iacute;. Phương ph&aacute;p n&agrave;y được thực hiện nhanh ch&oacute;ng, &iacute;t sử dụng c&ocirc;ng cụ, thời gian huấn luyện ngắn. Tuy nhi&ecirc;n, chi ph&iacute; vật tư cao, độ suy hao lớn hơn phương ph&aacute;p h&agrave;n nhiệt cũng l&agrave; một yếu tố để c&acirc;n nhắc.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Bấm đầu quang</em>&ndash; kh&ocirc;ng giống c&aacute;c phương thức trước, đầu nối được m&agrave;i sẵn bởi nh&agrave; sản xuất nhưng kh&ocirc;ng k&egrave;m theo đoạn sợi quang ngắn như pigtail. Người thi c&ocirc;ng chỉ cần tuốt v&agrave; cắt sợi quang bằng c&ocirc;ng cụ chuy&ecirc;n dụng, sau đ&oacute; luồn v&agrave;o b&ecirc;n trong đầu nối, sử dụng bộ c&ocirc;ng cụ bấm đầu th&iacute;ch hợp để kh&oacute;a giữ sợi quang v&agrave;o đầu nối quang. Thao t&aacute;c dễ d&agrave;ng v&agrave; nhanh ch&oacute;ng, c&oacute; khả năng thực hiện ở kh&ocirc;ng gian hẹp, vị tr&iacute; tr&ecirc;n cao. Nhược điểm của phương ph&aacute;p n&agrave;y chi ph&iacute; vật tư cao, suy hao cao hơn h&agrave;n nhiệt v&agrave; kh&ocirc;ng c&oacute; khả năng t&aacute;i sử dụng khi bấm đầu bị lỗi.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">8. L&agrave;m sạch v&agrave; nghiệm thu</span><br style="box-sizing: inherit;" />
		Trong những số trước đ&atilde; c&oacute; nhiều b&agrave;i viết đề cập đến tầm quan trọng của việc l&agrave;m sạch đầu nối quang, n&ecirc;n b&agrave;i viết n&agrave;y sẽ kh&ocirc;ng đề cập s&acirc;u về c&aacute;c phương thức l&agrave;m sạch, ngoại trừ việc nhắc lại cần l&agrave;m sạch bề mặt đầu nối đ&uacute;ng c&aacute;ch bằng c&aacute;c bộ c&ocirc;ng cụ v&agrave; dung dịch chuy&ecirc;n dụng. V&igrave; bụi bẩn, mảnh vụn hay vệt dầu từ ng&oacute;n tay người thi c&ocirc;ng đều ảnh hưởng nghi&ecirc;m trọng đến hiệu suất quang.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Khi đ&atilde; ho&agrave;n th&agrave;nh, cần tiến h&agrave;nh đo kiểm v&agrave; nghiệm thu hệ thống mạng sợi quang. C&aacute;ch phổ biến nhất l&agrave; đo suy hao quang bằng c&aacute;c loại m&aacute;y đo chuy&ecirc;n dụng. Tuy nhi&ecirc;n, c&aacute;ch đo n&agrave;y chỉ cho ra th&ocirc;ng số suy hao tr&ecirc;n to&agrave;n tuyến c&aacute;p, chứ kh&ocirc;ng cung cấp th&ocirc;ng số suy hao chi tiết tr&ecirc;n từng đầu nối. Khi suy hao vượt giới hạn cho ph&eacute;p v&agrave; kết quả đo kh&ocirc;ng được chấp nhận, c&aacute;c nh&agrave; thi c&ocirc;ng sẽ l&uacute;ng t&uacute;ng v&igrave; kh&ocirc;ng biết lỗi xảy ra ở vị tr&iacute; n&agrave;o, đặc biệt với c&aacute;c tuyến c&aacute;p quang c&oacute; nhiều khớp nối. Khi đ&oacute;, cần sử dụng thiết bị đo OTDR nhằm x&aacute;c định khoảng c&aacute;ch đến điểm lỗi, x&aacute;c định suy hao v&agrave; chất lượng từng khớp nối, từ đ&oacute; hạn chế thời gian m&ograve; mẫm v&agrave; thay thế c&aacute;c đầu nối một c&aacute;ch v&ocirc; &iacute;ch.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		<u style="box-sizing: inherit;"><span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Kết luận</span></u><br style="box-sizing: inherit;" />
		Hệ thống mạng sợi quang ng&agrave;y c&agrave;ng ph&aacute;t triển, k&eacute;o theo c&ocirc;ng nghệ đầu nối quang cũng c&oacute; những bước tiến vượt bậc với rất nhiều kiểu thiết kế tr&ecirc;n thị trường. Khi hệ thống mạng dịch chuyển theo xu hướng mật độ v&agrave; tốc độ ứng dụng cao, thị trường đầu nối cũng sẽ dịch chuyển đến c&aacute;c kiểu đầu nối nhỏ hơn như LC hoặc c&aacute;c đầu nối t&iacute;ch hợp nhiều sợi quang như MPO.</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Để đ&aacute;p ứng giới hạn ng&agrave;y c&agrave;ng chặt chẽ về độ suy hao cho ph&eacute;p của c&aacute;c ứng dụng như 40 GbE hay 100 GbE, c&aacute;c kỹ thuật vi&ecirc;n phải tu&acirc;n thủ quy tr&igrave;nh của nh&agrave; sản xuất bao gồm kiểm tra v&agrave; l&agrave;m sạch tất cả c&aacute;c đầu nối trước khi thực hiện kết nối. C&aacute;ch tiếp cận n&agrave;y sẽ đảm bảo hiệu suất, chất lượng v&agrave; độ tin cậy của hệ thống c&aacute;p sợi quang.</p>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Dau-noi-quang/102', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246060486176797.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (103, 1, N'Kìm tuốt sợi quang Miller', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(127 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span class="kiimtuotquang" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Với ba lỗ được thiết kế để&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">tuốt vỏ lớp ngo&agrave;i sợi c&aacute;p quang</span>&nbsp;đường k&iacute;nh 125mm , 250mm.</span></h3>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Sản phấm chuy&ecirc;n dụng cho thi c&ocirc;ng mạng c&aacute;p quang, kh&ocirc;ng điều chỉnh v&agrave; kh&ocirc;ng g&acirc;y mẻ sợi trong qu&aacute; tr&igrave;nh thao t&aacute;c. Bề mặt cắt của sợi dễ d&agrave;ng lau ch&ugrave;i, vệ sinh ; Kh&oacute;a chốt k&igrave;m ngay khi kh&ocirc;ng sử dụng</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<img alt="kim-tuot-soi-quang-3-lo" height="338" src="http://phukienquang.net/wp-content/uploads/2015/01/kim-tuot-soi-cap-quang-miller-cfs-3.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang 3 chức năng miller" width="555" /></p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					K&igrave;m được sử dụng để tuốt lớp vỏ bọc b&ecirc;n ngo&agrave;i v&agrave; lớp thủy tinh để chuẩn bị cho qu&aacute; tr&igrave;nh h&agrave;n nối. Thuận tiện vừa b&agrave;n tay, an to&agrave;n khi sử dụng được nh&agrave; sản xuất ưu ti&ecirc;n khi thiết kế sản phẩm</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="kim-tuot-soi-cap-quang-miller-my" height="261" src="http://phukienquang.net/wp-content/uploads/2015/01/su-dung-kim-tuot-soi-quang-miller.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang miller" width="429" /></td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="ban-kim-tuot-soi-cap-quang" height="254" src="http://phukienquang.net/wp-content/uploads/2015/01/su-dung-kim-tuot-soi-quang-miller-2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang Mỹ miller" width="418" /></td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Một số sản phẩm k&igrave;m tuốt mặt ngo&agrave;i sợi quang tr&ecirc;n thị trường</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
					<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">K&igrave;m tuốt sợi quang Pro&rsquo;skit 8PK-326</em></h2>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Sản phẩm<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">&nbsp;gồm 3 lỗ chức năng</em>, thiết kế gọn đẹp</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Xuất xứ: Đ&agrave;i Loan</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="kim-tuot-soi-cap-quang-pro-kit" src="http://phukienquang.net/wp-content/uploads/2015/01/kim-tuot-soi-quang-prokit.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang Mỹ miller" width="418" /></td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
					K&igrave;m tuốt sợi quang Miller</h2>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Model:&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">CFS-2</span></p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Xuất xứ : USA</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<em style="box-sizing: inherit; border: 0px; font-family: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Dao tuốt sợi quang 2 chức năng</em></h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&ndash; Tuốt lớp vỏ d&acirc;y nhảy, nối quang 2-3mm</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&ndash; Tuốt lớp m&agrave;u sợi quang: 250um-&gt;125um</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="kim-tuot-soi-cap-quang-miller-cfs-2" src="http://phukienquang.net/wp-content/uploads/2015/06/kim-tuot-soi-quang-miller-cfs2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang Mỹ miller" width="418" /></td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
					K&igrave;m tuốt sợi quang Sumitomo JR-M03</h2>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					D&ugrave;ng tuốt 3 lỗ sợi c&aacute;p quang</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Xuất xứ: Nhật Bản</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="kim-tuot-soi-cap-quang-jr-m03-sumitomo-nhat-ban" height="254" src="http://phukienquang.net/wp-content/uploads/2015/06/kim-tuot-soi-quang-JR-M03-sumitomo.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="kìm tuốt sợi quang Mỹ miller" width="418" /></td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Kim-tuot-soi-quang-Miller/103', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246061518715855.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (104, 1, N'Máy đo OTDR cáp quang AQ7280', N'Vui lòng liên hệ: 0913.886.008 để biết thêm chi tiết', CAST(128 AS Numeric(5, 0)), N'<p>
	<span style="color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; white-space: nowrap;">M&ocirc; tả sản phẩm</span></p>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Năm 2002, Yokogawa đ&atilde; trở th&agrave;nh nh&agrave; cung cấp&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo OTDR c&aacute;p quang</span>&nbsp;v&agrave; giải ph&aacute;p đo kiểm bằng việc s&aacute;t nhập h&atilde;ng Ando. Ng&agrave;y nay với tr&ecirc;n 30 năm kinh nghiệm trong c&ocirc;ng nghệ điện tử v&agrave; lĩnh vực testing, Yokogawa đưa ra nhiều đổi mới trong chất lượng v&agrave; nh&agrave; ti&ecirc;n phong.</h3>
<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	M&aacute;y đo OTDR c&aacute;p quang yokogawa AQ7280 được thiết kế cải thiện về độ ch&iacute;nh x&aacute;c v&agrave; nhanh hơn đ&aacute;p ứng mạng c&aacute;p quang.</h4>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="734">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="3" height="38" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Tr&ecirc;n 30 năm kinh nghiệm về m&aacute;y đo OTDR</h4>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="6" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="480">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="may-do-otdr-cap-quang-aq7280-yokogawa" height="391" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-otdr-may-do-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="máy đo otdr cáp quang aq7275" width="480" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						M&aacute;y đo tốt nhất hiện nay</p>
				</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="66">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1915</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="166">
				Yokogawa được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1933</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Ando được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1981</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ1702 m&aacute;y đo OTDR đầu ti&ecirc;n ra đời</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2002</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Yokogawa mua lại / s&aacute;t nhập với Ando</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2010</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Mẫu m&aacute;y đo AQ1200 multi tester được thiết kế</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2014</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ7280 mới nhất</td>
		</tr>
	</tbody>
</table>
<h3 align="center" style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	OTDR 7280 l&agrave; m&aacute;y đo hữu dụng nhất trong việc bảo tr&igrave; mạng c&aacute;p quang</h3>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo c&ocirc;ng suất từ nguồn ph&aacute;t</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo nguồn s&aacute;ng</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Test laser nguồn s&aacute;ng sợi quang</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Phần mềm AQ7932 d&ugrave;ng ph&acirc;n t&iacute;ch giản đồ tr&ecirc;n PC. Từng bước hướng dẫn kĩ sư tạo ra bảng b&aacute;o c&aacute;o trong định dạng Excel</li>
</ul>
<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%; color: rgb(20, 20, 20);">
	<img alt="may-do-aq7280-otdr-002" height="512" src="http://phukienquang.net/wp-content/uploads/2015/05/ung-dung-may-do-otdr-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="693" />
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		&nbsp;</p>
	<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
		Ứng dụng OTDR 7280</p>
</div>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="OTDR-aq7280-may-do-cap-quang" height="284" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-ung-dung.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="694" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&nbsp;</p>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="679">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&aacute;y đo OTDR c&aacute;p quang AQ7280 .Nhanh nhất, dễ thao t&aacute;c tất cả chỉ trong một ng&oacute;n tay</h3>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="338">
				<img alt="yokogawa testing machine OTDR" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/hien-thi-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Nhiều chức năng tăng cường hoạt động cho OTDR</h4>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 được quản l&yacute; bởi hệ thống vận h&agrave;nh hiệu quả nhất</li>
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 với Nhiều chức năng c&oacute; thể hoạt động c&ugrave;ng l&uacute;c .</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">OTDR 7280</span>&nbsp;c&oacute; thể thực thi đo OTDR tr&ecirc;n sợi quang trong khi kiểm tra c&ocirc;ng suất v&agrave; bề mặt của connector</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="325">
				<img alt="aq7280 OTDR tester" height="209" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="283" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị th&ocirc;ng minh</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Tất cả phương ph&aacute;p đo chỉ trong một n&uacute;t bấm</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dễ d&agrave;ng đọc trace/ sơ đồ định tuyến với nhiều dải động cho ph&eacute;p kĩ sư ph&aacute;t hiện điểm m&ugrave;, sự kiện với 1 thao t&aacute;c nhấn</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Ngưỡng giới hạn của OTDR7280 cho ph&eacute;p kĩ sư lập tức biết được hoạt động đo PASS/FAIL</li>
				</ul>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="Máy đo otdr cáp quang 7280" height="193" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-aq7280-touch-screen.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="337" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						m&agrave;n h&igrave;nh cảm ứng OTDR</p>
				</div>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y đo OTDR c&aacute;p quang AQ7280&nbsp;</span>chế độ hoạt động 2 thao t&aacute;c c&ugrave;ng l&uacute;c</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								M&agrave;n h&igrave;nh cảm ứng v&agrave; kh&oacute;a bấm.</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Tap, lướt, chạm v&agrave; nhấn. Chọn giữa độ ph&acirc;n giải m&agrave;n h&igrave;nh 8.4inch v&agrave; n&uacute;t thao t&aacute;c gi&uacute;p qu&aacute; tr&igrave;nh đo OTDR nhanh hơn</li>
				</ul>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="OTDR testing machine yokogawa" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-qua-do-may-do-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị đo nhiều sợi</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Tổ chức, hiển thị nhanh đặc điểm/ biến cố mạng</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Hướng dẫn kĩ sư ghi lại nhiều chế độ đo OTDR, c&ocirc;ng suất v&agrave; connector trong 1 bảng hiển thị</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="máy đo otdr cáp quang aq7280" height="194" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-noi-wireless-may-do-cap-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="338" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					OTDR kết nối wireless</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Sử dụng hệ thống c&ocirc;ng nghệ Windows&trade; v&agrave; truyền kết quả đo lường OTDR tới thiết bị th&ocirc;ng qua c&ocirc;ng nghệ FlashAir&trade;.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Aq7280 gửi kết quả/ report bằng email/ file nhanh ch&oacute;ng</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img align="middle" alt="aq7280 long battery" height="206" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-battery-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="248" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Thời gian hoạt động của Pin</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Bạn kh&ocirc;ng phải lo lắng trong suốt qu&aacute; tr&igrave;nh thi c&ocirc;ng về Pin của m&aacute;y đo.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Nguồn pin Li-Ion của AQ7280 sẽ li&ecirc;n tục tới 15 giờ l&agrave;m việc theo chuẩn Telcordia</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="module máy đo otdr cáp quang yokogawa" height="211" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-da-dang-module.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="637" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Đa dạng module cho OTDR aq7280</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								9 module OTDR từ single mode tới multi mode v&agrave; từ dải động thấp (low dynamic) tới dải động cao (ultra-high dynamic).</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Chọn 2 bước s&oacute;ng tới 4 bước s&oacute;ng.</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dựa tr&ecirc;n ứng dụng người d&ugrave;ng c&oacute; thể chọn module đo c&ocirc;ng suất<br style="box-sizing: inherit;" />
								thay v&igrave; sử dụng&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo c&ocirc;ng suất quang&nbsp;</span>hay<br style="box-sizing: inherit;" />
								nguồn s&aacute;ng quang, v&agrave; ph&oacute;ng laser d&ograve; t&igrave;m sợi quang .</li>
						</ul>
					</li>
				</ul>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Ng&ocirc;n ngữ sử dụng cho m&aacute;y đo OTDR</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Chinese, Czech, Dutch, English,</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Finnish, French, German, Italian, Norwegian, Polish, Portuguese, Spanish, Swedish, and Turkish.</p>
			</td>
		</tr>
	</tbody>
</table>
<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Năm 2002, Yokogawa đ&atilde; trở th&agrave;nh nh&agrave; cung cấp&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo OTDR c&aacute;p quang</span>&nbsp;v&agrave; giải ph&aacute;p đo kiểm bằng việc s&aacute;t nhập h&atilde;ng Ando. Ng&agrave;y nay với tr&ecirc;n 30 năm kinh nghiệm trong c&ocirc;ng nghệ điện tử v&agrave; lĩnh vực testing, Yokogawa đưa ra nhiều đổi mới trong chất lượng v&agrave; nh&agrave; ti&ecirc;n phong.</h3>
<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	M&aacute;y đo OTDR c&aacute;p quang yokogawa AQ7280 được thiết kế cải thiện về độ ch&iacute;nh x&aacute;c v&agrave; nhanh hơn đ&aacute;p ứng mạng c&aacute;p quang.</h4>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="734">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="3" height="38" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Tr&ecirc;n 30 năm kinh nghiệm về m&aacute;y đo OTDR</h4>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="6" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="480">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="may-do-otdr-cap-quang-aq7280-yokogawa" height="391" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-otdr-may-do-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="máy đo otdr cáp quang aq7275" width="480" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						M&aacute;y đo tốt nhất hiện nay</p>
				</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="66">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1915</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="166">
				Yokogawa được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1933</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Ando được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1981</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ1702 m&aacute;y đo OTDR đầu ti&ecirc;n ra đời</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2002</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Yokogawa mua lại / s&aacute;t nhập với Ando</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2010</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Mẫu m&aacute;y đo AQ1200 multi tester được thiết kế</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2014</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ7280 mới nhất</td>
		</tr>
	</tbody>
</table>
<h3 align="center" style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	OTDR 7280 l&agrave; m&aacute;y đo hữu dụng nhất trong việc bảo tr&igrave; mạng c&aacute;p quang</h3>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo c&ocirc;ng suất từ nguồn ph&aacute;t</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo nguồn s&aacute;ng</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Test laser nguồn s&aacute;ng sợi quang</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Phần mềm AQ7932 d&ugrave;ng ph&acirc;n t&iacute;ch giản đồ tr&ecirc;n PC. Từng bước hướng dẫn kĩ sư tạo ra bảng b&aacute;o c&aacute;o trong định dạng Excel</li>
</ul>
<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%; color: rgb(20, 20, 20);">
	<img alt="may-do-aq7280-otdr-002" height="512" src="http://phukienquang.net/wp-content/uploads/2015/05/ung-dung-may-do-otdr-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="693" />
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		&nbsp;</p>
	<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
		Ứng dụng OTDR 7280</p>
</div>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="OTDR-aq7280-may-do-cap-quang" height="284" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-ung-dung.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="694" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&nbsp;</p>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="679">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&aacute;y đo OTDR c&aacute;p quang AQ7280 .Nhanh nhất, dễ thao t&aacute;c tất cả chỉ trong một ng&oacute;n tay</h3>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="338">
				<img alt="yokogawa testing machine OTDR" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/hien-thi-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Nhiều chức năng tăng cường hoạt động cho OTDR</h4>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 được quản l&yacute; bởi hệ thống vận h&agrave;nh hiệu quả nhất</li>
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 với Nhiều chức năng c&oacute; thể hoạt động c&ugrave;ng l&uacute;c .</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">OTDR 7280</span>&nbsp;c&oacute; thể thực thi đo OTDR tr&ecirc;n sợi quang trong khi kiểm tra c&ocirc;ng suất v&agrave; bề mặt của connector</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="325">
				<img alt="aq7280 OTDR tester" height="209" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="283" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị th&ocirc;ng minh</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Tất cả phương ph&aacute;p đo chỉ trong một n&uacute;t bấm</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dễ d&agrave;ng đọc trace/ sơ đồ định tuyến với nhiều dải động cho ph&eacute;p kĩ sư ph&aacute;t hiện điểm m&ugrave;, sự kiện với 1 thao t&aacute;c nhấn</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Ngưỡng giới hạn của OTDR7280 cho ph&eacute;p kĩ sư lập tức biết được hoạt động đo PASS/FAIL</li>
				</ul>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="Máy đo otdr cáp quang 7280" height="193" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-aq7280-touch-screen.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="337" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						m&agrave;n h&igrave;nh cảm ứng OTDR</p>
				</div>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y đo OTDR c&aacute;p quang AQ7280&nbsp;</span>chế độ hoạt động 2 thao t&aacute;c c&ugrave;ng l&uacute;c</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								M&agrave;n h&igrave;nh cảm ứng v&agrave; kh&oacute;a bấm.</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Tap, lướt, chạm v&agrave; nhấn. Chọn giữa độ ph&acirc;n giải m&agrave;n h&igrave;nh 8.4inch v&agrave; n&uacute;t thao t&aacute;c gi&uacute;p qu&aacute; tr&igrave;nh đo OTDR nhanh hơn</li>
				</ul>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="OTDR testing machine yokogawa" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-qua-do-may-do-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị đo nhiều sợi</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Tổ chức, hiển thị nhanh đặc điểm/ biến cố mạng</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Hướng dẫn kĩ sư ghi lại nhiều chế độ đo OTDR, c&ocirc;ng suất v&agrave; connector trong 1 bảng hiển thị</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="máy đo otdr cáp quang aq7280" height="194" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-noi-wireless-may-do-cap-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="338" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					OTDR kết nối wireless</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Sử dụng hệ thống c&ocirc;ng nghệ Windows&trade; v&agrave; truyền kết quả đo lường OTDR tới thiết bị th&ocirc;ng qua c&ocirc;ng nghệ FlashAir&trade;.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Aq7280 gửi kết quả/ report bằng email/ file nhanh ch&oacute;ng</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img align="middle" alt="aq7280 long battery" height="206" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-battery-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="248" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Thời gian hoạt động của Pin</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Bạn kh&ocirc;ng phải lo lắng trong suốt qu&aacute; tr&igrave;nh thi c&ocirc;ng về Pin của m&aacute;y đo.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Nguồn pin Li-Ion của AQ7280 sẽ li&ecirc;n tục tới 15 giờ l&agrave;m việc theo chuẩn Telcordia</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="module máy đo otdr cáp quang yokogawa" height="211" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-da-dang-module.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="637" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Đa dạng module cho OTDR aq7280</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								9 module OTDR từ single mode tới multi mode v&agrave; từ dải động thấp (low dynamic) tới dải động cao (ultra-high dynamic).</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Chọn 2 bước s&oacute;ng tới 4 bước s&oacute;ng.</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dựa tr&ecirc;n ứng dụng người d&ugrave;ng c&oacute; thể chọn module đo c&ocirc;ng suất<br style="box-sizing: inherit;" />
								thay v&igrave; sử dụng&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo c&ocirc;ng suất quang&nbsp;</span>hay<br style="box-sizing: inherit;" />
								nguồn s&aacute;ng quang, v&agrave; ph&oacute;ng laser d&ograve; t&igrave;m sợi quang .</li>
						</ul>
					</li>
				</ul>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Ng&ocirc;n ngữ sử dụng cho m&aacute;y đo OTDR</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Chinese, Czech, Dutch, English,</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Finnish, French, German, Italian, Norwegian, Polish, Portuguese, Spanish, Swedish, and Turkish.</p>
			</td>
		</tr>
	</tbody>
</table>
<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Năm 2002, Yokogawa đ&atilde; trở th&agrave;nh nh&agrave; cung cấp&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo OTDR c&aacute;p quang</span>&nbsp;v&agrave; giải ph&aacute;p đo kiểm bằng việc s&aacute;t nhập h&atilde;ng Ando. Ng&agrave;y nay với tr&ecirc;n 30 năm kinh nghiệm trong c&ocirc;ng nghệ điện tử v&agrave; lĩnh vực testing, Yokogawa đưa ra nhiều đổi mới trong chất lượng v&agrave; nh&agrave; ti&ecirc;n phong.</h3>
<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	M&aacute;y đo OTDR c&aacute;p quang yokogawa AQ7280 được thiết kế cải thiện về độ ch&iacute;nh x&aacute;c v&agrave; nhanh hơn đ&aacute;p ứng mạng c&aacute;p quang.</h4>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="734">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="3" height="38" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Tr&ecirc;n 30 năm kinh nghiệm về m&aacute;y đo OTDR</h4>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td rowspan="6" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="480">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="may-do-otdr-cap-quang-aq7280-yokogawa" height="391" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-otdr-may-do-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="máy đo otdr cáp quang aq7275" width="480" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						M&aacute;y đo tốt nhất hiện nay</p>
				</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="66">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1915</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="166">
				Yokogawa được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1933</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Ando được th&agrave;nh lập</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					1981</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ1702 m&aacute;y đo OTDR đầu ti&ecirc;n ra đời</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2002</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Yokogawa mua lại / s&aacute;t nhập với Ando</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2010</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				Mẫu m&aacute;y đo AQ1200 multi tester được thiết kế</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div align="center" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					2014</div>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				AQ7280 mới nhất</td>
		</tr>
	</tbody>
</table>
<h3 align="center" style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	OTDR 7280 l&agrave; m&aacute;y đo hữu dụng nhất trong việc bảo tr&igrave; mạng c&aacute;p quang</h3>
<ul style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial; color: rgb(20, 20, 20);">
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo c&ocirc;ng suất từ nguồn ph&aacute;t</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Đo nguồn s&aacute;ng</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Test laser nguồn s&aacute;ng sợi quang</li>
	<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		Phần mềm AQ7932 d&ugrave;ng ph&acirc;n t&iacute;ch giản đồ tr&ecirc;n PC. Từng bước hướng dẫn kĩ sư tạo ra bảng b&aacute;o c&aacute;o trong định dạng Excel</li>
</ul>
<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%; color: rgb(20, 20, 20);">
	<img alt="may-do-aq7280-otdr-002" height="512" src="http://phukienquang.net/wp-content/uploads/2015/05/ung-dung-may-do-otdr-cap-quang.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="693" />
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		&nbsp;</p>
	<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
		Ứng dụng OTDR 7280</p>
</div>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<img alt="OTDR-aq7280-may-do-cap-quang" height="284" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-ung-dung.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="694" /></p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	&nbsp;</p>
<table border="1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);" width="679">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&aacute;y đo OTDR c&aacute;p quang AQ7280 .Nhanh nhất, dễ thao t&aacute;c tất cả chỉ trong một ng&oacute;n tay</h3>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="338">
				<img alt="yokogawa testing machine OTDR" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/hien-thi-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Nhiều chức năng tăng cường hoạt động cho OTDR</h4>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 được quản l&yacute; bởi hệ thống vận h&agrave;nh hiệu quả nhất</li>
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						OTDR 7280 với Nhiều chức năng c&oacute; thể hoạt động c&ugrave;ng l&uacute;c .</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">OTDR 7280</span>&nbsp;c&oacute; thể thực thi đo OTDR tr&ecirc;n sợi quang trong khi kiểm tra c&ocirc;ng suất v&agrave; bề mặt của connector</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" width="325">
				<img alt="aq7280 OTDR tester" height="209" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-may-do-cap-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="283" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị th&ocirc;ng minh</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Tất cả phương ph&aacute;p đo chỉ trong một n&uacute;t bấm</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dễ d&agrave;ng đọc trace/ sơ đồ định tuyến với nhiều dải động cho ph&eacute;p kĩ sư ph&aacute;t hiện điểm m&ugrave;, sự kiện với 1 thao t&aacute;c nhấn</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Ngưỡng giới hạn của OTDR7280 cho ph&eacute;p kĩ sư lập tức biết được hoạt động đo PASS/FAIL</li>
				</ul>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<div class="wp-caption alignnone" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; max-width: 100%;">
					<img alt="Máy đo otdr cáp quang 7280" height="193" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-aq7280-touch-screen.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="337" />
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						&nbsp;</p>
					<p class="wp-caption-text" style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0.8075em 0px 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: center; line-height: 24px; color: rgb(127, 126, 126);">
						m&agrave;n h&igrave;nh cảm ứng OTDR</p>
				</div>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&aacute;y đo OTDR c&aacute;p quang AQ7280&nbsp;</span>chế độ hoạt động 2 thao t&aacute;c c&ugrave;ng l&uacute;c</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								M&agrave;n h&igrave;nh cảm ứng v&agrave; kh&oacute;a bấm.</li>
						</ul>
					</li>
				</ul>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
						Tap, lướt, chạm v&agrave; nhấn. Chọn giữa độ ph&acirc;n giải m&agrave;n h&igrave;nh 8.4inch v&agrave; n&uacute;t thao t&aacute;c gi&uacute;p qu&aacute; tr&igrave;nh đo OTDR nhanh hơn</li>
				</ul>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="OTDR testing machine yokogawa" height="198" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-qua-do-may-do-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="269" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					M&agrave;n h&igrave;nh hiển thị đo nhiều sợi</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Tổ chức, hiển thị nhanh đặc điểm/ biến cố mạng</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Hướng dẫn kĩ sư ghi lại nhiều chế độ đo OTDR, c&ocirc;ng suất v&agrave; connector trong 1 bảng hiển thị</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="máy đo otdr cáp quang aq7280" height="194" src="http://phukienquang.net/wp-content/uploads/2015/05/ket-noi-wireless-may-do-cap-aq7280.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="338" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					OTDR kết nối wireless</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Sử dụng hệ thống c&ocirc;ng nghệ Windows&trade; v&agrave; truyền kết quả đo lường OTDR tới thiết bị th&ocirc;ng qua c&ocirc;ng nghệ FlashAir&trade;.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Aq7280 gửi kết quả/ report bằng email/ file nhanh ch&oacute;ng</p>
			</td>
			<td style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img align="middle" alt="aq7280 long battery" height="206" src="http://phukienquang.net/wp-content/uploads/2015/05/aq7280-battery-otdr.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="248" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Thời gian hoạt động của Pin</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Bạn kh&ocirc;ng phải lo lắng trong suốt qu&aacute; tr&igrave;nh thi c&ocirc;ng về Pin của m&aacute;y đo.</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Nguồn pin Li-Ion của AQ7280 sẽ li&ecirc;n tục tới 15 giờ l&agrave;m việc theo chuẩn Telcordia</p>
			</td>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td colspan="2" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="module máy đo otdr cáp quang yokogawa" height="211" src="http://phukienquang.net/wp-content/uploads/2015/05/may-do-cap-otdr-da-dang-module.png" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Otdr aq7280" width="637" />
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Đa dạng module cho OTDR aq7280</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					&nbsp;</p>
				<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
					<li>
						<ul style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style: disc;">
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								9 module OTDR từ single mode tới multi mode v&agrave; từ dải động thấp (low dynamic) tới dải động cao (ultra-high dynamic).</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Chọn 2 bước s&oacute;ng tới 4 bước s&oacute;ng.</li>
							<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
								Dựa tr&ecirc;n ứng dụng người d&ugrave;ng c&oacute; thể chọn module đo c&ocirc;ng suất<br style="box-sizing: inherit;" />
								thay v&igrave; sử dụng&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">m&aacute;y đo c&ocirc;ng suất quang&nbsp;</span>hay<br style="box-sizing: inherit;" />
								nguồn s&aacute;ng quang, v&agrave; ph&oacute;ng laser d&ograve; t&igrave;m sợi quang .</li>
						</ul>
					</li>
				</ul>
				<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
					Ng&ocirc;n ngữ sử dụng cho m&aacute;y đo OTDR</h4>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Chinese, Czech, Dutch, English,</p>
				<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
					Finnish, French, German, Italian, Norwegian, Polish, Portuguese, Spanish, Swedish, and Turkish.</p>
			</td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/May-do-OTDR-cap-quang-AQ7280/104', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636246062904955144.png', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (105, 1, N'Máy hàn cáp quang fujikura', N'Vui lòng liên hệ: 0913.886.008 để biết thêm chi tiết', CAST(129 AS Numeric(5, 0)), N'<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Thời gian h&agrave;n nối 7 gi&acirc;y, nung nhiệt 14 gi&acirc;y. Sử dụng Pin Li-Ion với gần 200 mối h&agrave;n, nắp chắn gi&oacute; tự động chống bụi, bẩn, rơi rớt. Nhiều chế độ cho nh&acirc;n c&ocirc;ng tự chọn, t&iacute;ch hợp hướng dẫn sử dụng, m&aacute;y h&agrave;n c&aacute;p quang&nbsp;<a href="http://phukienquang.net/may-han-soi-quang/may-han-cap-quang-fujikura/huong-dan-su-dung-nhanh-may-han-cap-quang-fujikura-fsm-70s/" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-decoration: none; color: rgb(201, 113, 120); transition: all 0.3s ease 0s;" target="_blank" title="máy hàn cáp quang Fujikura fsm-70s"><span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Fujikrua FSM-70S</span></a>&nbsp;giống phi&ecirc;n bản trước 60s với phương ph&aacute;p căn chỉnh l&otilde;i (PAS) c&oacute; thể h&agrave;n nối tất cả c&aacute;c loại sợi quang<a href="http://phukienquang.net/wp-content/uploads/2015/07/FSM-60S-may-han-cap-quang-fujikura.png" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-decoration: none; color: rgb(201, 113, 120); transition: all 0.3s ease 0s;"><img alt="FSM-60S-may-han-cap-quang-fujikura" class="alignnone size-medium wp-image-1156" height="300" sizes="(max-width: 270px) 100vw, 270px" src="http://phukienquang.net/wp-content/uploads/2015/07/FSM-60S-may-han-cap-quang-fujikura-270x300.png" srcset="http://phukienquang.net/wp-content/uploads/2015/07/FSM-60S-may-han-cap-quang-fujikura-270x300.png 270w, http://phukienquang.net/wp-content/uploads/2015/07/FSM-60S-may-han-cap-quang-fujikura.png 300w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; border: 0px;" width="270" /></a></h3>
', 0, N'~/Chi-tiet-san-pham/May-han-cap-quang-fujikura/105', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636247746328857883.png', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (106, 1, N'Máy hàn cáp quang Hàn Quốc ilsintech Swift S3', N'Vui lòng liên hệ: 0913.886.008 để biết thêm chi tiết', CAST(130 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	Swift S3 l&agrave; d&ograve;ng m&aacute;y h&agrave;n c&aacute;p quang mới nhất của H&agrave;n Quốc với c&ocirc;ng nghệ ti&ecirc;n tiến tự động căn chỉnh l&otilde;i, ph&ugrave; hợp thi c&ocirc;ng h&agrave;n nối c&aacute;p quang Fttx, CATV v&agrave; mạng LAN</h2>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	<br style="box-sizing: inherit;" />
	+Trang bị m&agrave;n h&igrave;nh m&agrave;u cảm ứng</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	+Suy hao mối h&agrave;n chuẩn: SMF: 0.02dB, MMF: 0.01dB, DSF: 0.04dB, NZDSF: 0.04dB</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	+Pin m&aacute;y h&agrave;n c&aacute;p quang Swift S3 với dung lượng lớn gi&uacute;p nh&acirc;n c&ocirc;ng k&eacute;o d&agrave;i thời gian h&agrave;n nối</p>
<p style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
	+Đ&ocirc;i cặp gia nhiệt hấp nhanh</p>
<table style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th rowspan="2" style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang hàn quốc giá rẻ" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="136" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					C&ocirc;ng nghệ căn chỉnh l&otilde;i IPAS</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						M&aacute;y h&agrave;n c&aacute;p quang Ilsintech Swift-S3 nhỏ nhất, nhanh nhất v&agrave; nhẹ nhất+ Đường k&iacute;nh: 138(W) 160(L) 135(H)</p>
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						+ Trọng lượng : 2.3KG</p>
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						+Thời gian h&agrave;n nối: 9 gi&acirc;y</p>
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						+ Gia nhiệt : 26 gi&acirc;y</p>
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						+ Pin v&agrave; bộ phận chống xốc được trang bị</p>
				</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang hàn quốc giá rẻ chống sốc" height="155" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3-chong-soc.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="177" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					Chịu t&aacute;c động m&ocirc;i trường l&agrave;m việc bụi bẩn, mưa v&agrave; va đập</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang hàn quốc pin lâu" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3-pin-lau.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="200" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					Chuẩn pin đi k&egrave;m với 250 chu kỳ h&agrave;n nối</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang ilsintech" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3-xoay-2chieu.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="165" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						M&agrave;n h&igrave;nh cảm ứng 4.3inch m&agrave;uĐộ ph&oacute;ng đại: 300X, 170X</p>
					<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
						Khả năng xoay hai chiều thuận tiện khi thi c&ocirc;ng h&agrave;n nối</p>
				</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang hàn quốc 002" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3-2gia-nhiet.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="157" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					Dual cặp gia nhiệt</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="máy hàn cáp quang giá rẻ" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/may-han-cap-quang-swift-s3-chuan-phukien.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="210" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					Chuẩn phụ kiện đi k&egrave;m</div>
			</th>
		</tr>
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<img alt="dao cắt sợi quang ci-03" height="194" src="http://phukienquang.net/wp-content/uploads/2015/04/dao-cat-soi-quang-ci-03.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="176" /></th>
			<th style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; text-align: left;">
				<div align="left" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
					C&aacute;c loại&nbsp;<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">dao cắt sợi quang</span>&nbsp;lựa chọn cho d&ograve;ng m&aacute;y h&agrave;n c&aacute;p quang H&agrave;n quốc</div>
			</th>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/May-han-cap-quang-Han-Quoc-ilsintech-Swift-S3/106', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636247747535556902.png', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 6)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (107, 1, N'Máy hàn cáp quang Sumitomo', N'Sạc pin bên trong máy trong khi thực hiện hàn nối
Bộ sạc pin rời đi kèm máy
Giao diện internet thu', CAST(131 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.3;">
	Type-QH201e-VS m&aacute;y h&agrave;n c&aacute;p quang FTTx cầm tay của Sumitomo Electric Lightwave l&agrave; d&ograve;ng thiết bị nhỏ nhất với thời gian h&agrave;n nối nhanh nhất, giao diện m&agrave;n h&igrave;nh cảm ứng, t&iacute;ch hợp hướng dẫn bằng Video, cập nhật phần mềm, khả năng bảo tr&igrave; 24-7 với cổng USB. C&ocirc;ng nghệ pin Li-ion</h3>
<table style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: Lato, sans-serif; font-size: 15px; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; border-spacing: 0px; width: 739px; color: rgb(20, 20, 20);">
	<tbody style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<tr style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="Máy hàn cáp quang SUMITOMO" class="alignnone size-medium wp-image-1470" height="300" sizes="(max-width: 300px) 100vw, 300px" src="http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum-300x300.png" srcset="http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum-300x300.png 300w, http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum-150x150.png 150w, http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum-100x100.png 100w, http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum-144x144.png 144w, http://phukienquang.net/wp-content/uploads/2016/09/may-han-cap-quang-sumitomo-qh201-quantum.png 500w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="300" /></td>
			<td style="box-sizing: inherit; border-width: 0px; border-style: initial; border-color: initial; font-family: inherit; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
				<img alt="Type-Q101-CA-may-han-cap-quang-sumitomo" class="alignnone size-medium wp-image-1471" sizes="(max-width: 300px) 100vw, 300px" src="http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo-300x300.png" srcset="http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo-300x300.png 300w, http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo-150x150.png 150w, http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo-100x100.png 100w, http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo-144x144.png 144w, http://phukienquang.net/wp-content/uploads/2016/09/Type-Q101-CA-may-han-cap-quang-sumitomo.png 400w" style="box-sizing: inherit; vertical-align: middle; height: 300px; max-width: 100%; width: 300px;" /></td>
		</tr>
	</tbody>
</table>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/May-han-cap-quang-Sumitomo/107', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636247749943194611.png', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (108, 1, N'Ống co nhiệt', N'Vui lòng liên hệ: 0753.500.500 để biết thêm thông tin', CAST(132 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<h1 class="entry-title" style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 24px; font-weight: 400; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; color: rgb(20, 20, 20); line-height: 1.5; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
	Sản phẩm ống co nhiệt 60mm h&agrave;n c&aacute;p quang</h1>
<div class="post-info" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<span class="date published time" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;" title="2014-04-08T14:52:58+00:00">08/04/2014</span>&nbsp;by&nbsp;<span class="author vcard" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">admin</span>&nbsp;<span class="post-comments" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">1 comment</span></div>
<div class="entry-content" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
		<span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Ống co nhiệt&nbsp;</span>với k&iacute;ch thước phổ biến 40mm v&agrave; 60mm d&ugrave;ng trong thi c&ocirc;ng h&agrave;n nối sợi c&aacute;p quang, đường k&iacute;nh ống sau khi gia nhiệt co lại 2.9mm</h3>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Cấu tạo bởi một thanh d&iacute;nh kim loại b&ecirc;n trong (th&eacute;p kh&ocirc;ng gỉ) v&agrave; lớp nhựa Polyolefin b&ecirc;n ngo&agrave;i. Ống nhựa b&ecirc;n ngo&agrave;i thường kh&ocirc;ng m&agrave;u cho ph&eacute;p c&ocirc;ng nh&acirc;n c&oacute; thể nh&igrave;n thấy m&agrave;u sắc của sợi sau khi h&agrave;n. L&agrave; một thiết kế ho&agrave;n hảo để đảm bảo duy tr&igrave; li&ecirc;n kết cho mối h&agrave;n</p>
	<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
		<img alt="ống co nhiệt hàn cáp quang" class="aligncenter size-full wp-image-443" height="202" src="http://phukienquang.net/wp-content/uploads/2014/04/ong-co-nhiet-han-cap-quang.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; clear: both; display: block; margin: 0px auto;" width="250" /></h4>
	<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;" title="ống co nhiệt hàn cáp quang">
		Ống co nhiệt c&oacute; thể chia l&agrave;m 2 loại</h4>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		+ Loại d&ugrave;ng cho sợi quang đon mode (single mode)</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		+ Loại c&ograve;n lại d&ugrave;ng cho sợi Ribbon</p>
	<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
		Sự kh&aacute;c nhau chủ yếu l&agrave; chất liệu kết d&iacute;nh b&ecirc;n trong ống. Ống cho sợi ribbon được l&agrave;m từ ceramic gia cường</p>
	<h4 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
		<img alt="ống co nhiệt bảo vệ mối hàn cáp quang" class="aligncenter size-full wp-image-444" height="161" sizes="(max-width: 250px) 100vw, 250px" src="http://phukienquang.net/wp-content/uploads/2014/04/ong-co-nhiet-bao-ve-moi-han-cap-quang.jpg" srcset="http://phukienquang.net/wp-content/uploads/2014/04/ong-co-nhiet-bao-ve-moi-han-cap-quang.jpg 250w, http://phukienquang.net/wp-content/uploads/2014/04/ong-co-nhiet-bao-ve-moi-han-cap-quang-125x80.jpg 125w" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%; clear: both; display: block; margin: 0px auto;" width="250" /></h4>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Ống-co-nhiet/108', CAST(0 AS Decimal(10, 0)), N'~/Images/SanPham/636247750606372542.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 7)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (109, 1, N'Điều hòa 2 chiều Daikin 1.5 HP FTXM35HVMV', N'1.5 HP
ĐIỀU HOÀ 2 CHIỀU (CÓ SƯỞI ẤM)
MÁY LẠNH INVERTER
Làm lạnh và sưởi ấm hiệu quả nhờ chức năng', CAST(140 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="imgnote" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<img alt="Thông số kỹ thuật Điều hòa 2 chiều Daikin 1.5 HP FTXM35HVMV" class="lazy" data-="" height="548" src="https://cdn.tgdd.vn/Products/Images/2002/72778/Kit/may-lanh-daikin-ftxm35hvmv-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="730" /></div>
<div class="box-article" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<article class="area_article" id="tinh-nang" style="box-sizing: inherit; border: none; margin: 0px; padding: 0px;">
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Mẫu m&atilde; hợp thời trang</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Điều h&ograve;a 2 chiều Daikin FTXM35HVMV c&oacute; kiểu d&aacute;ng sang trọng với m&agrave;u trắng thanh nh&atilde;, tạo n&ecirc;n vẻ hiện đại cho kh&ocirc;ng gian nh&agrave; bạn. Với c&ocirc;ng suất 1.5 HP, chiếc điều h&ograve;a 2 chiều Daikin n&agrave;y sẽ ph&ugrave; hợp cho c&aacute;c căn ph&ograve;ng c&oacute; diện t&iacute;ch từ 15 đến 20 m&eacute;t vu&ocirc;ng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Điều hòa 2 chiều Daikin FTXM35HVMV " class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/72778/may-dieu-hoa-daikin-ftxm35hvmv5-99.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Điều hòa 2 chiều Daikin FTXM35HVMV " /><img alt="Với công suất 1.5 HP, chiếc điều hòa 2 chiều Daikin này sẽ phù hợp cho các căn phòng có diện tích từ 15 đến 20 mét vuông" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/72778/may-dieu-hoa-daikin-ftxm35hvmv2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Với công suất 1.5 HP, chiếc điều hòa 2 chiều Daikin này sẽ phù hợp cho các căn phòng có diện tích từ 15 đến 20 mét vuông" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Khả năng điều h&ograve;a 2 chiều</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Với khả năng c&oacute; thể hoạt động được cả chiều n&oacute;ng v&agrave; chiều lạnh của m&igrave;nh, điều h&ograve;a 2 chiều Daikin FTXM35HVMV sẽ gi&uacute;p gia đ&igrave;nh bạn giữ nhiệt độ ph&ograve;ng th&iacute;ch hợp hơn, vừa sưởi ấm v&agrave; l&agrave;m m&aacute;t t&ugrave;y nhiệt độ m&ocirc;i trường.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Với khả năng có thể hoạt động được cả chiều nóng và chiều lạnh của mình, điều hòa 2 chiều Daikin FTXM35HVMV sẽ giúp gia đình bạn giữ nhiệt độ phòng thích hợp hơn" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/72778/may-dieu-hoa-daikin-ftxm35hvmv3.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Với khả năng có thể hoạt động được cả chiều nóng và chiều lạnh của mình, điều hòa 2 chiều Daikin FTXM35HVMV sẽ giúp gia đình bạn giữ nhiệt độ phòng thích hợp hơn" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&ocirc;ng nghệ Inverter tiết kiệm điện</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Điều h&ograve;a 2 chiều Daikin FTXM35HVMV c&oacute; c&ocirc;ng nghệ Inverter tiết kiệm điện. Kh&ocirc;ng chỉ gi&uacute;p bạn tiết kiệm phần lớn chi ph&iacute; tiền điện trong nh&agrave;, chiếc điều h&ograve;a 2 chiều n&agrave;y sẽ c&ograve;n mang lại khả năng giữ ổn định nhiệt độ, cho bạn cảm gi&aacute;c thoải m&aacute;i nhất.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Điều hòa 2 chiều Daikin FTXM35HVMV có công nghệ Inverter tiết kiệm điện" class="lazy" data-="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Điều hòa 2 chiều Daikin FTXM35HVMV có công nghệ Inverter tiết kiệm điện" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Phin lọc x&uacute;c t&aacute;c quang Apatit Titan</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Hệ thống phin lọc x&uacute;c t&aacute;c quang Apatit Titan hứa hẹn sẽ mang đến cho người d&ugrave;ng kh&ocirc;ng gian sống trong l&agrave;nh. Điều h&ograve;a 2 chiều Daikin FTXM35HVMV sẽ lọc sạch bụi bẩn v&agrave; ti&ecirc;u diệt ho&agrave;n to&agrave;n những vi khuẩn c&oacute; hại cho sức khỏe của bạn.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt=" Điều hòa 2 chiều Daikin FTXM35HVMV sẽ lọc sạch bụi bẩn và tiêu diệt hoàn toàn những vi khuẩn có hại cho sức khỏe của bạn" class="lazy" data-="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title=" Điều hòa 2 chiều Daikin FTXM35HVMV sẽ lọc sạch bụi bẩn và tiêu diệt hoàn toàn những vi khuẩn có hại cho sức khỏe của bạn" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&aacute;nh tản nhiệt d&agrave;n n&oacute;ng chống ăn m&ograve;n</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Với c&ocirc;ng nghệ xử l&yacute; c&aacute;nh tản nhiệt d&agrave;n n&oacute;ng chống ăn m&ograve;n, điều h&ograve;a 2 chiều Daikin FTXM35HVMV sẽ c&oacute; tuổi thọ l&acirc;u hơn, hoạt động bền bỉ v&agrave; &iacute;t chịu ảnh hưởng của thời tiết hơn so với c&aacute;c thế hệ m&aacute;y lạnh kh&aacute;c.</p>
	</article>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Dieu-hoa-2-chieu-Daikin-1.5-HP-FTXM35HVMV/109', CAST(13490000 AS Decimal(10, 0)), N'~/Images/SanPham/636247766069386976.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (110, 1, N'Điều hòa Midea 1 chiều 9.000BTU MSMA-09CR', N'Mã sản phẩm:MSMA-09CR', CAST(141 AS Numeric(5, 0)), N'<div class="w-pd-b-r-col1" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<div class="w-pd-main-feature" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span class="w-pd-mf-l" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">M&atilde; sản phẩm</span><span class="w-pd-mf-c" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">:</span><span style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: 600; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;"><span class="w-pd-mf-r  color-orange" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(255, 0, 0);">MSMA-09CR</span></span></div>
	<p class="w-pd-main-feature" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span class="w-pd-mf-l" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Trạng th&aacute;i</span><span class="w-pd-mf-c" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">:</span><span class="w-pd-mf-r color-orange" style="box-sizing: inherit; font-weight: 600;">C&ograve;n h&agrave;ng</span></p>
	<p class="w-pd-main-feature" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span class="w-pd-mf-l" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Bảo h&agrave;nh</span><span class="w-pd-mf-c" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">:</span><span class="w-pd-mf-r color-orange" style="box-sizing: inherit; font-weight: 600;">Ch&iacute;nh h&atilde;ng 12 th&aacute;ng</span></p>
	<p class="w-pd-main-feature" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 10px; outline: 0px; padding: 0px; vertical-align: baseline;">
		<span class="w-pd-mf-l" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">Xuất xứ</span><span class="w-pd-mf-c" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">:</span><span class="w-pd-mf-r color-orange" style="box-sizing: inherit; font-weight: 600;">Ch&iacute;nh h&atilde;ng Việt Nam</span></p>
</div>
<div class="w-pd-b-r-col4" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 16px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(127, 126, 126);">
	<ul class="l pr-des-featured" style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px 0px 15px 3em; outline: 0px; padding-right: 0px; padding-left: 0px; vertical-align: baseline; list-style-position: initial; list-style-image: initial;">
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			Điều h&ograve;a Midea gi&aacute; rẻ</li>
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			1 chiều &ndash; 9.000BTU</li>
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			Thiết kế mới, l&agrave;m lạnh nhanh</li>
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			M&agrave;ng lọc kh&aacute;ng khuẩn</li>
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			Xuất xứ: Ch&iacute;nh h&atilde;ng Việt Nam</li>
		<li style="box-sizing: inherit; border: 0px; font-family: inherit; font-style: inherit; font-weight: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;">
			Bảo h&agrave;nh: Ch&iacute;nh h&atilde;ng 12 th&aacute;ng</li>
	</ul>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/Dieu-hoa-Midea-1-chieu-9.000BTU-MSMA-09CR/110', CAST(6250000 AS Decimal(10, 0)), N'~/Images/SanPham/636247769307492185.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (111, 1, N'MÁY LẠNH DAIKIN 1 HP FTNE25MV1V9', N'1 HP
ĐIỀU HOÀ 1 CHIỀU (CHỈ LÀM LẠNH)
MÁY LẠNH KHÔNG INVERTER
Cánh đảo gió rộng mạnh mẽ, hơi lạnh ', CAST(142 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="imgnote" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<img alt="Thông số kỹ thuật Máy lạnh Daikin 1 HP FTNE25MV1V9" class="lazy" data-="" height="548" src="https://cdn.tgdd.vn/Products/Images/2002/70307/Kit/may-lanh-daikin-ftne25mv1v9.gif" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="730" /></div>
<div class="box-article" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<article class="area_article" id="tinh-nang" style="box-sizing: inherit; border: none; margin: 0px; padding: 0px;">
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Thiết kế tinh tế, sang trọng</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh Daikin FTNE25MV1V9 c&oacute; thiết kế m&agrave;u trắng hạnh nh&acirc;n sang trọng, ưa nh&igrave;n, th&iacute;ch hợp với nhiều kh&ocirc;ng gian nội thất kh&aacute;c nhau, đa dạng chọn lựa vị tr&iacute; đặt cho người d&ugrave;ng, tạo n&ecirc;n sự sang trọng cho căn ph&ograve;ng của bạn.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Thiết kế sang trọng" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/70307/may-lanh-daikin-ftne25mv1v9-1-11.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Thiết kế sang trọng" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&ocirc;ng suất l&agrave;m lạnh 1 HP</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y c&oacute; c&ocirc;ng suất l&agrave;m lạnh 1 HP c&oacute; khả năng l&agrave;m lạnh cho diện t&iacute;ch ph&ograve;ng dưới 15 m2, gi&uacute;p bạn giải tỏa mọi n&oacute;ng bức, thoải m&aacute;i v&agrave; dễ chịu hơn với kh&ocirc;ng kh&iacute; trong l&agrave;nh, m&aacute;t mẻ. M&aacute;y th&iacute;ch hợp khi đặt trong ph&ograve;ng ăn, ph&ograve;ng kh&aacute;ch, ph&ograve;ng ngủ.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Công suất làm lạnh 1HP" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/70307/may-lanh-daikin-ftne25mv1v9-2-2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Công suất làm lạnh 1HP" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Điều khiển luồng gi&oacute; th&ocirc;ng minh</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y c&oacute; hệ thống l&agrave;m lạnh hiệu quả với chế độ gi&oacute; linh hoạt với 2 c&aacute;nh k&eacute;p c&ugrave;ng khả năng tự động đảo gi&uacute;p gi&oacute; ph&acirc;n bố khắp ph&ograve;ng, gi&uacute;p bạn tận hưởng được những cơn gi&oacute; m&aacute;t lạnh một c&aacute;ch nhanh ch&oacute;ng trong những ng&agrave;y oi bức m&agrave; kh&ocirc;ng phải chờ đợi qu&aacute; l&acirc;u.</p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Hoạt động &ecirc;m &aacute;i</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Hệ thống m&aacute;y lạnh hoạt động &ecirc;m &aacute;i, với tiếng ồn cực thấp, v&agrave; hầu như bạn sẽ kh&ocirc;ng nghe thấy trong qu&aacute; tr&igrave;nh sử dụng. D&agrave;n lạnh tạo cho bạn kh&ocirc;ng gian y&ecirc;n tĩnh, tho&aacute;ng đ&atilde;ng, c&ugrave;ng bầu kh&ocirc;ng kh&iacute; m&aacute;t lạnh, bạn sẽ thoải m&aacute;i l&agrave;m việc v&agrave; thư gi&atilde;n ngay trong ch&iacute;nh căn ph&ograve;ng của m&igrave;nh.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Hệ thống hoat động êm ái" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/70307/may-lanh-daikin-ftne25mv1v9-4-2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Hệ thống hoat động êm ái" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Vận h&agrave;nh hiệu quả, tiết kiệm điện năng</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh vận h&agrave;nh với hiệu suất cao, hiệu quả nhưng v&ocirc; c&ugrave;ng tiết kiệm điện năng. Khi đạt đến nhiệt độ y&ecirc;u cầu, m&aacute;y sẽ tự động duy tr&igrave; v&agrave; hạn chế ti&ecirc;u tốn điện năng nhờ đ&oacute; bạn sẽ ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m với ho&aacute; đơn tiền điện h&agrave;ng th&aacute;ng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Tiết kiệm điện năng" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/70307/may-lanh-daikin-ftne25mv1v9-6-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Tiết kiệm điện năng" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Thiết kế d&agrave;n n&oacute;ng chống gỉ s&eacute;t, ăn m&ograve;n</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y c&oacute; d&agrave;n n&oacute;ng được xử l&yacute; chống ăn m&ograve;n tốt, bề mặt phủ nhựa Acrylic chống mưa axit v&agrave; hơi muối, đồng thời c&ograve;n được trang bị m&agrave;n chống thấm nước, hạn chế gỉ s&eacute;t do nước t&iacute;ch tụ v&ocirc; c&ugrave;ng hiệu quả mang đến độ bền v&agrave; tuổi thọ cao cho m&aacute;y trong qu&aacute; tr&igrave;nh sử dụng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Thiết kế chống ăn mòn, rỉ sét" class="lazy" data-="" src="https://cdn.dmx.vn/Products/Images/2002/70307/may-lanh-daikin-ftne25mv1v9-5-2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Thiết kế chống ăn mòn, rỉ sét" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&aacute;c tiện &iacute;ch phục vụ kh&aacute;c</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			&bull; &nbsp;&nbsp;&nbsp;Sử dụng gas 410A c&oacute; hiệu suất l&agrave;m lạnh cao, cho hơi lạnh s&acirc;u, tiết kiệm điện, th&acirc;n thiện với m&ocirc;i trường v&agrave; sức khoẻ con người.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			&bull; &nbsp;&nbsp;&nbsp;Remote trang bị m&agrave;n h&igrave;nh LED th&ocirc;ng minh với khả năng hiển thị chuẩn đo&aacute;n sự cố.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Nh&igrave;n chung, m&aacute;y lạnh Daikin FTNE25MV1V9 l&agrave; một chiếc m&aacute;y c&oacute; nhiều t&iacute;nh năng vượt trội trong tầm gi&aacute;. Nếu như bạn đang cần một chiếc m&aacute;y với khả năng l&agrave;m lạnh nhanh ch&oacute;ng, tiết kiệm điện năng tốt ph&ugrave; hợp với căn ph&ograve;ng c&oacute; diện t&iacute;ch nhỏ dưới 15 m2 th&igrave; m&aacute;y lạnh Daikin FTNE25MV1V9 sẽ l&agrave; một sự lựa chọn rất đ&aacute;ng để c&acirc;n nhắc.</p>
	</article>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/MAY-LANH-DAIKIN-1-HP-FTNE25MV1V9/111', CAST(7125000 AS Decimal(10, 0)), N'~/Images/SanPham/636247770021683035.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (112, 1, N'MÁY LẠNH DAIKIN INVERTER 1 HP FTKS25GVMV', N'1 HP
ĐIỀU HOÀ 1 CHIỀU (CHỈ LÀM LẠNH)
MÁY LẠNH INVERTER
Chế độ làm lạnh nhanh mang đến nhiệt độ cà', CAST(143 AS Numeric(5, 0)), N'<h2 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 20px; margin: 0px 0px 5px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 30px; opacity: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: rgb(0, 0, 0) !important;">
	M&ocirc; tả sản phẩm</h2>
<div class="imgnote" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<img alt="Thông số kỹ thuật Máy lạnh Daikin 1 HP FTKS25GVMV" class="lazy" data-="" height="548" src="https://cdn.tgdd.vn/Products/Images/2002/68782/Kit/may-lanh-daikin-ftks25gvmv-1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" width="730" /></div>
<div class="box-article" style="box-sizing: inherit; border: 0px; font-family: Lato, sans-serif; font-size: 15px; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(20, 20, 20);">
	<article class="area_article" id="tinh-nang" style="box-sizing: inherit; border: none; margin: 0px; padding: 0px;">
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Thiết kế hiện đại v&agrave; sang trọng</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Sở hữu thiết kế sang trọng, m&aacute;y lạnh Daikin FTKS25GVMV hứa hẹn sẽ đem lại vẻ hiện đại cho căn ph&ograve;ng của bạn. Với c&ocirc;ng suất hoạt động 1 HP, chiếc m&aacute;y lạnh Daikin n&agrave;y kh&aacute; th&iacute;ch hợp cho c&aacute;c khu vực c&oacute; diện t&iacute;ch dưới 15 m&eacute;t vu&ocirc;ng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Sở hữu thiết kế sang trọng, máy lạnh Daikin FTKS25GVMV hứa hẹn sẽ đem lại vẻ hiện đại cho căn phòng của bạn" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/68782/may-lanh-daikin-ftks25gvmv1.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Sở hữu thiết kế sang trọng, máy lạnh Daikin FTKS25GVMV hứa hẹn sẽ đem lại vẻ hiện đại cho căn phòng của bạn" /><img alt="Với công suất hoạt động 1 HP, chiếc máy lạnh Daikin này khá thích hợp cho các khu vực có diện tích dưới 15 mét vuông" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/68782/may-lanh-daikin-ftks25gvmv2.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Với công suất hoạt động 1 HP, chiếc máy lạnh Daikin này khá thích hợp cho các khu vực có diện tích dưới 15 mét vuông" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Chế độ l&agrave;m lạnh nhanh</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			B&ecirc;n cạnh đ&oacute;, nhờ sở hữu chế độ l&agrave;m lạnh nhanh Powerful, m&aacute;y lạnh Daikin FTKS25GVMV sẽ gi&uacute;p cho người d&ugrave;ng nhanh ch&oacute;ng được thư gi&atilde;n với luồng kh&ocirc;ng kh&iacute; m&aacute;t lạnh ngay khi vừa bước ch&acirc;n v&agrave;o căn ph&ograve;ng.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Bên cạnh đó, nhờ sở hữu chế độ làm lạnh nhanh Powerful, máy lạnh Daikin FTKS25GVMV sẽ giúp cho người dùng nhanh chóng được thư giãn" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/68782/may-lanh-daikin-ftks25gvmv6.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Bên cạnh đó, nhờ sở hữu chế độ làm lạnh nhanh Powerful, máy lạnh Daikin FTKS25GVMV sẽ giúp cho người dùng nhanh chóng được thư giãn" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			L&agrave;m lạnh hiệu quả với Econo</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh Daikin FTKS25GVMV sở hữu c&ocirc;ng nghệ Econo độc đ&aacute;o, hạn chế sự ti&ecirc;u thụ điện năng tối đa v&agrave; t&igrave;nh trạng qu&aacute; tải, gi&uacute;p m&aacute;y lạnh hoạt động ổn định hơn.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Máy lạnh Daikin FTKS25GVMV sở hữu công nghệ Econo độc đáo" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/68782/may-lanh-daikin-ftks25gvmv8.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Máy lạnh Daikin FTKS25GVMV sở hữu công nghệ Econo độc đáo" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			Phin lọc x&uacute;c t&aacute;c quang Apatit Titan</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Nhờ phin lọc x&uacute;c t&aacute;c quang Apatit Titan, m&aacute;y lạnh Daikin FTKS25GVMV sẽ hỗ trợ người d&ugrave;ng ti&ecirc;u diệt vi khuẩn, khử m&ugrave;i, lọc kh&iacute; hiệu quả. Với c&ocirc;ng nghệ độc đ&aacute;o n&agrave;y, sức khỏe của gia đ&igrave;nh bạn sẽ được đảm bảo.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Nhờ phin lọc xúc tác quang Apatit Titan, máy lạnh Daikin FTKS25GVMV sẽ hỗ trợ người dùng tiêu diệt vi khuẩn, khử mùi, lọc khí hiệu quả" class="lazy" data-="" src="https://cdn.tgdd.vn/Products/Images/2002/68782/may-lanh-daikin-ftks25gvmv5.jpg" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Nhờ phin lọc xúc tác quang Apatit Titan, máy lạnh Daikin FTKS25GVMV sẽ hỗ trợ người dùng tiêu diệt vi khuẩn, khử mùi, lọc khí hiệu quả" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&ocirc;ng nghệ mắt thần th&ocirc;ng minh</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			Với mắt thần cảm biến th&ocirc;ng minh, m&aacute;y lạnh Daikin FTKS25GVMV sẽ theo d&otilde;i sự chuyển động của người d&ugrave;ng trong ph&ograve;ng v&agrave; đưa ra t&ugrave;y chỉnh nhiệt độ th&iacute;ch hợp, sao cho vừa tiết kiệm điện, vừa l&agrave;m lạnh tối ưu.</p>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			<img alt="Với mắt thần cảm biến thông minh, máy lạnh Daikin FTKS25GVMV sẽ theo dõi sự chuyển động của người dùng trong phòng" class="lazy" data-="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC" style="box-sizing: inherit; vertical-align: middle; height: auto; max-width: 100%;" title="Với mắt thần cảm biến thông minh, máy lạnh Daikin FTKS25GVMV sẽ theo dõi sự chuyển động của người dùng trong phòng" /></p>
		<h3 style="box-sizing: inherit; border: 0px; font-family: &quot;Open Sans&quot;, sans-serif; font-size: 26px; font-style: inherit; font-weight: 300; margin: 0px 0px 15px; outline: 0px; padding: 0px; vertical-align: baseline; clear: both; line-height: 1.3;">
			C&ocirc;ng nghệ Inverter tiết kiệm điện</h3>
		<p style="box-sizing: inherit; border: 0px; font-family: inherit; font-size: 16px; font-style: inherit; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline; line-height: 24px; color: rgb(127, 126, 126);">
			M&aacute;y lạnh Daikin FTKS25GVMV với c&ocirc;ng nghệ Inverter c&ograve;n hỗ trợ gia đ&igrave;nh bạn c&oacute; th&ecirc;m một khoản tiền nho nhỏ d&agrave;nh cho c&aacute;c chi ti&ecirc;u kh&aacute;c trong gia đ&igrave;nh. C&ocirc;ng nghệ Inverter n&agrave;y c&ograve;n gi&uacute;p cho nhiệt độ ph&ograve;ng lu&ocirc;n được giữ ổn định cho người d&ugrave;ng cảm gi&aacute;c dễ chịu.</p>
	</article>
</div>
<p>
	&nbsp;</p>
', 0, N'~/Chi-tiet-san-pham/MAY-LANH-DAIKIN-INVERTER-1-HP-FTKS25GVMV/112', CAST(11115000 AS Decimal(10, 0)), N'~/Images/SanPham/636247771192189984.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 8)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (229, 1, N'Bút lông dầu-PM04  CeeDee', N'Bút lông dầu-PM04  CeeDee', CAST(34 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-dau-PM04--CeeDee/229', CAST(9000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp25.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (230, 1, N'Bút lông dầu-PM09', N'Bút lông dầu-PM09', CAST(35 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/But-long-dau-PM09/230', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp26.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (231, 1, N'Bìa còng Thiªn Long A4-F4', N'Bìa còng Thiên Long A4-F4', CAST(36 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-cong-Thiªn-Long-A4-F4/231', CAST(14000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp27.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (232, 1, N'Bìa còng Kingim A4-F4', N'Bìa còng Kingim A4-F4', CAST(37 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-cong-Kingim-A4-F4/232', CAST(27000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp28.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (233, 1, N'Bìa còng Plus  A4-F4', N'Bìa còng Plus  A4-F4', CAST(38 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-cong-Plus--A4-F4/233', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp28.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (234, 1, N'Fine nan 1 ngăn nhựa - Đại', N'Fine nan 1 ngăn nhựa - Đại', CAST(39 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Fine-nan-1-ngan-nhua---Dai/234', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp29.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (235, 1, N'Fine nan 3 ngăn nhựa', N'Fine nan 3 ngăn nhựa', CAST(40 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Fine-nan-3-ngan-nhua/235', CAST(83000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp30.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (236, 1, N'Bìa 3 dây 8cm - Thuong', N'Bìa 3 dây 8cm - Thuong', CAST(41 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-3-day-8cm---Thuong/236', CAST(9000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp31.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (237, 1, N'Bìa 3 dây 10 cm Thuong', N'Bìa 3 dây 10 cm Thuong', CAST(42 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-3-day-10-cm-Thuong/237', CAST(11000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp32.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (238, 1, N'Bìa 3 dây 15 cm Thuong', N'Bìa 3 dây 15 cm Thuong', CAST(43 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-3-day-15-cm-Thuong/238', CAST(8000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp32.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (239, 1, N'Bìa 3 dây 20 cm Thuong', N'Bìa 3 dây 20 cm Thuong', CAST(44 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-3-day-20-cm-Thuong/239', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp32.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (240, 1, N'Bìa Tký simili đơn A4', N'Bìa Tký simili đơn A4', CAST(45 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-Tky-simili-don-A4/240', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp33.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (241, 1, N'Bìa Tký simili  đôi  A4', N'Bìa Tký simili  đôi  A4', CAST(46 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-Tky-simili--doi--A4/241', CAST(14000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp34.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (242, 1, N'Bìa t.ký nhựa - cao cấp YP700 ', N'Bìa t.ký nhựa - cao cấp YP700 ', CAST(47 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bia-t.ky-nhua---cao-cap-YP700/242', CAST(27000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp35.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (243, 1, N'Bấm 2 lỗ EG 837', N'Bấm 2 lỗ EG 837', CAST(48 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bam-2-lo-EG-837/243', CAST(37000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp36.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (244, 1, N'Bấm 2 lỗ KW -912 bấm 16 tờ', N'Bấm 2 lỗ KW -912 bấm 16 tờ', CAST(49 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bam-2-lo-KW--912-bam-16-to/244', CAST(56000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp37.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (245, 1, N'Bấm 2 lỗ KW - 978 bấm 30 tờ', N'Bấm 2 lỗ KW - 978 bấm 30 tờ', CAST(50 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bam-2-lo-KW---978-bam-30-to/245', CAST(83000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp38.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (246, 1, N'Băng keo trong - đục (4,8F*80YA)', N'Băng keo trong - đục (4,8F*80YA)', CAST(51 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bang-keo-trong---duc-(4,8F*80YA)/246', CAST(9000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp39.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (247, 1, N'Băng keo trong - đục (4,8F*100YA)', N'Băng keo trong - đục (4,8F*100YA)', CAST(52 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bang-keo-trong---duc-(4,8F*100YA)/247', CAST(11000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp39.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (248, 1, N'Băng keo simili 3.6F', N'Băng keo simili 3.6F', CAST(53 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bang-keo-simili-3.6F/248', CAST(8000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp40.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM] ([MA_SANPHAM], [MA_TRANGTHAI], [TEN_SANPHAM], [MOTA], [THUTU], [NOIDUNG], [SLIDE_SHOW], [URL], [GIA], [AVATAR], [NGAY_DANG], [UU_TIEN], [GIA_KHUYENMAI], [MA_NHOM_SAN_PHAM]) VALUES (249, 1, N'Băng keo simili 4.8F', N'Băng keo simili 4.8F', CAST(54 AS Numeric(5, 0)), N'', 0, N'~/Chi-tiet-san-pham/Bang-keo-simili-4.8F/249', CAST(10000 AS Decimal(10, 0)), N'~/Images/SanPham/vpp40.jpg', CAST(0x0000A73700B40017 AS DateTime), 0, CAST(0 AS Decimal(10, 0)), 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (1, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (2, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (3, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (4, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (5, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (6, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (7, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (8, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (9, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (10, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (11, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (12, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (13, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (14, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (15, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (16, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (17, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (18, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (19, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (20, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (21, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (22, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (23, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (24, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (25, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (26, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (27, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (28, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (29, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (30, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (31, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (32, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (33, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (34, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (35, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (36, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (37, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (38, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (39, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (40, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (41, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (42, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (43, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (44, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (45, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (46, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (47, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (48, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (49, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (50, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (51, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (52, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (53, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (54, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (55, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (56, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (57, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (58, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (59, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (60, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (61, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (62, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (63, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (64, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (65, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (66, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (67, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (68, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (69, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (70, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (71, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (72, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (73, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (74, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (75, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (76, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (77, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (78, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (79, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (80, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (81, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (82, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (83, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (84, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (85, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (86, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (87, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (88, 2)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (89, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (90, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (91, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (92, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (93, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (94, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (95, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (96, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (97, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (98, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (99, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (100, 7)
GO
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (101, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (102, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (103, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (104, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (105, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (106, 6)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (107, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (108, 7)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (109, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (110, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (111, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (112, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (113, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (114, 8)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (115, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (116, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (117, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (118, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (119, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (120, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (121, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (122, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (123, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (124, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (125, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (126, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (127, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (128, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (129, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (130, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (131, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (132, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (133, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (134, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (135, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (136, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (137, 9)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (138, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (139, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (140, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (141, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (142, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (143, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (144, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (145, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (146, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (147, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (148, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (149, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (150, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (151, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (152, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (153, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (154, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (155, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (156, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (157, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (158, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (159, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (160, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (161, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (162, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (163, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (164, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (165, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (166, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (167, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (168, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (169, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (170, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (171, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (172, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (173, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (174, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (175, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (176, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (177, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (178, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (179, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (180, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (181, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (182, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (183, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (184, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (185, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (186, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (187, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (188, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (189, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (190, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (191, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (192, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (193, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (194, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (195, 4)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (196, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (197, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (198, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (199, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (200, 1)
GO
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (201, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (202, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (203, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (204, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (205, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (206, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (207, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (208, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (209, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (210, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (211, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (212, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (213, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (214, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (215, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (216, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (217, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (218, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (219, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (220, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (221, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (222, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (223, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (224, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (225, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (226, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (227, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (228, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (229, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (230, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (231, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (232, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (233, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (234, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (235, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (236, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (237, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (238, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (239, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (240, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (241, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (242, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (243, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (244, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (245, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (246, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (247, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (248, 1)
INSERT [dbo].[SANPHAM_CHITIET] ([MA_SANPHAM], [MANHOM_SANPHAM]) VALUES (249, 1)
INSERT [dbo].[THONGTINCHUNG] ([ID], [TENCONGTY], [DIENTHOAI], [EMAIL], [DIACHI], [LINK_FACE], [LINK_SKYPE], [LINK_TWITTER], [LINK_GOOGLE], [GHICHU]) VALUES (1, N'Công ty TNHH Bán hàng tận nơi', N'(075).3500.500', N'banhangtannoi24@gmail.com', N'318C, Nguyễn Đình Chiểu, Phường 8, TP.Bến Tre', N'fghfg', N'fghfg', N'fghfg', N'fghfg', N'fghf')
INSERT [dbo].[TRANGTHAI] ([MA_TRANGTHAI], [TEN_TRANGTHAI], [MOTA]) VALUES (0, N'Không hoạt động', NULL)
INSERT [dbo].[TRANGTHAI] ([MA_TRANGTHAI], [TEN_TRANGTHAI], [MOTA]) VALUES (1, N'Hoạt động', NULL)
/****** Object:  Index [PK_DON_HANG]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[DONHANG] ADD  CONSTRAINT [PK_DON_HANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_DONHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_HINH]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[HINH] ADD  CONSTRAINT [PK_HINH] PRIMARY KEY NONCLUSTERED 
(
	[MA_HINH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DANH_GIA_KH]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[KHACHHANG_DANHGIA] ADD  CONSTRAINT [PK_DANH_GIA_KH] PRIMARY KEY NONCLUSTERED 
(
	[MA_DANHGIA_KHACHHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_LIENHE]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[KHACHHANG_LIENHE] ADD  CONSTRAINT [PK_LIENHE] PRIMARY KEY NONCLUSTERED 
(
	[MA_LIENHE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_KHACH_HANG]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[KHACHHANG_TAIKHOAN] ADD  CONSTRAINT [PK_KHACH_HANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TAIKHOAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_LUOTTRUYCAP]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[LUOTTRUYCAP] ADD  CONSTRAINT [PK_LUOTTRUYCAP] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_MODULE]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[MODULE] ADD  CONSTRAINT [PK_MODULE] PRIMARY KEY NONCLUSTERED 
(
	[MA_MODULE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_NHOM_HINH]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[NHOM_HINH] ADD  CONSTRAINT [PK_NHOM_HINH] PRIMARY KEY NONCLUSTERED 
(
	[MANHOM_HINH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_NHOM_SP]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[NHOM_SANPHAM] ADD  CONSTRAINT [PK_NHOM_SP] PRIMARY KEY NONCLUSTERED 
(
	[MANHOM_SANPHAM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_NGUOI_DUNG]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[QUANTRI_TAIKHOAN] ADD  CONSTRAINT [PK_NGUOI_DUNG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TAIKHOAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_NHOM_QUYEN]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[ROLE] ADD  CONSTRAINT [PK_NHOM_QUYEN] PRIMARY KEY NONCLUSTERED 
(
	[MA_ROLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_SANPHAM]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[SANPHAM] ADD  CONSTRAINT [PK_SANPHAM] PRIMARY KEY NONCLUSTERED 
(
	[MA_SANPHAM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TRANGTHAI]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[TRANGTHAI] ADD  CONSTRAINT [PK_TRANGTHAI] PRIMARY KEY NONCLUSTERED 
(
	[MA_TRANGTHAI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TRANGTHAI_DONHANG]    Script Date: 15/03/2017 11:05:38 AM ******/
ALTER TABLE [dbo].[TRANGTHAI_DONHANG] ADD  CONSTRAINT [PK_TRANGTHAI_DONHANG] PRIMARY KEY NONCLUSTERED 
(
	[MA_TRANGTHAI_DONHANG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[MENU]  WITH CHECK ADD  CONSTRAINT [FK_NHOMMENU_MENU] FOREIGN KEY([MA_NHOM_MEMU])
REFERENCES [dbo].[NHOM_MENU] ([MA_NHOM_MENU])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MENU] CHECK CONSTRAINT [FK_NHOMMENU_MENU]
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
ALTER TABLE [dbo].[NHOM_MENU]  WITH CHECK ADD  CONSTRAINT [FK_NHOMMENU_TT] FOREIGN KEY([MA_TRANG_THAI])
REFERENCES [dbo].[TRANGTHAI] ([MA_TRANGTHAI])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NHOM_MENU] CHECK CONSTRAINT [FK_NHOMMENU_TT]
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
