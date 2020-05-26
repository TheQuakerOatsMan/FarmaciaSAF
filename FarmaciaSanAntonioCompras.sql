CREATE DATABASE FarmSAntonioCompras
USE FarmSAntonioCompras

USE FarmSAntonio
drop database FarmSAntonio

--------------------------------------------------------
--			SECCION DE COMPRAS
--------------------------------------------------------
CREATE TABLE PROVEEDORES (
	CVEPROV INT PRIMARY KEY
	,NOMPROV VARCHAR(50) NOT NULL
	,EMPRESA VARCHAR(30) NOT NULL
	,DIRPROV VARCHAR(50)
	,DIREMPSA VARCHAR(50) NOT NULL
	,TELPROV VARCHAR(15) NOT NULL
	,ESTADO VARCHAR(20) NOT NULL
	,CODIGOP VARCHAR(8) NOT NULL
	,LOCALIDAD VARCHAR(30) NOT NULL
	,CORREOPROV VARCHAR(30) NOT NULL
	,ACTIVO INT
	)

CREATE TABLE CADUCIDAD (
	CVECAD INT PRIMARY KEY
	,FECHACAD DATE NOT NULL
	)
CREATE TABLE MEDICAMENTOS (
	CVEMED INT PRIMARY KEY
	,NOMED VARCHAR(30) NOT NULL
	,DESCRIPCIONM VARCHAR(60) NOT NULL
	,PRECIOCOMPM MONEY DEFAULT(0)
	,PRECIOVTAM MONEY DEFAULT(0)
	,EXISTENCIASM INT DEFAULT(0)
	,ESTADO INT
	)
CREATE TABLE PRODUCTOS (
	CVEPROD INT PRIMARY KEY
	,NOMP VARCHAR(30) NOT NULL
	,DESCRIP VARCHAR(60) NOT NULL
	,PRECIOCOMP MONEY DEFAULT(0)
	,PRECIOVTAP MONEY DEFAULT(0)
	,EXISTENCIASP INT DEFAULT(0)
	,ESTADO INT
	)
CREATE TABLE COMPRAS (
	CVECOMP INT PRIMARY KEY
	,TOTALCOMP MONEY DEFAULT(0)
	,FECHACOMP DATE DEFAULT(GETDATE())
	)
--TABLAS INTERMEDIAS
CREATE TABLE DETCOMPRV (
	CVECOMP INT FOREIGN KEY REFERENCES COMPRAS NOT NULL
	,CVEPROV INT FOREIGN KEY REFERENCES PROVEEDORES NOT NULL
	)
CREATE TABLE DETCOMPRO --Las siguientes dos tablas fueron modificadas
	(
	CVECOMP INT FOREIGN KEY REFERENCES COMPRAS NOT NULL
	,CVEPROD INT FOREIGN KEY REFERENCES PRODUCTOS NOT NULL
	,CANTCOMP INT NOT NULL
	,CAD DATE NOT NULL
	,PRECOMP MONEY NOT NULL
	,LOTE VARCHAR(10)
	,GANANCIAP MONEY DEFAULT(0)
	)
CREATE TABLE DETCOMMED (
	CVECOMP INT FOREIGN KEY REFERENCES COMPRAS NOT NULL
	,CVEMED INT FOREIGN KEY REFERENCES MEDICAMENTOS NOT NULL
	,CANTCOMPM INT NOT NULL
	,TIPOMED VARCHAR(30) NOT NULL
	,CADM DATE NOT NULL
	,PRECOMPM MONEY NOT NULL
	,LOTE VARCHAR(10)
	,GANANCIAM MONEY DEFAULT(0)
	)
CREATE TABLE DETCADMED (
	CVECAD INT FOREIGN KEY REFERENCES CADUCIDAD NOT NULL
	,CVEMED INT FOREIGN KEY REFERENCES MEDICAMENTOS NOT NULL
	,LOTE VARCHAR(10) NOT NULL
	,FECHALIMT DATE NOT NULL
	)
CREATE TABLE DETCADPRO (
	CVECAD INT FOREIGN KEY REFERENCES CADUCIDAD NOT NULL
	,CVEPROD INT FOREIGN KEY REFERENCES PRODUCTOS NOT NULL
	,LOTE VARCHAR(10) NOT NULL
	)

--STORED PROCEDURES
/*OTRA ACTUALIZACION, POR LAS FALLAS DEL TIPO QUE SON */

--Procedimoiento de almacenado para insertar proveedores con clave automatica 
SELECT * FROM PROVEEDORES
DELETE FROM PROVEEDORES
USE FarmSAntonio
USE FarmSAntonioCompras

PROVAUTO 'ADRIAN CEJA RENTERIA', 'GAMESA','FAKE 123','FAKE 234','3531522293','MICHOACAN','59050','FORESTAL','adriancar75@hotmail.com',0,0
PROVAUTO 'CESAR PAULINO MENDIOLA CORREA', 'LICONSA','FAKE 123','FAKE 234','3531522293','MICHOACAN','59050','LIMONERA','cesar@hotmail.com',0,0
PROVAUTO 'FERNANDO CEJA','ALMACEN DE DROGAS S.A DE C.V','SANTA TERESA#106','JULIANDEOBREGON#54','3145651214','GUANAJUATO','45444','LEON','PVV_996@HOTMAIL.COM',0,0
PROVAUTO 'MEMINmemero', 'GAMESA','FAKE 123','FAKE 234','3531522293','MICHOACAN','59050','FORESTAL','adriancar75@hotmail.com',1,0


CREATE PROC PROVAUTO
	@NOMPROV VARCHAR(50)
	,@EMPRESA VARCHAR(30)
	,@DIRPROV VARCHAR(50)
	,@DIREMPSA VARCHAR(50)
	,@TELPROV VARCHAR(15)
	,@ESTADO VARCHAR(20)
	,@CODIGOP VARCHAR(8)
	,@LOCALIDAD VARCHAR(30)
	,@CORREOPROV VARCHAR(30)
	,@clave int
	,@ban INT OUTPUT
AS
DECLARE @CVEPROV INT

IF (
		SELECT COUNT(*)
		FROM PROVEEDORES
		) = 0
	SET @CVEPROV = 1
ELSE
	SET @CVEPROV = (
			SELECT MAX(CVEPROV)
			FROM PROVEEDORES
			) + 1
IF @NOMPROV = ''
	SET @ban = 1
	--PRINT 'EL NOMBRE DEL PROVEEDOR NO DEBE DE ESTAR VACIO'
ELSE IF (@NOMPROV LIKE '%[0-9]%')
	--PRINT 'El NOMBRE NO DEBE DE TENER CARACTERES NUMERICOS'
	SET @ban = 2
ELSE IF @EMPRESA = ''
	--PRINT 'lA EMPRESA DEL PROVEEDOR NO DEBE DE ESTAR VACIA'
	SET @ban = 3
ELSE IF @DIREMPSA = ''
	--PRINT 'LA DIRECCION DE LA EMPRESA NO DEBE DE ESTAR VACIA'
	SET @ban = 4
ELSE IF @TELPROV = ''
	---PRINT 'EL TELEFONO DEL PROVEEDOR NO DEBE DE ESTAR VACIO'
	SET @ban = 5
ELSE IF (@TELPROV LIKE '%[A-Z]%')
	--PRINT 'EL TELEFONO TIENE LETRAS'
	SET @ban = 6
ELSE IF @ESTADO = ''
	--PRINT 'EL ESTADO NO DEBE DE ESTAR VACIO'
	SET @ban = 7
ELSE IF @CODIGOP = ''
	--PRINT 'EL CODIGO POSTAL NO DEBE DE ESTAR VACIO'
	SET @ban = 8
ELSE IF (@CODIGOP LIKE '%[A-Z]%')
	--PRINT 'EL CODIGO POSTAL TIENE LETRAS'
	SET @ban = 9
ELSE IF @LOCALIDAD = ''
	--PRINT 'LA LOCALIDAD DEBE NO DEBE DE ESTAR VACIA'
	SET @ban = 10
ELSE IF @CORREOPROV = ''
	--PRINT 'EL CORREO DEL PROVEEDOR NO DEBE DE ESTAR VACIO'
	SET @ban = 11
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	IF (len(@nomprov) > 49)
		--print 'EL NOMBRE DEL PROVEEDOR EXCEDE LOS 50 CARACTERES'
		SET @ban = 12
	ELSE IF (LEN(@empresa) > 29)
		--print 'EL NOMBRE DE LA EMPRESA EXCEDE LOS 30 CARACTERES'
		SET @ban = 13
	ELSE IF (LEN(@dirprov) > 49)
		--print 'LA DIRECCION DEL PROVEEDOR EXCEDE LOS 50 CARACTERES'
		SET @ban = 14
	ELSE IF (LEN(@dirempsa) > 49)
		--print 'LA DIRECCION DEL LA EMPRESA EXCEDE LOS 50 CARACTERES'
		SET @ban = 15
	ELSE IF (LEN(@telprov) > 14)
		--print 'LA DIRECCION DEL CLIENTE EXCEDE LOS 15 CARACTERES'
		SET @ban = 16
	ELSE IF (LEN(@estado) > 19)
		--print 'EL ESTADO DE LA EMPRESA EXCEDE LOS 20 CARACTERES'
		SET @ban = 17
	ELSE IF (LEN(@codigop) > 7)
		--print 'EL CODIGO POSTAL EXCEDE LOS 8 CARACTERES'
		SET @ban = 18
	ELSE IF (len(@localidad) > 29)
		--print 'LA LOCALIDAD DEL PROVEEDOR EXCEDE LOS 30 CARACTERES'
		SET @ban = 19
	ELSE IF (len(@correoprov) > 29)
		--print 'EL CORREO DEL PROVEEDOR EXCEDE LOS 30 CARACTERES'
		SET @ban = 20
	ELSE IF (
			SELECT count(*)
			FROM proveedores
			WHERE nomprov = @nomprov
				AND empresa = @empresa
				AND dirprov = @dirprov
				AND dirempsa = @dirempsa
				AND telprov = @telprov
				AND estado = @estado
				AND codigop = @codigop
				AND localidad = @localidad
				AND correoprov = @correoprov
			) > 0
		--PRINT 'ESTE PROVEEDOR YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS'
		SET @ban = 21
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DE PROVEEDORES (ACTUAL)
		--------------------------------------------------------
		INSERT INTO PROVEEDORES
		VALUES (
			@CVEPROV
			,@NOMPROV
			,@EMPRESA
			,@DIRPROV
			,@DIREMPSA
			,@TELPROV
			,@ESTADO
			,@CODIGOP
			,@LOCALIDAD
			,@CORREOPROV
			,1
			)		
		--------------------------------------------------------
		--INSERCION DE PROVEEDORES A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.PROVEEDORES
		VALUES (
			@CVEPROV
			,@NOMPROV
			,@EMPRESA
			,@DIRPROV
			,@DIREMPSA
			,@TELPROV
			,@ESTADO
			,@CODIGOP
			,@LOCALIDAD
			,@CORREOPROV
			,1
			)
		COMMIT TRAN
	END
