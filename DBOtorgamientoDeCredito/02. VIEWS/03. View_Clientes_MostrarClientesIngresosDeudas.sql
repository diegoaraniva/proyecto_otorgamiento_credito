CREATE VIEW View_Clientes_MostrarClientesIngresosDeudas
AS
SELECT 
	C.IdCliente,
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
	CI.Cargo,
	CI.DescripcionIngreso,
	CI.Empresa,
	CI.FechaInicioIngreso,
	CI.FuenteIngreso,
	CI.IngresoMensual,
	CS.ScoreCrediticio,
	CASE
		WHEN CS.ScoreCrediticio >= 800 THEN 'Excelente'
		WHEN CS.ScoreCrediticio >= 740 AND CS.ScoreCrediticio <= 799 THEN 'Muy Bueno'
		WHEN CS.ScoreCrediticio >= 670 AND CS.ScoreCrediticio <= 739 THEN 'Bueno'
		WHEN CS.ScoreCrediticio >= 580 AND CS.ScoreCrediticio <= 669 THEN 'Regular'
		WHEN CS.ScoreCrediticio < 580 THEN 'Malo'
		ELSE ''
	END AS PuntuaciobCrediticia,
	CS.FechaConsultaScore
FROM Clientes.Clientes C
	JOIN Clientes.ClientesIngresos CI ON CI.IdCliente = C.IdCliente
	JOIN Clientes.ClientesScore CS ON CS.IdCliente = C.IdCliente
WHERE C.TipoCliente = 1