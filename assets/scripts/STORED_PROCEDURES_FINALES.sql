
USE DW_COMERCIAL
GO

/*################################################################*/
/*           STORE PROCEDURE CARGA DE INT A FINALES               */
/*################################################################*/

-- SP para agregar datos de INT_DIM_CATEGORIA a DIM_CATEGORIA
CREATE PROCEDURE SP_CARGA_DIM_CATEGORIA
AS
BEGIN
	
	--NOCOUNT oculta el conteo de filas que intervienen en la ejecuci�n
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;
	
	--Actualiza los registros existentes
	UPDATE DC
		SET DC.COD_CATEGORIA = IDC.COD_CATEGORIA,
			DC.DESC_CATEGORIA = IDC.DESC_CATEGORIA,
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_CATEGORIA] DC
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_CATEGORIA] IDC
			ON DC.COD_CATEGORIA = IDC.COD_CATEGORIA
		WHERE DC.COD_CATEGORIA = IDC.COD_CATEGORIA;

	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_CATEGORIA]
			(DC.COD_CATEGORIA, 
			DC.DESC_CATEGORIA, 
			FECHA_ALTA, 
			USUARIO_ALTA)
	SELECT 
		IDC.COD_CATEGORIA,
		IDC.DESC_CATEGORIA,
		@FECHA FECHA_ALTA,
		@USUARIO USUARIO_ALTA
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_CATEGORIA] IDC
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_CATEGORIA] DC
		ON IDC.COD_CATEGORIA = DC.COD_CATEGORIA
	WHERE DC.COD_CATEGORIA IS NULL;
END
GO	

-- SP para agregar datos de INT_DIM_CLIENTE a DIM_CLIENTE
CREATE PROCEDURE SP_CARGA_DIM_CLIENTE
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Actualiza los registros existentes
	UPDATE DC
		SET DC.NOMBRE = IDC.NOMBRE,
			DC.APELLIDO = IDC.APELLIDO,
			FECHA_UPDATE = @FECHA,
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_CLIENTE] AS DC
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_CLIENTE] AS IDC 
			ON IDC.COD_Cliente = DC.COD_CLIENTE
		WHERE DC.NOMBRE = IDC.NOMBRE;

	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_CLIENTE]
		(COD_CLIENTE, 
		NOMBRE, 
		APELLIDO, 
		FECHA_ALTA, 
		USUARIO_ALTA)
	SELECT 
		IDC.COD_CLIENTE,
		IDC.NOMBRE, 
		IDC.APELLIDO,
		@FECHA,
		@USUARIO
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_CLIENTE] IDC
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_CLIENTE] DC
		ON IDC.COD_CLIENTE = DC.COD_CLIENTE
	WHERE DC.COD_CLIENTE IS NULL
END		
GO

-- SP para agregar datos de INT_DIM_PAIS a DIM_PAIS
CREATE PROCEDURE SP_CARGA_DIM_PAIS
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Actualiza los registros existentes
	UPDATE DP
		SET DP.COD_PAIS = IDP.COD_PAIS,
			DP.DESC_PAIS = IDP.DESC_PAIS,
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_PAIS] DP
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_PAIS] IDP
			ON DP.COD_PAIS = IDP.COD_PAIS
		WHERE DP.COD_PAIS = IDP.COD_PAIS;
	
	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_PAIS]
			(COD_PAIS,
			DESC_PAIS,
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT IDP.COD_PAIS,
			IDP.DESC_PAIS,
			@FECHA,
			@USUARIO
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_PAIS] IDP
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_PAIS] DP
		ON IDP.COD_PAIS = DP.COD_PAIS
	WHERE DP.COD_PAIS IS NULL
END
GO

