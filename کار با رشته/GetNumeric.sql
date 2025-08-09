CREATE FUNCTION dbo.[GetNumeric](@Name nVarChar(Max))
RETURNS nvarchar(50) 
AS
begin

Declare @S nVarChar(Max)=@Name
Declare @C int=0
Declare @B nVarChar(1),@Dig VarChar(Max)='',@Chr nVarChar(Max)=''
While @C<Len(@S)Begin
Set @C=@C+1
Set @B=SubString(@S,@C,1)
if Charindex(@B,'0123456789۱۲۳۴۵۶۷۸۹۰')<>0
Set @Dig=@Dig+@B
else
Set @Chr=@Chr+@B
End

RETURN @Dig
end