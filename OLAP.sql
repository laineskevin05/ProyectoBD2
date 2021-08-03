USE master;
GO

CREATE DATABASE Hotel_OLAP;
Go

USE Hotel_OLAP;




CREATE TABLE Clientes(
	IdPersona nvarchar(15) PRIMARY KEY NOT NULL,

	PrimerNombre nvarchar(20),
	PrimerApellido nvarchar(20),
	Tipo nvarchar(20)
)
GO