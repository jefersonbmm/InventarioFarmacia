use FarmaUZIEL




-- Control de inventario en DetalleVentas
create trigger DetalleVentaInvNuevo
on
Ventas
after insert,update
as
	update Productos set cantidad = cantidad - (select cantidadv from inserted)
	from Productos p, Ventas dv where p.Cod_Prod = dv.Cod_Prod

create trigger DetalleVentaInvNuevoUp
on
Ventas
for update
as
	update Productos set cantidad = cantidad + (select cantidadv from inserted)
	from Productos p, Ventas dv where p.Cod_Prod = dv.Cod_Prod

create trigger DetalleVentaInvEliminado
on
Ventas
after delete
as
	update Productos set cantidad = cantidad - (select cantidadv from deleted)
	from Productos p, Ventas dv where p.Cod_Prod = dv.Cod_Prod


--Calcular Total
create Trigger TotalVentaNuevo
on
Ventas
after insert , update
as
declare @idv as int
set @idv = (Select Id_Venta from inserted)

	update Ventas set totalv= dbo.CTV(@idv) where @idv=Id_Venta

create Trigger TotalVentaEliminar
on
Ventas
after delete
as
declare @idv as int
set @idv = (Select Id_Venta from deleted)

	update Ventas set totalv= dbo.CTV(@idv) where @idv=Id_Venta


