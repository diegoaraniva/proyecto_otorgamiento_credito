CREATE VIEW MostrarSolicitudesPorClientes
AS
SELECT
	SC.IdSolicitud,
	SC.IdCliente,
	SC.MontoSolicitado,
	SC.PlazoMeses,
	(SELECT Nombre FROM Creditos.CatalogoCreditos WHERE IdCatalogo = 1 AND Valor = SC.Producto) Producto,
	(SELECT Nombre FROM Creditos.CatalogoCreditos WHERE IdCatalogo = 2 AND Valor = SC.SubProducto) SubProducto,
	(SELECT Nombre FROM Creditos.CatalogoCreditos WHERE IdCatalogo = 3 AND Valor = SC.EstadoCredito) EstadoCredito,
	SC.FechaSolicitud,

	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 1 AND Valor = C.TipoCliente) TipoCliente,

	C.Descripcion,
	C.Nombres,
	C.ApellidoPaterno,
	C.ApellidoMaterno,
	C.ApellidoCasada,
	C.ConocidoPor,

	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 2 AND Valor = C.Genero) Genero,
	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 3 AND Valor = C.EstadoFamiliar) EstadoFamiliar,
	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 4 AND Valor = C.TipoDNI) TipoDNI,

	C.NumeroDNI,
	C.FechaNacimiento,
	C.RazonSocial,
	C.NombreComercial,
	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 5 AND Valor = CAST(C.TipoEmpresa AS NVARCHAR(MAX))) TipoEmpresa,
	C.NumeroRUC,
	C.FechaConstitucion,
	C.RepresentanteLegal,
	(SELECT Nombre FROM Clientes.CatalogoClientes WHERE IdCatalogo = 4 AND Valor = C.TipoDNIRepresentante) TipoDNIRepresentante,
	C.NumeroDNIRepresentante,
	C.Nacionalidad,
	SC.FechaRegistro,
	SC.FechaModificacion

FROM Creditos.SolicitudesCredito SC 
	INNER JOIN Clientes.Clientes C ON C.IdCliente = SC.IdCliente 