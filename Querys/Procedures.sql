use FarmaUZIEL


-- Procedimientos para Clientes


-- Insertar
create procedure NuevoCliente
--@IDC int,
@PNC char(15),
@SNC char(15),
@PAC char(15),
@SAC char(15),
@DC nvarchar(70),
@TC char(8)
as
--declare @idcl as int
--set @idcl = (select Id_Cliente from Clientes where Id_Cliente=@IDC)

declare @pdn as char(1)
set @pdn=(select SUBSTRING(@TC,1,1))

if( @PNC='' or @PAC='' or @DC='' or @TC='')
	BEGIN
		print 'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@pdn='2'or @pdn='7'or @pdn='5'or @pdn='8')
			BEGIN
				--if(@idcl=@IDC)
				--	BEGIN
				--		print'Ese usario ya existe!!'
				--	END
				--ELSE
					BEGIN
						insert into Clientes values(@PNC,@SNC,@PAC,@SAC,@DC,@TC)
					END
			END
		else
			BEGIN
				print 'El número de teléfono debe iniciar con 2, 5, 7 u 8 y solo contener números'
			END
	END


NuevoCliente '00006','Ramon','Javier','Perez','Soza','PalisanJudas','88740598','001-120879-1456B'


select * from Clientes


-- Modificar
ALTER Procedure [dbo].[ModificarCliente]
@IDC char(5),
@PNC char(15),
@SNC char(15),
@PAC char(15),
@SAC char(15),
@DC nvarchar(70),
@TC char(8),
@CC char(16)
as
declare @idcl as char(5)
set @idcl = (select Id_Cliente from Clientes where Id_Cliente=@IDC)

declare @pdn as char(1)
set @pdn=(select SUBSTRING(@TC,1,1))


if(@IDC='' or @PNC='' or @PAC='' or @DC='' or @TC='' or @CC='')
	BEGIN
		print 'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@idcl=@IDC)
			BEGIN
				if(@pdn='2'or @pdn='7'or @pdn='5'or @pdn='8')
					BEGIN
						UPDATE Clientes set PNCliente=@PNC, SNCliente=@SNC,PACliente=@PAC, SACliente=@SAC,TelCliente=@TC, DirC=@DC,CedulaC=@CC where Id_Cliente=@IDC
					END
				else
					BEGIN
						print 'Debe iniciar con 2, 5, 7 u 8'
					END
			END
		ELSE
			BEGIN
				print'Ese Cliente no existe!!'
			END
	END	



--Eliminar cliente

alter Procedure EliminarCliente
@IDC char(5)
as
declare @idcl as char(5)
set @idcl = (select Id_Cliente from Clientes where @IDC=Id_Cliente)

if(@IDC=@idcl)
	BEGIN
		update Clientes set Estado='I' where Id_Cliente=@IDC
	END
else
	BEGIN
		print'El cliente que desea descontinuar no existe'
	END

	EliminarCliente '00010'

--Reactivar Cliente
Create Procedure ReactivarCliente
@IDC char(5)
as
declare @idcl as char(1)
set @idcl = (select Id_Cliente from Clientes where @IDC=Id_Cliente)

if(@IDC=@idcl)
	BEGIN
		update Clientes set Estado='A' where Id_Cliente=@IDC
	END
else
	BEGIN
		print'El cliente que desea descontinuar no existe'
	END

-- Listar
alter procedure ListClients
as
select Id_Cliente as Id, PNCliente as PrimerNombre, SNCliente as SegundoNombre, PACliente as PrimerApellido, SACliente as SegundoApellido, DirC as Dirección, TelCliente as Teléfono, CedulaC as Cédula from Clientes
where Estado = 'A'

ListClients

select * from Clientes

--Buscar Cliente

create procedure BuscarClientes
@IDC char(5)
as
declare @idcl as char(5)
set @idcl= (select Id_Cliente from Clientes where Id_Cliente= @IDC)

if(@idcl=@IDC)
	BEGIN
		SELECT * from Clientes where Id_Cliente=@IDC

	END
else
	BEGIN
		PRINT'No se encuentra el cliente'
	END

BuscarClientes '00001' 

select* from Clientes

-- Procedimientos para Productos


-- Insertar
ALTER procedure AddProd
@CP char(4),
@NOMP nvarchar(50),
@FE datetime,
@FEX datetime,
@TMED char(1),
@FMed nvarchar(15),
@IDL char(4),
@DESCP nvarchar(70),
@DP char(4)
as
declare @codprod as char(4)
set @codprod =(select Cod_Prod from Productos where Cod_Prod=@CP)

declare @idlab as char(4)
set @idlab = (select Id_Lab from Laboratorios where Id_Lab=@IDL)

declare @tipmed as char(1)
set @tipmed = (select TipoMedic from Productos where NombreProd=@NOMP and TipoMedic=@TMED)

declare @distrop char(4)
set @distrop = (select Id_Distribuidora from Distibuidoras where Id_Distribuidora=@DP)

if(@CP='' or @NOMP='' or @DESCP='' or @FE='' or @FEX='' or @TMED='' or @IDL='' or
@FMed='' or @DP='')
	BEGIN
		print'Ningun campo puede quedar vacio'
	END
else
	BEGIN
		if(@codprod=@CP)
			BEGIN
				print'Ese producto ya esta registrado'
			END
		else
			BEGIN
				if(@idlab=@IDL)
					BEGIN
						if(@distrop =@DP)
							BEGIN
								if(@TMED='P' or @TMED='PG'or @TMED='PC' or @TMED='C' or @TMED='CG' or @TMED='J' or @TMED='I' or
								@TMED='SS')
									BEGIN
										if(@tipmed=@TMED)
											BEGIN
												Print'El medicamento ya esta registrado con esa presentacion'

											END
										else
											BEGIN
												insert into Productos values(@CP,@NOMP,@FE,@FEX,@TMED,@FMed,@IDL,@DESCP,0,0,@DP,'A','0000')
											END
									END
								else
									BEGIN
										print'Ingrese un tipo de medicamento valido porfavor'
									END
								
							END
						else
							BEGIN
								print'La distribuidora que menciono, no existe'
							END
					END
				else
					BEGIN
						print'El laboratorio que ingreso no existe'
					END
			END

	END

	insert into Laboratorios values('0001','La Sante','Kilometro 15 carretera a masaya','22775634','LaSante@gmail.com','www.LaSante.com')

