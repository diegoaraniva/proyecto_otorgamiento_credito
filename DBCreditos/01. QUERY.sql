

CREATE TABLE SolicitudesCredito (
    IdSolicitud INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
    MontoSolicitado DECIMAL(10,2) NOT NULL,
    PlazoMeses INT NOT NULL,
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Aprobado', 'Rechazado')),
    FechaSolicitud DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

CREATE TABLE ProspeccionesCredito (
    IdEvaluacion INT PRIMARY KEY IDENTITY(1,1),
    IdSolicitud INT NOT NULL,
    IngresosMensuales DECIMAL(10,2) NOT NULL,
    DeudasActuales DECIMAL(10,2) NOT NULL,
    ScoreCrediticio INT NOT NULL,
    Resultado NVARCHAR(20) CHECK (Resultado IN ('Aprobado', 'Rechazado')),
    Comentario NVARCHAR(255),
    FechaEvaluacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IdSolicitud) REFERENCES SolicitudesCredito(IdSolicitud)
);

CREATE TABLE Creditos (
    IdCredito INT PRIMARY KEY IDENTITY(1,1),
    IdSolicitud INT NOT NULL,
    MontoAprobado DECIMAL(10,2) NOT NULL,
    TasaInteres DECIMAL(5,2) NOT NULL,
    PlazoMeses INT NOT NULL,
    Estado NVARCHAR(20) CHECK (Estado IN ('Activo', 'Cancelado', 'Mora')),
    FechaInicio DATE NOT NULL,
    FechaVencimiento DATE NOT NULL,
    FOREIGN KEY (IdSolicitud) REFERENCES SolicitudesCredito(IdSolicitud)
);

CREATE TABLE Pagos (
    IdPago INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    MontoPagado DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME DEFAULT GETDATE(),
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Procesado', 'Retrasado')),
    FOREIGN KEY (IdCredito) REFERENCES Creditos(IdCredito)
);

CREATE TABLE Garantias (
    IdGarantia INT PRIMARY KEY IDENTITY(1,1),
    IdCredito INT NOT NULL,
    Tipo NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(255) NOT NULL,
    ValorEstimado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdCredito) REFERENCES Creditos(IdCredito)
);
