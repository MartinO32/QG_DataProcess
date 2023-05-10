
USE DW_COMERCIAL
GO

/*########################################################*/
/*    Ejecución de los los procedure de carga de datos	  */
/*                 para las tablas INT					  */
/*########################################################*/

EXEC SP_CARGA_INT_DIM_CATEGORIA
;

EXEC SP_CARGA_INT_DIM_CLIENTE
;

EXEC SP_CARGA_INT_DIM_PAIS
;

EXEC SP_CARGA_INT_DIM_PRODUCTO
;

EXEC SP_CARGA_INT_DIM_SUCURSAL
;

EXEC SP_CARGA_INT_DIM_VENDEDOR
;

EXEC SP_CARGA_INT_FACT_VENTAS
;
/*########################################################*/

/*########################################################*/
/*    Ejecución de los los procedure de carga de datos	  */
/*            para las tablas DIM y FACT				  */
/*########################################################*/

EXEC SP_CARGA_DIM_CATEGORIA;

EXEC SP_CARGA_DIM_CLIENTE;

EXEC SP_CARGA_DIM_PAIS;

EXEC SP_CARGA_DIM_PRODUCTO;

EXEC SP_CARGA_DIM_SUCURSAL;

EXEC SP_CARGA_DIM_VENDEDOR;

EXEC SP_CARGA_FACT_VENTAS;

----------------------------------------------------------------
-- Carga de las fechas en DIM_TIEMPO según los años que presenta la tabla ventas

DECLARE @INICIO INTEGER;
DECLARE @FIN INTEGER;

SELECT @INICIO = MIN (YEAR(FECHA)) FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS];
SELECT @FIN = MAX (YEAR(FECHA)) FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS]

WHILE @FIN>=@INICIO
	BEGIN
		EXEC SP_CARGA_DIM_TIEMPO @ANIO = @INICIO;
		SET @INICIO = @INICIO +1
	END;