AddProd 'ASD1','Rivotril','2018-09-15','2021-04-08','P','50mg','0001','Relajante Muscular',25.50,20,'0001'

select * from Productos

-- Modificar
ALTER procedure ModProd
@CP char(4),
@NOMP nvarchar(50),
@FE datetime,
@FEX datetime,
@TMED char(1),
@FMed nvarchar(15),
@IDL char(4),
@DESCP nvarchar(70),
@PRE float,
@DP char(4)
as
declare @codprod as char(4)
set @codprod =(select Cod_Prod from Productos where Cod_Prod=@CP)

declare @idlab as char(4)
set @idlab = (select Id_Lab from Laboratorios where Id_Lab=@IDL)

declare @distrop char(4)
set @distrop = (select Id_Distribuidora from Distibuidoras where Id_Distribuidora=@DP)

if(@CP='' or @NOMP='' or @DESCP='' or @FE='' or @FEX='' or @TMED='' or @IDL='' or
@FMed='' or @PRE='' or @DP='')
	BEGIN
		print'Ningun campo puede quedar vacio'
	END
else
	BEGIN
		if(@codprod=@CP)
			BEGIN
				if(@idlab=@IDL)
					BEGIN
						if(@distrop =@DP)
							BEGIN
								if(@TMED='P' or @TMED='PG'or @TMED='PC' or @TMED='C' or @TMED='CG' or @TMED='J' or @TMED='I' or
								@TMED='SS')
									BEGIN
										update Productos set NombreProd=@NOMP,
												FechaElab= @FE,FechaVenc= @FEX,
												TipoMedic= @TMED,Formulacion= @FMed,Id_Lab=@IDL,DescProd= @DESCP,precio= @PRE,Id_Distribuidora= @DP where Cod_Prod =@CP
									END
								else
									BEGIN
										print'Ingrese un tipo de medicamento valido porfavor'
									END
								
							END
						else
							BEGIN
								print'La distribuidora que menciono, no existe'
							END
					END
				else
					BEGIN
						print'El laboratorio que ingreso no existe'
					END
				
			END
		else
			BEGIN
				print'Ese producto no existe'
			END

	END
	ModProd 'ASD1','Rivotril','2018-09-15','2021-04-08','P','50mg','0001','Relajante Muscular',25.50,25,'0001'

	SELECT * FROM Productos

--Eliminar Producto
Alter Procedure EliminarProducto
@CP char(5)
as
declare @Cod_pro as char(5)
set @Cod_pro = (select Cod_Prod from Productos where @CP=Cod_Prod)

if(@CP=@Cod_pro)
	BEGIN
		update Productos set EstadoP='I' where Cod_Prod=@CP
	END
else
	BEGIN
		print'El Producto que desea descontinuar no esta registrado'
	END

select * from Productos
EliminarProducto 'ASD1'

--Reactivar Producto
alter Procedure ReactivarProducto
@CP char(5)
as
declare @Cod_pro as char(5)
set @Cod_pro = (select Cod_Prod from Productos where @CP=Cod_Prod)

if(@CP=@Cod_pro)
	BEGIN
		update Productos set EstadoP='A' where Cod_Prod=@CP
	END
else
	BEGIN
		print'El Producto que desea reactivar no esta registrado'
	END

select * from Productos

ReactivarProducto 'ASD1'

--Buscar Producto
Alter Procedure BuscarProducto
@CP char(5)
as
declare @Cod_pro as char(5)
set @Cod_pro = (select Cod_Prod from Productos where @CP=Cod_Prod)

if(@CP=@Cod_pro)
	BEGIN
		select * from Productos where @CP=Cod_Prod
	END
else
	BEGIN
		print'El Producto no existe'
	END

select * from Productos

BuscarProducto 'ASD1'

-- Listar
alter procedure ListProducts
as
select Cod_Prod as Código, NombreProd as Nombre, DescProd as Descripción, FechaElab as Elaboración, FechaVenc as Vencimiento, TipoMedic as Presentación, (select NDLab from Laboratorios where Productos.Id_Lab= Id_Lab) as Laboratorio, Formulacion as Formulación, precio as Precio, cantidad as Cantidad,
NDistribuidora as Distribuidora 
from Productos inner join Distibuidoras on Productos.Id_Distribuidora = Distibuidoras.Id_Distribuidora

ListProducts

update Productos set FechaVenc = '2021-12-09' where Cod_Prod = 'ASS2' 

ListVisitadores

-- Procedimientos para Distribuidoras
-- Insertar
create procedure NuevaDistribuidora
@IDD char(4),
@ND nvarchar(45),
@DD nvarchar(70),
@TD char(8),
@URLD nvarchar(45)
as
declare @iddistro as char(4)
set @iddistro = (select Id_Distribuidora from Distibuidoras where @IDD=Id_Distribuidora)

declare @ndistro as nvarchar(45)
set @ndistro = (Select NDistribuidora from Distibuidoras where @ND= NDistribuidora)

if(@IDD='' or @ND='' or @DD='' or @TD='' or @URLD='')
	BEGIN
		print'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@iddistro= @IDD)
			BEGIN
				print'Esa Distribuidora ya esta registrada'
			END
		else
			BEGIN
				if(@ndistro= @ND)
					BEGIN
						print'Ya hay una distribuidora con ese nombre'
					END
				else
					BEGIN
						insert into Distibuidoras values (@IDD, @ND,@Dd,@TD,@URLD)
					END
			END
	END

SELECT * FROM Distibuidoras

NuevaDistribuidora '0006','Disprofar','Las Colinas','222546798','www.Disprofarprods.com'


