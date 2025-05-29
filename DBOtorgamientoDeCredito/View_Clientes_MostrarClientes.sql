CREATE VIEW MostrarClientes
AS
SELECT
IdCliente,
TipoCliente, 
Descripcion, 
Nombres, 
ApellidoPaterno, 
ApellidoMaterno, 
ApellidoCasada, 
ConocidoPor, 
Genero, 
EstadoFamiliar, 
TipoDNI, 
NumeroDNI, 
FechaNacimiento, 
RazonSocial, 
NombreComercial, 
TipoEmpresa, 
NumeroRUC, 
FechaConstitucion, 
RepresentanteLegal, 
TipoDNIRepresentante, 
NumeroDNIRepresentante,
Nacionalidad, 
Estado,
FORMAT(FechaRegistro, 'yyyy-MM-dd HH:mm:ss') AS FechaRegistro,
FORMAT(FechaModificacion, 'yyyy-MM-dd HH:mm:ss') AS FechaModificacion
FROM Clientes.Clientes