END

--PROCEDIMIENTO DE ALMACENADO PARA INGRESAR CADUCIDADES
SELECT * FROM caducidad
DELETE FROM CADUCIDAD
USE FarmSAntonio
USE FarmSAntonioCompras
SELECT * FROM PROVEEDORES
SELECT * FROM PRODUCTOS
CADAUTO '' CADAUTO '2019/07/12' CADAUTO '2020/10/11' CADAUTO '2020/10/11' CADAUTO '2021/11/01'

CREATE PROC CADAUTO 
@fechacad DATE
,@clave int
,@BAN INT OUTPUT
AS
DECLARE @cvecad INT
IF (SELECT COUNT(*) FROM CADUCIDAD) = 0
	SET @cvecad = 1
ELSE
	SET @cvecad = (SELECT MAX(cvecad) FROM CADUCIDAD) + 1
IF @fechacad = ''
	--PRINT 'La fecha de caducidad no debe de estar vacia'
	SET @ban = 1
ELSE IF (@fechacad <= getdate())
	--PRINT 'La fecha de cauducidad debe ser mayor a la fecha de hoy'
	SET @ban = 2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	IF (SELECT count(*) FROM caducidad WHERE fechacad = @fechacad) > 0
	--PRINT 'ESTA CADUCIDAD YA SE ENCUENTRA REGISTRADA'
		SET @ban = 3
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DE CADUCIDAD (ACTUAL)
		--------------------------------------------------------
		INSERT INTO CADUCIDAD (
			CVECAD
			,FECHACAD
			)
		VALUES (
			@cvecad
			,@fechacad
			)
		--------------------------------------------------------
		--INSERCION DE CADUCIDAD A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.CADUCIDAD (
			CVECAD
			,FECHACAD
			)
		VALUES (
			@cvecad
			,@fechacad
			)
		COMMIT TRAN
	END
END

--PROC DE ALMACENADO PARA MEDICAMENTOS 
SELECT * FROM MEDICAMENTOS
DELETE FROM MEDICAMENTOS
USE FarmSAntonio
USE FarmSAntonioCompras

MEDAUTO 'LOMOTIL','Efervecente',2,0
MEDAUTO 'ALKASETZER','Efervecente',1,0

CREATE PROC MEDAUTO
@NOMED VARCHAR(30),
@DESCRIPCIONM VARCHAR(60)
,@clave int 
,@BAN INT OUTPUT
AS
DECLARE @CVEMED INT
IF (SELECT COUNT(*) FROM MEDICAMENTOS) = 0
	SET @CVEMED = 4000
ELSE
	SET @CVEMED = (SELECT MAX(CVEMED) FROM MEDICAMENTOS) + 1
IF @NOMED = ''
	--PRINT 'EL NOMBRE DEL MEDICAMENTO NO DEBE DE ESTAR VACIO'
	SET @BAN = 1
ELSE IF @DESCRIPCIONM = ''
	--PRINT 'LA DESCRICION NO DEBE DE ESTAR VACIA'
	SET @BAN = 2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	IF (LEN(@NOMED) > 29)
		--PRINT 'EL NOMBRE DEL MEDICAMENTO EXCEDE LOS 30 CARACTERES'
		SET @BAN = 3
	ELSE IF (LEN(@DESCRIPCIONM) > 59)
		--PRINT 'LA DESCRIPCION DEL MEDICAMENTO EXCEDE LOS 50 CARACTERES'
		SET @BAN = 4
	ELSE IF (
			SELECT COUNT(*)
			FROM MEDICAMENTOS
			WHERE NOMED = @NOMED
			) > 0
		--PRINT 'ESTE MEDICAMENTO YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS'
		SET @BAN = 5
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DE MEDICAMENTO (ACTUAL)
		--------------------------------------------------------
		INSERT INTO MEDICAMENTOS (
			CVEMED
			,NOMED
			,DESCRIPCIONM
			,ESTADO
			)
		VALUES (
			@CVEMED
			,@NOMED
			,@DESCRIPCIONM
			,1
			)
		--------------------------------------------------------
		--INSERCION DE MEDICAMENTO A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.MEDICAMENTOS (
			CVEMED
			,NOMED
			,DESCRIPCIONM
			,ESTADO
			)
		VALUES (
			@CVEMED
			,@NOMED
			,@DESCRIPCIONM
			,1
			)
		--------------------------------------------------------
		--INSERCION DE MEDICAMENTO A VENTAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioVentas.DBO.MEDICAMENTOS (
			CVEMED
			,NOMED
			,DESCRIPCIONM
			,ESTADO
			)
		VALUES (
			@CVEMED
			,@NOMED
			,@DESCRIPCIONM
			,1
			)
		COMMIT TRAN
	END
END


--PROCEDIMIENTO DE ALMACENADO PARA INGRESAR PRODUCTOS CON CVE AUTOMATICA
SELECT * FROM PRODUCTOS
DELETE FROM PRODUCTOS
USE FarmSAntonio
USE FarmSAntonioCompras

PRODAUTO 'CEPILLO COLGATE','DENTAL',1,0
PRODAUTO 'RASTRILLO GILLETE','DENTAL',2,0

CREATE PROC PRODAUTO 
@NOMP VARCHAR(30),
@DESCRIP VARCHAR(60)
,@clave int 
,@BAN INT output
AS
DECLARE @CVEPROD INT
IF (SELECT COUNT(*) FROM PRODUCTOS) = 0
	SET @CVEPROD = 1
ELSE
	SET @CVEPROD = (SELECT MAX(CVEPROD) FROM PRODUCTOS) + 1
IF @NOMP = ''
	--PRINT 'EL NOMBRE DEL PRODUCTO NO DEBE DE ESTAR VACIO'
	SET @BAN = 1
ELSE IF @DESCRIP = ''
	--PRINT 'LA DESCRIPCION NO DEBE DE ESTAR VACIA'
	SET @BAN = 2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	IF (LEN(@NOMP) > 29)
		--PRINT 'EL NOMBRE DEL PRODUCTO EXCEDE LOS 30 CARACTERES'
		SET @BAN = 3
	ELSE IF (LEN(@DESCRIP) > 49)
		--PRINT 'LA DESCRIPCION DEL PRODUCTO EXCEDE LOS 50 CARACTERES'
		SET @BAN = 4
	ELSE IF (SELECT COUNT(*) FROM PRODUCTOS WHERE NOMP = @NOMP) > 0
		--PRINT 'ESTE PRODUCTO YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS'
		SET @BAN = 5
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DE PRODUCTOS (ACTUAL)
		--------------------------------------------------------
		INSERT INTO PRODUCTOS (
			CVEPROD
			,NOMP
			,DESCRIP
			,ESTADO
			)
		VALUES (
			@CVEPROD
			,@NOMP
			,@DESCRIP
			,1
			)
		--------------------------------------------------------
		--INSERCION DE PRODUCTOS A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.PRODUCTOS (
			CVEPROD
			,NOMP
			,DESCRIP
			,ESTADO
			)
		VALUES (
			@CVEPROD
			,@NOMP
			,@DESCRIP
			,1
			)
		--------------------------------------------------------
		--INSERCION DE PRODUCTOS A LA DE VENTAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioVentas.DBO.PRODUCTOS (
			CVEPROD
			,NOMP
			,DESCRIP
			,ESTADO
			)
		VALUES (
			@CVEPROD
			,@NOMP
			,@DESCRIP
			,1
			)
		COMMIT TRAN
END
END


--PROCEDIMINETO DE ALMACENADO PARA INGRESAR COMPRAS CON SU CVE AUTOMATICA Y SU DETALLE ENTRE PROVEEDORES MANUAL
--/*ESTE HAY QUE HACER MANUAL EL DETALLE*/
SELECT * FROM compras
SELECT * FROM detcomprv
SELECT * FROM proveedores
DELETE FROM COMPRAS 
DELETE FROM DETCOMPRV
USE FarmSAntonio
USE FarmSAntonioCompras

COMAUTO '' COMAUTO 15 COMAUTO 1 --med
COMAUTO 1 --prod

DROP PROC COMAUTO

CREATE  PROC COMAUTO
@CVEPROV INT
,@clave int
,@BAN INT OUTPUT 
AS
DECLARE @CVECOMP INT
IF (
		SELECT COUNT(*)
		FROM COMPRAS
		) = 0
	SET @CVECOMP = 1
ELSE
	SET @CVECOMP = (
			SELECT MAX(CVECOMP)
			FROM COMPRAS
			) + 1
IF (
		@cveprov = ''
		OR @cveprov = 0
		)
	--PRINT 'LA CLAVE NO DEBE ESTAR VACÍA O SER 0'
	SET @BAN = 1
ELSE IF (
		SELECT COUNT(cveprov)
		FROM proveedores
		WHERE cveprov = @cveprov 
		) = 0 --NO EXISTE LA CVE 
	--PRINT 'LA CLAVE DEL PROVEEDOR NO EXISTE'
	SET @BAN = 2
ELSE IF (SELECT ACTIVO FROM PROVEEDORES WHERE CVEPROV =@CVEPROV) = 0
	--PRINT 'ESTE PROVEEDOR ESTA INACTIVO O DADO DE BAJA'
	SET @BAN = 3
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DE CVE DE COMPRAS (ACTUAL)
		--------------------------------------------------------
		INSERT INTO COMPRAS (
			CVECOMP
			)
		VALUES (
			@CVECOMP
			)
		--------------------------------------------------------
		--INSERCION DE CVE DE COMPRAS A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.COMPRAS (
			CVECOMP
			)
		VALUES (
			@CVECOMP
			)
		--------------------------------------------------------
		--INSERCION DETALLE COMPRA PROV (ACTUAL)
		--------------------------------------------------------
		INSERT INTO DETCOMPRV (
			CVECOMP
			,CVEPROV
			)
		VALUES (
			@CVECOMP
			,@cveprov
			)
		--------------------------------------------------------
		--INSERCION DETALLE COMPRA PROV A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.DETCOMPRV (
			CVECOMP
			,CVEPROV
			)
		VALUES (
			@CVECOMP
			,@cveprov
			)
		COMMIT TRAN
	END

--PROCEDIMIENTO DE ALAMCENADO PARA INGRESAR DETALLES ENTRE MEDICAMENTOS Y COMPRAS ASI COMO SI TIENE UNA CADUCIDAD EN COMUN SE HACE LA RELACION
--EN CASO CONTRARIO, HARA ESTE ULTIMO DETALLE MANUAL
--PARA INGRESAR TODOS LOS CAMPOS
SELECT * FROM caducidad
SELECT * FROM COMPRAS
SELECT * FROM MEDICAMENTOS
SELECT * FROM CADUCIDAD
SELECT * FROM DETCOMMED
SELECT * FROM DETCADMED

USE FarmSAntonio
USE FarmSAntonioCompras

DETCMED 1,4000,100, '1', '2021/11/01' ,30, 2000, 1.3,1,0

