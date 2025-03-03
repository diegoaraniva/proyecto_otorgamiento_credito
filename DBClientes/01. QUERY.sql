------------------------------------------------------------------------------------------
-----------------------------------CREATE TABLE CLIENTES----------------------------------
------------------------------------------------------------------------------------------
CREATE DATABASE Clientes

USE Clientes

CREATE TABLE Clientes(
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
	TipoCliente INT NOT NULL,
	Descripcion NVARCHAR(250),
    Estado BIT,
    FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE()
)

CREATE TABLE ClientesNaturales(
	IdClienteNat INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
	Nombres NVARCHAR(250),
    ApellidoPaterno NVARCHAR(100),
	ApellidoMaterno NVARCHAR(100),
	ApellidoCasada NVARCHAR(100),
	ConocidoPor NVARCHAR(100),
	Genero NVARCHAR(100),
	EstadoFamiliar NVARCHAR(100),
	TipoDNI NVARCHAR(20),
	NumeroDNI NVARCHAR(20) UNIQUE,
    FechaNacimiento DATE,
	Nacionalidad INT

	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE ClientesJuridicos(
    IdClienteJur INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
    RazonSocial NVARCHAR(250),
    NombreComercial NVARCHAR(250),
    TipoEmpresa NVARCHAR(100),
    NumeroRUC NVARCHAR(20) UNIQUE,
    FechaConstitucion DATE,
    Nacionalidad INT,
    RepresentanteLegal NVARCHAR(250),
    TipoDNIRepresentante NVARCHAR(20),
    NumeroDNIRepresentante NVARCHAR(20) UNIQUE

	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);


CREATE TABLE ClientesContactos(
	IdContacto INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
	TipoContacto INT NOT NULL,
	InformacionContacto INT NOT NULL,
	Descripcion NVARCHAR(250),
	Principal BIT,
	FechaRegistro DATETIME DEFAULT GETDATE(),
	FechaModificacion DATETIME DEFAULT GETDATE(),
	Estado BIT

	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE ClientesDirecciones(
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

	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE ClientesIngresos (
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

    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE CatalogoClientes(
    IdCatalogo INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(250),
	Valor INT,
	ValorPadre INT,
	Estado BIT
)