-- SP para agregar datos de INT_DIM_PRODUCTO a DIM_PRODUCTO
CREATE PROCEDURE SP_CARGA_DIM_PRODUCTO
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Actualiza los registros existentes
	UPDATE DP
		SET DP.COD_PRODUCTO = IDP.COD_PRODUCTO,
			DP.DESC_PRODUCTO = IDP.DESC_PRODUCTO,
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_PRODUCTO] DP
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_PRODUCTO] IDP
			ON DP.COD_PRODUCTO = IDP.COD_PRODUCTO
		WHERE DP.COD_PRODUCTO = IDP.COD_PRODUCTO;
	
	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_PRODUCTO]
			(COD_PRODUCTO,
			DESC_PRODUCTO,
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT IDP.COD_PRODUCTO,
			IDP.DESC_PRODUCTO,
			@FECHA,
			@USUARIO
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_PRODUCTO] IDP
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_PRODUCTO] DP
		ON IDP.COD_PRODUCTO = DP.COD_PRODUCTO
	WHERE DP.COD_PRODUCTO IS NULL
END
GO

-- SP para agregar datos de INT_DIM_SUCURSAL a DIM_SUCURSAL
CREATE PROCEDURE SP_CARGA_DIM_SUCURSAL
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Actualiza los registros existentes
	UPDATE DS
		SET DS.COD_SUCURSAL = IDS.COD_SUCURSAL,
			DS.DESC_SUCURSAL = IDS.DESC_SUCURSAL,
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_SUCURSAL] DS
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_SUCURSAL] IDS
			ON DS.COD_SUCURSAL = IDS.COD_SUCURSAL
		WHERE DS.COD_SUCURSAL = IDS.COD_SUCURSAL;
	
	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_SUCURSAL]
			(COD_SUCURSAL,
			DESC_SUCURSAL,
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT IDS.COD_SUCURSAL,
			IDS.DESC_SUCURSAL,
			@FECHA,
			@USUARIO
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_SUCURSAL] IDS
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_SUCURSAL] DS
		ON IDS.COD_SUCURSAL = DS.COD_SUCURSAL
	WHERE DS.COD_SUCURSAL IS NULL
END
GO

