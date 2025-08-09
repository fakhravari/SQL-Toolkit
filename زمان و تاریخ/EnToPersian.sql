CREATE Function [dbo].[EnToPersian] (@date datetime)
Returns nvarchar(50)
as
BEGIN
RETURN FORMAT(CAST( @date AS DATE),'yyyy/MM/dd', 'fa-ir')
End