CREATE PROC DETCMED 
	@CVECOMP INT
	,@CVEMED INT
	,@CANTCOMPM INT
	,@TIPOMED VARCHAR(30)
	,@CADM DATE
	,@PRECOMPM MONEY
	,@LOTE VARCHAR(10)
	,@GANANCIA MONEY
	,@clave int
	,@BAN INT OUTPUT
AS
DECLARE @AUX INT,
@fechalimt2 DATE
SET @fechalimt2 = (
		SELECT DATEADD(MM, - 3, @CADM)
		)
IF @CVECOMP = ''
	--PRINT 'LA CLAVE DE COMPRA NO DEBE DE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (
		SELECT COUNT(*)
		FROM compras
		WHERE CVECOMP = @CVECOMP
		) = 0
	--PRINT 'LA CLAVE DE COMPRA NO EXISTE'
	SET @BAN = 2
ELSE IF @CVEMED = ''
	--PRINT 'LA CLAVE DEL MEDICAMENTO ESTA VACIA'
	SET @BAN = 3
ELSE IF (
		SELECT COUNT(*)
		FROM MEDICAMENTOS
		WHERE CVEMED = @CVEMED
		) = 0
	--PRINT 'LA CLAVE DEL MEDICAMENTO NO EXISTE'
	SET @BAN = 4
ELSE IF @CANTCOMPM = ''
	OR @CANTCOMPM < 1
	--PRINT 'LA CANTIDAD COMPRADA ESTA VACIA O ES INFERIOR A 1'
	SET @BAN = 5
ELSE IF @GANANCIA = ''
	OR @GANANCIA < 1.1
	--PRINT 'LA GANANCIA ESTA VACIA O ES INFERIOR A 1.1'
	SET @BAN = 6
ELSE IF @TIPOMED = ''
	--PRINT 'EL TIPO DE MEDICAMENTO ESTA VACIO'
	SET @BAN = 7
ELSE IF @TIPOMED != '1'
	AND @TIPOMED != '2'
	AND @TIPOMED != '3'
	--PRINT 'EL TIPO DE MEDICAMENTO DEBE DE SER 1, 2 O 3'
	SET @BAN = 8
ELSE IF @CADM = ''
	--PRINT 'LA FECHA DE CAD DEL MEDICAMENTO NO DEBE DE ESTAR VACIA'
	SET @BAN = 9
ELSE IF (@CADM <= getdate())
	--PRINT 'LA FECHA DE CAD DEL MEDICAMENTO YA CADUCO O ESTA PROXIMO A CADUCAR'
	SET @BAN = 10
ELSE IF @PRECOMPM = ''
	OR @PRECOMPM < 1
	--PRINT 'EL PRECIO DE COMPRA NO DEBE DE ESTAR VACIO NI CERO'
	SET @BAN = 11
ELSE IF @LOTE = ''
	--PRINT 'EL LOTE DEL MEDICAMENTO NO DEBE DE ESTAR VACIO'
	SET @BAN = 12
else if (@fechalimt2<=getdate())
--PRINT 'LA FECHA DE DEBE SER MAYOR A 3 Meses DE SU VENCIMINETO'
	SET @BAN = 19
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN --1
	IF (LEN(@LOTE) > 9)
		--PRINT 'EL LOTE EXCEDE LOS 10 CARACTERES'
		SET @BAN = 13
	ELSE IF (
			SELECT COUNT(*)
			FROM DETCOMMED
			WHERE CVECOMP = @CVECOMP
				AND CVEMED = @CVEMED
				AND TIPOMED = @TIPOMED
			) > 0
	BEGIN --2
		IF (
				SELECT COUNT(*)
				FROM DETCADMED
				WHERE cvecad = (
						SELECT cvecad
						FROM caducidad
						WHERE fechacad = @CADM
						)
					AND CVEMED = @CVEMED
					AND LOTE = @LOTE
				) > 0 --ya hay un registro igual con su lote igual
		BEGIN			--------------------------------------------------------
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET PRECIOCOMPM = @PRECOMPM
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET PRECIOCOMPM = @PRECOMPM
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--ESTE CAMPO NO EXISTE EN VENTAS
			--------------------------------------------------------
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA DE MED COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA DE MED COMPRADOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA DE MED COMPRADOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LA CANTIDAD DE MED COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE DETCOMMED
			SET CANTCOMPM = CANTCOMPM + @CANTCOMPM
			WHERE CVECOMP = @CVECOMP
				AND CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LA CANTIDAD DE MED COMPRADOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETCOMMED
			SET CANTCOMPM = CANTCOMPM + @CANTCOMPM
			WHERE CVECOMP = @CVECOMP
				AND CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MED (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MED A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MED A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA MED (ACTUAL)
			--------------------------------------------------------
			UPDATE COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
			WHERE CVECOMP = @CVECOMP
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA MED A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
			WHERE CVECOMP = @CVECOMP
		END
		ELSE --ya hay un registro igual en la compra, pero el producto posee un lote diferente
		BEGIN
			--------------------------------------------------------
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET PRECIOCOMPM = @PRECOMPM
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET PRECIOCOMPM = @PRECOMPM
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--ESTE CAMPO NO EXISTE EN VENTAS
			--------------------------------------------------------
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA MEDICAMENTOS COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA MEDICAMENTOS COMPRADOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL PRECIO DE VENTA MEDICAMENTOS COMPRADOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
			SET PRECIOVTAM = @PRECOMPM * @GANANCIA
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE ALA CANTIDAD COMPRADOS (ACTUAL)
			--------------------------------------------------------
			UPDATE DETCOMMED
			SET CANTCOMPM = CANTCOMPM + @CANTCOMPM
			WHERE CVECOMP = @CVECOMP
				AND CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE ALA CANTIDAD COMPRADOS DE LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETCOMMED
			SET CANTCOMPM = CANTCOMPM + @CANTCOMPM
			WHERE CVECOMP = @CVECOMP
				AND CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS DE LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS DE VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
			SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
			WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--UPDATE AL TOTAL DE LA COMPRA (ACTUAL)
			--------------------------------------------------------
			UPDATE COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
			WHERE CVECOMP = @CVECOMP
			--------------------------------------------------------
			--UPDATE AL TOTAL DE LA COMPRA DE LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
			WHERE CVECOMP = @CVECOMP
			IF (
					SELECT COUNT(FECHACAD)
					FROM caducidad
					WHERE FECHACAD = @CADM
					) = 1 --HAY UNA CADUCIDAD EN COMUN
			BEGIN
				SET @AUX = (
						SELECT cvecad
						FROM caducidad
						WHERE fechacad = @CADM
						)
				EXEC DETCAME @AUX
					,@CVEMED
					,@LOTE
					,@clave 
					,@BAN
			END --se cambia la sentencia que tenia como una variable auxiliar, ya que la anterior sentnecia la detectaba como un varchar en lugar de int 
			ELSE --NO HAY UNA CADUCIDAD EN COMUN
			BEGIN
				EXEC CADAUTO @CADM, @clave, @BAN

				SET @AUX = (
						SELECT cvecad
						FROM caducidad
						WHERE fechacad = @CADM
						)

				EXEC DETCAME @AUX
					,@CVEMED
					,@LOTE
					,@clave 
					,@BAN
			END
		END
	END --2
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DETCOMMED (ACTUAL)
		--------------------------------------------------------
		INSERT INTO DETCOMMED (
			CVECOMP
			,CVEMED
			,CANTCOMPM
			,TIPOMED
			,CADM
			,PRECOMPM
			,LOTE
			,GANANCIAM
			)
		VALUES (
			@CVECOMP
			,@CVEMED
			,@CANTCOMPM
			,@TIPOMED
			,@CADM
			,@PRECOMPM
			,@LOTE
			,@GANANCIA
			)
		--------------------------------------------------------
		--INSERCION DETCOMMED A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.DETCOMMED (
			CVECOMP
			,CVEMED
			,CANTCOMPM
			,TIPOMED
			,CADM
			,PRECOMPM
			,LOTE
			,GANANCIAM
			)
		VALUES (
			@CVECOMP
			,@CVEMED
			,@CANTCOMPM
			,@TIPOMED
			,@CADM
			,@PRECOMPM
			,@LOTE
			,@GANANCIA
			)
		--------------------------------------------------------
		--UPDATE AL PRECIO DE COMPRA (ACTUAL)
		--------------------------------------------------------
		UPDATE MEDICAMENTOS
		SET PRECIOCOMPM = @PRECOMPM
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE AL PRECIO DE LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.MEDICAMENTOS
		SET PRECIOCOMPM = @PRECOMPM
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--ESTE CAMPO NO EXISTE EN VENTAS
		--------------------------------------------------------
		--------------------------------------------------------
		--UPDATE AL PRECIO DE VENTA (ACTUAL)
		--------------------------------------------------------
		UPDATE MEDICAMENTOS
		SET PRECIOVTAM = @PRECOMPM * @GANANCIA
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE AL PRECIO DE VENTA DE LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.MEDICAMENTOS
		SET PRECIOVTAM = @PRECOMPM * @GANANCIA
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE AL PRECIO DE VENTA DE VENTAS
		--------------------------------------------------------
		UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
		SET PRECIOVTAM = @PRECOMPM * @GANANCIA
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS (ACTUAL)
		--------------------------------------------------------
		UPDATE MEDICAMENTOS
		SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS DE LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.MEDICAMENTOS
		SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS DE VENTAS
		--------------------------------------------------------
		UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
		SET EXISTENCIASM = EXISTENCIASM + (@CANTCOMPM)
		WHERE CVEMED = @CVEMED
		--------------------------------------------------------
		--UPDATE AL TOTAL DE LA COMPRA (ACTUAL)
		--------------------------------------------------------
		UPDATE COMPRAS
		SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
		WHERE CVECOMP = @CVECOMP
		--------------------------------------------------------
		--UPDATE AL TOTAL DE LA COMPRA DE LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.COMPRAS
		SET TOTALCOMP = TOTALCOMP + (@PRECOMPM * @CANTCOMPM)
		WHERE CVECOMP = @CVECOMP
		IF (
				SELECT COUNT(FECHACAD)
				FROM caducidad
				WHERE FECHACAD = @CADM
				) = 1 --HAY UNA CADUCIDAD EN COMUN
		BEGIN
			SET @AUX = (
					SELECT cvecad
					FROM caducidad
					WHERE fechacad = @CADM
					)
			EXEC DETCAME @AUX
				,@CVEMED
				,@LOTE
				,@clave
				,@BAN
		END
		ELSE --NO HAY UNA CADUCIDAD EN COMUN Y SE RELACIONARA EL DETALLE MANUALMENTE
		BEGIN
			EXEC CADAUTO @CADM, @clave, @BAN 

			SET @AUX = (
					SELECT cvecad
					FROM caducidad
					WHERE fechacad = @CADM
					)
			EXEC DETCAME @AUX
				,@CVEMED
				,@LOTE
				,@clave
				,@BAN
		END
		COMMIT TRAN
	END
END --1

--PROCEDIMENTO PARA LLENAR DETALLE ENTRE CADUCIDADES Y MEDICAMENTOS(MANUAL)	
SELECT * FROM DETCADMED
SELECT * FROM MEDICAMENTOS
SELECT * FROM DETCADMED

USE FarmSAntonio
USE FarmSAntonioCompras

CREATE PROC DETCAME @cvecad INT
	,@cvemed INT
	,@lote VARCHAR(10)
	,@clave int
	,@BAN INT OUTPUT
AS
DECLARE @fechalimt DATE
SET @fechalimt = (
		SELECT DATEADD(MM, - 3, (
					SELECT fechacad
					FROM caducidad
					WHERE cvecad = @cvecad
					))
		)
IF @cvecad = ''
	OR @cvecad < 1
	--PRINT 'La clave de la caducidad esta vacia o se encuentra en 0'
	SET @BAN = 1
ELSE IF (
		SELECT COUNT(CVECAD)
		FROM caducidad
		WHERE CVECAD = @cvecad
		) = 0
	--PRINT 'LA CVE DE LA CADUCIDAD NO EXISTE'
	SET @BAN = 2
ELSE IF @cvemed = ''
	OR @cvemed < 1
	--PRINT 'La clave del medicamento esta vacia o se encuentra en 0'
	SET @BAN = 3
ELSE IF (
		SELECT COUNT(cvemed)
		FROM medicamentos
		WHERE cvemed = @cvemed
		) = 0
	--PRINT 'LA CVE DEL MEDICAMENTO NO EXISTE'
	SET @BAN = 4
ELSE IF @lote = ''
	--PRINT 'EL LOTE NO DEBE DE ESTAR VACIO'
	SET @BAN = 5
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	BEGIN TRAN
	--------------------------------------------------------
	--INSERCION DE DETALLE CADUCIDAD (ACTUAL)
	--------------------------------------------------------
	INSERT INTO DETCADMED (
		CVECAD
		,CVEMED
		,LOTE
		,FECHALIMT
		)
	VALUES (
		@cvecad
		,@cvemed
		,@lote
		,@fechalimt
		)
	--------------------------------------------------------
	--INSERCION DE DETALLE CADUCIDAD DE LA ORIGINAL
	--------------------------------------------------------
	INSERT INTO FarmSAntonio.DBO.DETCADMED (
		CVECAD
		,CVEMED
		,LOTE
		,FECHALIMT
		)
	VALUES (
		@cvecad
		,@cvemed
		,@lote
		,@fechalimt
		)
	COMMIT TRAN
END
RETURN

--PROCEDIMIENTO DE ALAMCENADO PARA INGRESAR DETALLES ENTRE PRODUCTOS Y COMPRAS ASI COMO SI TIENE UNA CADUCIDAD EN COMUN
--EN CASO CONTRARIO, HARA ESTE ULTIMO DETALLE MANUAL 
--PARA INGRESAR TODOS LOS CAMPOS
SELECT * FROM COMPRAS
SELECT * FROM PRODUCTOS
SELECT * FROM DETCOMPRO
SELECT * FROM CADUCIDAD
SELECT * FROM DETCADPRO

USE FarmSAntonio
USE FarmSAntonioCompras

DETCPROD 1,1,50,'2021-11-01',20,'4545',1.5

CREATE  PROC DETCPROD
	@cvecomp INT
	,@cveprod INT
	,@cantcomp INT
	,@cad DATE
	,@precomp MONEY
	,@lote VARCHAR(10)
	,@GANANCIA MONEY
	,@clave int 
	,@BAN INT OUTPUT
AS
DECLARE @AUX INT
SET @AUX = (
		SELECT cvecad
		FROM caducidad
		WHERE fechacad = @CAD
		)
IF @cvecomp = ''
	--PRINT 'LA CLAVE DE COMPRA NO DEBE DE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (
		SELECT COUNT(*)
		FROM compras
		WHERE cvecomp = @cvecomp
		) = 0
	--PRINT 'LA CLAVE DE COMPRA NO EXISTE'
	SET @BAN = 2