-- SP para agregar datos de INT_DIM_VENDEDOR a DIM_VENDEDOR
CREATE PROCEDURE SP_CARGA_DIM_VENDEDOR
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Actualiza los registros existentes
	UPDATE DV
		SET DV.[COD_VENDEDOR] = IDV.[COD_VENDEDOR],
			DV.[NOMBRE] = IDV.[NOMBRE],
			DV.[APELLIDO] = IDV.[APELLIDO],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [DW_COMERCIAL].[dbo].[DIM_VENDEDOR] DV
		INNER JOIN [DW_COMERCIAL].[dbo].[INT_DIM_VENDEDOR] IDV
			ON DV.[COD_VENDEDOR] = IDV.[COD_VENDEDOR]
		WHERE DV.[COD_VENDEDOR] = IDV.[COD_VENDEDOR];
	
	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[DIM_VENDEDOR]
			([COD_VENDEDOR],
			[NOMBRE],
			[APELLIDO],
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT IDV.[COD_VENDEDOR],
			IDV.[NOMBRE],
			IDV.[APELLIDO],
			@FECHA,
			@USUARIO
	FROM [DW_COMERCIAL].[dbo].[INT_DIM_VENDEDOR] IDV
	LEFT JOIN [DW_COMERCIAL].[dbo].[DIM_VENDEDOR] DV
		ON DV.[COD_VENDEDOR] = IDV.[COD_VENDEDOR]
	WHERE DV.[COD_VENDEDOR] IS NULL
END
GO

-- SP para agregar datos de INT_FACT_VENTAS a FACT_VENTAS
CREATE PROCEDURE SP_CARGA_FACT_VENTAS
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO NVARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = SYSTEM_USER;

	--Inserta los registros nuevos
	INSERT INTO [DW_COMERCIAL].[dbo].[FACT_VENTAS]
			(PRODUCTO_KEY, 
			CATEGORIA_KEY, 
			CLIENTE_KEY, 
			PAIS_KEY, 
			VENDEDOR_KEY, 
			SUCURSAL_KEY, 
			TIEMPO_KEY, 
			CANTIDAD_VENDIDA, 
			MONTO_VENDIDO, PRECIO, 
			COMISION_COMERCIAL, 
			FECHA_ALTA, 
			USUARIO_ALTA)

	SELECT V.* FROM 
			(SELECT PRODUCTO_KEY, CATEGORIA_KEY, CLIENTE_KEY, PAIS_KEY, VENDEDOR_KEY, SUCURSAL_KEY, TIEMPO_KEY, 
						CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL, @FECHA FECHA_ALTA, @USUARIO USUARIO_ALTA
			FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS] IFV
			INNER JOIN [DW_COMERCIAL].DBO.DIM_PRODUCTO PROD
				ON IFV.COD_PRODUCTO = PROD.COD_PRODUCTO
			INNER JOIN [DW_COMERCIAL].DBO.DIM_CATEGORIA CAT
				ON CAT.COD_CATEGORIA = IFV.COD_CATEGORIA
			INNER JOIN [DW_COMERCIAL].DBO.DIM_CLIENTE CLI
				ON CLI.COD_CLIENTE = IFV.COD_CLIENTE
			INNER JOIN [DW_COMERCIAL].DBO.DIM_PAIS PAIS
				ON PAIS.COD_PAIS = IFV.COD_PAIS
			INNER JOIN [DW_COMERCIAL].DBO.DIM_VENDEDOR VEND
				ON VEND.COD_VENDEDOR = IFV.COD_VENDEDOR
			INNER JOIN [DW_COMERCIAL].DBO.DIM_SUCURSAL SUC
				ON SUC.COD_SUCURSAL = IFV.COD_SUCURSAL
			INNER JOIN [DW_COMERCIAL].DBO.DIM_TIEMPO TI
				ON TI.TIEMPO_KEY = IFV.FECHA) AS V
	WHERE NOT EXISTS 
			--Corroboramos que los atributos KEY en conjunto no est�n repetidos, por lo que tengamos un error de la restricci�n UNIQUE 
			--y que trunque la carga de algunos registros
			(SELECT * 
				FROM [DW_COMERCIAL].[dbo].[FACT_VENTAS] 
				WHERE PRODUCTO_KEY = V.PRODUCTO_KEY AND 
					CATEGORIA_KEY = V.CATEGORIA_KEY AND 
					CLIENTE_KEY = V.CLIENTE_KEY AND
					PAIS_KEY = V.PAIS_KEY AND
					VENDEDOR_KEY = V. VENDEDOR_KEY AND
					SUCURSAL_KEY = V.SUCURSAL_KEY AND
					TIEMPO_KEY = V.TIEMPO_KEY)
END
GO

/*################################################################*/
/*           STORE PROCEDURE PARA DIM_TIEMPO                      */
/*################################################################*/

CREATE PROCEDURE DBO.SP_CARGA_DIM_TIEMPO
	@anio INTEGER
