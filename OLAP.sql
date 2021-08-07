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












Use Hotel_OLTP;

SELECT * FROM [Hotel_OLTP].[dbo].[RH_Empleado] 
INNER JOIN [Hotel_OLTP].[dbo].[P_Persona] 
ON [Hotel_OLTP].[dbo].[RH_Empleado].[IdEmpleado] = [Hotel_OLTP].[dbo].[P_Persona] 


SELECT Reserva.IdReserva, Reserva.IdPersona, Lista.IdHabitacion, Reserva.Fecha_ingreso, Reserva.Estado FROM [dbo].[V_Reserva] Reserva
INNER JOIN [dbo].[V_ListaHabitacionesPorReserva] Lista
ON Reserva.[IdReserva] = Lista.[IdReserva] 