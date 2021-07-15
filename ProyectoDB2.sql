CREATE DATABASE Prueba2;
Go

USE Prueba2;

-- RH = Recursos Humanos
CREATE TABLE RH_Departamento(
	IdDepartamento smallint IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(30) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Departamento_FechaDeModificacion DEFAULT (getdate()),
) 

GO

CREATE TABLE RH_Empleado(
	IdEmpleado int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --LLave foranea a P_Persona
	TituloProfesional nvarchar(50) NOT NULL,
	FechaDeCumpleanios date NOT NULL,
	EstadoCivil nvarchar(20) NOT NULL CHECK (EstadoCivil IN('Soltero(a)', 'Casado(a)', 'Union Libre', 'Divorciado(a)', 'Viudo(a)')),
	Sexo nchar(1) NOT NULL CHECK (Sexo IN('F', 'H')), --
	FechaDeContratacion date NOT NULL,
	HorasDeVacaciones smallint NOT NULL DEFAULT (0),
	HorasPorEnfermedad smallint NOT NULL DEFAULT (0),
	Estado varchar(15) NOT NULL CHECK (Estado IN('Activo', 'En Vacaciones', 'Enfermo', 'Despedido')) CONSTRAINT DF_Empleado_Estado DEFAULT ('ACTIVO'),
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Empleado_FechaDeModificacion  DEFAULT (getdate()), 
) 
GO

--lleva el registro del historial de cambios de departamento y jornada de los empleados
CREATE TABLE RH_HistorialEmpleadoDepartamento(
	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	IdDepartamento smallint NOT NULL, --llave foranea a RH_Departamento
	IdJornada tinyint NOT NULL, --llave foranea a RH_Jornada

	FechaDeInicio date NOT NULL,
	FechaDeFinalizacion date NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_HistorialEmpleadoDepartamento_FechaDeModificacion  DEFAULT (getdate()),
	PRIMARY KEY(IdPersona, IdDepartamento, IdJornada)
) 
GO

--Cada dia es un nuevo turno.
CREATE TABLE RH_Jornada(
	IdJornada tinyint IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(15) NOT NULL,
	HoraInicio time NOT NULL,
	HoraSalida time NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Jornada_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

CREATE TABLE RH_HistorialPagoEmpleado(
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	FechaDeCambioDePago datetime NOT NULL,
	SalarioPoHora money NOT NULL,
	FecuenciaDePago tinyint NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_HistorialPagoEmpleado_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

--P = Persona
CREATE TABLE P_Direccion(
	IdDireccion int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	DireccionDescripcion1 nvarchar(60) NOT NULL,
	DireccionDescripcion2 nvarchar(60) NULL,
	Ciudad nvarchar(30) NOT NULL,
	Departamento_Estado nvarchar(30) NOT NULL,
	Pais nvarchar(30) NOT NULL,
	CodigoPostal nvarchar(15) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Direccion_FechaDeModificacion  DEFAULT (getdate()),
)
GO


CREATE TABLE P_Persona(
	IdPersona nvarchar(15) PRIMARY KEY NOT NULL, -- el id de la persona puede ser el dni o pasaporte

	PrimerNombre nvarchar(20) NOT NULL,
	SegundoNombre nvarchar(20) NULL,
	PrimerApellido nvarchar(20) NOT NULL,
	SegundoApellido nvarchar(20) NULL,
	InformacionAdicional nvarchar(60) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Persona_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--El telefono/s de la persona, ya sea cliente o empleado
CREATE TABLE P_PersonaTelefono(
	IdTelefono int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	NumeroTelefono nvarchar(20) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_PersonaTelefono_FechaDeModificacion  DEFAULT (getdate()),
) 
GO



--A = Administracion
--En el inventario van los intrumentos o herramientas usadas en el hotel, por ejemplo cameras, herramientas para reparacion, etc.
CREATE TABLE A_Inventario(
	IdInventario int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(30) NOT NULL,
	cantidadExistencia smallint NOT NULL,
	Tamanio nvarchar(12) NULL,
	Descipcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Inventario_FechaDeModificacion  DEFAULT (getdate()),
)
GO

-- Productos que se venderan a los clientes
CREATE TABLE A_Producto(
	IdProducto int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(30) NOT NULL,
	Precio_venta money NOT NULL,
	Descripcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Producto_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--la orden de compra de cualquiera de las dos tablas, A_Inventario o A_Producto
CREATE TABLE A_OrdenCompra(
	IdOrdenCompraInventario int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdEmpleado int NOT NULL, --llave foranea a RH_Empleado
	IdInventario int NULL, --llave foranea a A_Inventario
	IdProducto int NULL, --llave foranea a A_Producto
	Cantidad smallint NOT NULL,
	PrecioTotal money NOT NULL,
	Descipcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_OrdenCompra_FechaDeModificacion  DEFAULT (getdate()),
)
GO

CREATE TABLE A_Habitaciones(
	IdHabitacion int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Numero smallint NOT NULL,
	Piso smallint NOT NULL,
	Precio money NULL,
	Estado nvarchar(20) NOT NULL check (Estado IN('Disponible','En Uso','En Mantenimiento')) CONSTRAINT DF_Habitaciones_Estado  DEFAULT ('Disponible'),
	Descripcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Habitaciones_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--V = Area de Ventas
CREATE TABLE V_Reserva(
	IdReserva int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdHabitacion int NOT NULL, --llave foranea a A_Habitaciones
	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	IdEmpleado int NULL, --llave foranea a RH_Empleado
	Fecha_ingresa date NOT NULL,
	Fecha_sale date NOT NULL,
	SubTotal money NULL,
	Estado nvarchar NOT NULL check (Estado IN('Activa','Cancelada')) CONSTRAINT DF_Reservacion_Estado  DEFAULT ('Activa'),
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Reserva_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--Cuando llega a recepcion y empieza a disfrutar del hospedaje
CREATE TABLE V_Registro(
	IdRegistro int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdEmpleado int NULL, --llave foranea a RH_Empleado
	Fecha_ingreso datetime NOT NULL,
	Fecha_salida datetime NOT NULL,
	SubTotal money NULL,
	Decuento money NULL CONSTRAINT DF_Registro_Descuento DEFAULT (0),
	Total nvarchar NULL, 
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Registro_FechaDeModificacion  DEFAULT (getdate()),
)
GO

CREATE TABLE V_Consumo(
	IdConsumo int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdRegistro int NULL, --llave foranea a V_Registro
	IdProducto int NOT NULL, --llave foranea a A_Producto
	Cantidad smallint NOT NULL,
	Precio_total money NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Consumo_FechaDeModificacion  DEFAULT (getdate()),
)
GO


CREATE TABLE V_Pago(
	IdPago int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdRegistro int NOT NULL, --llave foranea a V_Registro
	Tipo_comprobante nvarchar(15) NOT NULL check (Tipo_comprobante IN('Normal','Con RTN')),
	Total_pago money NOT NULL,
	Fecha_pago datetime CONSTRAINT DF_pago_FechaDePago DEFAULT (getdate()),
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Pago_FechaDeModificacion  DEFAULT (getdate())
)
GO


ALTER TABLE RH_Empleado ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE RH_HistorialEmpleadoDepartamento ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE RH_HistorialEmpleadoDepartamento ADD FOREIGN KEY (IdDepartamento) REFERENCES RH_Departamento(IdDepartamento);
GO
ALTER TABLE RH_HistorialEmpleadoDepartamento ADD FOREIGN KEY (IdJornada) REFERENCES RH_Jornada(IdJornada);
GO
ALTER TABLE P_Direccion ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE P_PersonaTelefono ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE A_OrdenCompra ADD FOREIGN KEY (IdEmpleado) REFERENCES RH_Empleado(IdEmpleado);
GO
ALTER TABLE A_OrdenCompra ADD FOREIGN KEY (IdInventario) REFERENCES A_Inventario(IdInventario);
GO
ALTER TABLE A_OrdenCompra ADD FOREIGN KEY (IdProducto) REFERENCES A_Producto(IdProducto);
GO
ALTER TABLE V_Reserva ADD FOREIGN KEY (IdHabitacion) REFERENCES A_Habitaciones(IdHabitacion);
GO
ALTER TABLE V_Reserva ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE V_Reserva ADD FOREIGN KEY (IdEmpleado) REFERENCES RH_Empleado(IdEmpleado);
GO
ALTER TABLE V_Consumo ADD FOREIGN KEY (IdRegistro) REFERENCES V_Registro(IdRegistro);
GO
ALTER TABLE V_Consumo ADD FOREIGN KEY (IdProducto) REFERENCES A_Producto(IdProducto);
GO
ALTER TABLE V_Pago ADD FOREIGN KEY (IdRegistro) REFERENCES V_Registro(IdRegistro);
GO

