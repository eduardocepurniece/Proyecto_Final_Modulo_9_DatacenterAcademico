
CREATE LOGIN AdminEmpresa
WITH PASSWORD='Admin123$';
GO

USE SolucionesEmpresarialesRD;
GO

CREATE USER AdminEmpresa
FOR LOGIN AdminEmpresa;
GO
