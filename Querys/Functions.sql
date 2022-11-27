use FarmaUZIEL


-- Calcular el subtotal de la venta
create function CSTV(@CP int, @Q int)
returns float
as
begin
   declare @st as float
   select @st = precio * @Q from Productos where Cod_Prod = @CP
   return @st
end

--Calcular el total de ventas

create function CTV(@IDV as int)
returns float
as
	BEGIN
		declare @TV as float
		select @TV = SUM(subtotalv)*1.15 from Ventas where Id_Venta=@IDV
		return @TV
	END