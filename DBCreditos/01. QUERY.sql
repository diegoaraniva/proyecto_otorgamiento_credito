------------------------------------------------------------------------------------------
-----------------------------------CREATE TABLE CREDITOS----------------------------------
------------------------------------------------------------------------------------------

CREATE DATABASE Creditos

USE DATABASE Creditos

CREATE TABLE SolicitudesCredito (
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

    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE ProspeccionesCredito (
    IdProspeccion INT PRIMARY KEY IDENTITY(1,1),
    IdSolicitud INT NOT NULL,
    IngresosMensuales DECIMAL(10,2) NOT NULL,
    DeudasActuales DECIMAL(10,2) NOT NULL,
    ScoreCrediticio INT NOT NULL,
    Resultado INT NOT NULL,
    Comentario NVARCHAR(255),
    FechaProspeccion DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (IdSolicitud) REFERENCES SolicitudesCredito(IdSolicitud)
)

CREATE TABLE Creditos (
    IdCredito INT PRIMARY KEY IDENTITY(1,1),
	IdCliente INT NOT NULL,
    Producto INT NOT NULL,
	SubProducto INT NOT NULL,
    MontoAprobado DECIMAL(10,2) NOT NULL,
    TasaInteres DECIMAL(5,2) NOT NULL,
    EstadoCredito INT,
    FechaInicio DATE NOT NULL,
    FechaVencimiento DATE NOT NULL

    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE Calendario (
    IdPago INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    MontoPago DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME,
    EstadoCalendario INT,

    FOREIGN KEY (IdCredito) REFERENCES Creditos(IdCredito)
)

CREATE TABLE Garantias (
    IdGarantia INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    Tipo NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(255) NOT NULL,
    ValorEstimado DECIMAL(10,2) NOT NULL

    FOREIGN KEY (IdCredito) REFERENCES Creditos(IdCredito)
)

CREATE TABLE CatalogoCreditos(
    IdCatalogo INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(250),
	Valor INT,
	ValorPadre INT,
	Estado BIT
)