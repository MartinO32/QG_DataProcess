
USE DW_COMERCIAL
GO

/*###########################################################*/
/*			Comprobar si hay nulls y eliminarlos			 */
/*				 (en caso de ser necesario)					 */
/*			 Comprobar la cantidad de registros				 */
/*###########################################################*/

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]
where [COD_CATEGORIA] is null and [DESC_CATEGORIA] is null
 ;

-- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]
where [COD_CATEGORIA] is null and [DESC_CATEGORIA] is null
 ;

 --Comprobar catidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]
 ;

------------------------------------------------------------------------

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]
where [COD_CLIENTE] is null and [DESC_CLIENTE] is null 
 ;

-- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]
where [COD_CLIENTE] is null and [DESC_CLIENTE] is null 
 ;

--Comprobar catidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]
 ;

--------------------------------------------------------------------------
 
 -- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]
 where [COD_PAIS] is null and [DESC_PAIS] is null 
 ;

 -- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]
 where [COD_PAIS] is null and [DESC_PAIS] is null 
 ;

 --Comprobar catidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]
 ;

------------------------------------------------------------------------

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]
where [COD_PRODUCTO] is null and [DESC_PRODUCTO] is null 
;

-- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]
where [COD_PRODUCTO] is null and [DESC_PRODUCTO] is null
;

--Comprobar catidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]
;

-----------------------------------------------------------------------

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]
where [COD_SUCURSAL] is null and [DESC_SUCURSAL] is null
;

-- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]
where [COD_SUCURSAL] is null and [DESC_SUCURSAL] is null
;

--Comprobar cantidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]
;

-------------------------------------------------------------------------

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]
where [COD_VENDEDOR] is null and [DESC_VENDEDOR] is null
;

-- Eliminar las filas nulas
delete from [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]
where [COD_VENDEDOR] is null and [DESC_VENDEDOR] is null
;

--Comprobar cantidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]
;
-------------------------------------------------------------------------------

-- Comprobar si hay filas nulas
select * from [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]
where [COD_PRODUCTO] is null AND COD_CATEGORIA IS NULL AND COD_CLIENTE IS NULL 
		AND COD_PAIS IS NULL AND COD_VENDEDOR IS NULL AND COD_SUCURSAL IS NULL
		AND FECHA IS NULL
;

-- Eliminar las filas nulas
DELETE from [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]
where [COD_PRODUCTO] is null AND COD_CATEGORIA IS NULL AND COD_CLIENTE IS NULL 
		AND COD_PAIS IS NULL AND COD_VENDEDOR IS NULL AND COD_SUCURSAL IS NULL
		AND FECHA IS NULL
;

--Comprobar cantidad de registros
select count(*) from [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]
;

/*##################################################################*/


/*##################################################################*/
/*          Comprobar que no hay registros duplicados				*/
/*##################################################################*/

SELECT COD_CATEGORIA, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]
GROUP BY COD_CATEGORIA
HAVING COUNT(*)>1;

SELECT COD_CLIENTE, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]
GROUP BY COD_CLIENTE
HAVING COUNT(*)>1;

SELECT COD_PAIS, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]
GROUP BY COD_PAIS
HAVING COUNT(*)>1;

SELECT COD_PRODUCTO, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]
GROUP BY COD_PRODUCTO
HAVING COUNT(*)>1;

SELECT COD_SUCURSAL, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]
GROUP BY COD_SUCURSAL
HAVING COUNT(*)>1;

SELECT COD_VENDEDOR, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]
GROUP BY COD_VENDEDOR
HAVING COUNT(*)>1;

SELECT COD_PRODUCTO, COD_CATEGORIA, COD_CLIENTE, COD_PAIS, COD_VENDEDOR, COD_SUCURSAL, FECHA, COUNT(*) CANTIDAD
FROM [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]
GROUP BY COD_PRODUCTO, COD_CATEGORIA, COD_CLIENTE, COD_PAIS, COD_VENDEDOR, COD_SUCURSAL, FECHA
HAVING COUNT(*)>1;

