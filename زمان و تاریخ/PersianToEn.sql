CREATE FUNCTION dbo.PersianToEn
(
    @Date NCHAR(10)   -- فرمت ورودی: YYYY/MM/DD
)
RETURNS DATE
AS
BEGIN
    DECLARE @iYear INT = CAST(SUBSTRING(@Date, 1, 4) AS INT);
    DECLARE @iMonth INT = CAST(SUBSTRING(@Date, 6, 2) AS INT);
    DECLARE @iDay INT = CAST(SUBSTRING(@Date, 9, 2) AS INT);

    -- محاسبه مبنا
    DECLARE @epbase INT, @epyear INT, @mdays INT, @jdn BIGINT;

    SET @epbase = CASE WHEN @iYear >= 0 THEN @iYear - 474 ELSE @iYear - 473 END;
    SET @epyear = 474 + (@epbase % 2820);

    SET @mdays = CASE 
                   WHEN @iMonth <= 7 THEN (@iMonth - 1) * 31
                   ELSE (@iMonth - 1) * 30 + 6
                 END;

    -- فرمول روز ژولیَن (JDN)
    SET @jdn = @iDay + @mdays 
             + CAST(((@epyear * 682) - 110) / 2816 AS INT) 
             + (@epyear - 1) * 365 
             + CAST(@epbase / 2820 AS INT) * 1029983 
             + 1948320;   -- مبنای جلالی

    -- تبدیل به میلادی (DATE)
    RETURN DATEADD(DAY, @jdn - 2415021, CAST('1900-01-01' AS DATETIME));
END;
GO