ELSE IF @CVEPROD = ''
	--PRINT 'LA CLAVE DEL PRODUCTO ESTA VACIA'
	SET @BAN = 3
ELSE IF (
		SELECT COUNT(*)
		FROM PRODUCTOS
		WHERE cveprod = @cveprod
		) = 0
	--PRINT 'LA CLAVE DEL PRODUCTO NO EXISTE'
	SET @BAN = 4
ELSE IF @cantcomp = ''
	OR @cantcomp < 1
	--PRINT 'LA CANTIDAD COMPRADA ESTA VACIA O ES INFERIOR A 1'
	SET @BAN = 5
ELSE IF @cad = ''
	--PRINT 'LA FECHA DE CAD DEL PRODUCTO NO DEBE DE ESTAR VACIA'
	SET @BAN = 6
ELSE IF (@cad <= getdate())
	--PRINT 'LA FECHA DE CAD DEL PRODUCTO YA CADUCO O ESTA PROXIMO A CADUCAR'
	SET @BAN = 7
ELSE IF @precomp = ''
	OR @precomp < 1
	--PRINT 'EL PRECIO DE COMPRA NO DEBE DE ESTAR VACIO NI CERO'
	SET @BAN = 8
ELSE IF @GANANCIA = ''
	OR @GANANCIA < 1.1
	--PRINT 'LA GANANCIA ESTA VACIA O ES INFERIOR A 1.1'
	SET @BAN = 9
ELSE IF @lote = ''
	--PRINT 'EL LOTE NO DEBE DE ESTAR VACIO'
	SET @BAN = 10