/*##################################################################*/


/*##################################################################*/
/*		Compruebo que los productos tienen solo 1 categoría			*/
/*##################################################################*/

SELECT DESC_PRODUCTO, DESC_CATEGORIA ,
DENSE_RANK() OVER (PARTITION BY DESC_PRODUCTO ORDER BY DESC_PRODUCTO) CATEGORIA_X_PRODUCTO
FROM [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS] V
INNER JOIN [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO] P
	ON V.COD_PRODUCTO = P.COD_PRODUCTO
INNER JOIN [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA] C
	ON V.COD_CATEGORIA = C.COD_CATEGORIA
GROUP BY DESC_PRODUCTO, DESC_CATEGORIA
ORDER BY DESC_PRODUCTO

/*##################################################################*/


/*##################################################################*/
/*		Compruebo las descripciones de CLIENTE y VENDEDOR			*/
/*		  que tienen mas de 1  espacio, para determinar             */
/*      la forma en las que se van separar en las tablas INT        */
/*##################################################################*/

--Para clientes
SELECT COD_CLIENTE, [DESC_CLIENTE], LEN([DESC_CLIENTE])-LEN(REPLACE([DESC_CLIENTE],' ','')) ESPACIOS 
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]
where LEN([DESC_CLIENTE])-LEN(REPLACE([DESC_CLIENTE],' ','')) >1;
-- separamos con 1 nombre y el resto apellido


--Para vendedores
SELECT COD_VENDEDOR, [DESC_VENDEDOR], LEN([DESC_VENDEDOR])-LEN(REPLACE([DESC_VENDEDOR],' ','')) ESPACIOS 
FROM [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]
where LEN([DESC_VENDEDOR])-LEN(REPLACE([DESC_VENDEDOR],' ','')) >1;
-- separamos con 1 o 2 nombres y el resto apellido

/*##################################################################*/


/*##################################################################*/
/*		 Corroboro los datos de las columnas que necesitamos        */
/*	   realizar cambio de formato para la tabla INT_FACT_VENTAS    	*/
/*##################################################################*/

SELECT FECHA, CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL 
FROM [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS];

/*##################################################################*/


/*##################################################################*/
/*		Comparar cantidad de registros en tablas STG e INT			*/
/*##################################################################*/

SELECT 'CATEGORIA' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_CATEGORIA] ) [INT]
;

SELECT 'CLIENTE' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_CLIENTE] ) [INT]
;

SELECT 'PAIS' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_PAIS] ) [INT]
;

SELECT 'PRODUCTO' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_PRODUCTO] ) [INT]
;

SELECT 'SUCURSAL' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_SUCURSAL] ) [INT]
;

SELECT 'VENDEDOR' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_VENDEDOR] ) [INT]
;

SELECT 'VENTAS' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS] ) [INT]
;

/*##################################################################*/

/*##################################################################*/
/*		  Comparar cantidad de registros en las 3 tablas 			*/
/*##################################################################*/

SELECT 'CATEGORIA' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CATEGORIA]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_CATEGORIA] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_CATEGORIA] ) [DIM]
;

SELECT 'CLIENTE' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_CLIENTE]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_CLIENTE] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_CLIENTE] ) [DIM]
;

SELECT 'PAIS' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PAIS]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_PAIS] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_PAIS] ) [DIM]
;

SELECT 'PRODUCTO' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_PRODUCTO]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_PRODUCTO] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_PRODUCTO] ) [DIM]
;

SELECT 'SUCURSAL' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_SUCURSAL]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_SUCURSAL] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_SUCURSAL] ) [DIM]
;

SELECT 'VENDEDOR' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_DIM_VENDEDOR]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_DIM_VENDEDOR] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[DIM_VENDEDOR] ) [DIM]
;

SELECT 'VENTAS' TABLA,
(SELECT COUNT(*)
FROM [DW_COMERCIAL].[dbo].[STG_FACT_VENTAS]) STG, 
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS] ) [INT],
(SELECT COUNT (*) 
FROM [DW_COMERCIAL].[dbo].[FACT_VENTAS] ) [FACT]
;

