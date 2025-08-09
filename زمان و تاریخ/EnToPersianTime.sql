
CREATE Function dbo.[EnToPersianTime] (@date datetime)
Returns nvarchar(50)
as
BEGIN
RETURN FORMAT(CAST( @date AS DATEtime),'yyyy/MM/dd HH:mm:ss', 'fa-ir') 
End
 
