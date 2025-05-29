------------------------------------------------------------------------------------------
---------------------------------------CREATE TABLE---------------------------------------
------------------------------------------------------------------------------------------

CREATE DATABASE OtorgamientoDeCreditos
GO

USE OtorgamientoDeCreditos

CREATE SCHEMA Clientes AUTHORIZATION dbo
GO

CREATE SCHEMA Creditos AUTHORIZATION dbo
GO

CREATE SCHEMA Core AUTHORIZATION dbo
GO

--El campo Estado indica si un registro está activo o inactivo, permitiendo realizar eliminaciones lógicas en lugar de eliminar físicamente los datos

CREATE TABLE Clientes.Clientes(
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
	TipoCliente INT NOT NULL,
	Descripcion NVARCHAR(250),

	Nombres NVARCHAR(250),
    ApellidoPaterno NVARCHAR(100),
	ApellidoMaterno NVARCHAR(100),
	ApellidoCasada NVARCHAR(100),
	ConocidoPor NVARCHAR(100),
	Genero INT,
	EstadoFamiliar INT,
	TipoDNI NVARCHAR(20),
	NumeroDNI NVARCHAR(20) UNIQUE, --Numero de DNI depende del campo TipoDNI, debido a ello, no se añade el tipo CHAR
    FechaNacimiento DATE,

	RazonSocial NVARCHAR(250),
    NombreComercial NVARCHAR(250),
    TipoEmpresa INT,
    NumeroRUC CHAR(17) UNIQUE,
    FechaConstitucion DATE,
    RepresentanteLegal NVARCHAR(250),
    TipoDNIRepresentante NVARCHAR(20),
    NumeroDNIRepresentante NVARCHAR(20) UNIQUE, --Numero de DNI depende del campo TipoDNI, debido a ello, no se añade el tipo CHAR

	Nacionalidad INT,
    Estado BIT,
    FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE()
)

CREATE TABLE Clientes.ClientesContactos(
	IdContacto INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
	TipoContacto INT NOT NULL,
	InformacionContacto NVARCHAR(250) NOT NULL,
	Descripcion NVARCHAR(250),
	Principal BIT,
	FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

	FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Clientes.ClientesDirecciones(
	IdDireccion INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
	Pais INT,
	EstadoRegion INT,
	Provincia INT,
	Distrito INT,
	Descripcion NVARCHAR(500),
	Principal BIT,
	FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

	FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Clientes.ClientesIngresos (
    IdIngreso INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
	FuenteIngreso NVARCHAR(250) NOT NULL,
    Empresa NVARCHAR(250),
    Cargo NVARCHAR(250),
    IngresoMensual DECIMAL(18, 2),
    FechaInicioIngreso DATE,
    TipoIngreso INT,
    DescripcionIngreso NVARCHAR(500),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

    FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Clientes.ClientesScore (
    IdScore INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
	ScoreCrediticio INT NOT NULL,
	FechaConsultaScore DATE NOT NULL,
	FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

    FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Clientes.ClientesHistorialCreditos (
    IdHistorialCredito INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
	CreditosVigentes INT NOT NULL,
	MontoTotalDeudaActual MONEY NOT NULL,
	FechaRegistro DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

    FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Clientes.CatalogoClientes(
    IdCatalogo INT,
	Nombre NVARCHAR(500),
	Valor NVARCHAR(MAX),
	ValorPadre NVARCHAR(MAX),
	Estado BIT
)

GO

CREATE TABLE Creditos.SolicitudesCredito (
    IdSolicitud INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
    MontoSolicitado DECIMAL(10,2) NOT NULL,
    PlazoMeses INT NOT NULL,
	Producto INT NOT NULL,
	SubProducto INT NOT NULL,
    EstadoCredito INT,
    FechaSolicitud DATETIME DEFAULT GETDATE(),
	FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE()

    FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Creditos.ProspeccionesCredito (
    IdProspeccion INT PRIMARY KEY IDENTITY(1,1),
    IdSolicitud INT NOT NULL,
    IngresosMensuales DECIMAL(10,2) NOT NULL,
    DeudasActuales DECIMAL(10,2) NOT NULL,
    ScoreCrediticio INT NOT NULL,
    Resultado INT NOT NULL,
    Comentario NVARCHAR(255),
    FechaProspeccion DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (IdSolicitud) REFERENCES Creditos.SolicitudesCredito(IdSolicitud)
)

CREATE TABLE Creditos.Creditos (
    IdCredito INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
    Producto INT NOT NULL,
	SubProducto INT NOT NULL,
    MontoAprobado DECIMAL(10,2) NOT NULL,
    TasaInteres DECIMAL(5,2) NOT NULL,
    EstadoCredito INT,
    FechaInicio DATE NOT NULL,
    FechaVencimiento DATE NOT NULL

    FOREIGN KEY (IdCliente) REFERENCES Clientes.Clientes(IdCliente)
)

CREATE TABLE Creditos.Calendario (
    IdPago INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    MontoPago DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME,
    EstadoCalendario INT,

    FOREIGN KEY (IdCredito) REFERENCES Creditos.Creditos(IdCredito)
)

CREATE TABLE Creditos.Garantias (
    IdGarantia INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    Tipo NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(255) NOT NULL,
    ValorEstimado DECIMAL(10,2) NOT NULL

    FOREIGN KEY (IdCredito) REFERENCES Creditos.Creditos(IdCredito)
)

CREATE TABLE Creditos.CatalogoCreditos(
    IdCatalogo INT,
	Nombre NVARCHAR(250),
	Valor INT,
	ValorPadre INT,
	Estado BIT
)

GO

CREATE TABLE Core.ParametrosSistema(
	IdParametro INT PRIMARY KEY IDENTITY(1, 1),
	NombreParametro NVARCHAR(255),
	ValorParametro NVARCHAR(MAX),  --Este campo no se delimita a un tipo de dato fijo, ya que puede almacenar variables del sistema. Dependiendo del contexto, podría contener parámetros, imágenes o archivos codificados en Base64
	TipoParametro INT --1 es tipo string, 2 es tipo numero, 3 es tipo fecha. Campo de uso exlusivo para lenguajes de programación
)

CREATE TABLE Core.Paises(
	IdPais INT PRIMARY KEY IDENTITY(1, 1),
	NombrePais NVARCHAR(255),	
	CodigoPostalPais VARCHAR(15)
)

GO