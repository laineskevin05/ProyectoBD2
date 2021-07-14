


-- RH = Recursos Humanos
CREATE TABLE RH_Departamento(
	DepartamentoID smallint IDENTITY(1,1) NOT NULL,

	Nombre varchar(30) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Departamento_FechaDeModificacion DEFAULT (getdate()),
) 

GO

CREATE TABLE RH_Empleado(
	IdEmpleado int IDENTITY(1,1) NOT NULL ,

	IdPersona nvarchar(15) NOT NULL, --Foreng key
	TituloProfesional nvarchar(50) NOT NULL,
	FechaDeCumpleanios date NOT NULL,
	EstadoCivil nchar(1) NOT NULL CHECK (EstadoCivil IN('Soltero(a)', 'Casado(a)', 'Union Libre', 'Divorciado(a)', 'Viudo(a)')),
	Sexo nchar(1) NOT NULL CHECK (EstadoCivil IN('F', 'H')), --
	FechaDeContratacion date NOT NULL,
	HorasDeVacaciones smallint NOT NULL DEFAULT (0),
	HorasPorEnfermedad smallint NOT NULL DEFAULT (0),
	Estado varchar(15) NOT NULL CONSTRAINT DF_Empleado_Estado DEFAULT ('ACTIVO'),
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Empleado_FechaDeModificacion  DEFAULT (getdate()), 
) 
GO

--lleva el registro del historial de cambios de departamento y jornada de los empleados
CREATE TABLE RH_HistorialEmpleadoDepartamento(
	IdPersona nvarchar(15) NOT NULL, --llave foranea
	IdDepartamento smallint NOT NULL, --llave foranea
	IdJornada tinyint NOT NULL, --llave foranea

	FechaDeInicio date NOT NULL,
	FechaDeFinalizacion date NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_HistorialEmpleadoDepartamento_FechaDeModificacion  DEFAULT (getdate()),
	PRIMARY KEY(IdPersona, IdDepartamento, IdJornada)
) 
GO

--Cada dia es un nuevo turno.
CREATE TABLE RH_Jornada(
	IdJornada tinyint IDENTITY(1,1) NOT NULL,

	Nombre varchar(15) NOT NULL,
	HoraInicio time NOT NULL,
	HoraSalida time NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Jornada_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

CREATE TABLE RH_HistorialPagoEmpleado(
	Id int primary key,

	IdPersona nvarchar(15) NOT NULL, --llave foranea
	FechaDeCambioDePago datetime NOT NULL,
	SalarioPoHora money NOT NULL,
	FecuenciaDePago tinyint NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_HistorialPagoEmpleado_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

--P = Persona
CREATE TABLE P_Direccion(
	IdDireccion int IDENTITY(1,1) NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea
	DireccionDescripcion1 nvarchar(60) NOT NULL,
	DireccionDescripcion2 nvarchar(60) NULL,
	Ciudad nvarchar(30) NOT NULL,
	Departamento_Estado nvarchar(30) NOT NULL,
	Pais nvarchar(30) NOT NULL,
	CodigoPostal nvarchar(15) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Direccion_FechaDeModificacion  DEFAULT (getdate()),
)
GO


CREATE TABLE P_Persona(
	IdPersona nvarchar(15) primary key NOT NULL, -- el id de la persona puede ser el dni o pasaporte

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
	IdTelefono int IDENTITY(1,1) NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --llave foranea
	NumeroTelefono nvarchar(20) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_PersonaTelefono_FechaDeModificacion  DEFAULT (getdate()),
) 
GO



--A = Administracion
--En el inventario van los intrumentos o herramientas usadas en el hotel, por ejemplo cameras, herramientas para reparacion, etc.
CREATE TABLE A_Inventario(
	IdInventario int IDENTITY(1,1) NOT NULL,

	Nombre nvarchar(30) NOT NULL,
	cantidadExistencia smallint NOT NULL,
	Tamanio nvarchar(12) NULL,
	Descipcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Inventario_FechaDeModificacion  DEFAULT (getdate()),
)
GO

-- Productos que se venderan a los clientes
CREATE TABLE A_Producto(
	IdProducto int IDENTITY(1,1) NOT NULL,

	Nombre nvarchar(30) NOT NULL,
	Precio_venta money NOT NULL,	Descripcion nvarchar(40) NULL,	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Producto_FechaDeModificacion  DEFAULT (getdate()),)
GO

--la orden de compra de cualquiera de las dos tablas, A_Inventario o A_Producto
CREATE TABLE A_OrdenCompra(
	IdOrdenCompraInventario int IDENTITY(1,1) NOT NULL,

	IdEmpleado int NOT NULL, --llave foranea
	IdInventario int NULL, --llave foranea
	IdProducto int NULL, --llave foranea
	Cantidad smallint NOT NULL,
	PrecioTotal money NOT NULL,
	Descipcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_OrdenCompra_FechaDeModificacion  DEFAULT (getdate()),
)
GO

CREATE TABLE A_Habitaciones(
	IdHabitacion int IDENTITY(1,1) NOT NULL,

	Numero smallint NOT NULL,
	Piso smallint NOT NULL,
	Precio money NULL,
	Estado nvarchar(20) check (Estado IN('Disponible','En Uso','En Mantenimiento')) NOT NULL,
	Descripcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Habitaciones_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--V = Area de Ventas
CREATE TABLE V_Reserva(
	IdReserva int IDENTITY(1,1) NOT NULL,

	IdHabitacion int NOT NULL, --llave foranea
	IdPersona int NOT NULL, --llave foranea
	IdEmpleado int NULL, --llave foranea
	Fecha_ingresa date NOT NULL,
	Fecha_sale date NOT NULL,	SubTotal money NULL,	Estado nvarchar NULL check (Estado IN('Activa','Cancelada')),	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Reserva_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--Cuando llega a recepcion y empieza a disfrutar del hospedaje
CREATE TABLE V_Registro(
	IdRegistro int IDENTITY(1,1) NOT NULL,

	IdEmpleado int NULL, --llave foranea
	Fecha_ingreso datetime NOT NULL,
	Fecha_salida datetime NOT NULL,	SubTotal money NULL,	Decuento money NOT NULL CONSTRAINT DF_Registro_Descuento DEFAULT (0),	Total nvarchar NULL, 	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Reserva_FechaDeModificacion  DEFAULT (getdate()),
)
GO

CREATE TABLE V_Consumo(
	IdConsumo int IDENTITY(1,1) NOT NULL,

	IdRegistro int NULL, --llave foranea
	IdProducto int NOT NULL, --llave foranea
	Cantidad smallint NOT NULL,
	Precio_total money NOT NULL,	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Consumo_FechaDeModificacion  DEFAULT (getdate()),)GOCREATE TABLE V_Pago(
	IdPago int IDENTITY(1,1) NOT NULL,

	IdRegistro int NOT NULL, --llave foranea
	Tipo_comprobante nvarchar check (Tipo_comprobante IN('Normal','Con RTN')),
	Total_pago money NOT NULL,
	Fecha_pago datetime CONSTRAINT DF_pago_FechaDePago DEFAULT (getdate()),
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Pago_FechaDeModificacion  DEFAULT (getdate())
)
GO