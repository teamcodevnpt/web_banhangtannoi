USE [BanHang]
GO
/****** Object:  StoredProcedure [dbo].[select_luottruycap]    Script Date: 2/20/2017 20:51:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[select_luottruycap]
as
BEGIN
	select * from [dbo].[LUOTTRUYCAP]
END