ELSE IF (LEN(@LOTE) > 9)
	--PRINT 'EL LOTE EXCEDE LOS 10 CARACTERES'
	SET @BAN = 11
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN --1
	IF (
			SELECT COUNT(*)
			FROM DETCOMPRO
			WHERE CVECOMP = @CVECOMP
				AND CVEPROD = @CVEPROD
			) > 0
	BEGIN --2
		IF (
				SELECT COUNT(*)
				FROM DETCADPRO
				WHERE CVECAD = (
						SELECT cvecad
						FROM caducidad
						WHERE fechacad = @CAD
						)
					AND CVEPROD = @CVEPROD
					AND LOTE = @LOTE
				) > 0 --ya hay un registro igual con su lote igual
		BEGIN			--------------------------------------------------------
			--UPDATE PRECIO DE COMPRA PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET PRECIOCOMP = @precomp
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE COMPRA PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET PRECIOCOMP = @precomp
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--ESTE CAMPO NO EXISTE EN VENTAS
			--------------------------------------------------------
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE CANTIDAD COMPRADA DE PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE DETCOMPRO
			SET CANTCOMP = CANTCOMP + @CANTCOMP
			WHERE CVECOMP = @CVECOMP
				AND CVEPROD = @CVEPROD
			--------------------------------------------------------
			--UPDATE CANTIDAD COMPRADA DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETCOMPRO
			SET CANTCOMP = CANTCOMP + @CANTCOMP
			WHERE CVECOMP = @CVECOMP
				AND CVEPROD = @CVEPROD
			--------------------------------------------------------
			--UPDATE DE LA EXISTENCIA DE PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE DE LA EXISTENCIA DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE DE LA EXISTENCIA DE PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA (ACTUAL)
			--------------------------------------------------------
			UPDATE COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
			WHERE CVECOMP = @cvecomp
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA DE LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
			WHERE CVECOMP = @cvecomp
		END
		ELSE --ya hay un registro igual en la compra, pero el producto posee un lote diferente
		BEGIN
			--------------------------------------------------------
			--UPDATE PRECIO DE COMPRA (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET PRECIOCOMP = @precomp
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE COMPRA AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET PRECIOCOMP = @precomp
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--ESTE CAMPO NO EXISTE EN VENTAS
			--------------------------------------------------------
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE PRECIO DE VENTA A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET PRECIOVTAP = @precomp * @GANANCIA
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE CANTIDAD DE PROD COMPRADA (ACTUAL)
			--------------------------------------------------------
			UPDATE DETCOMPRO
			SET CANTCOMP = CANTCOMP + @CANTCOMP
			WHERE CVECOMP = CVECOMP
				AND CVEPROD = @CVEPROD
			--------------------------------------------------------
			--UPDATE CANTIDAD DE PROD COMPRADA A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETCOMPRO
			SET CANTCOMP = CANTCOMP + @CANTCOMP
			WHERE CVECOMP = CVECOMP
				AND CVEPROD = @CVEPROD
			--------------------------------------------------------
			--UPDATE EXISTENCIAS DE PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE EXISTENCIAS DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE EXISTENCIAS DE PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
			WHERE cveprod = @cveprod
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA (ACTUAL)
			--------------------------------------------------------
			UPDATE COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
			WHERE CVECOMP = @cvecomp
			--------------------------------------------------------
			--UPDATE TOTAL DE LA COMPRA A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.COMPRAS
			SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
			WHERE CVECOMP = @cvecomp
			IF (
					SELECT COUNT(FECHACAD)
					FROM caducidad
					WHERE FECHACAD = @CAD
					) = 1 --HAY UNA CADUCIDAD EN COMUN
				EXEC DETCAPROD @AUX
					,@CVEPROD
					,@LOTE
					,@clave
					,@BAN
			ELSE --NO HAY UNA CADUCIDAD EN COMUN
			BEGIN
				EXEC CADAUTO @CAD,@clave,@BAN 

				SET @AUX = (
						SELECT cvecad
						FROM caducidad
						WHERE fechacad = @CAD
						)

				EXEC DETCAPROD @AUX
					,@CVEPROD
					,@LOTE
					,@clave 
					,@BAN
			END
		END
	END --2
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DEL DETCOMPRO (ACTUAL)
		--------------------------------------------------------
		INSERT INTO DETCOMPRO (
			CVECOMP
			,CVEPROD
			,CANTCOMP
			,CAD
			,PRECOMP
			,LOTE
			,GANANCIAP
			)
		VALUES (
			@cvecomp
			,@cveprod
			,@cantcomp
			,@cad
			,@precomp
			,@lote
			,@GANANCIA
			)
		--------------------------------------------------------
		--INSERCION DEL DETCOMPRO A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.DETCOMPRO (
			CVECOMP
			,CVEPROD
			,CANTCOMP
			,CAD
			,PRECOMP
			,LOTE
			,GANANCIAP
			)
		VALUES (
			@cvecomp
			,@cveprod
			,@cantcomp
			,@cad
			,@precomp
			,@lote
			,@GANANCIA
			)
		--------------------------------------------------------
		--UPDATE PRECIO DE COMPRA PROD (ACTUAL)
		--------------------------------------------------------
		UPDATE PRODUCTOS
		SET PRECIOCOMP = @precomp
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE PRECIO DE COMPRA PROD A LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.PRODUCTOS
		SET PRECIOCOMP = @precomp
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--ESTE CAMPO NO EXISTE EN VENTAS
		--------------------------------------------------------
		--------------------------------------------------------
		--UPDATE PRECIO DE VENTA PROD (ACTUAL)
		--------------------------------------------------------
		UPDATE PRODUCTOS
		SET PRECIOVTAP = @precomp * @GANANCIA
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE PRECIO DE VENTA PROD A LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.PRODUCTOS
		SET PRECIOVTAP = @precomp * @GANANCIA
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE PRECIO DE VENTA PROD A VENTAS
		--------------------------------------------------------
		UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
		SET PRECIOVTAP = @precomp * @GANANCIA
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE EXISTENCIA DE PROD (ACTUAL)
		--------------------------------------------------------
		UPDATE PRODUCTOS
		SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE EXISTENCIA DE PROD A LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.PRODUCTOS
		SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE EXISTENCIA DE PROD A VENTAS
		--------------------------------------------------------
		UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
		SET EXISTENCIASP = EXISTENCIASP + (@cantcomp)
		WHERE cveprod = @cveprod
		--------------------------------------------------------
		--UPDATE TOTAL DE LA COMPRA (ACTUAL)
		--------------------------------------------------------
		UPDATE COMPRAS
		SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
		WHERE CVECOMP = @cvecomp
		--------------------------------------------------------
		--UPDATE TOTAL DE LA COMPRA A LA ORIGINAL
		--------------------------------------------------------
		UPDATE FarmSAntonio.DBO.COMPRAS
		SET TOTALCOMP = TOTALCOMP + (@precomp * @cantcomp)
		WHERE CVECOMP = @cvecomp
		IF (
				SELECT COUNT(FECHACAD)
				FROM caducidad
				WHERE FECHACAD = @cad
				) = 1 --HAY UNA CADUCIDAD EN COMUN
			EXEC DETCAPROD @AUX
				,@cveprod
				,@lote,@clave,@ban --DE IGUAL FORMA QUE CON EL PROC DEL MEDICAMENTO, SE USA UNA VARIABLE AUXILIAR
		ELSE --NO HAY UNA CADUCIDAD EN COMUN Y SE RELACIONARA EL DETALLE MANUALMENTE
		BEGIN
	EXEC CADAUTO @CAD,@clave,@BAN

			SET @AUX = (
					SELECT cvecad
					FROM caducidad
					WHERE fechacad = @CAD
					)
			EXEC DETCAPROD @AUX
				,@CVEPROD
				,@LOTE
				,@clave
				,@BAN
		END
		COMMIT TRAN
	END
END --1


--PROCEDIMIENTO DE ALMACENADO PARA DETALLE ENTRE PRODUCTOS Y CADUCIDADES CON CVE AUTOMATICA		
SELECT * FROM DETCADPRO

USE FarmSAntonio
USE FarmSAntonioCompras

CREATE PROC DETCAPROD 
	@cvecad INT
	,@cveprod INT
	,@lote VARCHAR(10)
	,@clave int 
	,@BAN INT OUTPUT
AS

IF @cvecad = ''
	OR @cvecad < 1
	--PRINT 'La clave de la caducidad esta vacia o se encuentra en 0'
	SET @BAN = 1
ELSE IF (
		SELECT COUNT(CVECAD)
		FROM caducidad
		WHERE CVECAD = @cvecad
		) = 0
	--PRINT 'LA CVE DE LA CADUCIDAD NO EXISTE'
	SET @BAN = 2
ELSE IF @cveprod = ''
	OR @cveprod < 1
	--PRINT 'La clave del producto esta vacia o se encuentra en 0'
	SET @BAN = 3
ELSE IF (
		SELECT COUNT(CVEPROD)
		FROM PRODUCTOS
		WHERE CVEPROD = @cveprod
		) = 0
	--PRINT 'LA CVE DEL PRODUCTO NO EXISTE'
	SET @BAN = 4
ELSE IF @lote = ''
	--PRINT 'EL LOTE NO DEBE DE ESTAR VACIO'
	SET @BAN = 5
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
	IF (LEN(@LOTE) > 10)
		--PRINT 'EL LOTE EXCEDE LOS 10 CARACTERES'
		SET @BAN = 6
	ELSE IF (
			SELECT COUNT(*)
			FROM DETCADPRO
			WHERE CVECAD = @CVECAD
				AND CVEPROD = @CVEPROD
				AND LOTE = @LOTE
			) > 0
		--PRINT 'LAS CLAVES YA HAN SIDO INGESADAS EN OTRO DETALLE' --ESTO QUITA QUE LOS DETALLES SE REPITAN MÀS LAS CLAVES SE PUEDEN SEGUIR UTILIZANDO, PERO NO SERAN CON EL MISMO LOTE, SINO CON OTRO
			--lO QUE SE CONSIDERA COMO UN NUEVO DETALLE
			SET @BAN = 7
	ELSE
	BEGIN
		BEGIN TRAN
		--------------------------------------------------------
		--INSERCION DETCADPROD (ACTUAL)
		--------------------------------------------------------
		INSERT INTO DETCADPRO (
			CVECAD
			,CVEPROD
			,LOTE
			)
		VALUES (
			@cvecad
			,@cveprod
			,@lote
			)
		--------------------------------------------------------
		--INSERCION DETCADPROD A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.DETCADPRO (
			CVECAD
			,CVEPROD
			,LOTE
			)
		VALUES (
			@cvecad
			,@cveprod
			,@lote
			)
		COMMIT TRAN
	END
END
RETURN

---
---PROCEDIMINETOS ALMACENADOS PARA BAJAS O ELIMINACIONES
---
--------------------------------------------------------
--			ELIMINACION DE PROVEEDORES
--------------------------------------------------------	
SELECT * FROM PROVEEDORES

USE FarmSAntonio
USE FarmSAntonioCompras

BAJAPROV  1 
CREATE PROC BAJAPROV
@CVEPROV INT
,@clave int 
,@BAN INT OUTPUT
AS

IF @CVEPROV='' OR @CVEPROV=0
		--PRINT 'LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA'
	SET @BAN = 1
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE 
	IF (SELECT COUNT(*) FROM PROVEEDORES WHERE CVEPROV=@CVEPROV)>0
		IF (SELECT COUNT(*) FROM DETCOMPRV WHERE CVEPROV = @CVEPROV)=0
			BEGIN 
				BEGIN TRAN
					DELETE PROVEEDORES WHERE CVEPROV=@CVEPROV
					--DELETE DETCOMPRV WHERE CVEPROV = @CVEPROV ESTO AFECTARÍA EL DETALLE Y LAS COMPRAS, POR ELLO EL PROCESO SE HACE DESDE BAJA COMPRA
					DELETE FarmSAntonio.DBO.PROVEEDORES WHERE CVEPROV=@CVEPROV
					--DELETE FarmSAntonio.DBO.DETCOMPRV WHERE CVEPROV=@CVEPROV
					--SE QUITARON LAS ANTERIORES YA QUE NOSOTROS SOLO PODEMOS ELIMINAR SI UN EMPLEADO NO TIENE RELACIONES 
					--Y ESAS DOS INSTRUCCIONES SON INECESARIAS
				COMMIT TRAN
			END
		ELSE
			--PRINT 'AUN EXISTEN ARTICULOS DISPONIBLES DE ESTE PROVEEDOR'
			SET @BAN = 2
	ELSE
		--PRINT 'LA CLAVE DEL PROVEEDOR NO SE ENCUENTRA REGISTRADA EN LA BASE DE DATOS'
		SET @BAN = 3

--------------------------------------------------------
--			BAJA TEMPORAL DE PROVEEDORES
--------------------------------------------------------	
SELECT * FROM PROVEEDORES

USE FarmSAntonio
USE FarmSAntonioCompras

BAJAPROVTEMP 1

CREATE PROC BAJAPROVTEMP
@CVEPROV INT
,@clave int 
,@BAN INT OUTPUT
AS
IF @CVEPROV='' OR @CVEPROV=0
	--PRINT 'LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE 
	IF (SELECT COUNT (*) CVEPROV FROM PROVEEDORES WHERE CVEPROV=@CVEPROV)=0
		--PRINT 'ESTA CLAVE DE PROVEEDOR NO EXISTE'
		SET @BAN=2
	ELSE 
		IF (SELECT ACTIVO FROM PROVEEDORES WHERE CVEPROV=@CVEPROV)=0
			--PRINT 'ESTE PROVEEDOR YA HA SIDO DADO DE BAJA TEMPORALMENTE'
			SET @BAN = 3
			else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL PROVEEDOR NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
		ELSE
			BEGIN 
				BEGIN TRAN
					UPDATE PROVEEDORES SET ACTIVO = 0 WHERE CVEPROV=@CVEPROV
					UPDATE FarmSAntonio.DBO.PROVEEDORES  SET ACTIVO = 0 WHERE CVEPROV=@CVEPROV
				COMMIT TRAN
			END


--------------------------------------------------------
--			REACTIVACION DE PROVEEDORES
--------------------------------------------------------
SELECT * FROM PROVEEDORES

USE FarmSAntonio
USE FarmSAntonioCompras

DROP PROC REACTPROV
REACTPROV 1

CREATE PROC REACTPROV
@CVEPROV INT
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEPROV='' OR @CVEPROV=0
	--PRINT 'LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA'
	SET @BAN = 1
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE 
	IF(SELECT COUNT(*) FROM PROVEEDORES WHERE CVEPROV=@CVEPROV AND ACTIVO = 0)=1
		BEGIN 
			BEGIN TRAN
				UPDATE PROVEEDORES SET ACTIVO = 1 WHERE CVEPROV=@CVEPROV
				UPDATE FarmSAntonio.DBO.PROVEEDORES  SET ACTIVO = 1 WHERE CVEPROV=@CVEPROV
			COMMIT TRAN
		END
	ELSE
		--PRINT 'EL PROVEEDOR NO SE ENCUENTRA DADO DE BAJA O ES INEXISTENTE'
		SET @BAN = 2
--------------------------------------------------------
--			BAJA DETALLE COM-MED
--------------------------------------------------------
SELECT * FROM DETCOMMED

USE FarmSAntonio
USE FarmSAntonioCompras

BAJADETCOMMED 1, 4000

DROP PROC BAJADETCOMMED
CREATE PROC BAJADETCOMMED
@CVECOMP INT
,@CVEMED INT
,@clave int 
,@BAN INT OUTPUT
AS
DECLARE @CANTCOMPM INT
if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
 IF (SELECT COUNT(*) FROM DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED)>0
	BEGIN 
		SET @CANTCOMPM=(SELECT CANTCOMPM FROM DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED)
		IF(SELECT EXISTENCIASM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)>=@CANTCOMPM
			BEGIN 
				BEGIN TRAN 
					UPDATE MEDICAMENTOS SET EXISTENCIASM=EXISTENCIASM-@CANTCOMPM WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonio.DBO.MEDICAMENTOS SET EXISTENCIASM=EXISTENCIASM-@CANTCOMPM WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS SET EXISTENCIASM=EXISTENCIASM-@CANTCOMPM WHERE CVEMED=@CVEMED
					UPDATE COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPM* (SELECT PRECIOCOMPM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED))
					WHERE CVECOMP=@CVECOMP
					UPDATE FarmSAntonio.DBO.COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPM* (SELECT PRECIOCOMPM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED))
					WHERE CVECOMP=@CVECOMP
					DECLARE @CVECAD INT, @FECHACAD DATE
					SET @CVECAD = (SELECT CVECAD FROM CADUCIDAD WHERE FECHACAD = (SELECT CADM FROM DETCOMMED WHERE CVECOMP = @CVECOMP AND CVEMED = @CVEMED))
					SET @FECHACAD = (SELECT CADM FROM DETCOMMED WHERE CVECOMP = @CVECOMP AND CVEMED = @CVEMED)
					DELETE DETCADMED WHERE CVECAD = @CVECAD AND CVEMED = @CVEMED --AQUI SE ELIMINAN LOS DETALLES (EN ESTE PROCEDIENTO DE MED, PUES LOS DETCADMED)
					DELETE FarmSAntonio.DBO.DETCADMED WHERE CVECAD = @CVECAD AND CVEMED = @CVEMED
					EXECUTE BAJACADU @CVECAD, @FECHACAD --ENTONCES AHORA BAJA LA CADUCIDAD EN CASO DE NO HABER OTRAS RELACIONES
					DELETE DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED
					DELETE FarmSAntonio.DBO.DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EXISTENCIAS INSUFICIENTES'
			SET @BAN=1
	END