-- Modificar

alter procedure ModificarDistribuidora
@IDD char(4),
@ND nvarchar(45),
@DD nvarchar(70),
@TD char(8),
@URLD nvarchar(45)
as
declare @iddistro as char(4)
set @iddistro = (select Id_Distribuidora from Distibuidoras where @IDD=Id_Distribuidora)

if(@IDD='' or @ND='' or @DD='' or @TD='' or @URLD='')
	BEGIN
		print'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@iddistro= @IDD)
			BEGIN
				update Distibuidoras set  NDistribuidora=@ND, DirDist=@DD, TelDist=@TD, URLDistribuidora=@URLD where @IDD=Id_Distribuidora
			END
		else
			BEGIN
				print'Esa Distribuidora no esta registrada'
					
			END
	END

	SELECT * FROM Distibuidoras

ModificarDistribuidora '0006','Disprofar','Los robles','222546798','www.Disprofarprods.com'
-- Listar
alter procedure ListDistribuidoras
as
select Id_Distribuidora as Id, NDistribuidora as Nombre, DirDist as Dirección, TelDist as Teléfono, URLDistribuidora as SitioWeb from Distibuidoras order by Id_Distribuidora

ListDistribuidoras

-- Procedimientos para Laboratorios

-- Insertar

create procedure NuevoLaboratorio
@IDL char(4),
@NL nvarchar(45),
@DL nvarchar(70),
@TL char(8),
@CL nvarchar(45),
@URLL nvarchar(45),
as
declare @idlab as char(4)
set @idlab = (select Id_Lab from Laboratorios where @IDL=Id_Lab)

declare @nlab as nvarchar(45)
set @nlab = (Select NDLab from Laboratorios where @IDL=Id_Lab)

if(@IDL='' or @NL='' or @DL='' or @TL='' or @URLL='' or @CL='')
	BEGIN
		print'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@idlab= @IDL)
			BEGIN
				print'Ese Laboratorio ya esta registrado'
			END
		else
			BEGIN
				if(@nlab= @NL)
					BEGIN
						print'Ya hay un Laboratorio con ese nombre'
					END
				else
					BEGIN
						insert into Laboratorios values (@IDL, @NL,@DL,@TL,@CL,@URLL)
					END
			END
	END

	NuevoLaboratorio '0002', 'dsfsdfds', 'sfsdfsd', 'dfdsf', 'sdfdsf', '88888888'

	select * from Laboratorios

-- Modificar

alter procedure ModificarLaboratorio
@IDL char(4),
@NL nvarchar(45),
@DL nvarchar(70),
@TL char(8),
@URLL nvarchar(45),
@CL nvarchar(45)
as
declare @idlab as char(4)
set @idlab = (select Id_Lab from Laboratorios where @IDL=Id_Lab)

if(@IDL='' or @NL='' or @DL='' or @TL='' or @URLL='' or @CL='')
	BEGIN
		print'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@idlab= @IDL)
			BEGIN
				update Laboratorios set NDLab= @NL, DirLab=@DL, TelLab=@TL, MailLab=@CL, URLLab=@URLL
			END
		else
			BEGIN
				print 'Ese Laboratorio no esta registrado'
					
			END
	END

select * from Laboratorios

-- Procedimientos para Visitadores Médicos

-- Insertar
alter procedure NuevoVisitadorMedico
@IDV char(4),
@PNV nvarchar(15),
@SNV nvarchar(15),
@PAV nvarchar(15),
@SAV nvarchar(15),
@DV nvarchar(70),
@TV char(8),
@MV nvarchar(50),
@IDD char(4)
as

declare @idvi as char(4)
set @idvi = (select Id_Visitador from Visitadores where Id_Visitador= @IDV)

declare @iddistro as char(4)
set @iddistro = (select Id_Distribuidora from Distibuidoras Where Id_Distribuidora= @IDD)

declare @pdn as char(1)
set @pdn=(select SUBSTRING(@TV,1,1))

if(@IDV='' or @PNV='' or @PAV='' or @DV='' or @TV='' or @MV='' or @IDD='')
	BEGIN
		PRINT'No puede dejar los valores en blanco'
	END

else
	BEGIN
		if(@IDV=@idvi)
			BEGIN
				print 'Ya hay un visitador registrado con ese id' 
			END
		else
			BEGIN
				if(@iddistro=@IDD)
					BEGIN
						if(@pdn='2'or @pdn='7'or @pdn='5'or @pdn='8')
							BEGIN
								insert into Visitadores values(@IDV,@PNV,@SNV,@PAV,@SAV,@DV,@TV,@MV,@IDD)
							END
						else
							BEGIN
								print 'Debe iniciar con 2, 5, 7 u 8 El numero'
							END
					END
				else
					BEGIN
						print 'La distribuidora que ingreso no existe'
					END

			END
	END
	SELECT * from Visitadores
	
	NuevoVisitadorMedico '0002','Jorge','','Obando','','Del puente la Reynaga 2 cuadras y 1/2 abajo','88675645','JorgeObando24@gmail.com','0002'

-- Modificar
alter procedure ModificarVisitadorMedico
@IDV char(4),
@PNV nvarchar(15),
@SNV nvarchar(15),
@PAV nvarchar(15),
@SAV nvarchar(15),
@DV nvarchar(70),
@TV char(8),
@MV nvarchar(50),
@IDD char(4)
as

declare @idvi as char(4)
set @idvi = (select Id_Visitador from Visitadores where Id_Visitador= @IDV)

declare @iddistro as char(4)
set @iddistro = (select Id_Distribuidora from Distibuidoras Where Id_Distribuidora= @IDD)

declare @pdn as char(1)
set @pdn=(select SUBSTRING(@TV,1,1))

if(@IDV='' or @PNV='' or @PAV='' or @DV='' or @TV='' or @MV='' or @IDD='')
	BEGIN
		PRINT'No puede dejar los valores en blanco'
	END

