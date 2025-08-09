CREATE FUNCTION dbo.[ToTableBigInt](@text NVARCHAR(MAX)='')
RETURNS @Result TABLE(Id BIGINT)
AS 
BEGIN
SET @text = LTRIM(RTRIM(@text));
SET @text = ISNULL(@text,'');

    INSERT INTO @Result(Id)
    SELECT CAST(value AS BIGINT) FROM STRING_SPLIT(@text, ',') WHERE value <> '';

    RETURN;
END;
GO