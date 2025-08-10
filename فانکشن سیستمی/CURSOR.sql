DECLARE @kalaId NVARCHAR(max)


DECLARE db_cursor55 CURSOR FOR 

SELECT 1

OPEN db_cursor55  
FETCH NEXT FROM db_cursor55 INTO @kalaId

WHILE @@FETCH_STATUS = 0  
BEGIN  

SELECT @kalaId


FETCH NEXT FROM db_cursor55 INTO @kalaId
END 

CLOSE db_cursor55  
DEALLOCATE db_cursor55	


