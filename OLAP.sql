USE master;
GO

CREATE DATABASE Hotel_OLAP;
Go

USE Hotel_OLAP;




CREATE TABLE DimClientes(
	IdPersona nvarchar(15) PRIMARY KEY NOT NULL,

	PrimerNombre nvarchar(20),
	PrimerApellido nvarchar(20),
	Tipo nvarchar(20)
)
GO


CREATE TABLE H_Reserva(
	IdReserva int,
	IdCliente nvarchar(15) REFERENCES DimClientes(IdPersona), 
	IdHabitacion int REFERENCES DimHabitaciones(IdHabitacion),
	Fecha datetime,
	Estado nvarchar(15),
	PRIMARY KEY (IdReserva, IdCliente, IdHabitacion, Fecha)
)
GO

CREATE TABLE DimProducto(
	IdProducto int PRIMARY KEY NOT NULL,

	Nombre nvarchar(30),
	Precio_venta money,
	Categoria nvarchar(20),
)
GO

CREATE TABLE H_Consumo(
	IdConsumo int,
	IdProducto int REFERENCES DimProducto(IdProducto),
	Fecha datetime,
	Cantidad smallint,
	Precio_total money,
	PRIMARY KEY (IdConsumo, IdProducto, Fecha)
)
GO

CREATE TABLE DimEmpleados(
	IdEmpleado int PRIMARY KEY,
	IdPersona int,
	PrimerNombre nvarchar(20),
	PrimerApellido nvarchar(20),
	Estado nvarchar(15),
)
GO

CREATE TABLE H_Mantenimiento(
	IdMantenimiento int,
	IdEmpleado int REFERENCES DimEmpleados(IdEmpleado),
	Fecha datetime,
	TipoSolicitud nvarchar(30),
	PRIMARY KEY (IdMantenimiento, IdEmpleado, Fecha)
)
GO

CREATE TABLE DimInformacionPermanenciaHabitacion (
    "ID" int PRIMARY KEY,
    "checkout" nvarchar(max),
    "checkin" nvarchar(max),
    "room_id" int,
    "room_name" nvarchar(max),
)

CREATE TABLE H_ComentariosHotel (
    ID int PRIMARY KEY,
	author_fk int REFERENCES DimAutor(ID),
    travel_purpose nvarchar(max),
    pros nvarchar(max),
    "date" datetime,
    title nvarchar(max),
    average_score float,
    cons nvarchar(max),
)


Use Hotel_OLTP

SELECT Reserva.IdReserva, Reserva.IdPersona, Lista.IdHabitacion, Reserva.Fecha_ingreso, Reserva.Estado 
FROM [dbo].[V_Reserva] Reserva
INNER JOIN [dbo].[V_ListaHabitacionesPorReserva] Lista
ON Reserva.[IdReserva] = Lista.[IdReserva] 

SELECT Empleado.IdEmpleado, Empleado.IdPersona, Info.PrimerNombre, Info.PrimerApellido, Empleado.Estado 
FROM [dbo].[RH_Empleado] Empleado
INNER JOIN [dbo].[P_Persona] Info
ON Empleado.IdPersona = Info.IdPersona

SELECT Mantenimiento.IdMantenimiento, Mantenimiento.IdEmpleado, Mantenimiento.Fecha_Realizacion AS Fecha, Solicitud.TipoSolicitud 
FROM [dbo].[A_Mantenimiento] Mantenimiento
INNER JOIN [dbo].[A_Solicitud_Mantenimiento] Solicitud
ON Mantenimiento.IdSolicitudMantenimiento = Solicitud.IdSolicitudMantenimiento

ALTER TABLE RH_Empleado ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO