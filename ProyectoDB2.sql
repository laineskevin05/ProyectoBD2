CREATE DATABASE Hotel_OLTP;
Go

USE Hotel_OLTP;

-- RH = Recursos Humanos
CREATE TABLE RH_Departamento(
	IdDepartamento smallint IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(30) NOT NULL,
) 

GO

CREATE TABLE RH_Empleado(
	IdEmpleado int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --LLave foranea a P_Persona
	TituloProfesional nvarchar(100) NOT NULL,
	FechaDeCumpleanios datetime,
	EstadoCivil nvarchar(20) NOT NULL CHECK (EstadoCivil IN('Soltero(a)', 'Casado(a)', 'Union Libre', 'Divorciado(a)', 'Viudo(a)')),
	Sexo nchar(1) NOT NULL CHECK (Sexo IN('F', 'H')), --
	FechaDeContratacion datetime NOT NULL,
	HorasDeVacaciones smallint NOT NULL DEFAULT (0),
	HorasPorEnfermedad smallint NOT NULL DEFAULT (0),
	Estado nvarchar(15) NOT NULL CHECK (Estado IN('Activo', 'En Vacaciones', 'Enfermo', 'Despedido')) CONSTRAINT DF_Empleado_Estado DEFAULT ('ACTIVO'),
) 
GO

--lleva el registro del historial de cambios de departamento y jornada de los empleados
CREATE TABLE RH_HistorialEmpleadoDepartamento(
	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	IdDepartamento smallint NOT NULL, --llave foranea a RH_Departamento
	IdJornada tinyint NOT NULL, --llave foranea a RH_Jornada

	FechaDeInicio date NOT NULL,
	FechaDeFinalizacion date NULL,
	PRIMARY KEY(IdPersona, IdDepartamento, IdJornada)
) 
GO

--Cada dia es un nuevo turno.
CREATE TABLE RH_Jornada(
	IdJornada tinyint IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(15) NOT NULL,
	HoraInicio time NOT NULL,
	HoraSalida time NOT NULL,
) 
GO

--Esta tabla sera llenada por medio de un Trigger
CREATE TABLE RH_HistorialPagoEmpleado(
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	FechaDeCambioDePago datetime NOT NULL CONSTRAINT DF_HistorialPagoEmpleado_FechaDeCambioDePago  DEFAULT (getdate()),
	SalarioPoHora money NOT NULL,
	FecuenciaDePago tinyint NOT NULL
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
)
GO


CREATE TABLE P_Persona(
	IdPersona nvarchar(15) PRIMARY KEY NOT NULL, -- el id de la persona puede ser el dni o pasaporte

	PrimerNombre nvarchar(30) NOT NULL,
	SegundoNombre nvarchar(30) NULL,
	PrimerApellido nvarchar(30) NOT NULL,
	SegundoApellido nvarchar(30) NULL,
	Tipo nvarchar(25) NOT NULL check (TIPO IN('Empleado','Cliente Natural','Cliente Juridico')) CONSTRAINT DF_Persona_Tipo DEFAULT ('Cliente Natural'),
	InformacionAdicional nvarchar(60) NULL,
)
GO

--El telefono/s de la persona, ya sea cliente o empleado
CREATE TABLE P_PersonaTelefono(
	IdTelefono int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	NumeroTelefono nvarchar(20) NOT NULL,
) 
GO

--A = Administracion

-- Productos que se venderan a los clientes
CREATE TABLE A_Producto(
	IdProducto int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Nombre nvarchar(80) NOT NULL,
	Precio_venta money NOT NULL,
	Categoria nvarchar(30) NULL,
	Descipcion nvarchar(100) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Producto_FechaDeModificacion  DEFAULT (getdate()),
)
GO


--En el inventario van que puede usarse en el hotel y tambien los productos para consumo que vende el hotel.
CREATE TABLE A_Inventario(
	IdInventario int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdProducto int NOT NULL, --llave foranea a A_Producto
	Nombre nvarchar(80) NOT NULL,
	CantidadExistencia int NOT NULL CHECK (cantidadExistencia >= 0),
)
GO
--la orden de compra de cualquiera de las dos tablas, A_Inventario o A_Producto
CREATE TABLE A_OrdenCompra(
	IdOrdenCompraInventario int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdEmpleado int NOT NULL, --llave foranea a RH_Empleado
	IdInventario int NULL, --llave foranea a A_Inventario
	Cantidad smallint NOT NULL CHECK (Cantidad >= 1),
	Fecha datetime NOT NULL CONSTRAINT DF_OrdenCompra_Fecha DEFAULT (getdate()),
	PrecioTotal money NOT NULL,
	Descipcion nvarchar(100) NULL,
)
GO

CREATE TABLE A_Solicitud_Mantenimiento(
	IdSolicitudMantenimiento int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdHabitacion INT NULL, --llave foranea a A_Habitaciones, es null si no se dio en una habitacion
	Fecha_Solicitud DATETIME NOT NULL, 
	TipoSolicitud nvarchar(60) NOT NULL,
	Descripcion nvarchar(100) NOT NULL,
	Estado nvarchar(20) NOT NULL check (Estado IN('Pendiente','Realizado')) CONSTRAINT DF_Solicitud_Estado DEFAULT('Pendiente')
)
GO

CREATE TABLE A_Mantenimiento(
	IdMantenimiento int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdSolicitudMantenimiento int NOT NULL,--llave foranea a A_Solicitud_Mantenimiento
	IdEmpleado INT NOT NULL, --llave foranea a RH_Empleado,
	Fecha_Realizacion DATETIME NOT NULL,
	Descripcion nvarchar(200),
)

CREATE TABLE A_Habitaciones(
	IdHabitacion int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	Numero smallint NOT NULL,
	Piso smallint NOT NULL,
	Precio money NULL,
	Categoria nvarchar(40) NOT NULL check (Categoria IN('Una Cama','Dos Camas','Tres Cama', 'Cuatro Camas')),
	Estado nvarchar(40) NOT NULL check (Estado IN('Disponible','En Uso','En Mantenimiento')) CONSTRAINT DF_Habitaciones_Estado  DEFAULT ('Disponible'),
	Descripcion nvarchar(100) NULL,
)
GO

--V = Area de Ventas
CREATE TABLE V_Reserva(
	IdReserva int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea a P_Persona
	IdEmpleado int NULL, --llave foranea a RH_Empleado
	Fecha_ingreso datetime NOT NULL,
	Fecha_sale datetime NOT NULL,
	NumeroDeHabitaciones smallint NULL CONSTRAINT DF_Reserva_Numero  DEFAULT (0), --sera llenada por medio de triggers y se sumara +1 por cada nuevo registro en ListaHabitacionesPorReserva
	Estado nvarchar(30) NOT NULL check (Estado IN('Activa','Cancelada')) CONSTRAINT DF_Reservacion_Estado  DEFAULT ('Activa'),
	SubTotal money NULL, -- Es el subtotal de la 1 o mas habitraciones en la reservacion, con los consumos, sin incluir descuentos e impuestos.
)
GO

--La Lista de habitaciones reservadas en una reservacion
CREATE TABLE V_ListaHabitacionesPorReserva(
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdReserva int NOT NULL, --llave foranea a V_Reserva
	IdHabitacion int NOT NULL, --llave foranea a A_Habitaciones
)
GO


CREATE TABLE V_Consumo(
	IdConsumo int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdReserva int NULL, --llave foranea a V_Reserva
	IdProducto int NOT NULL, --llave foranea a A_Producto
	Cantidad smallint NOT NULL CHECK (Cantidad >= 0),
	Precio_total money NOT NULL,
	Fecha datetime NOT NULL CONSTRAINT DF_Consumo_Fecha  DEFAULT (getdate()),
)
GO


CREATE TABLE V_Pago(
	IdPago int IDENTITY(1,1) PRIMARY KEY NOT NULL,

	IdReserva int NOT NULL, --llave foranea a V_Reserva
	Tipo_comprobante nvarchar(15) NOT NULL check (Tipo_comprobante IN('Normal','Con RTN')),
	RTN nvarchar(15) NULL,
	Descuento money NULL CONSTRAINT DF_Registro_Descuento DEFAULT (0),
	Impuesto money NULL,
	Total_pago money NULL,
	Fecha_pago datetime CONSTRAINT DF_pago_FechaDePago DEFAULT (getdate()),
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
ALTER TABLE A_Inventario ADD FOREIGN KEY (IdProducto) REFERENCES A_Producto(IdProducto);
GO
ALTER TABLE A_OrdenCompra ADD FOREIGN KEY (IdEmpleado) REFERENCES RH_Empleado(IdEmpleado);
GO
ALTER TABLE A_OrdenCompra ADD FOREIGN KEY (IdInventario) REFERENCES A_Inventario(IdInventario);
GO
ALTER TABLE V_Reserva ADD FOREIGN KEY (IdPersona) REFERENCES P_Persona(IdPersona);
GO
ALTER TABLE V_Reserva ADD FOREIGN KEY (IdEmpleado) REFERENCES RH_Empleado(IdEmpleado);
GO
ALTER TABLE V_ListaHabitacionesPorReserva ADD FOREIGN KEY (IdReserva) REFERENCES V_Reserva(IdReserva);
GO
ALTER TABLE V_ListaHabitacionesPorReserva ADD FOREIGN KEY (IdHabitacion) REFERENCES A_Habitaciones(IdHabitacion);
GO
ALTER TABLE V_Consumo ADD FOREIGN KEY (IdReserva) REFERENCES V_Reserva(IdReserva);
GO
ALTER TABLE V_Consumo ADD FOREIGN KEY (IdProducto) REFERENCES A_Producto(IdProducto);
GO
ALTER TABLE V_Pago ADD FOREIGN KEY (IdReserva) REFERENCES V_Reserva(IdReserva);
GO
ALTER TABLE A_Mantenimiento ADD FOREIGN KEY (IdEmpleado) REFERENCES RH_Empleado(IdEmpleado);
GO
ALTER TABLE A_Solicitud_Mantenimiento ADD FOREIGN KEY (IdHabitacion) REFERENCES A_Habitaciones(IdHabitacion);
GO
ALTER TABLE A_Mantenimiento ADD FOREIGN KEY (IdSolicitudMantenimiento) REFERENCES A_Solicitud_Mantenimiento(IdSolicitudMantenimiento);
GO

