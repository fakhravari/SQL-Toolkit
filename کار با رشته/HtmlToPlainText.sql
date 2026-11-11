CREATE   FUNCTION dbo.HtmlToPlainText
(
    @Html NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    IF @Html IS NULL RETURN NULL;

    DECLARE @Result NVARCHAR(MAX);
    DECLARE @Start INT;
    DECLARE @End INT;

    SET @Result = @Html;

    -- حفظ ساختار پاراگراف‌ها
    SET @Result = REPLACE(@Result, '</p>', CHAR(13)+CHAR(10));
    SET @Result = REPLACE(@Result, '<br>', CHAR(13)+CHAR(10));
    SET @Result = REPLACE(@Result, '<br/>', CHAR(13)+CHAR(10));
    SET @Result = REPLACE(@Result, '<br />', CHAR(13)+CHAR(10));

    -- حذف تمام تگ‌های HTML
    SET @Start = CHARINDEX('<', @Result);

    WHILE @Start > 0
    BEGIN
        SET @End = CHARINDEX('>', @Result, @Start);

        IF @End = 0 BREAK;

        SET @Result = STUFF(
            @Result,
            @Start,
            @End - @Start + 1,
            N''
        );

        SET @Start = CHARINDEX('<', @Result);
    END;

    -- تبدیل Entity های HTML
    SET @Result = REPLACE(@Result, N'&nbsp;', N' ');
    SET @Result = REPLACE(@Result, N'&#160;', N' ');
    SET @Result = REPLACE(@Result, N'&quot;', N'"');
    SET @Result = REPLACE(@Result, N'&amp;', N'&');
    SET @Result = REPLACE(@Result, N'&lt;', N'<');
    SET @Result = REPLACE(@Result, N'&gt;', N'>');
    SET @Result = REPLACE(@Result, N'&ndash;', N'–');
    SET @Result = REPLACE(@Result, N'&mdash;', N'—');
    SET @Result = REPLACE(@Result, N'&rsquo;', N'’');
    SET @Result = REPLACE(@Result, N'&lsquo;', N'‘');
    SET @Result = REPLACE(@Result, N'&rdquo;', N'”');
    SET @Result = REPLACE(@Result, N'&ldquo;', N'“');
    SET @Result = REPLACE(@Result, N'&hellip;', N'…');
    SET @Result = REPLACE(@Result, N'&copy;', N'©');
    SET @Result = REPLACE(@Result, N'&reg;', N'®');

    -- اصلاح فاصله‌ها
    SET @Result = REPLACE(@Result, CHAR(9), N' ');
    SET @Result = REPLACE(@Result, N'  ', N' ');

    -- حذف فاصله‌های ابتدا و انتهای متن
    RETURN LTRIM(RTRIM(@Result));
END;

GO