ELSE 
	--PRINT 'ESE DETALLE NO EXISTE'
	SET @BAN=2
RETURN 
--------------------------------------------------------
--			BAJA CADUCIDAD
--------------------------------------------------------
SELECT * FROM DETCOMMED
SELECT * FROM CADUCIDAD
SELECT * FROM DETCADMED
DROP PROC BAJACADU

CREATE PROC BAJACADU
@CVECAD INT
,@FECHACAD DATE
,@clave int
,@ban int output
AS
if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
IF (SELECT COUNT(*) FROM CADUCIDAD WHERE CVECAD = @CVECAD AND FECHACAD = @FECHACAD) > 0 --AQUI PRIMERO REVISA QUE EXISTA LA CADUCIDAD

	IF ( (SELECT COUNT(*) FROM DETCADMED WHERE CVECAD = @CVECAD) = 0) AND ((SELECT COUNT(*) FROM DETCADPRO WHERE CVECAD = @CVECAD) = 0) --AQUI YA SOLO VENDRIA A BORRAR EN CASO DE QUE YA NO HAYA NADA
		BEGIN 
			BEGIN TRAN 
				DELETE CADUCIDAD WHERE CVECAD = @CVECAD AND FECHACAD = @FECHACAD
				DELETE FarmSAntonio.DBO.CADUCIDAD WHERE CVECAD=@CVECAD AND FECHACAD=@FECHACAD   --BORRANDO ASÍ SOLO SI YA NO EXISTEN RELACIONES
			COMMIT TRAN
		
		/*BEGIN       ESTO YA NO TIENE SENTIDO
			BEGIN TRAN 
				DELETE DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEMP
				DELETE FarmSAntonioCompras.DBO.DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEMP
			COMMIT TRAN
		BEGIN 
			BEGIN TRAN 
				DELETE DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMP
				DELETE FarmSAntonioCompras.DBO.DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMP
			COMMIT TRAN
		END*/
		END
RETURN
--------------------------------------------------------
--			BAJA DETALLE COM-PRO
--------------------------------------------------------
CREATE PROC BAJADETCOMPRO
@CVECOMP INT,
@CVEPROD INT,
@clave int, 
@BAN INT OUTPUT
AS 
DECLARE @CANTCOMPP INT
if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
IF (SELECT COUNT(*) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD)>0
	BEGIN 
		SET @CANTCOMPP=(SELECT CANTCOMP FROM DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD)
		IF(SELECT EXISTENCIASP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)>=@CANTCOMPP --SI HAY EXISTENCIAS
			BEGIN 
				BEGIN TRAN 
					UPDATE PRODUCTOS SET EXISTENCIASP=EXISTENCIASP-@CANTCOMPP WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonio.DBO.PRODUCTOS SET EXISTENCIASP=EXISTENCIASP-@CANTCOMPP WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonioVentas.DBO.PRODUCTOS SET EXISTENCIASP=EXISTENCIASP-@CANTCOMPP WHERE CVEPROD=@CVEPROD
					UPDATE COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPP * (SELECT PRECIOCOMP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD))
					WHERE CVECOMP=@CVECOMP
					UPDATE FarmSAntonio.DBO.COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPP * (SELECT PRECIOCOMP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD))
					WHERE CVECOMP=@CVECOMP
					DECLARE @CVECAD INT, @FECHACAD DATE
					SET @CVECAD = (SELECT CVECAD FROM CADUCIDAD WHERE FECHACAD = (SELECT CAD FROM DETCOMPRO WHERE CVECOMP = @CVECOMP AND CVEPROD = @CVEPROD))
					SET @FECHACAD = (SELECT CAD FROM DETCOMPRO WHERE CVECOMP = @CVECOMP AND CVEPROD = @CVEPROD)
					DELETE DETCADPRO WHERE CVECAD = @CVECAD AND CVEPROD = @CVEPROD
					DELETE FarmSAntonio.DBO.DETCADPRO WHERE CVECAD = @CVECAD AND CVEPROD = @CVEPROD
					EXECUTE BAJACADU  @CVECAD, @FECHACAD
					DELETE DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD
					DELETE FarmSAntonio.DBO.DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EXISTENCIAS INSUFICIENTES'
			SET @BAN=3
	END
ELSE 
	--PRINT 'ESE DETALLE NO EXISTE bara'
	SET @BAN=4
RETURN 
--------------------------------------------------------
--			BAJA COMPRAS
--------------------------------------------------------
SELECT * FROM COMPRAS
SELECT * FROM DETCOMMED
SELECT * FROM MEDICAMENTOS
SELECT * FROM DETCADMED
SELECT * FROM CADUCIDAD
SELECT * FROM DETCADPRO
SELECT * FROM PRODUCTOS
SELECT * FROM DETCOMPRO
BAJACOMPRAS 1

CREATE PROC BAJACOMPRAS
@CVECOMP INT
,@clave2 int 
,@BAN INT OUTPUT
AS
IF @CVECOMP='' OR @CVECOMP=0
	--PRINT 'LA CLAVE DE LA COMPRA NO PUEDE ESTAR VACIA'
	SET @BAN = 7
else if(@clave2 = '' or @clave2 = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave2)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave2 and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52

DECLARE @CUANTOSM INT,@CUANTOSP INT, @CLAVE INT

IF ((SELECT COUNT(*) FROM DETCOMMED WHERE CVECOMP=@CVECOMP)>0 OR (SELECT COUNT(*) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP)>0)  -- CAMBIAMOS POR OR PARA QUE TODO SE HAGA AQUÍ MISMO
	BEGIN 

		SET @CUANTOSM=(SELECT COUNT(*) FROM DETCOMMED WHERE CVECOMP=@CVECOMP) --REVISA MEDICAMENTOS Y PRODUCTOS DISTINTOS
		SET @CUANTOSP=(SELECT COUNT(*) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP)

		IF @CUANTOSP>0
			BEGIN
				WHILE @CUANTOSP>0
					BEGIN 
						SET @CLAVE=(SELECT MAX(CVEPROD) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP) --ELIMINA UNO A UNO CADA PRODUCTO DEL DETALLE
						EXEC BAJADETCOMPRO @CVECOMP, @CLAVE,@clave2, @BAN
						IF (SELECT MAX(CVEPROD) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP)=@CLAVE
							SET @CUANTOSP=0
						ELSE
							SET @CUANTOSP=@CUANTOSP-1
					END 
			END
				
		IF @CUANTOSM>0
			BEGIN
				WHILE @CUANTOSM>0
					BEGIN 
						SET @CLAVE=(SELECT MAX(CVEMED) FROM DETCOMMED WHERE CVECOMP=@CVECOMP)
						EXEC BAJADETCOMMED @CVECOMP, @CLAVE, @clave2, @BAN
						IF (SELECT MAX(CVEMED) FROM DETCOMMED WHERE CVECOMP=@CVECOMP)=@CLAVE
							SET @CUANTOSM=0
						ELSE
							SET @CUANTOSM=@CUANTOSM-1
					END 
			END

		IF((SELECT COUNT(*) FROM DETCOMMED WHERE CVECOMP=@CVECOMP)=0 AND (SELECT COUNT(*) FROM DETCOMPRO WHERE CVECOMP=@CVECOMP)=0 ) --AQUI SE REVISA SI YA NO QUEDA NADA (Y LO BORRA)
			BEGIN
				BEGIN TRAN 
				/*ESTO YA SE HIZO ARRIVA
					DELETE DETCOMMED WHERE CVECOMP=@CVECOMP
					DELETE DETCOMPRO WHERE CVECOMP=@CVECOMP
					DELETE FarmSAntonio.DBO.DETCOMMED WHERE CVECOMP=@CVECOMP
					DELETE FarmSAntonio.DBO.DETCOMPRO WHERE CVECOMP=@CVECOMP
				*/
					DELETE DETCOMPRV WHERE CVECOMP = @CVECOMP
					DELETE FarmSAntonio.DBO.DETCOMPRV WHERE CVECOMP = @CVECOMP
					DELETE COMPRAS WHERE CVECOMP=@CVECOMP
					DELETE FarmSAntonio.DBO.COMPRAS WHERE CVECOMP=@CVECOMP
				COMMIT TRAN
			END 
		ELSE 
	--PRINT 'DETALLES EXISTENTES'
		SET @BAN=8
	END
ELSE
	BEGIN
		BEGIN TRAN 
			DELETE DETCOMPRV WHERE CVECOMP = @CVECOMP
			DELETE FarmSAntonio.DBO.DETCOMPRV WHERE CVECOMP = @CVECOMP
			DELETE COMPRAS WHERE CVECOMP=@CVECOMP
			DELETE FarmSAntonio.DBO.COMPRAS WHERE CVECOMP=@CVECOMP
		COMMIT TRAN
	END 

--------------------------------------------------------
--			BAJA MEDICAMENTOS
--------------------------------------------------------
SELECT * FROM MEDICAMENTOS
BAJAMED 4000
CREATE PROC BAJAMED
@CVEMED INT
,@clave int
,@BAN INT OUTPUT
AS

