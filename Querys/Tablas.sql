use FarmaUZIEL

-- Creando tablas


-- CLIENTES
create table Clientes(
Id_Cliente int identity(1,1) primary key not null,
PNCliente nvarchar(15) not null,
SNCliente nvarchar(15),
PACliente nvarchar(15) not null,
SACliente nvarchar(15),
DirC nvarchar(70) not null,
TelCliente char(8) check (TelCliente like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
)


-- PRODUCTOS
create table Medicamentos(
IdMedicamento int identity(1,1) primary key not null,
NombreMed nvarchar(50) not null,
FechaElab datetime not null,
FechaVenc datetime not null,
DescProd nvarchar(50) not null,
precio float not null,
cantidad int not null,
Distribuidora nvarchar(50) not null,
)





-- VENTAS
create table Ventas(
Id_Venta int identity (1,1) primary key not null,
Id_Cliente int foreign key references Clientes(Id_Cliente) not null,
IdMedicamento int foreign key references Medicamentos(IdMedicamento) not null,
cantidadv int not null,
Fecha_Venta datetime default getdate() not null,
subtotalv float,
totalv float,
)




