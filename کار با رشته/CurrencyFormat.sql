create FUNCTION dbo.[CurrencyFormat](@money decimal(25,10))
RETURNS nvarchar(25)
AS
Begin
RETURN  CASE WHEN CAST(@money AS DECIMAL(25,4))=0 THEN  CAST(0 AS VARCHAR(25)) ELSE     CAST( FORMAT(@money, '#,#.##########') as nvarchar(25))   END   
End