IF @CVEMED='' OR @CVEMED=0
	--PRINT 'LA CLAVE DEL MEDICAENTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
	IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=1
		IF (SELECT  COUNT (*) FROM DETCOMMED WHERE CVEMED=@CVEMED)=0
			IF (SELECT COUNT (*) FROM FarmSAntonioVentas.dbo.DETVTAMED WHERE CVEMED=@CVEMED)=0
				IF (SELECT  COUNT (*) FROM DETCADMED WHERE CVEMED=@CVEMED)=0
					IF (SELECT EXISTENCIASM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED) = 0
						BEGIN
							BEGIN TRAN
								DELETE FROM MEDICAMENTOS WHERE CVEMED=@CVEMED
								DELETE FROM FarmSAntonio.DBO.MEDICAMENTOS WHERE CVEMED=@CVEMED
								DELETE FROM FarmSAntonioVentas.DBO.MEDICAMENTOS WHERE CVEMED=@CVEMED
							COMMIT TRAN
						END
					ELSE 
						--PRINT 'HAY EXISTENCIAS DENTRO DEL MEDICAMENTO, NO SE PUEDE DAR DE BAJA'
						SET @BAN=2
				ELSE
					--PRINT 'EL MEDICAMENTO TIENE UNA CADUCIDAD ASIGNADA'
					SET @BAN=3
			ELSE
				--PRINT  'EL MEDICAMENTO TIENE UNA VENTA ASIGNADA'
				SET @BAN=4
		ELSE
			--PRINT 'EL MEDICAMENTO TIENE UNA COMPRA ASIGNADA'
			SET @BAN=5
	ELSE
		--PRINT 'LA CLAVE DEL MEDICAMENTO NO EXISTE'
		SET @BAN=6


--------------------------------------------------------
--			BAJA TEMPORAL DE MEDICAMENTOS
--------------------------------------------------------
SELECT * FROM MEDICAMENTOS
BAJAMEDTEMP 1000, 1,0
CREATE  PROC BAJAMEDTEMP
@CVEMED INT
,@clave int
,@BAN INT OUTPUT
AS

IF @CVEMED='' OR @CVEMED=0
	--PRINT 'LA CLAVE DEL MEDICAENTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT(*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0
	--PRINT 'LA CLAVE DEL MEDICAMENTO NO EXISTE'
	SET @BAN = 2
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
begin
	IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED AND ESTADO=1)=1
		IF (SELECT EXISTENCIASM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED) = 0
			BEGIN
				BEGIN TRAN
					UPDATE MEDICAMENTOS SET ESTADO=0 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonio.DBO.MEDICAMENTOS SET ESTADO=0 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS SET ESTADO=0 WHERE CVEMED=@CVEMED
				COMMIT TRAN
			END
		ELSE
		--PRINT 'HAY EXISTENCIAS DENTRO DEL MEDICAMENTO, NO SE PUEDE DAR DE BAJA'
			SET @BAN=3

		ELSE 
			--PRINT 'EL MEDICAMENTO NO SE ENCUENTRA DADO DE ALTA '
			SET @BAN=4
END
--------------------------------------------------------
--			REACTIVACION DE MEDICAMENTOS
--------------------------------------------------------
SELECT * FROM MEDICAMENTOS
REACTMED 4000
CREATE PROC REACTMED
@CVEMED INT,
@clave int,
@BAN INT OUTPUT
AS

IF @CVEMED='' OR @CVEMED=0
	--PRINT 'LA CLAVE DEL MEDICAENTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
begin
	IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=1
		IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED AND ESTADO=0)=1
			BEGIN
				BEGIN TRAN
					UPDATE MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonio.DBO.MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EL MEDICAMENTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE'
			SET @BAN=2
	ELSE 
		--PRINT 'EL MEDICAMENTO NO EXISTE'
		SET @BAN=3
END
--------------------------------------------------------
--			BAJA PRODUCTOS
--------------------------------------------------------
SELECT * FROM PRODUCTOS
BAJPROD 2,1,0
CREATE PROC BAJPROD
@CVEPROD INT
,@clave int
,@BAN INT OUTPUT
AS

IF @CVEPROD='' OR @CVEPROD=0
	--PRINT 'LA CLAVE DEL PRODUCTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
begin
	IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=1
		IF (SELECT  COUNT (*) FROM DETCOMPRO WHERE CVEPROD=@CVEPROD)=0
			IF (SELECT COUNT (*) FROM FarmSAntonioVentas.DBO.DETVTAPRO WHERE CVEPROD=@CVEPROD)=0
				IF (SELECT  COUNT (*) FROM DETCADPRO WHERE CVEPROD=CVEPROD)=0
					IF (SELECT EXISTENCIASP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD) = 0
						BEGIN
							BEGIN TRAN
								DELETE FROM PRODUCTOS WHERE CVEPROD=@CVEPROD
								DELETE FROM FarmSAntonio.DBO.PRODUCTOS WHERE CVEPROD=@CVEPROD
								DELETE FROM FarmSAntonioVentas.DBO.PRODUCTOS WHERE CVEPROD=@CVEPROD
							COMMIT TRAN
						END
					ELSE
						--PRINT 'HAY EXISTENCIAS DENTRO DEL PRODUCTO, NO SE PUEDE DAR DE BAJA'
						SET @BAN=2
				ELSE 
					--PRINT 'EL PRODUCTO TIENE UNA CADUCIDAD ASIGNADA'
					SET @BAN=3
			ELSE
				--PRINT  'EL PRODUCTO TIENE UNA VENTA ASIGNADA'
				SET @BAN=4
		ELSE
			--PRINT 'EL PRODUCTO TIENE UNA COMPRA ASIGNADA'
			SET @BAN=5
	ELSE
		--PRINT 'LA CLAVE DEL PRODUCTO NO EXISTE'
		SET @BAN=6
END
--------------------------------------------------------
--			BAJA TEMPORAL DE PRODUCTOS
--------------------------------------------------------
SELECT * FROM PRODUCTOS
BAJAPRODTEMP 2


CREATE PROC BAJAPRODTEMP
@CVEPROD INT
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEPROD='' OR @CVEPROD=0
	--PRINT 'LA CLAVE DEL PRODUCTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT(*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=0
	--PRINT 'LA CLAVE DEL PRODUCTO NO EXISTE'
	SET @BAN = 2
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
	IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD AND ESTADO=1)=1
		IF (SELECT EXISTENCIASP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD) = 0
			BEGIN
				BEGIN TRAN
					UPDATE PRODUCTOS SET ESTADO=0 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonio.DBO.PRODUCTOS SET ESTADO=0 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonioVentas.DBO.PRODUCTOS SET ESTADO=0 WHERE CVEPROD=@CVEPROD
				COMMIT TRAN
			END
		ELSE
			--PRINT 'HAY EXISTENCIAS DENTRO DEL PRODUCTO, NO SE PUEDE DAR DE BAJA'
			sET @BAN=3
		ELSE 
			--PRINT 'EL PRODUCTO NO SE ENCUENTRA DADO DE ALTA '
			SET @BAN=4
--------------------------------------------------------
--			REACTIVACION DE PRODUCTOS
--------------------------------------------------------
SELECT * FROM PRODUCTOS
REACTPROD 2

CREATE PROC REACTPROD
@CVEPROD INT
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEPROD='' OR @CVEPROD=0
	--PRINT 'LA CLAVE DEL PRODUCTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT(*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=0
	--PRINT 'LA CLAVE DEL PRODUCTO NO EXISTE'
	SET @BAN = 2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
	IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=1
		IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD AND ESTADO=0)=1
			BEGIN
				BEGIN TRAN
					UPDATE PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonio.DBO.PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonioVentas.DBO.PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EL PRODUCTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE'
			SET @BAN=3
	ELSE 
		--PRINT 'EL PRODUCTO NO SE ENCUENTRA DADO DE ALTA '
		SET @BAN=4

---
---PROCEDIMINETOS ALMACENADOS MODIFICACIONES
---
--------------------------------------------------------
--			MODIFICACION A PROVEEDORES 
--------------------------------------------------------
SELECT * FROM PROVEEDORES
USE FarmSAntonio
USE FarmSAntonioCompras

MODPROV 1,'JULIAN DE ASIS','LICONSA','PINO ST 12','PASEO DE LA REFORMA 230','3531001065','MICHOACAN','59050','SAHUAYO','juan@mamon.com',1,0

CREATE PROC MODPROV
@CVEPROV INT,
@NOMPROV VARCHAR(50),
@EMPRESA VARCHAR(30),
@DIRPROV VARCHAR(50),
@DIREMPRESA VARCHAR(50),
@TELPROV VARCHAR(15),
@ESTADO VARCHAR(20),
@CODIGOP VARCHAR(8),
@LOCALIDAD VARCHAR(30),
@CORREOPROV VARCHAR(30),
@clave int,
@BAN INT OUTPUT
AS
IF @CVEPROV='' OR @CVEPROV=0
	--PRINT 'LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA'
	SET @BAN = 1
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
	IF (SELECT COUNT(*) FROM PROVEEDORES WHERE CVEPROV=@CVEPROV)=1
		BEGIN 
			BEGIN TRAN
				UPDATE PROVEEDORES SET 
				NOMPROV = @NOMPROV,
				EMPRESA = @EMPRESA,
				DIRPROV = @DIRPROV,
				DIREMPSA = @DIREMPRESA,
				TELPROV = @TELPROV,
				ESTADO = @ESTADO,
				CODIGOP = @CODIGOP,
				LOCALIDAD = @LOCALIDAD,
				CORREOPROV = @CORREOPROV
				WHERE CVEPROV = @CVEPROV

				UPDATE FarmSAntonio.dbo.PROVEEDORES SET 
				NOMPROV = @NOMPROV,
				EMPRESA = @EMPRESA,
				DIRPROV = @DIRPROV,
				DIREMPSA = @DIREMPRESA,
				TELPROV = @TELPROV,
				ESTADO = @ESTADO,
				CODIGOP = @CODIGOP,
				LOCALIDAD = @LOCALIDAD,
				CORREOPROV = @CORREOPROV
				WHERE CVEPROV = @CVEPROV
			COMMIT TRAN
		END
	ELSE 
		--PRINT 'EL PROVEEDOR ES INEXISTENTE'
		SET @BAN = 2

--------------------------------------------------------
--			MODIFICACION DE  LA FECHA DE LA CADUCIDAD
--------------------------------------------------------
SELECT * FROM CADUCIDAD
USE FarmSAntonio
USE FarmSAntonioCompras

MODFCAD 1,'2021-12-02'

CREATE PROC MODFCAD
@CVECAD INT
,@FECHAN DATE
,@clave int 
,@BAN INT OUTPUT
AS

IF @CVECAD='' OR @CVECAD=0
	--PRINT 'LA CVE DE LA CADUCIDAD ESTA VACIA'
	SET @BAN=1
ELSE IF @FECHAN=''
	--PRINT 'LA FECHA NO DEBE DE ESTAR VACIA'
	SET @BAN=2
ELSE IF @FECHAN < GETDATE ()
	--PRINT 'LA FECHA INGRESADA ES MENOR A LA FECHA ACTUAL'
	SET @BAN=3
	else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE
BEGIN
IF (SELECT COUNT (*) FROM CADUCIDAD WHERE CVECAD=@CVECAD)=1
	IF ((SELECT COUNT (CVECAD) FROM DETCADMED WHERE CVECAD=@CVECAD)>0 OR (SELECT COUNT (CVECAD) FROM DETCADPRO WHERE CVECAD=@CVECAD)>0)
		--PRINT 'RELACIONES ENCONTRADAS CON LA CADUCIDAD, NO SE PUEDE MODIFICAR'
		SET @BAN=4
	ELSE 
		BEGIN
			BEGIN TRAN
			UPDATE CADUCIDAD SET FECHACAD = @FECHAN WHERE CVECAD=@CVECAD--ACTUAL
			UPDATE FarmSAntonio.dbo.CADUCIDAD SET FECHACAD = @FECHAN WHERE CVECAD=@CVECAD--ACTUAL 
			COMMIT TRAN
		END
