


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
	EstadoCivil nchar(1) NOT NULL CHECK (EstadoCivil IN('S', 'C', 'U', 'D', 'V')), -- S = Soltero/a, C = Casado/a, U = Unión libre o unión de hecho, D = Divorciado/a  V = Viudo/a.
	Sexo nchar(1) NOT NULL CHECK (EstadoCivil IN('F', 'H')), --
	FechaDeContratacion date NOT NULL,
	HorasDeVacaciones smallint NOT NULL DEFAULT (0),
	HorasPorEnfermedad smallint NOT NULL DEFAULT (0),
	Estado varchar(15) NOT NULL CONSTRAINT DF_Empleado_Estado DEFAULT ((1)),
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
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_EmpleadoDepartamentoHistorial_FechaDeModificacion  DEFAULT (getdate()),
	primary key (IdPersona, IdDepartamento, IdJornada)
) 
GO
--Cada dia es un nuevo turno.
CREATE TABLE RH_Jornada(
	IdJornada tinyint IDENTITY(1,1) NOT NULL,
	Nombre varchar(15) NOT NULL,
	HoraInicio time NOT NULL,
	HoraSalida time NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Turno_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

CREATE TABLE RH_HistorialPagoEmpleado(
	Id int primary key,

	IdPersona nvarchar(15) NOT NULL,
	FechaDeCambioDePago datetime NOT NULL,
	SalarioPoHora money NOT NULL,
	FecuenciaDePago tinyint NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_EmpleadoPagoHistorial_FechaDeModificacion  DEFAULT (getdate()),
) 
GO

--P = Persona
CREATE TABLE P_Direccion(
	IdDireccion int IDENTITY(1,1) NOT NULL,

	IdPersona nvarchar(15) NOT NULL, --foreng key
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

	TipoDePersona nchar(2) NOT NULL, --Se podria poner cliente o empleado
	PrimerNombre nvarchar(20) NOT NULL,
	SegundoNombre nvarchar(20) NULL,
	PrimerApellido nvarchar(20) NOT NULL,
	SegundoApellido nvarchar(20) NOT NULL,
	InformacionAdicional nvarchar(60) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Persona_FechaDeModificacion  DEFAULT (getdate()),
)
GO

--El telefono/s de la persona, ya sea cliente o empleado
CREATE TABLE P_PersonaTelefono(
	IdTelefono int IDENTITY(1,1) NOT NULL,
	IdPersona nvarchar(15) NOT NULL, -- foreng key
	NumeroTelefono nvarchar(20) NOT NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_PersonaTelefono_FechaDeModificacion  DEFAULT (getdate()),
) 
GO


CREATE TABLE Utencilios(
	IdUtencilio int IDENTITY(1,1) NOT NULL,
	Nombre nvarchar(30) NOT NULL,
	NumeroDeSerie nvarchar(25) NOT NULL,
	Vendible BIT NOT NULL CONSTRAINT DF_Produccion_Vendible  DEFAULT ((1)),
	Color nvarchar(15) NULL,
	cantidadExistencia smallint NOT NULL,
	Tamanio nvarchar(12) NULL,
	TipoDeComponente nchar(15) NULL,
	Descipcion nvarchar(40) NULL,
	FechaDeModificacion datetime NOT NULL CONSTRAINT DF_Produccion_FechaDeModificacion  DEFAULT (getdate()),
)
GO