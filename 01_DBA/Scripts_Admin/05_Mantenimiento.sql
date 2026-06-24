
USE SolucionesEmpresarialesRD;
GO

DBCC CHECKDB
('SolucionesEmpresarialesRD');
GO

EXEC sp_updatestats;
GO
