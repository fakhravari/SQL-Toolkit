CREATE FUNCTION dbo.ToTableVarchar(@text NVARCHAR(MAX)='')
RETURNS @Result TABLE(Id NVARCHAR(400))
AS 
BEGIN
SET @text = LTRIM(RTRIM(@text));
SET @text = ISNULL(@text,'');

    INSERT INTO @Result(Id)
    SELECT value AS Id
    FROM STRING_SPLIT(@text, ',')
    WHERE value <> '';

    RETURN;
END;
GO