/*##################################################################*/

/*##################################################################*/
/*   Validaciones varias sobre la tabla FACT en relación a las DIM  */
/*##################################################################*/

-- Métricas propuestas en el PDF
SELECT 
(SELECT SUM(MONTO_VENDIDO) 
FROM DW_COMERCIAL.DBO.FACT_VENTAS) MONTO_VENDIDO ,
(SELECT SUM(CANTIDAD_VENDIDA) 
FROM DW_COMERCIAL.DBO.FACT_VENTAS) CANTIDAD_VENDIDA ,
(SELECT  CAST(AVG(MONTO_VENDIDO) AS DECIMAL(18,2)) 
FROM DW_COMERCIAL.DBO.FACT_VENTAS) PROMEDIO_VENTAS ,
(SELECT SUM(COMISION_COMERCIAL)
FROM DW_COMERCIAL.DBO.FACT_VENTAS) COMISION, 
(SELECT COUNT(*)  
FROM DW_COMERCIAL.DBO.DIM_CLIENTE) TOTAL_CLIENTES
;

------------------------------------------------------------------------

-- Monto Total de Ventas por mes y por año
SELECT MES_NOMBRE, ANIO AÑO, SUM(MONTO_VENDIDO) MONTO_VENDIDO
FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
	ON T.TIEMPO_KEY=FV.TIEMPO_KEY
GROUP BY MES_NOMBRE,MES_NRO, ANIO
ORDER BY ANIO, MES_NRO 
;

------------------------------------------------------------------------

-- Cantidad vendida por mes y por año
SELECT MES_NOMBRE, ANIO AÑO, SUM(CANTIDAD_VENDIDA) CANTIDAD_VENDIDA
FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
	ON T.TIEMPO_KEY=FV.TIEMPO_KEY
GROUP BY MES_NOMBRE,MES_NRO, ANIO
ORDER BY ANIO, MES_NRO 
;

------------------------------------------------------------------------

-- Monto promedio de Ventas por año
SELECT ANIO AÑO, CAST(AVG(MONTO_VENDIDO) AS DECIMAL(18,2)) PROMEDIO_VENTAS
FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
	ON T.TIEMPO_KEY=FV.TIEMPO_KEY
GROUP BY  ANIO
ORDER BY ANIO
;

------------------------------------------------------------------------

-- Importe Comisión Comercial por año
SELECT ANIO AÑO, CONCAT(APELLIDO,', ',NOMBRE) VENDEDOR, SUM(COMISION_COMERCIAL)  COMISION
FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
	ON T.TIEMPO_KEY=FV.TIEMPO_KEY
INNER JOIN DW_COMERCIAL.DBO.DIM_VENDEDOR V
	ON V.VENDEDOR_KEY = FV.VENDEDOR_KEY
GROUP BY  ANIO, CONCAT(APELLIDO,', ',NOMBRE)
ORDER BY ANIO
;

------------------------------------------------------------------------

-- TOP 3 productos más vendidos (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_PRODUCTO PRODUCTO, SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PRODUCTO P
			ON P.PRODUCTO_KEY = FV.PRODUCTO_KEY
		GROUP BY  ANIO, DESC_PRODUCTO) R
WHERE R.RANKING <= 3
;

-- TOP 3 productos más vendidos (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_PRODUCTO PRODUCTO, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PRODUCTO P
			ON P.PRODUCTO_KEY = FV.PRODUCTO_KEY
		GROUP BY  ANIO, DESC_PRODUCTO) R
WHERE R.RANKING <= 3
;
-----------------------------------------------------------------------------------
-- TOP 3 categorías más vendidos (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_CATEGORIA CATEGORIA, SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_CATEGORIA C
			ON C.CATEGORIA_KEY = FV.CATEGORIA_KEY
		GROUP BY  ANIO, DESC_CATEGORIA) R
WHERE R.RANKING <= 3
;