else
	BEGIN
		if(@IDV=@idvi)
			BEGIN
				if(@iddistro=@IDD)
					BEGIN
						if(@pdn='2'or @pdn='7'or @pdn='5'or @pdn='8')
							BEGIN
								update Visitadores set PNVisitador= @PNV,SNVisitador= @SNV,
								PAVisitador= @PAV,SAVisitador= @SAV,DirVisitador=@DV,TelVisitador= @TV,MailVisitador= @MV,Id_Distribuidora= @IDD  where Id_Visitador=@IDV
							END
						else
							BEGIN
								print 'Debe iniciar con 2, 5, 7 u 8 El numero'
							END
					END
				else
					BEGIN
						print 'La distribuidora que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'El visitador que desea modificar no existe' 
			END
	END

	SELECT * from Visitadores
	
	ModificarVisitadorMedico '0001','Jorge','Andrés','Obando','','Del puente la Reynaga 2 cuadras y 1/2 abajo','88675645','JorgeObando24@gmail.com','0003'


-- Listar
create procedure ListarVisitadores
as
select Id_Visitador as Id, PNVisitador as PrimerNombre, SNVisitador as SegundoNombre, PAVisitador as PrimerApellido, SAVisitador as SegundoApellido, TelVisitador as Teléfono, MailVisitador as Correo,
NDistribuidora as Distribuidora
from Visitadores inner join Distibuidoras on Visitadores.Id_Distribuidora = Distibuidoras.Id_Distribuidora 

ListarVisitadoresMedicos

-- Procedimientos para Ventas

-- Insertar
alter procedure NuevaVenta
@IDV char(4),
@IDC char(5)
as
declare @TV as float
set @TV =(SELECT SUM(subtotalv) from DetalleVentas where Id_Venta=@IDV)

declare @idvent as char(4)
set @idvent = (select Id_Venta from Ventas where @IDV=Id_Venta)

declare @idcl as char(5)
set @idcl = (select Id_Cliente from Clientes where Id_Cliente= @IDC)

if(@IDV='')
	BEGIN
		print'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@IDV= @idvent)
			BEGIN
				print'Esa venta ya esta registrada'
			END
		else
			BEGIN
				if(@IDC='')
					BEGIN
						insert into Ventas values(@IDV,@IDC,GetDate(),@TV)
					END
				else
					BEGIN
						if(@IDC=@idcl)
							BEGIN 
								insert into Ventas values(@IDV,@IDC,GetDate(),@TV)
							END
						else
							BEGIN
								print'El Cliente que trato de ingresar no esta registrado'
							END
					END
			END
	END

select * from Ventas
select * from Clientes
NuevaVenta '0001','00005'
-- Modificar

alter procedure ModificarVenta
@IDV char(4),
@IDC char(5)
as
declare @TV as float
set @TV =(SELECT SUM(subtotalv) from DetalleVentas where Id_Venta=@IDV)

declare @idvent as char(4)
set @idvent = (select Id_Venta from Ventas where @IDV=Id_Venta)

declare @idcl as char(5)
set @idcl = (select Id_Cliente from Clientes where Id_Cliente= @IDC)

if(@IDV='')
	BEGIN
		print'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@IDV= @idvent)
			BEGIN
				if(@IDC='')
					BEGIN
						update Ventas set  Id_Cliente= @IDC, totalv=@TV where @IDV=Id_Venta
					END
				else
					BEGIN
						if(@IDC=@idcl)
							BEGIN 
								update Ventas set  Id_Cliente= @IDC, totalv=@TV where @IDV=Id_Venta
							END
						else
							BEGIN
								print'El Cliente que trato de ingresar no esta registrado'
							END
					END
				
			END
		else
			BEGIN
				print'Esa venta no esa esta registrada'
			END
	END

select * from Ventas
select * from Clientes
ModificarVenta '0001','00004'

--Eliminar la venta

alter Procedure EliminarVenta
@IV char(4)
as

declare @idventa as char(4)
set @idventa = (select Id_Venta from Ventas where Id_Venta=@IV)

if(@IV='')
	BEGIN
		print 'El campo no puede quedar vacio'
	END
else
	BEGIN
		if(@IV=@idventa)
			BEGIN
				delete from DetalleVentas where @IV=Id_Venta
				delete from Ventas where Id_Venta=@IV
			END
		else
			BEGIN
				print'La venta que esta tratando de eliminar no existe'
			END
	END

select * from Ventas
select * from Clientes
EliminarVenta '0001'

-- Listar
create procedure ListSales
as
select Id_Venta as Id, Fecha_Venta as Fecha, totalv as Total,
PNCliente as NombreCliente, PACliente as ApellidoCliente
from Ventas inner join Clientes on Ventas.Id_Cliente = Clientes.Id_Cliente

ListSales

-- Procedimientos para Detalles de Ventas

-- Insertar
ALTER procedure NuevoDetalleVenta
@IDV char(4),
@CP char(4),
@C int
as
declare @idvent as char(4)
set @idvent = (select Id_Venta from Ventas where @IDV=Id_Venta)

declare @ST as float
set @ST = (Select @C*precio from Productos where @CP=Cod_Prod)

declare @codprod as char(4)
set @codprod =(Select Cod_Prod from Productos where  @CP=Cod_Prod)

declare @cantv as int
set @cantv = (select cantidad from Productos where  @CP=Cod_Prod)

if(@IDV='' OR @CP='' OR @C='')
	BEGIN
		print 'No pueden quedar los campos vacios' 
	END
else
	BEGIN
		if(@idvent=@IDV)
			BEGIN
				if(@CP=@codprod)
					BEGIN
						if(@C <=@cantv)
							BEGIN
								IF(@C<=0)
									BEGIN
										print'No puede ingresar una cantidad nula o negativa'
									END
								else
									BEGIN
										if(@CP=@codprod AND @idvent=@IDV)
											BEGIN
												print'Ya esta ingresado este producto en la venta'
											END
										else
											BEGIN
												insert into DetalleVentas values(@IDV,@CP,@C,@ST)
											END										
									END
							END
						else
							BEGIN
								Print'Esta tratando de llevar una cantidad mayor a la del inventario'
							END
					END
				else
					BEGIN
						print'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a la venta por que esta no existe'
			END
	END

