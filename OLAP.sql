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
	IdProducto int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(30),
	Precio_venta money,
	Categoria nvarchar(20),
)
GO










SELECT Reserva.IdReserva, Reserva.IdPersona, Lista.IdHabitacion, Reserva.Fecha_ingreso, Reserva.Estado FROM [dbo].[V_Reserva] Reserva
INNER JOIN [dbo].[V_ListaHabitacionesPorReserva] Lista
ON Reserva.[IdReserva] = Lista.[IdReserva] 