-- TOP 3 categorías más vendidos (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_CATEGORIA CATEGORIA, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_CATEGORIA C
			ON C.CATEGORIA_KEY = FV.CATEGORIA_KEY
		GROUP BY  ANIO, DESC_CATEGORIA) R
WHERE R.RANKING <= 3
;
----------------------------------------------------------------------------------------------
-- TOP 3 vendedores que más vendieron (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, CONCAT(APELLIDO, ', ', NOMBRE) VENDEDOR , SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_VENDEDOR V
			ON V.VENDEDOR_KEY = FV.VENDEDOR_KEY
		GROUP BY  ANIO, CONCAT(APELLIDO, ', ', NOMBRE)) R
WHERE R.RANKING <= 3
;

-- TOP 3 vendedores que más vendieron (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, CONCAT(APELLIDO, ', ', NOMBRE) VENDEDOR, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_VENDEDOR V
			ON V.VENDEDOR_KEY = FV.VENDEDOR_KEY
		GROUP BY  ANIO, CONCAT(APELLIDO, ', ', NOMBRE)) R
WHERE R.RANKING <= 3
;

------------------------------------------------------------------------------

-- TOP 3 clientes que más compraron (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, CONCAT(APELLIDO, ', ', NOMBRE) CLIENTE , SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_CLIENTE C
			ON C.CLIENTE_KEY = FV.CLIENTE_KEY
		GROUP BY  ANIO, CONCAT(APELLIDO, ', ', NOMBRE)) R
WHERE R.RANKING <= 3
;

-- TOP 3 clientes que más compraron (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, CONCAT(APELLIDO, ', ', NOMBRE) CLIENTE, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_CLIENTE C
			ON C.CLIENTE_KEY = FV.CLIENTE_KEY
		GROUP BY  ANIO, CONCAT(APELLIDO, ', ', NOMBRE)) R
WHERE R.RANKING <= 3
;
------------------------------------------------------------------------------------

-- TOP 3 sucursales con más ventas (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_SUCURSAL SUCURSAL, DESC_PAIS PAIS, SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_SUCURSAL S
			ON S.SUCURSAL_KEY = FV.SUCURSAL_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PAIS P
			ON P.PAIS_KEY = FV.PAIS_KEY
		GROUP BY  ANIO, DESC_SUCURSAL, DESC_PAIS) R
WHERE R.RANKING <= 3
;

-- TOP 3 sucursales con más ventas (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_SUCURSAL SUCURSAL, DESC_PAIS PAIS, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_SUCURSAL S
			ON S.SUCURSAL_KEY = FV.SUCURSAL_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PAIS P
			ON P.PAIS_KEY = FV.PAIS_KEY
		GROUP BY  ANIO, DESC_SUCURSAL, DESC_PAIS) R
WHERE R.RANKING <= 3

-----------------------------------------------------------------------------------------
-- TOP 3 país con más ventas (CANTIDAD) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_PAIS PAIS, SUM(CANTIDAD_VENDIDA)  CANTIDAD_VENDIDA,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(CANTIDAD_VENDIDA) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PAIS P
			ON P.PAIS_KEY = FV.PAIS_KEY
		GROUP BY  ANIO, DESC_PAIS) R
WHERE R.RANKING <= 3
;

-- TOP 3 país con más ventas (VALOR) por año
SELECT * FROM (
		SELECT ANIO AÑO, DESC_PAIS PAIS, SUM(MONTO_VENDIDO)  MONTO_VENDIDO,
		DENSE_RANK() OVER (PARTITION BY ANIO ORDER BY SUM(MONTO_VENDIDO) DESC) [RANKING]
		FROM DW_COMERCIAL.DBO.FACT_VENTAS FV
		INNER JOIN DW_COMERCIAL.DBO.DIM_TIEMPO T
			ON T.TIEMPO_KEY=FV.TIEMPO_KEY
		INNER JOIN DW_COMERCIAL.DBO.DIM_PAIS P
			ON P.PAIS_KEY = FV.PAIS_KEY
		GROUP BY  ANIO, DESC_PAIS) R
WHERE R.RANKING <= 3
;