NuevoDetalleVenta '0001', 'ASD1',5

	select * from Ventas
	SELECT* FROM Productos
select * from DetalleVentas

--MODIFICAR

alter procedure ModificarDetalleVenta
@IDV char(4),
@CP char(4),
@C int
as
declare @idvent as char(4)
set @idvent = (select Id_Venta from Ventas where @IDV=Id_Venta)
declare @ST as float
set @ST = (Select @C*precio from Productos where @CP=Cod_Prod)

declare @codprod as char(4)
set @codprod =(Select Cod_Prod from Productos where  @CP=Cod_Prod)

declare @cantv as int
set @cantv = (select cantidad from Productos where  @CP=Cod_Prod)

if(@IDV='' OR @CP='' OR @C='')
	BEGIN
		print 'No pueden quedar los campos vacios' 
	END
else
	BEGIN
		if(@idvent=@IDV)
			BEGIN
				if(@CP=@codprod)
					BEGIN
						if(@C <=@cantv)
							BEGIN
								if(@C<=0)
									BEGIN
										PRINT'No puede ingresar una cantidad nula'
									END
								else
									BEGIN
										update DetalleVentas set Cod_Prod= @CP,cantidadv= @C,subtotalv= @ST where Id_Venta=@IDV and @CP=Cod_Prod
									END
							END
						else
							BEGIN
								Print'Esta tratando de llevar una cantidad mayor a la del inventario'
							END
					END
				else
					BEGIN
						print'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a la venta por que esta no existe'
			END
	END

ModificarDetalleVenta '0001', 'ASD1',7

delete from DetalleVentas where Id_Venta= '0001'
	select * from Ventas
	SELECT* FROM Productos
select * from DetalleVentas

--eliminar detalle de ventas
create procedure EliminarDetalleVenta
@IDV char(4),
@CP char(4)
as

declare @idvent as char(4)
set @idvent = (select Id_Venta from Ventas where @IDV=Id_Venta)

declare @codprod as char(4)
set @codprod =(Select Cod_Prod from Productos where  @CP=Cod_Prod)

if(@IDV='' OR @CP='')
	BEGIN
		print 'No pueden quedar los campos vacios' 
	END
else
	BEGIN
		if(@idvent=@IDV)
			BEGIN
				if(@CP=@codprod)
					BEGIN					
						DELETE from DetalleVentas where Cod_Prod=@CP and @IDV=Id_Venta	
					END
				else
					BEGIN
						print'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a la venta por que esta no existe'
			END
	END

EliminarDetalleVenta '0001', 'ASD1'

select * from DetalleVentas

--COMPRAS

--AÑADIR COMPRA

create procedure NuevaCompra
@IDC char(4),
@IDD char(4)
as
declare @idCo as char(4)
set @idCo = (select Id_Compra from Compras where @IDC= Id_Compra)
declare @iddistro as char(4)
set @iddistro = (Select Id_Distribuidora from Distibuidoras where Id_Distribuidora=@IDD)


if(@IDC='' or @IDD='')
	BEGIN
		print 'Los campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDC=@idCo)
			BEGIN
				print'Esa compra ya esta registrada'
			END
		else
			BEGIN
				if(@IDD=@iddistro)
					BEGIN
						insert into Compras values(@IDC,GETDATE(),@IDD,0)
					END
				else
					BEGIN
						print'La distribuidora que ingreso no existe'
					END
			END
	END

Select * from Compras

NuevaCompra '0001','0005'

--modificar compra
create procedure ModificarCompra
@IDC char(4),
@IDD char(4)
as
declare @idCo as char(4)
set @idCo = (select Id_Compra from Compras where @IDC= Id_Compra)
declare @iddistro as char(4)
set @iddistro = (Select Id_Distribuidora from Distibuidoras where Id_Distribuidora=@IDD)


if(@IDC='' or @IDD='')
	BEGIN
		print 'Los campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDC=@idCo)
			BEGIN
				if(@IDD=@iddistro)
					BEGIN
						update Compras set Id_Distribuidora=@IDD where @IDC=Id_Compra
					END
				else
					BEGIN
						print'La distribuidora que ingreso no existe'
					END
				
			END
		else
			BEGIN
				print'Esa compra ya esta registrada'
			END
	END

ModificarCompra '0001','0006'
Select * from Compras

--ELIMINAR COMPRA

alter procedure EliminarCompra
@IDC char(4)
as
declare @idco as char(4)
set @idco = (select Id_compra from Compras where Id_Compra=@IDC)

if(@IDC='')
	BEGIN
		PRINT'No puede dejar el campo vacio'
	END
else
	BEGIN
		if(@IDC=@idco)
			BEGIN
				delete from DetalleCompras where Id_Compra=@IDC
				delete from Compras where Id_Compra=@IDC
			END
		else
			BEGIN
				print'La compra que desea eliminar no existe'
			END
	END

EliminarCompra '0001'
Select * from Compras

--Para DETALLECOMPRAS	

alter procedure NuevoDetalleCompra
@IDC char(4),
@CP char(4),
@C int,
@P float
as
declare @SST as float
set @SST =@P*@C

declare @idco as char(4)
set @idco = (select Id_Compra from Compras where Id_Compra=@IDC)

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Productos where Cod_Prod=@CP)

if(@IDC='' or @CP='' or @C='' or @P='')
	BEGIN
		print'Los Campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@idco=@IDC)
			BEGIN
				if(@codpro=@CP)
					BEGIN
						if(@C<=0)
							BEGIN
								PRINT'No puede ingresar un valor nulo'
							END
						else
							BEGIN
								if(@CP=@codpro AND @idco=@IDC)
									BEGIN
										print'ese detalle de compra ya esta registrado'
									END
								else
									BEGIN
										insert into DetalleCompras values(@IDC,@CP,@C,@SST,@P)
									END	
								
							END
					END
				else
					BEGIN
						PRINT'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a una compra que no existe'
			END
	END

NuevoDetalleCompra '0001','ASD1',30,20


Select * from DetalleCompras

--Modificar DetalleCompras


ALTER procedure ModificarDetalleCompra
@IDC char(4),
@CP char(4),
@C int,
@P float
as
declare @SST as float
set @SST =@P*@C

declare @idco as char(4)
set @idco = (select Id_Compra from Compras where Id_Compra=@IDC)

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Productos where Cod_Prod=@CP)

if(@IDC='' or @CP='' or @C='' or @P='')
	BEGIN
		print'Los Campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@idco=@IDC)
			BEGIN
				if(@codpro=@CP)
					BEGIN
							if(@C<=0)
							BEGIN
								PRINT'No puede ingresar un valor nulo'
							END
						else
							BEGIN
								update DetalleCompras set Cod_Prod= @CP, cantidaddc= @C,subtotaldc= @SST,preciodc= @P where Id_Compra=@IDC
							END
					END
				else
					BEGIN
						PRINT'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a una compra que no existe'
			END
	END

ModificarDetalleCompra '0001','ASD1',20,20

Select * from DetalleCompras
--ELIMINAR DETALLE COMPRAS

create procedure EliminarDetalleCompra
@IDC char(4),
@CP char(4)
as

declare @idvent as char(4)
set @idvent = (select Id_Compra from Compras where @IDC=Id_Compra)

declare @codprod as char(4)
set @codprod =(Select Cod_Prod from Productos where  @CP=Cod_Prod)

if(@IDC='' OR @CP='')
	BEGIN
		print 'No pueden quedar los campos vacios' 
	END
else
	BEGIN
		if(@idvent=@IDC)
			BEGIN
				if(@CP=@codprod)
					BEGIN
						DELETE from DetalleCompras where Cod_Prod=@CP and @IDC=Id_Compra
					END
				else
					BEGIN
						print'El producto que ingreso no existe'
					END
			END
		else
			BEGIN
				print 'No se puede asignar a la venta por que esta no existe'
			END
	END

EliminarDetalleCompra '0001','ASD1'

SELECT * FROM DetalleCompras

--Para Devoluciones

alter procedure NuevaDevolucionCliente
@IDDC char(4),
@IDV char(4)
as
declare @iddcl as char(4)
set @iddcl = (Select Id_Devolucion from Dev_Clientes where @IDDC=Id_Devolucion)
declare @idcl as char(5)
set @idcl =(Select Id_Cliente from Ventas where Id_Venta=@IDV)
declare @idve as char(4)
set @idve = (Select Id_Venta from Ventas where @IDV= Id_Venta)

declare @TDC as float
set @TDC = (Select totalv from Ventas WHERE @IDV=Id_Venta)

if(@IDDC='' OR @IDV='')
	BEGIN
		PRINT 'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDV=@idve)
			BEGIN
				if(@IDDC=@iddcl)
					BEGIN
						Print'La devolucion de esta venta ya ha sido registrada'
					END
				else
					BEGIN
						if(@idcl='')
							BEGIN
								PRINT'El cliente que ingreso no existe'
							END
						else
							BEGIN
								insert into Dev_Clientes values (@IDDC,getdate(),@idcl,@IDV,@TDC)
								
							END
					END
			END
		else
			BEGIN
				Print'la venta que trata de devolver no existe'
			END
	END

NuevaDevolucionCliente '0001','0001'

delete from Dev_Clientes

select * from Clientes
select * from Ventas 

--Modificar Devolucion

create procedure ModificarDevolucionCliente
@IDDC char(4),
@IDV char(4)
as
declare @iddcl as char(4)
set @iddcl = (Select Id_Devolucion from Dev_Clientes where @IDDC=Id_Devolucion)
declare @idcl as char(5)
set @idcl =(Select Id_Cliente from Ventas where Id_Venta=@IDV)
declare @idve as char(4)
set @idve = (Select Id_Venta from Ventas where @IDV= Id_Venta)

declare @TDC as float
set @TDC = (Select totalv from Ventas WHERE @IDV=Id_Venta)

if(@IDDC='' OR @IDV='')
	BEGIN
		PRINT 'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDV=@idve)
			BEGIN
				if(@IDDC=@iddcl)
					BEGIN
						if(@idcl='')
							BEGIN
								PRINT'El cliente que ingreso no existe'
							END
						else
							BEGIN
								update Dev_Clientes set Id_Venta=@IDV, Id_Cliente=@idcl,totaldc=@TDC where Id_Devolucion=@IDDC	
							END
						
					END
				else
					BEGIN
						Print'La devolucion de esta venta no ha sido registrada'
					END
			END
		else
			BEGIN
				Print'la venta que trata de devolver no existe'
			END
	END

ModificarDevolucionCliente '0001','0001'

--Eliminar Devolucion Cliente

Create procedure	EliminarDevolucionCliente
@IDDC char(4)
as
declare @iddcl as char(4)
set @iddcl = (select Id_Devolucion from Dev_Clientes where Id_Devolucion=@IDDC)

IF(@IDDC='')
	BEGIN
		print'Los campos no pueden quedar en blanco' 
	END
else
	BEGIN
		if(@IDDC=@iddcl)
			BEGIN
				delete from Det_DevClientes where @IDDC=Id_DevolucionDC
				delete from Dev_Clientes where @IDDC=Id_Devolucion
			END
		else
			BEGIN
				print 'La devolucion que esta tratando de eliminar no existe'
			END
	END

delete from Dev_Clientes

select * from Clientes
select * from Ventas 

--Detalle devClientes

--Insertar
ALTER procedure [dbo].[NuevoDetalleDevolucionClientes]
@IDDC char(4),
@CP char(4),
@C int,
@MDC char(2)
as
declare @idvent as char(4)
set @idvent =(Select Id_Venta from Dev_Clientes where @IDDC=Id_Devolucion)
declare @codpro as char(4)
set @codpro= (Select Cod_prod from DetalleVentas where Id_Venta=@idvent and Cod_Prod=@CP)
declare @ST as float
set @ST = (SELECT @C*precio from Productos where
		   Cod_Prod=@codpro)
