CREATE FUNCTION [dbo].[PersianToEn](@Date NCHAR(10))
RETURNS NVARCHAR(10)
AS BEGIN
    DECLARE @PERSIAN_EPOCH AS INT;
    DECLARE @epbase AS BIGINT;
    DECLARE @epyear AS BIGINT;
    DECLARE @mdays AS BIGINT;
    DECLARE @Jofst AS NUMERIC(18, 2);
    DECLARE @jdn BIGINT;
    DECLARE @iYear INT=CAST(SUBSTRING(@Date, 1, 4) AS INT);
    DECLARE @iMonth INT=CAST(SUBSTRING(@Date, 6, 2) AS INT);
    DECLARE @iDay INT=CAST(SUBSTRING(@Date, 9, 2) AS INT);
    IF @iYear>='1404' SET @PERSIAN_EPOCH=1948322;
    ELSE SET @PERSIAN_EPOCH=1948321;
    SET @Jofst=2415020.5;
    IF LEN(@Date)>1
    BEGIN
        IF @iYear>=0 BEGIN
            SET @epbase=@iYear-474;
        END;
        ELSE BEGIN
            SET @epbase=@iYear-473;
        END;
        SET @epyear=474+(@epbase % 2820);
        IF @iMonth<=7 BEGIN
            SET @mdays=(CONVERT(BIGINT, (@iMonth)-1)* 31);
        END;
        ELSE BEGIN
            SET @mdays=(CONVERT(BIGINT, (@iMonth)-1)* 30+6);
        END;
    END;
    SET @jdn=CONVERT(INT, @iDay)+@mdays+CAST(((@epyear * 682)-110)/ 2816 AS INT)+(@epyear-1)* 365+CAST(@epbase / 2820 AS INT)* 1029983+(@PERSIAN_EPOCH-1);
    RETURN CONVERT(NVARCHAR(11), CONVERT(DATETIME, (@jdn-@Jofst), 131), 120);
END;