ELSE
	--PRINT 'LA FECHA DE CADUCIDAD NO EXISTE'
	SET @BAN=5
END
--------------------------------------------------------
--			MODIFICACION DE MEDICAMENTOS
--------------------------------------------------------
SELECT * FROM MEDICAMENTOS
USE FarmSAntonio
USE FarmSAntonioCompras

MODDESMED 4001,'Pastilloso'
CREATE PROC MODDESMED
@CVEMED INT
,@DESCN VARCHAR (60)
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEMED=0 OR @CVEMED=''
	--PRINT 'LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @DESCN=''
	--PRINT 'LA DESCRPICION NO PUEDE ESTAR VACIA'
	SET @BAN=2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE 
BEGIN

IF (SELECT COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=1
	BEGIN
	BEGIN TRAN
	UPDATE MEDICAMENTOS SET DESCRIPCIONM=@DESCN WHERE CVEMED=@CVEMED --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.MEDICAMENTOS SET DESCRIPCIONM=@DESCN WHERE CVEMED=@CVEMED --FRAG VENTAS
	UPDATE FarmSAntonio.dbo.MEDICAMENTOS SET DESCRIPCIONM=@DESCN WHERE CVEMED=@CVEMED --ORIGINAL
	COMMIT TRAN
	END
ELSE
	--PRINT 'ESTE MEDICAMENTO NO EXISTE'
	SET @BAN=3
END

//////****////////////////////
select * from empleados
select * from usuarios
MODNOMMED 4001,'SESIITBXP',1,0

CREATE PROC MODNOMMED
@CVEMED INT
,@NOMEDN VARCHAR (30)
,@clave int
,@BAN INT OuTPUT
AS

IF @CVEMED=0 OR @CVEMED=''
	--PRINT 'LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
IF @NOMEDN=''
	--PRINT 'EL NOMBRE DEL MEDICAMENTO NO PUEDE ESTAR VACIO'
	SET @BAN=2
IF(SELECT COUNT (NOMED)  FROM MEDICAMENTOS WHERE NOMED=@NOMEDN)>0
	--PRINT 'ESTE NOMBRE YA SE ENCUENTRA REGISTRADO'
	SET @BAN=3
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52

IF (SELECT COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=1
	BEGIN
		BEGIN TRAN
			UPDATE MEDICAMENTOS SET NOMED=@NOMEDN WHERE CVEMED=@CVEMED --ACTUAL
			UPDATE FarmSAntonioVentas.dbo.MEDICAMENTOS SET NOMED=@NOMEDN WHERE CVEMED=@CVEMED --ORIGINAL
			UPDATE FarmSAntonio.dbo.MEDICAMENTOS SET NOMED=@NOMEDN WHERE CVEMED=@CVEMED --VENTAS
		COMMIT TRAN
	END
ELSE
	--PRINT 'ESTE MEDICAMENTO NO EXISTE'
	SET @BAN=4


--------------------------------------------------------
--			MODIFICACION DE PRODUCTOS
--------------------------------------------------------
SELECT * FROM PRODUCTOS
USE FarmSAntonio
USE FarmSAntonioCompras
MODDESPROD 2,'ANAL'

CREATE PROC MODDESPROD
@CVEPROD INT
,@DESPN VARCHAR (60)
,@clave int 
,@BAN INT OUTPUT
AS
IF @CVEPROD=0 OR @CVEPROD=''
	--PRINT 'LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @DESPN=''
	--PRINT 'LA DESCRPICION NO PUEDE ESTAR VACIA'
	SET @BAN=2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE 
BEGIN
IF (SELECT COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=1
	BEGIN
	BEGIN TRAN
	UPDATE PRODUCTOS SET DESCRIP=@DESPN WHERE CVEPROD=@CVEPROD --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.PRODUCTOS SET DESCRIP=@DESPN WHERE CVEPROD=@CVEPROD --FRAG VENTAS
	UPDATE FarmSAntonio.dbo.PRODUCTOS SET DESCRIP=@DESPN WHERE @CVEPROD=@CVEPROD --ORIGINAL
	COMMIT TRAN
	END
ELSE
	--PRINT 'ESTE PRODUCTO NO SE ENCUENTRA REGISTRADO EN LA BD'
	SET @BAN=3
END


MODNOMPROD 2,'ludacrest',1,0
CREATE PROC MODNOMPROD
@CVEPROD INT
,@NOMPRON VARCHAR (30)
,@clave int 
,@BAN INT OUTPUT
AS
IF @CVEPROD=0 OR @CVEPROD=''
	--PRINT 'LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @NOMPRON=''
	--PRINT 'EL NOMBRE DEL PRODUCTO NO PUEDE ESTAR VACIO'
	SET @BAN=2
ELSE IF(SELECT COUNT (NOMP)  FROM PRODUCTOS WHERE NOMP=@NOMPRON)>0
	--PRINT 'ESTE NOMBRE YA SE ENCUENTRA REGISTRADO'
	SET @BAN=3
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
	ELSE 
BEGIN

IF (SELECT COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=1
	BEGIN
	BEGIN TRAN
	UPDATE PRODUCTOS SET NOMP=@NOMPRON WHERE CVEPROD=@CVEPROD --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.PRODUCTOS SET NOMP=@NOMPRON WHERE CVEPROD=@CVEPROD --ORIGINAL
	UPDATE FarmSAntonio.dbo.PRODUCTOS SET NOMP=@NOMPRON WHERE @CVEPROD=@CVEPROD --VENTAS
	COMMIT TRAN
	END
ELSE
	--PRINT 'ESTE PRODUCTO NO EXISTE'
	SET @BAN=4
END

--------------------------------------------------------
--			MODIFICACION DE GANANCIA EN MEDICAMENTOS
--------------------------------------------------------
SELECT * FROM DETCOMMED
USE FarmSAntonioCompras
USE FarmSAntonio
USE FarmSAntonioVentas
MODGANANCIAMED 4000, 1.2,1,0

CREATE PROC MODGANANCIAMED
@CVEMED INT,
@GANANCIA MONEY
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEMED=0 OR @CVEMED=''
	--PRINT 'LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @GANANCIA = '' OR @GANANCIA < 1.1
	--PRINT 'LA GANANCIA ESTA VACIA O ES INFERIOR A 1.1'
	SET @BAN=2
ELSE IF (SELECT COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0
	--PRINT 'LA CVE DEL MEDICAMENTO NO EXISTE'
	SET @BAN=3
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE  BEGIN IF (SELECT COUNT(*) FROM DETCOMMED WHERE CVEMED=@CVEMED)>0
	BEGIN
		BEGIN TRAN
			UPDATE DETCOMMED SET GANANCIAM=@GANANCIA WHERE CVEMED=@CVEMED --ACTUAL
			UPDATE MEDICAMENTOS SET PRECIOVTAM=(PRECIOCOMPM*(SELECT GANANCIAM FROM DETCOMMED WHERE CVEMED = @CVEMED)) WHERE CVEMED = @CVEMED
		COMMIT TRAN
		BEGIN TRAN
			UPDATE FarmSAntonio.dbo.DETCOMMED SET GANANCIAM=@GANANCIA WHERE CVEMED=@CVEMED --ORIGINAL
			UPDATE FarmSAntonio.dbo.MEDICAMENTOS SET PRECIOVTAM=(PRECIOCOMPM*(SELECT GANANCIAM FROM DETCOMMED WHERE CVEMED = @CVEMED)) WHERE CVEMED = @CVEMED
		COMMIT TRAN
		BEGIN TRAN
			UPDATE FarmSAntonioVentas.dbo.MEDICAMENTOS SET PRECIOVTAM = (SELECT PRECIOVTAM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED) WHERE CVEMED = @CVEMED
		COMMIT TRAN
	END ELSE 	
	--PRINT 'MEDICAMENTO INEXISTENTE'
	set @ban=4
	END

--------------------------------------------------------
--			MODIFICACION DE GANANCIA EN PRODUCTOS
--------------------------------------------------------
SELECT * FROM DETCOMMED
USE FarmSAntonioCompras
USE FarmSAntonio
USE FarmSAntonioVentas
MODGANANCIAPROD 1, 1.8,1,0

CREATE PROC MODGANANCIAPROD
@CVEPROD INT
,@GANANCIA MONEY
,@clave int 
,@BAN INT OUTPUT
AS

IF @CVEPROD=0 OR @CVEPROD=''
	--PRINT 'LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @GANANCIA = '' OR @GANANCIA < 1.1
	--PRINT 'LA GANANCIA ESTA VACIA O ES INFERIOR A 1.1'
	SET @BAN=2
ELSE IF (SELECT COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=0
	--PRINT 'LA CVE DEL PRODUCTO NO EXISTE'
	SET @BAN=3
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE BEGIN IF (SELECT COUNT(*) FROM DETCOMPRO WHERE CVEPROD=@CVEPROD)>0
	BEGIN
		BEGIN TRAN
			UPDATE DETCOMPRO SET GANANCIAP=@GANANCIA WHERE CVEPROD=@CVEPROD --ACTUAL
			UPDATE PRODUCTOS SET PRECIOVTAP=(PRECIOCOMP*(SELECT GANANCIAP FROM DETCOMPRO WHERE CVEPROD = @CVEPROD)) WHERE CVEPROD = @CVEPROD
		COMMIT TRAN
		BEGIN TRAN
			UPDATE FarmSAntonio.dbo.DETCOMPRO SET GANANCIAP=@GANANCIA WHERE CVEPROD=@CVEPROD --COMPRAS
			UPDATE FarmSAntonio.dbo.PRODUCTOS SET PRECIOVTAP=(PRECIOCOMP*(SELECT GANANCIAP FROM DETCOMPRO WHERE CVEPROD = @CVEPROD)) WHERE CVEPROD = @CVEPROD
		COMMIT TRAN
		BEGIN TRAN
			UPDATE FarmSAntonioVentas.dbo.PRODUCTOS SET PRECIOVTAP = (SELECT PRECIOVTAP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD) WHERE CVEPROD=@CVEPROD
		COMMIT TRAN
	END
ELSE
	--PRINT 'PRODUCTO INEXISTENTE'
	set @ban=4
END


/*ACTUALIZACION DEL 5 DE MAYO */
/**/
CREATE PROC SESIONINI
@clave int 
,@ban int output
as 
DECLARE @CVEMP INT,
@DEPTO VARCHAR (10)
	If(@clave = '' or @clave = 0)
		--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
		set @ban = 50
	else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
		--print 'EL USUARIO NO EXISTE'
		set @ban = 51
	else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
		BEGIN print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
		set @ban = 52
END