declare @iddcl as char(4)
set  @iddcl = (Select Id_Devolucion from Dev_Clientes where Id_Devolucion=@IDDC)

declare @cantdc as int
set @cantdc =(Select cantidadv from DetalleVentas where Id_Venta=@idvent and Cod_Prod=@codpro)

IF(@IDDC='' or @CP ='' or @C='')
	BEGIN
		print'No se pueden dejar los camposs vacios'
	END
else
	BEGIN
		if(@IDDC=@iddcl)
			BEGIN
				if(@CP=@codpro)
					BEGIN
						IF(@C<=@cantdc)
							BEGIN
								if(@C<=0)
									BEGIN
										PRINT 'No puede ingresar una cantidad nula'
									END
								else
									BEGIN
										if(@MDC='V' or @MDC='D' or @MDC='E')
											BEGIN
												if(@CP=@codpro AND @iddcl=@IDDC)
													BEGIN
														print'ese detalle de devolucion ya esta registrado'
													END
												else
													BEGIN
														insert into Det_DevClientes values(@IDDC,@CP,@C,@ST,@MDC)
													END	
											END
										else
											BEGIN
												PRINT'Porfavor ingrese un motivo valido'
											END
									END
							END
						else
							BEGIN
								print'No puede devolver una cantidad mayor a la que compro'
							END
					END
				else
					BEGIN 
						print'El producto que esta tratando de ingresar no existe'
					END
			END
		else
			BEGIN 
				print'No se le puede asignar a una devolucion que no existe'
			END
	END

--Modificar

ALTER procedure ModificarDetalleDevolucionClientes
@IDDC char(4),
@CP char(4),
@C int,
@MDC CHAR(2)
as
declare @idvent as char(4)
set @idvent =(Select Id_Venta from Dev_Clientes where @IDDC=Id_Devolucion)
declare @codpro as char(4)
set @codpro= (Select Cod_prod from DetalleVentas where Id_Venta=@idvent and Cod_Prod=@CP)
declare @ST as float
set @ST = (SELECT @C*precio from Productos where
		   Cod_Prod=@codpro)
declare @iddcl as char(4)
set  @iddcl = (Select Id_Devolucion from Dev_Clientes)

declare @cantdc as int
set @cantdc =(Select cantidadv from DetalleVentas where Id_Venta=@idvent and Cod_Prod=@codpro)

IF(@IDDC='' or @CP ='' or @C='')
	BEGIN
		print'No se pueden dejar los camposs vacios'
	END
else
	BEGIN
		if(@IDDC=@iddcl)
			BEGIN
				if(@CP=@codpro)
					BEGIN
						IF(@C<=@cantdc)
							BEGIN
								if(@C<=0)
									BEGIN
										PRINT 'No puede ingresar una cantidad nula'
									END
								else
									BEGIN
										if(@MDC='V' or @MDC='D' or @MDC='E')
											BEGIN
												update Det_DevClientes set Cod_prod=@CP,cantidaddc=@C,subtdc= @ST ,motivodc= @MDC  where Id_DevolucionDC=@IDDC and Cod_prod=@CP
											END
										else
											BEGIN
												PRINT'Porfavor ingrese un motivo valido'
											END		
									END
							END
						else
							BEGIN
								print'No puede devolver una cantidad mayor a la que compro'
							END
					END
				else
					BEGIN 
					
						print'El producto que esta tratando de ingresar no existe'
					END
			END
		else
			BEGIN 
				print'No se le puede asignar a una devolucion que no existe'
			END
	END

--Eliminar devolucion clientes

create procedure ELiminarDetalleDevolucionClientes
@IDDC char(4),
@CP char(4)

as

declare @iddcl as char(4)
set @iddcl = (Select Id_Devolucion from Dev_Clientes where @IDDC=Id_Devolucion)

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Det_DevClientes where @IDDC=Id_DevolucionDC and Cod_Prod=@CP)

if(@IDDC='' or @CP='')
	BEGIN
		prinT'Los campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDDC=@iddcl)
			BEGIN
				if(@Cp=@codpro)
					BEGIN
						delete from Det_DevClientes where @codpro=Cod_prod and @IDDC=Id_DevolucionDC
					END
				else
					BEGIN
						Print'Esta tratando de devolver un producto equivocado'
					END
			END
		else
			BEGIN
				print'No se puede asignar a una compra que no existe'
			END
	END
--Devoluciones Distribuidora

--Insertar
create procedure NuevaDevolucionDistribuidora
@IDDD char(4),
@IDD char(4)
as
declare @idddev char(4)
set @idddev =(Select Id_DevolucionDD from Dev_Distribuidoras where @IDD=Id_DevolucionDD)

declare @iddistro as char(4)
set @iddistro = (SElect @IDD from Distibuidoras where @IDD =Id_Distribuidora)

if(@IDD='' or @IDD='')
	BEGIN
		print'Los campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDDD= @idddev)
			BEGIN
				print'Esta devolucion ya esta registrada'
			END
		else
			BEGIN
				if(@IDD=@iddistro)
					BEGIN
						insert into Dev_Distribuidoras values(@IDDD,GETDATE(),@IDDD,0)
					END
				else
					BEGIN
						print'La distribuidora que trata de ingresar no existe'
					END
			END

			
	END

--Modificar

create procedure ModificarDevolucionDistribuidora
@IDDD char(4),
@IDD char(4)
as
declare @idddev char(4)
set @idddev =(Select Id_DevolucionDD from Dev_Distribuidoras where @IDD=Id_DevolucionDD)

declare @iddistro as char(4)
set @iddistro = (SElect @IDD from Distibuidoras where @IDD =Id_Distribuidora)

