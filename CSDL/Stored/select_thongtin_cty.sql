USE [BanHang]
GO
/****** Object:  StoredProcedure [dbo].[select_thongtin_cty]    Script Date: 2/20/2017 20:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[select_thongtin_cty]
AS
BEGIN
	select * from [dbo].[THONGTIN_CTY]
END