AS

	SET NOCOUNT ON
	SET arithabort off
	SET arithignore on

	/**************/
	/* Variables */
	/**************/
	SET DATEFIRST 1;
	SET DATEFORMAT mdy
	DECLARE @dia smallint
	DECLARE @mes smallint
	DECLARE @f_txt varchar(10)
	DECLARE @fecha_DT smalldatetime
	DECLARE @key int
	DECLARE @vacio smallint
	DECLARE @fin smallint
	DECLARE @fin_mes int
	DECLARE @anioperiodicidad int
	DECLARE @USUARIO NVARCHAR (100)
	DECLARE @FECHA_ALTA DATETIME
	SELECT @dia = 1
	SELECT @mes = 1
	SELECT @f_txt = Convert(char(2), @mes) + '/' + Convert(char(2), @dia) + '/' + Convert(char(4), @anio)
	SELECT @fecha_DT = Convert(smalldatetime, @f_txt)
	select @anioperiodicidad = @anio
	SET @USUARIO = SYSTEM_USER
	SET @FECHA_ALTA = GETDATE()

	/************************************/
	/* Se chequea que el a�o a procesar */
	/* no exista en la tabla TIME       */
	/************************************/

	IF (SELECT Count(*) FROM [DW_COMERCIAL].DBO.DIM_TIEMPO WHERE anio = @anio) > 0
	BEGIN
		Print 'El a�o que ingreso ya existe en la tabla'
		Print 'Procedimiento CANCELADO.................'
		Return 0
	END


	/*************************/
	/* Se inserta d�a a d�a  */
	/* hasta terminar el a�o */
	/*************************/

	SELECT @fin = @anio + 1

	WHILE (@anio < @fin)
		BEGIN
		--Armo la fecha
			IF Len(Rtrim(Convert(Char(2),Datepart(mm, @fecha_DT))))=1
			BEGIN
				IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha_DT))))=1
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha_DT)) + '0' +
				Rtrim(Convert(Char(2),Datepart(mm, @fecha_DT))) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha_DT)))
				ELSE
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha_DT)) + '0' +
				Rtrim(Convert(Char(2),Datepart(mm, @fecha_DT))) + Convert(Char(2),Datepart(dd, @fecha_DT))
			END
			ELSE
				BEGIN
				IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha_DT))))=1
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha_DT)) + Convert(Char(2),Datepart(mm,
				@fecha_DT)) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha_DT)))
				ELSE
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha_DT)) + Convert(Char(2),Datepart(mm,
				@fecha_DT)) + Convert(Char(2),Datepart(dd, @fecha_DT))
			END

	--Calculo el �ltimo d�a del mes
		SET @fin_mes = day(dateadd(d, -1, dateadd(m, 1, dateadd(d, - day(@fecha_DT) + 1, @fecha_DT))))

	INSERT [DW_COMERCIAL].DBO.DIM_TIEMPO
			(Tiempo_Key, 
			Anio, 
			MES_NRO, 
			Mes_Nombre, 
			Semestre, 
			Trimestre, 
			Semana_Anio,
			Semana_Nro_Mes,
			Dia, 
			Dia_Nombre, 
			Dia_Semana_Nro,
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT
		tiempo_key = @fecha_DT
		, anio = Datepart(yyyy, @fecha_DT)
		, mes = Datepart(mm, @fecha_DT)
		, mes_nombre = 
			CASE Datename(mm, @fecha_DT)
				when 'January' then 'Enero'
				when 'February' then 'Febrero'
				when 'March' then 'Marzo'
				when 'April' then 'Abril'
				when 'May' then 'Mayo'
				when 'June' then 'Junio'
				when 'July' then 'Julio'
				when 'August' then 'Agosto'
				when 'September' then 'Septiembre'
				when 'October' then 'Octubre'
				when 'November' then 'Noviembre'
				when 'December' then 'Diciembre'
			else Datename(mm, @fecha_DT)
			END
		, semestre = 
			CASE Datepart(mm, @fecha_DT)
				when (SELECT Datepart(mm, @fecha_DT)
				WHERE Datepart(mm, @fecha_DT) between 1 and 6) then 1
			else 2
			END
		, trimestre = Datepart(qq, @fecha_DT)
		, semana_anio = Datepart(wk, @fecha_DT)
		, semana_nro_mes = Datepart(wk, @fecha_DT) - datepart(week,
							dateadd(dd,-day(@fecha_DT)+1,@fecha_DT)) +1
		, dia = Datepart(dd, @fecha_DT)
		, dia_nombre =
				CASE Datename(dw, @fecha_DT)
					when 'Monday' then 'Lunes'
					when 'Tuesday' then 'Martes'
					when 'Wednesday' then 'Miercoles'
					when 'Thursday' then 'Jueves'
					when 'Friday' then 'Viernes'
					when 'Saturday' then 'Sabado'
					when 'Sunday' then 'Domingo'
				else Datename(dw, @fecha_DT)
				END
		, dia_semana_nro = Datepart(dw, @fecha_DT)
		, @FECHA_ALTA
		, @USUARIO
				
		SELECT @fecha_DT = Dateadd(dd, 1, @fecha_DT)
		SELECT @dia = Datepart(dd, @fecha_DT)
		SELECT @mes = Datepart(mm, @fecha_DT)
		SELECT @anio = Datepart(yy, @fecha_DT) 
		CONTINUE
END