if(@IDD='' or @IDD='')
	BEGIN
		print'Los campos no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDDD= @idddev)
			BEGIN
				if(@IDD=@iddistro)
					BEGIN
						update Dev_Distribuidoras set Id_Distribuidora= @IDD where @IDDD=Id_DevolucionDD
					END
				else
					BEGIN
						print'La distribuidora que trata de ingresar no existe'
					END
				
			END
		else
			BEGIN
				print'Esta devolucion ya esta registrada'
			END			
	END

--ELIMINAR

create procedure EliminarDevolucionDistribuidora
@IDDD char(4)

as
declare @iddevd as char(4)
set @iddevd = (Select Id_DevolucionDD from Dev_Distribuidoras where Id_DevolucionDD=@IDDD)

IF(@IDDD='')
	BEGIN
		print'Los valores no pueden quedar vacios'
	END
else
	BEGIN
		if(@IDDD=@iddevd)
			BEGIN
				delete from Det_DevDistribuidoras WHERE @IDDD= Id_DevolucionDD
				delete from Dev_Distribuidoras where @IDDD= Id_DevolucionDD
			END
		else
			BEGIN
				print'La devolucion que esta tratando de eliminar '
			END
	END

--Detalle devolucion distribuidora 

ALTER procedure NuevoDetalleDevolucionDistribuidora
@IDDD char(4),
@IDC char(4),
@CP char(4),
@C int
as
declare @P as float
set @P = (Select precio*0.9 from Productos where Cod_Prod=@CP)
declare @ST as float
set @ST= @C*@P

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Productos where Cod_Prod=@CP)

declare @cant as int
set @cant =(Select cantidaddc from DetalleCompras where Id_Compra=@IDC )

declare @idddev as char(4)
set @idddev = (Select Id_DevolucionDD from Dev_Distribuidoras where @IDDD=Id_DevolucionDD)

declare @idcomp as char(4)
set @idcomp= (Select Id_Compra from Compras where Id_Compra=@IDC)

if(@IDDD='' or @IDC='' or @CP='' or @C='')
	BEGIN
		PRINT'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@IDDD=@idddev)
			BEGIN
				if(@IDC= @idcomp)
					BEGIN
						if(@CP = @codpro)
							BEGIN
								if(@C <= @cant)
									BEGIN
										if(@C<=0)
											BEGIN
												PRINT'No puede ingresar una cantidad nula'
											END
										else
											BEGIN
												if(@CP=@codpro AND @idddev=@IDDD)
													BEGIN
														print'ese detalle de devolucion ya esta registrado'
													END
												else
													BEGIN
														insert into Det_DevDistribuidoras values(@IDDD,@CP,@C,@P,@ST,@IDC)
													END	
											END
									END
								else
									BEGIN
										print'No puede regresar una cantidad mayor a la comprada'
									END
							END
						else
							BEGIN
								print'El producto que ingreso no es valido'
							END
					END
				else
					BEGIN
						print'No se puede devolver sin numero de compra correcto'
					END
			END
		else
			BEGIN
				print'No se puede asignar a una devolucion no registrada'
			END
	END

--Modificar

create procedure ModificarDetalleDevolucionDistribuidora
@IDDD char(4),
@IDC char(4),
@CP char(4),
@C int
as
declare @P as float
set @P = (Select precio*0.9 from Productos where Cod_Prod=@CP)
declare @ST as float
set @ST= @C*@P

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Productos where Cod_Prod=@CP)

declare @cant as int
set @cant =(Select cantidaddc from DetalleCompras where Id_Compra=@IDC )

declare @idddev as char(4)
set @idddev = (Select Id_DevolucionDD from Dev_Distribuidoras where @IDDD=Id_DevolucionDD)

declare @idcomp as char(4)
set @idcomp= (Select Id_Compra from Compras where Id_Compra=@IDC)

if(@IDDD='' or @IDC='' or @CP='' or @C='')
	BEGIN
		PRINT'No se pueden dejar los campos vacios'
	END
else
	BEGIN
		if(@IDDD=@idddev)
			BEGIN
				if(@IDC= @idcomp)
					BEGIN
						if(@CP = @codpro)
							BEGIN
								if(@C <= @cant)
									BEGIN
										if(@C<=0)
											BEGIN
												PRINT'No puede ingresar una cantidad nula'
											END
										else
											BEGIN
												update Det_DevDistribuidoras set Cod_Prod= @CP,cantdd=@C,preciodd= @P,subtdd= @ST,Id_Compra=@IDC
											END
									END
								else
									BEGIN
										print'No puede regresar una cantidad mayor a la comprada'
									END
							END
						else
							BEGIN
								print'El producto que ingreso no es valido'
							END
					END
				else
					BEGIN
						print'No se puede devolver sin numero de compra correcto'
					END
			END
		else
			BEGIN
				print'No se puede asignar a una devolucion no registrada'
			END
	END

--Eliminat

create procedure EliminarDetalleDevolucionDistribuidora
@IDDD  char(4),
@CP  char(4)
as

declare @codpro as char(4)
set @codpro = (Select Cod_Prod from Productos where Cod_Prod=@CP)

declare @idddev as char(4)
set @idddev = (Select Id_DevolucionDD from Dev_Distribuidoras where @IDDD=Id_DevolucionDD)

if(@IDDD='' OR @CP='')
	BEGIN
		print'Los campos no pueden quedar nulos'
	END
else
	BEGIN
		if(@IDDD=@idddev)
			BEGIN
				if(@codpro=@CP)
					BEGIN
						delete from Det_DevDistribuidoras where Id_DevolucionDD=@IDDD and Cod_Prod=@CP
					END
				else
					BEGIN
						print'Inserte un producto que exista'
					END 
			END
		else
			BEGIN
				print'No puede elimnar por que esa compra no existe'
			END
	END

alter procedure USDAC
@USD float
as
declare @cordobas as float
set @cordobas = @USD * 33.71
if(@cordobas > 0)
	begin
		select @cordobas as TasaCambio
	end
else
	begin
		print 'No se pueden ingresar cantidades nulas ni negativas'
	end

