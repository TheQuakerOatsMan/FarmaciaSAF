﻿/*+++++++++++++++++++++++ FARMACIA SAN ANTONIO COMPLETO +++++++++++++++++++++++++++++++++++++++++++++++*/
/*INTEGRANTES DEL EQUIPO:
--**CEJA RENETRIA ADRIAN --FRAGMENTO DE COMPRAS
--**MENDIOLA CORREA CESR PAULINO --FRAGMENTO DE VENTAS*/

CREATE DATABASE FarmSAntonio
USE FarmSAntonioCompras
DROP DATABASE FarmSAntonio
--------------------------------------------------------
		--FRAGMENTO DE VENTAS
--------------------------------------------------------
CREATE TABLE EMPLEADOS (
	CVEMP INT PRIMARY KEY
	,NOMEMP VARCHAR(50) NOT NULL
	,DIREMP VARCHAR(20) NOT NULL
	,CORREOEMP VARCHAR(30) NOT NULL
	,TELEMP VARCHAR(15) NOT NULL
	,EDADEMP INT CHECK (EDADEMP LIKE '[1-6][0-9]') NOT NULL
	/*actualizacion del 03 de mayo 2020 se modifico estepedo y se agrego la tabla de usuarios*/
	,PUESTO VARCHAR(30) NOT NULL CHECK (PUESTO='CAJERO(A)' OR PUESTO ='MOSTRADOR' OR PUESTO = 'ENC. DE TIENDA' 
	OR PUESTO='ADMINISTRADOR(A)' OR PUESTO='AUX. CONTABLE' OR PUESTO='CONTADOR(A)')/*asi lo tenia mi ma :,v*/
	,DEPTO VARCHAR (10) NOT NULL check (depto='GERENCIA' or depto='VENTAS' or depto='COMPRAS')
	,ACTIVO INT
	)

CREATE TABLE VENTAS (
	CVEVTA INT PRIMARY KEY
	,SUBTOTAL MONEY DEFAULT(0)
	,IVA MONEY DEFAULT(0)
	,TIPOPAG VARCHAR(20)
	,FECHAVTA DATE DEFAULT(GETDATE())
	)

/*CREACION DE LA TABLA USUARIOS*/
CREATE TABLE USUARIOS (
NUSUARIO VARCHAR (10) UNIQUE NOT NULL,
CONTRASENA varchar (12) unique not null,
TIPODEPTO VARCHAR (1) NOT NULL CHECK (TIPODEPTO='C' OR TIPODEPTO='V' OR TIPODEPTO='G'),
SESION INT DEFAULT 0 NOT NULL,
CVEMP INT FOREIGN KEY REFERENCES EMPLEADOS NOT NULL
)

CREATE TABLE DETVTAEMP (
	CVEVTA INT FOREIGN KEY REFERENCES VENTAS NOT NULL
	,CVEMP INT FOREIGN KEY REFERENCES EMPLEADOS NOT NULL
	,COMISION INT DEFAULT(0)
	)

CREATE TABLE DETVTAMED (
	CVEVTA INT FOREIGN KEY REFERENCES VENTAS NOT NULL
	,CVEMED INT FOREIGN KEY REFERENCES MEDICAMENTOS NOT NULL
	,CANTVM INT NOT NULL
	,PREVENDIDOM MONEY DEFAULT (0)
	,IMGRECT VARCHAR(100) NOT NULL --LA RUTA DE LA IMAGEN ESCANEADA
	)

CREATE TABLE DETVTAPRO (
	CVEVTA INT FOREIGN KEY REFERENCES VENTAS NOT NULL
	,CVEPROD INT FOREIGN KEY REFERENCES PRODUCTOS NOT NULL
	,PREVENDIDOP MONEY DEFAULT (0)
	,CANTVP INT NOT NULL
	)

--------------------------------------------------------
--			FRAGMENTO DE COMPRAS
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

--PROCEDIMENTOS DE ALMACENADO COMPRAS

--**********************************************************************************************************************

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
		INSERT INTO FarmSAntonioCompras.DBO.PROVEEDORES
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
		INSERT INTO FarmSAntonioCompras.DBO.CADUCIDAD (
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
		INSERT INTO FarmSAntonioCompras.DBO.MEDICAMENTOS (
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
		--INSERCION DE PRODUCTOS A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.PRODUCTOS (
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
		--INSERCION DE CVE 
		--------------------------------------------------------
		INSERT INTO COMPRAS (
			CVECOMP
			)
		VALUES (
			@CVECOMP
			)
		--------------------------------------------------------
		--INSERCION DE CVE DE COMPRAS A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.COMPRAS (
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
		--INSERCION DETALLE COMPRA PROV A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.DETCOMPRV (
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
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE AL PRECIO DE VENTA DE MED COMPRADOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE A LA CANTIDAD DE MED COMPRADOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.DETCOMMED
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
			--UPDATE A LAS EXISTENCIAS DE MED A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE TOTAL DE LA COMPRA MED A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
			--UPDATE AL PRECIO DE MEDICAMENTOS COMPRADOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE AL PRECIO DE VENTA MEDICAMENTOS COMPRADOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE ALA CANTIDAD COMPRADOS DE COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.DETCOMMED
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
			--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
			--UPDATE AL TOTAL DE LA COMPRA DE COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
		--INSERCION DETCOMMED A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.DETCOMMED (
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
		--UPDATE AL PRECIO DE COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
		--UPDATE AL PRECIO DE VENTA DE COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
		--UPDATE A LAS EXISTENCIAS DE MEDICAMENTOS DE COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
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
		--UPDATE AL TOTAL DE LA COMPRA DE COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
	--INSERCION DE DETALLE CADUCIDAD A COMPRAS
	--------------------------------------------------------
	INSERT INTO FarmSAntonioCompras.DBO.DETCADMED (
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
			--UPDATE PRECIO DE COMPRA PRODUCTOS (COMPRAS)
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE PRECIO DE VENTA PRODUCTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE CANTIDAD COMPRADA DE PRODUCTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.DETCOMPRO
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
			--UPDATE DE LA EXISTENCIA DE PRODUCTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE TOTAL DE LA COMPRA A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
			--UPDATE PRECIO DE COMPRA A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE PRECIO DE VENTA A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE CANTIDAD DE PROD COMPRADA A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.DETCOMPRO
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
			--UPDATE EXISTENCIAS DE PRODUCTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
			--UPDATE TOTAL DE LA COMPRA A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
		--INSERCION DEL DETCOMPRO A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.DETCOMPRO (
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
		--UPDATE PRECIO DE COMPRA PROD A COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
		--UPDATE PRECIO DE VENTA PROD A COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
		--UPDATE EXISTENCIA DE PROD A COMPRAS
		--------------------------------------------------------
		UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
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
		UPDATE FarmSAntonioCompras.DBO.COMPRAS
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
		--INSERCION DETCADPROD A COMPRAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioCompras.DBO.DETCADPRO (
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
					DELETE FarmSAntonioCompras.DBO.PROVEEDORES WHERE CVEPROV=@CVEPROV
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
					UPDATE FarmSAntonioCompras.DBO.PROVEEDORES  SET ACTIVO = 0 WHERE CVEPROV=@CVEPROV
				COMMIT TRAN
			END


--------------------------------------------------------
--			REACTIVACION DE PROVEEDORES
--------------------------------------------------------
SELECT * FROM PROVEEDORES

USE FarmSAntonio
USE FarmSAntonioCompras

DROP PROC REACTPROV
REACTPROV 1,1,0

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
				UPDATE FarmSAntonioCompras.DBO.PROVEEDORES  SET ACTIVO = 1 WHERE CVEPROV=@CVEPROV
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

BAJADETCOMMED 1, 4000,1,0

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
					UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET EXISTENCIASM=EXISTENCIASM-@CANTCOMPM WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS SET EXISTENCIASM=EXISTENCIASM-@CANTCOMPM WHERE CVEMED=@CVEMED
					UPDATE COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPM* (SELECT PRECIOCOMPM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED))
					WHERE CVECOMP=@CVECOMP
					UPDATE FarmSAntonioCompras.DBO.COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPM* (SELECT PRECIOCOMPM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED))
					WHERE CVECOMP=@CVECOMP
					DECLARE @CVECAD INT, @FECHACAD DATE
					SET @CVECAD = (SELECT CVECAD FROM CADUCIDAD WHERE FECHACAD = (SELECT CADM FROM DETCOMMED WHERE CVECOMP = @CVECOMP AND CVEMED = @CVEMED))
					SET @FECHACAD = (SELECT CADM FROM DETCOMMED WHERE CVECOMP = @CVECOMP AND CVEMED = @CVEMED)
					DELETE DETCADMED WHERE CVECAD = @CVECAD AND CVEMED = @CVEMED --AQUI SE ELIMINAN LOS DETALLES (EN ESTE PROCEDIENTO DE MED, PUES LOS DETCADMED)
					DELETE FarmSAntonioCompras.DBO.DETCADMED WHERE CVECAD = @CVECAD AND CVEMED = @CVEMED
					EXECUTE BAJACADU @CVECAD, @FECHACAD --ENTONCES AHORA BAJA LA CADUCIDAD EN CASO DE NO HABER OTRAS RELACIONES
					DELETE DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED
					DELETE FarmSAntonioCompras.DBO.DETCOMMED WHERE CVECOMP=@CVECOMP AND CVEMED=@CVEMED
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
				DELETE FarmSAntonioCompras.DBO.CADUCIDAD WHERE CVECAD=@CVECAD AND FECHACAD=@FECHACAD   --BORRANDO ASÍ SOLO SI YA NO EXISTEN RELACIONES
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
					UPDATE FarmSAntonioCompras.DBO.PRODUCTOS SET EXISTENCIASP=EXISTENCIASP-@CANTCOMPP WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonioVentas.DBO.PRODUCTOS SET EXISTENCIASP=EXISTENCIASP-@CANTCOMPP WHERE CVEPROD=@CVEPROD
					UPDATE COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPP * (SELECT PRECIOCOMP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD))
					WHERE CVECOMP=@CVECOMP
					UPDATE FarmSAntonioCompras.DBO.COMPRAS SET TOTALCOMP=TOTALCOMP-(@CANTCOMPP * (SELECT PRECIOCOMP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD))
					WHERE CVECOMP=@CVECOMP
					DECLARE @CVECAD INT, @FECHACAD DATE
					SET @CVECAD = (SELECT CVECAD FROM CADUCIDAD WHERE FECHACAD = (SELECT CAD FROM DETCOMPRO WHERE CVECOMP = @CVECOMP AND CVEPROD = @CVEPROD))
					SET @FECHACAD = (SELECT CAD FROM DETCOMPRO WHERE CVECOMP = @CVECOMP AND CVEPROD = @CVEPROD)
					DELETE DETCADPRO WHERE CVECAD = @CVECAD AND CVEPROD = @CVEPROD
					DELETE FarmSAntonioCompras.DBO.DETCADPRO WHERE CVECAD = @CVECAD AND CVEPROD = @CVEPROD
					EXECUTE BAJACADU  @CVECAD, @FECHACAD
					DELETE DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD
					DELETE FarmSAntonioCompras.DBO.DETCOMPRO WHERE CVECOMP=@CVECOMP AND CVEPROD=@CVEPROD
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
BAJACOMPRAS 1,1,0

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
					DELETE FarmSAntonioCompras.DBO.DETCOMPRV WHERE CVECOMP = @CVECOMP
					DELETE COMPRAS WHERE CVECOMP=@CVECOMP
					DELETE FarmSAntonioCompras.DBO.COMPRAS WHERE CVECOMP=@CVECOMP
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
BAJAMED 4000,1,0
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
								DELETE FROM FarmSAntonioCompras.DBO.MEDICAMENTOS WHERE CVEMED=@CVEMED
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
					UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET ESTADO=0 WHERE CVEMED=@CVEMED
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
REACTMED 4000,1,0
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
					UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
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
								DELETE FROM FarmSAntonioCompras.DBO.PRODUCTOS WHERE CVEPROD=@CVEPROD
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
BAJAPRODTEMP 2,1,0


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
					UPDATE FarmSAntonioCompras.DBO.PRODUCTOS SET ESTADO=0 WHERE CVEPROD=@CVEPROD
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
REACTPROD 2,1,0

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
					UPDATE FarmSAntonioCompras.DBO.PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
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

				UPDATE FarmSAntonioCompras.dbo.PROVEEDORES SET 
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

MODFCAD 1,'2021-12-02',1,0

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
			UPDATE FarmSAntonioCompras.dbo.CADUCIDAD SET FECHACAD = @FECHAN WHERE CVECAD=@CVECAD--ACTUAL 
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

MODDESMED 4001,'Pastilloso',1,0
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
	UPDATE FarmSAntonioCompras.dbo.MEDICAMENTOS SET DESCRIPCIONM=@DESCN WHERE CVEMED=@CVEMED --COMPRAS
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
			UPDATE FarmSAntonioCompras.dbo.MEDICAMENTOS SET NOMED=@NOMEDN WHERE CVEMED=@CVEMED --COMPRAS
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
MODDESPROD 2,'ANAL',1,0

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
	UPDATE FarmSAntonioCompras.dbo.PRODUCTOS SET DESCRIP=@DESPN WHERE @CVEPROD=@CVEPROD --COMPRAS
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
	UPDATE FarmSAntonioCompras.dbo.PRODUCTOS SET NOMP=@NOMPRON WHERE @CVEPROD=@CVEPROD --COMPRAS
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
			UPDATE FarmSAntonioCompras.dbo.DETCOMMED SET GANANCIAM=@GANANCIA WHERE CVEMED=@CVEMED --COMPRAS
			UPDATE FarmSAntonioCompras.dbo.MEDICAMENTOS SET PRECIOVTAM=(PRECIOCOMPM*(SELECT GANANCIAM FROM DETCOMMED WHERE CVEMED = @CVEMED)) WHERE CVEMED = @CVEMED
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
			UPDATE FarmSAntonioCompras.dbo.DETCOMPRO SET GANANCIAP=@GANANCIA WHERE CVEPROD=@CVEPROD --COMPRAS
			UPDATE FarmSAntonioCompras.dbo.PRODUCTOS SET PRECIOVTAP=(PRECIOCOMP*(SELECT GANANCIAP FROM DETCOMPRO WHERE CVEPROD = @CVEPROD)) WHERE CVEPROD = @CVEPROD
		COMMIT TRAN
		BEGIN TRAN
			UPDATE FarmSAntonioVentas.dbo.PRODUCTOS SET PRECIOVTAP = (SELECT PRECIOVTAP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD) WHERE CVEPROD=@CVEPROD
		COMMIT TRAN
	END
ELSE
	--PRINT 'PRODUCTO INEXISTENTE'
	set @ban=4
END

/****** FIN DE LOS PROC DE ALMACENADO ****/

/******PROC DE ALMACENADO PARA VENTAS  *********/

/*PROCEDIMIENTOS DE ALMACENADO NUEVOS*/

CREATE PROC ACTIVASESION
@NUSUARIO VARCHAR(10),
@CONTRASENA VARCHAR(10),
@BAN INT OUTPUT

AS

IF @NUSUARIO='' OR @CONTRASENA='' 
	--PRINT'EL USUARIO O LA CONTRASEÑA NO PUEDEN ESTAR VACIOS'
	SET @BAN=1
ELSE
  IF (SELECT COUNT(*)FROM USUARIOS WHERE NUSUARIO=@NUSUARIO AND CONTRASENA=@CONTRASENA)=1
    IF (SELECT COUNT(*)FROM USUARIOS WHERE SESION=1 AND NUSUARIO=@NUSUARIO AND CONTRASENA=@CONTRASENA)=1
	    --PRINT'EL USUARIO TIENE UNA SESIÓN ABIERTA'
	    SET @BAN=2
	ELSE
		BEGIN
			BEGIN TRAN
				UPDATE USUARIOS SET SESION=1 WHERE NUSUARIO=@NUSUARIO AND CONTRASENA=@CONTRASENA
				UPDATE FarmSAntonioVentas.DBO.USUARIOS SET SESION=1 WHERE NUSUARIO=@NUSUARIO AND CONTRASENA=@CONTRASENA
			COMMIT TRAN
		END

  ELSE
    --PRINT'EL USUARIO O LA CONTRASEÑA NO EXISTEN, VERIFICA'
	SET @BAN=3
 

CREATE ALTER PROC FINALIZASESION
@NUSUARIO VARCHAR(10),
@BAN INT OUTPUT

AS

IF @NUSUARIO=''  
	--PRINT'NO PUEDE ESTAR VACIO EL NOMBRE DEL USUARIO'
	SET @BAN=1
ELSE
  IF (SELECT SESION FROM FarmSAntonioVentas.DBO.USUARIOS WHERE NUSUARIO=@NUSUARIO)=1
    BEGIN
	    BEGIN TRAN
			UPDATE FarmSAntonioVentas.DBO.USUARIOS SET SESION=0 WHERE NUSUARIO=@NUSUARIO
			UPDATE FarmSAntonio.DBO.USUARIOS SET SESION=0 WHERE NUSUARIO=@NUSUARIO
		COMMIT TRAN
	END

  ELSE
    --PRINT'EL USUARIO NO EXISTE, VERIFICA'
	SET @BAN=2



CREATE  alter PROC VDEPTO
@USER VARCHAR (10)
,@PASS VARCHAR (12) --LA CONTRA
,@BAN INT OUTPUT
AS
IF @USER = '' OR @PASS =''
	--PRINT 'EL NOMBRE DE USER O CONTRASEÑA NO PUEDE ESTAR VACIA'
	SET @BAN=1
	ELSE
		IF (SELECT COUNT (*) FROM USUARIOS WHERE  NUSUARIO=@USER AND CONTRASENA=@PASS)=1
		IF (SELECT COUNT (*) FROM USUARIOS WHERE NUSUARIO=@USER AND TIPODEPTO = 'G')=1
			--PRINT 'GERENCIA'
			SET @BAN=4
			ELSE IF (SELECT COUNT (*) FROM USUARIOS WHERE NUSUARIO=@USER AND TIPODEPTO = 'V')=1
			--PRINT 'VENTAS'
			SET @BAN=3
			ELSE IF (SELECT COUNT (*) FROM USUARIOS WHERE NUSUARIO=@USER AND TIPODEPTO = 'C')=1
			--PRINT 'COMPRAS'
			SET @BAN=5
			ELSE
			--PRINT 'DEPARTAMENTO NO ESPECIFICADO'
			SET @BAN=6
		ELSE
		--PRINT 'USUARIO O CONTRASEÑA NO VALIDOS, INTENTE DE NUEVO'
		SET @BAN=2

--------------------------------------------------------
--			PROCEDIMIENTOS DE ALMACENADO INSERCION
--------------------------------------------------------
INSEREMP '','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415bd',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',10,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'ADMINISTRADOR(A)','GERENCIA','EL PODER XD','1234',0,0
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)'
INSEREMP 'ESTOI ARMANDO ESTEBAN QUITO','VENECIA#58','ESARESBAQU_1986@hotmail.com','3532101415',32,'CAJERO(A)','VENTAS','ELPODER3','123',0,0
INSEREMP 'RAMIRO GARCIA','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',30,'MOSTRADOR','COMPRAS','ELPODER2','12345',0,0 --CON EL SE HARAN PRUEBAS DE ELIMINARLO
INSEREMP 'RAMIRO ZEPEDA','SANTA SOFIA#225','RAMIZEP@hotmail.com','3531204989',30,'MOSTRADOR','COMPRAS','ELPODER4','12365',1,0 --CON EL SE HARAN PRUEBAS DE ELIMINARLO
select * from usuarios
SELECT * FROM EMPLEADOS
--PROC DE ALMACENADO PARA INGRESAR EMPLEADOS CON SU CVE AUTOMATICA
CREATE alter PROC INSEREMP 
	@NOMEMP VARCHAR(50)
	,@DIREMP VARCHAR(20)
	,@CORREOEMP VARCHAR(30)
	,@TELEMP VARCHAR(15)
	,@EDADEMP INT
	,@PUESTO VARCHAR(30)
	,@DEPTO VARCHAR (10)
	,@USER VARCHAR (10)
	,@PASS VARCHAR (12)
	,@clave int ----ESTA MADRE ES DE PRUEBA, RECOGE EL NOMBRE QUE ES
	,@ban INT OUTPUT
	
AS
DECLARE @CVEMP INT
DECLARE @tdepto varchar (1)

IF (
		SELECT COUNT(*)
		FROM EMPLEADOS
		) = 0
	SET @CVEMP = 1
ELSE
	SET @CVEMP = (
			SELECT MAX(CVEMP)
			FROM EMPLEADOS
			) + 1

IF @NOMEMP = ''
	--PRINT 'EL NOMBRE DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 1
ELSE IF @DIREMP = ''
	--PRINT 'LA DIRECCION DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 2
ELSE IF @CORREOEMP = ''
	--PRINT 'EL CORREO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 3
ELSE IF @TELEMP = ''
	--PRINT 'EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 4
ELSE IF (@TELEMP LIKE '%[A-Z]%')
	--PRINT 'EL TELEFONO DEL EMPLEADO TIENE LETRAS'
	SET @ban = 5
ELSE IF @EDADEMP = ''
	--PRINT 'LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @ban = 6
ELSE IF (@EDADEMP < 18)
	--PRINT 'LA EDAD DEL EMPLEADO DEBE DE SER MAYOR A 18 AÑOS'
	SET @ban = 7
ELSE IF @PUESTO = ''
	--PRINT 'EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 8
ELSE IF (
		@PUESTO != 'CAJERO(A)'
		AND @PUESTO != 'MOSTRADOR' AND @PUESTO != 'ENC. DE TIENDA' AND @PUESTO != 'CONTADOR(A)' AND @PUESTO != 'AUX. CONTABLE'
	AND @PUESTO !='ADMINISTRADOR(A)'
		)
	--PRINT 'EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A), MOSTRADOR, ENC. DE TIENDA, AUX. CONTABLE, ADMINISTRADOR(A) o CONTADOR(A)'
	SET @ban = 9
/*MODIFICAMOS DESDE AQUI 03 DE MAYO*/

ELSE IF (@DEPTO ='')
	--PRINT 'EL DEPARTAMENTO NO PUEDE ESTAR VACIO'
	SET @BAN=17
ELSE IF (@USER ='')
	--PRINT 'EL USUARIO NO PUEDE ESTAR VACIO'
	SET @BAN=18
ELSE IF (@PASS ='')
	--PRINT 'LA CONTRASEÑA NO PUEDE ESTAR VACIA'
	SET @BAN=19
else if @DEPTO != 'COMPRAS' AND @DEPTO !='VENTAS' AND @DEPTO !='GERENCIA'
	--PRINT 'DEPARTAMENTO NO EXISTENTE'
	set @ban = 20
/*else if (select count (*) from usuarios where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA'
	set @ban = 23*/
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52

--ACTUALIZACION: ESTA OCNSIDICION SIRVE PARA CHECAR EN QUE DEPARTAMENTO ESTA EL USUARIO, YA QUE
--UN EMPLEADO DE COMPRAS SE PUDIERA METER AQUI DESDE EL CODIGO FUENTE, MAS DESDE UN FORMULAIRO SE PUEDE RESTRINGIR DE MEJOR MANERA
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
if @DEPTO != 'GERENCIA' AND (@PUESTO = 'ADMINISTRADOR(A)' OR @PUESTO = 'CONTADOR(A)'OR  @PUESTO = 'ENC. DE TIENDA')
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =24
		ELSE IF ((@DEPTO != 'VENTAS') AND(@PUESTO = 'CAJERO(A)'))
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =25
		ELSE IF ((@DEPTO != 'COMPRAS') AND(@PUESTO = 'MOSTRADOR' OR @PUESTO = 'AUX. CONTABLE'))
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =26
ELSE
BEGIN
	IF (LEN(@NOMEMP) > 49)
		--PRINT 'LA LONGITUD DEL NOMBRE NO DEBE DE SER MAYOR A 50 CARACTERES'
		SET @ban = 10
	ELSE IF (LEN(@DIREMP) > 19)
		--PRINT 'LA LONGITUD DE LA DIRECCION NO DEBE DE SER MAYOR A 20 CARACTERES'
		SET @ban = 11
	ELSE IF (LEN(@CORREOEMP) > 29)
		--PRINT 'LA LONGITUD DEL CORREO NO DEBE DE SER MAYOR A 30 CARACTERES'
		SET @ban = 12
	ELSE IF (LEN(@TELEMP) > 14)
		--PRINT 'LA LONGITUD DEL TELEFONO NO DEBE DE SER MAYOR A 15 CARACTERES'
		SET @ban = 13
	ELSE IF (LEN(@PUESTO) > 29)
		--PRINT 'LA LONGITUD DEL PUESTO NO DEBE DE SER MAYOR A 30 CARACTERES'
		SET @ban = 14
	ELSE IF (
			SELECT COUNT(*)
			FROM EMPLEADOS
			WHERE NOMEMP = @NOMEMP
				AND DIREMP = @DIREMP
				AND CORREOEMP = @CORREOEMP
				AND TELEMP = @TELEMP
				AND EDADEMP = @EDADEMP
				AND PUESTO = @PUESTO
			) > 0
		--SET @ban = 15 
		PRINT 'ESTE EMPLEADO YA SE ENCUENTRA REGISTRADO'
	ELSE IF (
			SELECT COUNT(*)
			FROM EMPLEADOS
			WHERE CORREOEMP = @CORREOEMP
			) > 0
		--SET @ban = 16 
		PRINT 'EL CORREO ELECTRONICO YA EXISTE' --es probable que el empleado no tenga correo, sin embargo no pueden poner el de otra persona ya sea por privacidad o jerarquia de puesto
	ELSE
	IF (SELECT COUNT (*) FROM USUARIOS WHERE NUSUARIO=@USER)=0
	IF (SELECT COUNT (*) FROM USUARIOS WHERE CONTRASENA=@PASS)=0
	BEGIN
		IF @DEPTO = 'COMPRAS'
		SET @TDEPTO = 'C'
		IF @DEPTO = 'VENTAS'
		SET @TDEPTO = 'V'
		IF @DEPTO = 'GERENCIA'
		SET @TDEPTO = 'G'
		BEGIN TRAN


		INSERT INTO EMPLEADOS
		VALUES (@CVEMP,@NOMEMP,@DIREMP,@CORREOEMP,@TELEMP,@EDADEMP,@PUESTO,@DEPTO, 1)
		INSERT INTO USUARIOS (NUSUARIO,CONTRASENA,TIPODEPTO,CVEMP)
		VALUES (@USER,@PASS,@TDEPTO,@CVEMP)
		--------------------------------------------------------
		--HACEMOS EL UPDATE DE EMPLEADOS A VENTAS
		--------------------------------------------------------
		INSERT INTO FarmSAntonioVentas.DBO.EMPLEADOS
		VALUES (@CVEMP,@NOMEMP,@DIREMP,@CORREOEMP,@TELEMP,@EDADEMP,@PUESTO,@DEPTO, 1)
		INSERT INTO FarmSAntonio.DBO.USUARIOS (NUSUARIO,CONTRASENA,TIPODEPTO,CVEMP)
		VALUES (@USER,@PASS,@TDEPTO,@CVEMP)
		COMMIT TRAN
	END
	else
		--print 'YA EXISTE ESTA CONTRASEÑA CON OTRO USUARIO'
		SET @BAN=21
	else
		--print 'EL NOMBRE DE USUARIO YA SE ENCUENTRA REGISTRADO'
		SET @BAN=22
END
END
ELSE 
 --PRINT 'EL DEPARTAMENTO DE ESTE USUARIO NO ESTA PERMITIDO PARA HACER ESTA OPERACION'
 SET @BAN=53 --condidion para visual

	--PROCEDIMIENTO DE ALMACENADO PARA INGRESAR DETALLES ENTRE VENTAS Y PRODUCTOS COMO SUS RESPECTIVAS MODIFICACIONES
SELECT * FROM productos
SELECT * FROM detvtapro
SELECT * FROM ventas
SELECT * FROM detvtaemp

DETVPRO '',2,3
DETVPRO 101,'',2
DETVPRO 101,1000,2
detvpro 103,2,3
detvpro 100,1,0
detvpro 100,1,3,3,0
select * from usuarios

CREATE alter PROC DETVPRO
	@CVEVTA INT
	,@CVEPROD INT
	,@CANTVP INT
	,@clave int 
	,@BAN INT OUTPUT
AS

IF @CVEVTA = ''
	--PRINT 'LA CVE DE LA VENTA ESTA VACIA'
	sET @BAN = 1
ELSE IF (SELECT COUNT(CVEVTA) FROM VENTAS WHERE CVEVTA = @CVEVTA) = 0
	--PRINT 'LA CVE DE LA VENTA NO EXISTE, MODIFICALA'
	SET @BAN = 2
ELSE IF @CVEPROD = ''
	--PRINT 'LA CVE DEL PRODUCTO NO EXISTE'
	SET @BAN = 3
ELSE IF (SELECT COUNT(CVEPROD) FROM PRODUCTOS WHERE CVEPROD = @CVEPROD) = 0
	--PRINT 'LA CVE DEL PRODUCTO NO EXISTE, MODIFICALA'
	SET @BAN = 4
ELSE IF @CANTVP = ''
	OR @CANTVP < 1
	--PRINT 'LA CANTIDAD VENDIDA ESTA VACIA O ES MENOR A 1'
	SET @BAN = 5
ELSE IF (SELECT ESTADO FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=0
	--PRINT 'ESTE PRODUCTO HA SIDO DADO DE BAJA'
	SET @BAN =6
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if ((select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 or (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'V')=1)
BEGIN
	IF (
			SELECT COUNT(*)
			FROM DETVTAPRO
			WHERE CVEPROD = @CVEPROD
				AND CVEVTA = @CVEVTA
			) > 0
		--Existe uno, en este caso el la cantidad del producto solo se incrementara, lo que hace que no repita las claves, solo aumenta la cantidad
	BEGIN
		IF (
				SELECT EXISTENCIASP
				FROM PRODUCTOS
				WHERE CVEPROD = @CVEPROD
				) >= @CANTVP --hay más en existencia
		BEGIN
			BEGIN TRAN

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTA DE PRODUCTOS A LA DE VENTAS (ACTUAL)
			--------------------------------------------------------
			UPDATE DETVTAPRO
			SET CANTVP = CANTVP + @CANTVP
			WHERE CVEPROD = @CVEPROD
				AND CVEVTA = @CVEVTA
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTA DE PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE  FarmSAntonioVentas.DBO.DETVTAPRO
			SET CANTVP = CANTVP + @CANTVP
			WHERE CVEPROD = @CVEPROD
				AND CVEVTA = @CVEVTA
			
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE PRODUCTOS A LA DE VENTAS (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE PRODUCTOS A LA DE COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTAS A LA DE VENTAS (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE VENTAS
			SET IVA = IVA + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .16
			WHERE CVEVTA = @CVEVTA --los productos tienen iva
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTAS A LA VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE FarmSAntonioVentas.DBO.VENTAS
			SET IVA = IVA + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .16
			WHERE CVEVTA = @CVEVTA --los productos tienen iva
			--------------------------------------------------------
			COMMIT TRAN

			BEGIN TRAN
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA EMPLEADO (ACTUAL)
			--------------------------------------------------------
			UPDATE DETVTAEMP
			SET COMISION =  (
					(
						SELECT SUBTOTAL
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						) + (
						SELECT IVA
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						)
					) * .03
			WHERE CVEVTA = @CVEVTA
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA EMPLEADO (VENTAS)
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.DETVTAEMP
			SET COMISION = (
					(
						SELECT SUBTOTAL
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						) + (
						SELECT IVA
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						)
					) * .03
			WHERE CVEVTA = @CVEVTA
			--------------------------------------------------------
			COMMIT TRAN
		END
		ELSE
			--PRINT ('LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE PRODUCTO')
			SET @BAN = 7
	END
	ELSE
	BEGIN
		IF (
				SELECT EXISTENCIASP
				FROM PRODUCTOS
				WHERE CVEPROD = @CVEPROD
				) >= @CANTVP --hay más en existencia
		BEGIN
			BEGIN TRAN

			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA DE PRODUCTO (ACTUAL)
			--------------------------------------------------------
			INSERT INTO DETVTAPRO (
				CVEVTA
				,CVEPROD
				,PREVENDIDOP
				,CANTVP
				)
			VALUES (
				@CVEVTA
				,@CVEPROD
				,(SELECT PRECIOVTAP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)
				,@CANTVP
				)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA DE PRODUCTO A VENTAS
			--------------------------------------------------------
			INSERT INTO FarmSAntonioVentas.DBO.DETVTAPRO (
				CVEVTA
				,CVEPROD
				,PREVENDIDOP
				,CANTVP
				)
			VALUES (
				@CVEVTA
				,@CVEPROD
				,(SELECT PRECIOVTAP FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)
				,@CANTVP
				)

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE RESTA DE PRODUCTO (ACTUAL)
			--------------------------------------------------------
			UPDATE PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE RESTA DE PRODUCTO A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE RESTA DE PRODUCTO A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.PRODUCTOS
			SET EXISTENCIASP = EXISTENCIASP - @CANTVP
			WHERE CVEPROD = @CVEPROD

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTAS (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE VENTAS
			SET IVA = IVA + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .16
			WHERE CVEVTA = @CVEVTA --los productos tienen iva
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE VENTAS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE FarmSAntonioVentas.DBO.VENTAS
			SET IVA = IVA + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .16
			WHERE CVEVTA = @CVEVTA --los productos tienen iva
			--------------------------------------------------------
			COMMIT TRAN

			BEGIN TRAN
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA EMPLEADO (ACTUAL)
			--------------------------------------------------------
			UPDATE DETVTAEMP
			SET COMISION = (
					(
						SELECT SUBTOTAL
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						) + (
						SELECT IVA
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						)
					) * .03
			WHERE CVEVTA = @CVEVTA
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA EMPLEADO AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.DETVTAEMP
			SET COMISION = (
					(
						SELECT SUBTOTAL
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						) + (
						SELECT IVA
						FROM VENTAS
						WHERE CVEVTA = @CVEVTA
						)
					) * .03
			WHERE CVEVTA = @CVEVTA
			--------------------------------------------------------
			COMMIT TRAN
		END
		ELSE
			--PRINT ('LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE PRODUCTO')
			SET @BAN = 8
	END
END
else 
 --PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA HACER ESTA OPERACION'
 SET @BAN=53 --condidion para visual

 --FIN
		--PROCEDIMIENTO DE ALMACENADO PARA INGRESAR DETALLES ENTRE VENTAS Y MEDICAMENTOS COMO SUS RESPECTIVAS MODIFICACIONES

SELECT * FROM medicamentos
SELECT * FROM detvtamed
SELECT * FROM ventas
SELECT * FROM detvtaemp

DETVME '',4000,3,'C:/img/imgrect1.PDF'
DETVME 100,'',1,'C:/img/imgrect3.PDF'
DETVME 112,4000,1,'C:/img/imgrect6.PDF'
DETVME 100,'',1,'C:/img/imgrect7.PDF'
DETVME 100,4000,0,'C:/img/imgrect8.PDF'
DETVME 100,4000,1,''
DETVME 100,4002,1,'C:/img/imgrect8.PDF'
DETVME 100,4000,1,'C:/img/imgrect8.PDF'
DETVME 100,4001,3,'C:/img/imgrect8.PDF',3,0


CREATE alter PROC DETVME 
	@CVEVTA INT
	,@CVEMED INT
	,@CANTVM INT
	,@IMGRECT VARCHAR(100)
	,@CLAVE INT
	,@BAN INT OUTPUT
AS
IF @CVEVTA = ''
	--PRINT 'LA CVE DE LA VENTA ESTA VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT(CVEVTA) FROM VENTAS WHERE CVEVTA = @CVEVTA) = 0
	--PRINT 'LA CVE DE LA VENTA NO EXISTE, MODIFICALA'
	SET @BAN = 2
ELSE IF @CVEMED = ''
	--PRINT 'LA CVE DEL MEDICAMENTO ESTA VACIA'
	SET @BAN = 3
ELSE IF (SELECT COUNT(CVEMED) FROM MEDICAMENTOS WHERE CVEMED = @CVEMED) = 0
	--PRINT 'LA CVE DEL MEDICAMENTO NO EXISTE, MODIFICALA'
	SET @BAN = 4
ELSE IF @CANTVM = ''
	OR @CANTVM < 1
	--PRINT 'LA CANTIDAD VENDIDA ESTA VACIA O ES MENOR A 1'
	SET @BAN = 5
ELSE IF @IMGRECT = ''
	--PRINT 'LA RUTA DE LA IMAGEN NO EXISTE O ESTA VACIA'
	SET @BAN = 6
ELSE IF (LEN(@IMGRECT) > 99)
	--PRINT 'LA RUTA DE LA IMAGEN EXCEDE LOS 100 CARACTERES'
	SET @BAN = 7
ELSE IF (SELECT ESTADO FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0
	--PRINT 'ESTE MEDICAMENTO HA SIDO DADO DE BAJA'
	SET @BAN = 8
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from FarmSAntonioVentas.DBO.USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if ((select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 or (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'V')=1)
BEGIN
	IF (
			SELECT COUNT(*) FROM DETVTAMED WHERE CVEMED = @CVEMED AND CVEVTA = @CVEVTA	AND IMGRECT = @IMGRECT) > 0
		--Existe uno, en este caso la cantidad del medicanmento solo se incrementara, lo que hace que no repita las claves, solo aumenta la cantidad
	BEGIN
		IF (SELECT EXISTENCIASM FROM MEDICAMENTOS WHERE CVEMED = @CVEMED) >= @CANTVM --hay más en existencia
		BEGIN
			BEGIN TRAN
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA MEDICAMENTO (ACTUAL)
			--------------------------------------------------------
			UPDATE DETVTAMED SET CANTVM = CANTVM + @CANTVM WHERE CVEMED = @CVEMED AND CVEVTA = @CVEVTA
			--------------------------------------------------------
			--HACEMOS EL UPDATE DETALLE VENTA MEDICAMENTO AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.DETVTAMED SET CANTVM = CANTVM + @CANTVM	WHERE CVEMED = @CVEMED AND CVEVTA = @CVEVTA

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS	SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE SUBTOTAL DE PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS SET SUBTOTAL = SUBTOTAL + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS	WHERE CVEMED = @CVEMED)) WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE SUBTOTAL DE PRODUCTOS A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.VENTAS SET SUBTOTAL = SUBTOTAL + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS WHERE CVEMED = @CVEMED)) WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE IVA  (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS
			SET IVA = IVA + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS	WHERE CVEMED = @CVEMED)) * 0
			WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE IVA  A LA VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.VENTAS SET IVA = IVA + (
					@CANTVM * (
						SELECT PRECIOVTAM
						FROM MEDICAMENTOS
						WHERE CVEMED = @CVEMED
						)
					) * 0
			WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)

			COMMIT TRAN

			BEGIN TRAN

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE COMISION  (ACTUAL)
			--------------------------------------------------------
			UPDATE DETVTAEMP
			SET COMISION = ((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA = @CVEVTA) + (SELECT IVA FROM VENTAS WHERE CVEVTA = @CVEVTA)) * .03 WHERE CVEVTA = @CVEVTA
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE IVA  A VENTAS
			--------------------------------------------------------
			UPDATE FarmSAntonioVentas.DBO.DETVTAEMP
			SET COMISION =
					((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA = @CVEVTA) + (SELECT IVA FROM VENTAS WHERE CVEVTA = @CVEVTA)) * .03 WHERE CVEVTA = @CVEVTA
			COMMIT TRAN
		END
		ELSE
			--PRINT 'LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE MEDICAMENTO'
			SET @BAN = 9
	END
	ELSE
	BEGIN
			IF (
					SELECT EXISTENCIASM
					FROM MEDICAMENTOS
					WHERE CVEMED = @CVEMED
					) >= @CANTVM --hay más en existencia
			BEGIN
				BEGIN TRAN

				--------------------------------------------------------
				--INSERCION DE DEETVMED  (ACTUAL)
				--------------------------------------------------------
				INSERT INTO DETVTAMED (
					CVEVTA
					,CVEMED
					,CANTVM
					,PREVENDIDOM
					,IMGRECT
					)
				VALUES (
					@CVEVTA
					,@CVEMED
					,@CANTVM 
					,(SELECT PRECIOVTAM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)
					,@IMGRECT
					)
				--------------------------------------------------------
				--INSERCION DE DEETVMED  A VENTAS
				--------------------------------------------------------
				INSERT INTO FarmSAntonioVentas.DBO.DETVTAMED (
					CVEVTA
					,CVEMED
					,CANTVM
					,PREVENDIDOM
					,IMGRECT
					)
				VALUES (
					@CVEVTA
					,@CVEMED
					,@CANTVM
					,(SELECT PRECIOVTAM FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)
					,@IMGRECT
					)

				--------------------------------------------------------
				--UPDATE A LA EXISTENCIA DE MEDICAMENTOS DESPUÉS DE VENTA  (ACTUAL)
				--------------------------------------------------------
				UPDATE MEDICAMENTOS
				SET EXISTENCIASM = EXISTENCIASM - @CANTVM
				WHERE CVEMED = @CVEMED
				--------------------------------------------------------
				--UPDATE A LA EXISTENCIA DE MEDICAMENTOS DESPUÉS DE VENTA A VENTAS
				--------------------------------------------------------
				UPDATE FarmSAntonioVentas.DBO.MEDICAMENTOS
				SET EXISTENCIASM = EXISTENCIASM - @CANTVM
				WHERE CVEMED = @CVEMED
				--------------------------------------------------------
				--UPDATE A LA EXISTENCIA DE MEDICAMENTOS DESPUÉS DE VENTA A COMPRAS
				--------------------------------------------------------
				UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS
				SET EXISTENCIASM = EXISTENCIASM - @CANTVM
				WHERE CVEMED = @CVEMED

				--------------------------------------------------------
				--UPDATE AL SUBTOTAL DE VENTA  (ACTUAL)
				--------------------------------------------------------
				UPDATE VENTAS
				SET SUBTOTAL = SUBTOTAL + (
						@CANTVM * (
							SELECT PRECIOVTAM
							FROM MEDICAMENTOS
							WHERE CVEMED = @CVEMED
							)
						)
				WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
				--------------------------------------------------------
				--UPDATE AL SUBTOTAL DE VENTA  AL ORIGINAL
				--------------------------------------------------------
				UPDATE FarmSAntonioVentas.DBO.VENTAS
				SET SUBTOTAL = SUBTOTAL + (
						@CANTVM * (
							SELECT PRECIOVTAM
							FROM MEDICAMENTOS
							WHERE CVEMED = @CVEMED
							)
						)
				WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)

				--------------------------------------------------------
				--UPDATE AL IVA DE VENTA  (ACTUAL)
				--------------------------------------------------------
				UPDATE VENTAS
				SET IVA = IVA + (
						@CANTVM * (
							SELECT PRECIOVTAM
							FROM MEDICAMENTOS
							WHERE CVEMED = @CVEMED
							)
						) * 0
				WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
				--------------------------------------------------------
				--UPDATE AL IVA DE VENTA  A VENTAS
				--------------------------------------------------------
				UPDATE FarmSAntonioVentas.DBO.VENTAS
				SET IVA = IVA + (
						@CANTVM * (
							SELECT PRECIOVTAM
							FROM MEDICAMENTOS
							WHERE CVEMED = @CVEMED
							)
						) * 0
				WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)

				COMMIT TRAN

				BEGIN TRAN
				--------------------------------------------------------
				--UPDATE A LA COMISION DEL EMPLEADO  (ACTUAL)
				--------------------------------------------------------
				UPDATE DETVTAEMP
				SET COMISION = (
						(
							SELECT SUBTOTAL
							FROM VENTAS
							WHERE CVEVTA = @CVEVTA
							) + (
							SELECT IVA
							FROM VENTAS
							WHERE CVEVTA = @CVEVTA
							)
						) * .03
				WHERE CVEVTA = @CVEVTA
				--------------------------------------------------------
				--UPDATE A LA COMISION DEL EMPLEADO  A VENTAS
				--------------------------------------------------------
				UPDATE FarmSAntonioVentas.DBO.DETVTAEMP
				SET COMISION = (
						(
							SELECT SUBTOTAL
							FROM VENTAS
							WHERE CVEVTA = @CVEVTA
							) + (
							SELECT IVA
							FROM VENTAS
							WHERE CVEVTA = @CVEVTA
							)
						) * .03
				WHERE CVEVTA = @CVEVTA

				COMMIT TRAN
			END
			ELSE
				--PRINT 'LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE MEDICAMENTO'
				SET @BAN = 11
		END
END
ELSE 
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA HACER ESTA OPERACION'
SET @BAN=53
		--PROCEDIMIENTO DE ALMACENADO PARA VENTAS CON CVE AUTOMATICA nota: las ventas inician a partir de la cve 100
		

SELECT * FROM VENTAS
SELECT * FROM DETVTAEMP
SELECT * FROM EMPLEADOS

VTAUTO 'EFECTIVO', ''
VTAUTO 'EFECTIVO', 2
VTAUTO 'EFECTIVO', 44
VTAUTO 'EFECTIVO', 5
VTAUTO 'EFECTIVO', 1
VTAUTO 'TARJETA', 3, 0
select * from usuarios

CREATE alter PROC VTAUTO
@TIPOPAG VARCHAR(20)
,@CVEMP INT
,@BAN INT OUTPUT
AS
DECLARE @CVEVTA INT

IF (SELECT COUNT(*)	FROM VENTAS) = 0
	SET @CVEVTA = 100 --inicia en 100
ELSE
	SET @CVEVTA = (SELECT MAX(CVEVTA) FROM VENTAS) + 1

IF @TIPOPAG = ''
	--PRINT 'EL TIPO DE PAGO NO DEBE DE ESTAR VACIO'
	SET @BAN = 1
ELSE IF @TIPOPAG LIKE '%[0-9]%'
	--PRINT 'EL TIPO DE PAGO TIENE NUMEROS'
	SET @BAN = 2
ELSE IF @CVEMP = ''
	--PRINT 'LA CVE DEL EMPLEADO ESTA VACIA'
	SET @BAN = 3
ELSE IF (
		SELECT COUNT(CVEMP)
		FROM EMPLEADOS
		WHERE CVEMP = @CVEMP
		) = 0
	--PRINT 'LA CVE DEL EMPLEADO NO EXISTE'
	SET @BAN = 4
ELSE IF (SELECT ACTIVO FROM EMPLEADOS WHERE CVEMP=@CVEMP)=0
	--PRINT 'ESTE EMPLEADO SE ENCUENTRA DADO DE BAJA'
	SET @BAN = 5
ELSE IF ((SELECT PUESTO FROM EMPLEADOS WHERE CVEMP = @CVEMP ) != 'CAJERO(A)' AND (SELECT PUESTO FROM EMPLEADOS WHERE CVEMP = @CVEMP ) != 'ADMINISTRADOR(A)' AND
 (SELECT PUESTO FROM EMPLEADOS WHERE CVEMP = @CVEMP )!='ENC. DE TIENDA')
	--PRINT 'LAS VENTAS SOLO PUEDEN SER COBRADAS POR LOS CAJEROS, ENC. DE TIENDA O ADMINISTRADORES'
	SET @BAN = 6
else if (select count (*) from USUARIOS where cvemp=@CVEMP and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 7
else if ((select count (*) from USUARIOS where cvemp=@CVEMP and tipodepto = 'G')=1 or (select count (*) from USUARIOS where cvemp=@CVEMP and tipodepto = 'V')=1)
BEGIN
	BEGIN TRAN
	--------------------------------------------------------
	--UPDATE DE VENTAS  (ACTUAL)
	--------------------------------------------------------
	INSERT INTO VENTAS (
		CVEVTA
		,TIPOPAG
		)
	VALUES (
		@CVEVTA
		,@TIPOPAG
		)
	--------------------------------------------------------
	--UPDATE DE VENTAS  A LA VENTAS
	--------------------------------------------------------
	INSERT INTO FarmSAntonioVentas.DBO.VENTAS (
		CVEVTA
		,TIPOPAG
		)
	VALUES (
		@CVEVTA
		,@TIPOPAG
		)

	--------------------------------------------------------
	--UPDATE DETVTAEMP  (ACTUAL)
	--------------------------------------------------------
	INSERT INTO DETVTAEMP (
		CVEVTA
		,CVEMP
		)
	VALUES (
		@CVEVTA
		,@CVEMP
		)
	--------------------------------------------------------
	--UPDATE DETVTAEMP  A LA ORIGINAL
	--------------------------------------------------------
	INSERT INTO FarmSAntonioVentas.DBO.DETVTAEMP (
		CVEVTA
		,CVEMP
		)
	VALUES (
		@CVEVTA
		,@CVEMP
		)

	COMMIT TRAN
END
ELSE 
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53
---*********************************************************
---PROCEDIMIENTOS ALMACENADOS PARA BAJAS O ELIMINACIONES   *
---*********************************************************

SELECT * FROM DETVTAEMP
SELECT * FROM EMPLEADOS
SELECT * FROM VENTAS

--------------------------------------------------------
--			ELIMINACION DE EMPLEADOS
--------------------------------------------------------
BAJAEMP '',1,0 --VACIO
BAJAEMP 35,1,0 --NO EXISTE
BAJAEMP 1,1,0 --TIENE RELACIONES
BAJAEMP 1,0,0 --LO BORRA

select * from empleados

CREATE alter PROC BAJAEMP
@CVEMP INT
,@clave int --del empleado de esta sesion
,@BAN INT OUTPUT

AS

IF @CVEMP='' OR @CVEMP=0
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEMP)=0
	--PRINT 'LA CLAVE DEL EMPLEADO NO SE ENCUENTRA REGISTRADA EN LA BASE DE DATOS'
	SET @BAN = 2
ELSE IF (SELECT COUNT (*) FROM USUARIOS  WHERE CVEMP = @CVEMP AND SESION = 1)=1
	--PRINT 'EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR'
	SET @BAN=4
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
	IF (SELECT COUNT(*) FROM DETVTAEMP WHERE CVEMP=@CVEMP)=0
			BEGIN 
				BEGIN TRAN
					DELETE FROM USUARIOS WHERE CVEMP=@CVEMP
					DELETE FROM FarmSAntonio.DBO.USUARIOS WHERE CVEMP=@CVEMP
				COMMIT TRAN
				BEGIN TRAN
					DELETE EMPLEADOS WHERE CVEMP=@CVEMP
					--DELETE DETVTAEMP WHERE CVEMP=@CVEMP
					DELETE FarmSAntonioVentas.DBO.EMPLEADOS WHERE CVEMP=@CVEMP
					--DELETE FarmSAntonio.DBO.DETVTAEMP WHERE CVEMP=@CVEMP
					--SE QUITARON LAS ENTRAIORES YA QUE OSOTROS SOLO PODEMOS ELIMINAR SI UN EMPLEADO NO TIENE RELACIONES 
					--Y ESAS DOS ISTRUCCIONES SON INECESARIAS
				COMMIT TRAN
			END
		ELSE 
			--PRINT 'AUN EXISTEN VENTAS REALIZADAS POR ESTE EMPLEADO'
			SET @BAN = 3
END 
ELSE 
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53
 

--------------------------------------------------------
--			ELIMINACION TEMPORAL DE EMPLEADOS
--------------------------------------------------------
BAJAEMPTEMP '' --VACIO
BAJAEMPTEMP 34 --NO EXISTE
BAJAEMPTEMP 5 --EL BUENO

SELECT * FROM EMPLEADOS
SELECT * FROM DETVTAEMP

CREATE alter PROC BAJAEMPTEMP
@CVEMP INT
,@clave int
,@BAN INT OUTPUT

AS

IF @CVEMP='' OR @CVEMP=0
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEMP)=0
	--PRINT 'LA CVE DEL EMPLEADO NO EXISTE'
	SET @BAN=2
ELSE IF (SELECT ACTIVO FROM EMPLEADOS WHERE CVEMP=@CVEMP)=0
	--PRINT 'ESTE EMPLEADO YA HA SIDO DADO DE BAJA TEMPORALMENTE'
	SET @BAN = 3
ELSE IF (SELECT COUNT (*) FROM USUARIOS  WHERE CVEMP = @CVEMP AND SESION = 1)=1
	--PRINT 'EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR'
	SET @BAN=4
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN 
			BEGIN TRAN
				UPDATE EMPLEADOS SET ACTIVO = 0 WHERE CVEMP=@CVEMP
				UPDATE FarmSAntonioVentas.DBO.EMPLEADOS SET ACTIVO = 0 WHERE CVEMP=@CVEMP
			COMMIT TRAN
END
ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53



----------------------------------------------------
--PROCEDIMENTO DE ALAMACENADO PARA ELIMNAR VENTAS
----------------------------------------------------

/*ACTUALIZACION, EN ESTE CASO SOLO PUEDE ELIMINAR LOS EMPLEADOS CON PUESTO EN GERENCIA*/
BAJAVTAS '',1,0
BAJAVTAS 233,1,0
BAJAVTAS 102,1,0 --EL BUENO


SELECT * FROM VENTAS
SELECT * FROM DETVTAEMP
SELECT * FROM DETVTAMED
SELECT * FROM DETVTAPRO
SELECT * FROM MEDICAMENTOS
SELECT * FROM PRODUCTOS

CREATE ALTER PROC BAJAVTAS
@CVEVTA INT
,@clave2 int
,@BAN INT OUTPUT
AS 
DECLARE @CUANTOS INT, @CLAVE INT, @rect varchar (100)

IF @CVEVTA=0 OR @CVEVTA=0
	 --PRINT 'LA CVE DE LA VENTA SE ENCUENTRA VACIA'
	 SET @BAN=1
ELSE IF (SELECT COUNT(*) FROM VENTAS WHERE CVEVTA=@CVEVTA)=0
	--PRINT 'LA CVE DE LA VENTA NO EXISTE'
	SET @BAN=2
else if(@clave2 = '' or @clave2 = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave2)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave2 and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave2 and tipodepto = 'G')=1 
BEGIN
IF (SELECT COUNT(*) FROM DETVTAMED WHERE CVEVTA=@CVEVTA)>0--SE ENCUENTRA UNO EN MED
SET @CUANTOS=(SELECT COUNT(*) FROM DETVTAMED WHERE CVEVTA=@CVEVTA)
IF @CUANTOS>0
	WHILE @CUANTOS>0
	BEGIN 
	SET @CLAVE=(SELECT MAX (CVEMED) FROM DETVTAMED WHERE CVEVTA=@CVEVTA)
	SET @rect= (SELECT imgrect from detvtamed where cvevta=@cvevta and cvemed=@clave)
	EXEC BAJADETMED @CVEVTA,@CLAVE,@rect,@clave2,@BAN
	IF (SELECT MAX(CVEMED) FROM DETVTAMED WHERE CVEVTA=@CVEVTA)=@CLAVE
	SET @CUANTOS=0
	ELSE 
	SET @CUANTOS=@CUANTOS-1
	END


IF (SELECT COUNT(*) FROM DETVTAPRO WHERE CVEVTA=@CVEVTA)>0--SE ENCUENTRA UNO EN PRODUCTOS
SET @CUANTOS=(SELECT COUNT(*) FROM DETVTAPRO WHERE CVEVTA=@CVEVTA)
IF @CUANTOS>0
	WHILE @CUANTOS>0
	BEGIN 
	SET @CLAVE=(SELECT MAX (CVEPROD) FROM DETVTAPRO WHERE CVEVTA=@CVEVTA)
	EXEC BAJADETPROD @CVEVTA,@CLAVE,@clave2,@BAN
	IF (SELECT MAX(CVEPROD) FROM DETVTAPRO WHERE CVEVTA=@CVEVTA)=@CLAVE
	SET @CUANTOS=0
	ELSE 
	SET @CUANTOS=@CUANTOS-1
	END	

IF ((SELECT COUNT (*) FROM DETVTAMED WHERE CVEVTA=@CVEVTA)=0 AND (SELECT COUNT (*) FROM DETVTAPRO WHERE CVEVTA=@CVEVTA)=0)
		BEGIN
			BEGIN TRAN
			DELETE DETVTAEMP WHERE CVEVTA=@CVEVTA
			DELETE FarmSAntonioVentas.dbo.DETVTAEMP WHERE CVEVTA=@CVEVTA
			DELETE VENTAS WHERE CVEVTA=@CVEVTA
			DELETE FarmSAntonioVentas.dbo.VENTAS WHERE CVEVTA=@CVEVTA
			COMMIT TRAN
		END
	ELSE
	BEGIN 
	BEGIN TRAN
		--PRINT 'NO SE PUEDE BORRAR LA VENTA'
		SET @BAN=3
	ROLLBACK
	END
	END
	ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53

 --------------------------------------
 --BAJA DE DETALLE ENTRE VENTAS Y MED
 --------------------------------------

BAJADETMED 100,400100,'C:/img/imgrect8.PDF',1,0
BAJADETMED 100,4000,'C:/img/imgrect8.PDF',0,0

SELECT * FROM VENTAS
SELECT * FROM MEDICAMENTOS
SELECT * FROM DETVTAMED
SELECT * FROM DETVTAEMP

CREATE ALTER PROC BAJADETMED
@CVEVTA INT,
@CVEMED INT,
@rect varchar (100)
,@clave int
,@BAN INT OUTPUT

AS
if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
 DECLARE @CANTVTA INT, @AUX MONEY --AUXILIAR GUARDA EL PRECIO DE VENTA QUE SE EFECTUO EN ESA COMPRA
 IF (SELECT CVEMED FROM DETVTAMED WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA and imgrect=@rect)=@CVEMED
	BEGIN 
	SET @CANTVTA = (SELECT CANTVM FROM DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED=@CVEMED and imgrect=@rect)
	SET @AUX = (SELECT PREVENDIDOM FROM DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED=@CVEMED AND IMGRECT=@RECT)
		IF (SELECT ESTADO FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0 --EN DADO CASO DE QUE ESTE DADO DE BAJA EL MED, LO REACTIVA YA QUE NO PUEDE ESTAR DADO DE BAJA UN MEDICAMENTO CON EXISTENCIAS
		BEGIN
		BEGIN TRAN
		EXEC REACTMED @CVEMED, @clave, @ban
		COMMIT TRAN
		END
		BEGIN TRAN
		UPDATE MEDICAMENTOS SET EXISTENCIASM = EXISTENCIASM+@CANTVTA WHERE CVEMED=@CVEMED --ACTUAL
		UPDATE FarmSAntonioCompras.dbo.MEDICAMENTOS SET EXISTENCIASM =EXISTENCIASM+@CANTVTA WHERE CVEMED=@CVEMED --COMPRAS
		UPDATE FarmSAntonioVentas.dbo.MEDICAMENTOS SET EXISTENCIASM =EXISTENCIASM+@CANTVTA WHERE CVEMED=@CVEMED --VENTAS
		--SE REDUCE EL TOTAL DE LA VENTA
		UPDATE VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))WHERE CVEVTA =@CVEVTA
		UPDATE VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * 0 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * 0 WHERE CVEVTA =@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		--SE REDUCE LA COMISION DEL EMPLEADO
		UPDATE DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		COMMIT TRAN
		BEGIN TRAN 
		DELETE DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED =@CVEMED and imgrect = @rect
		DELETE FarmSAntonioVentas.dbo.DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED= @CVEMED and imgrect = @rect
		COMMIT TRAN
	END
 ELSE 
-- PRINT 'EL DETALLE NO EXISTE'
 SET @BAN=1
 END
 ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53
 RETURN

 --------------------------------------
 --BAJA DE DETALLE ENTRE VENTAS Y PROD
 --------------------------------------

 BAJADETPROD 100,2,1,0 --no existe
 BAJADETPROD 100,1,1,0 --el bueno

 select * from ventas
 select * from productos
 select * from detvtapro
 select * from detvtaemp

 CREATE ALTER PROC BAJADETPROD
@CVEVTA INT,
@CVEPROD INT
,@clave INT
,@BAN INT OUTPUT

AS
if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
 DECLARE @CANTVTA INT, @AUX MONEY
 IF (SELECT CVEPROD FROM DETVTAPRO WHERE CVEPROD=@CVEPROD AND CVEVTA=@CVEVTA)=@CVEPROD
	BEGIN 
	SET @CANTVTA = (SELECT CANTVP FROM DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD)
	SET @AUX = (SELECT PREVENDIDOP FROM DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD)
		IF (SELECT ESTADO FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=0 --VERIFICA SI EL PRODUCTO NO SE ENCUENTRE DADO DE BAJA
		BEGIN
		EXEC REACTPROD @CVEPROD, @clave, @ban
		END
		BEGIN TRAN
		UPDATE PRODUCTOS SET EXISTENCIASP = EXISTENCIASP+@CANTVTA WHERE CVEPROD=@CVEPROD --ACTUAL
		UPDATE FarmSAntonioCompras.dbo.PRODUCTOS SET EXISTENCIASP =EXISTENCIASP+@CANTVTA WHERE CVEPROD=@CVEPROD --VENTAS
		UPDATE FarmSAntonioVentas.dbo.PRODUCTOS SET EXISTENCIASP =EXISTENCIASP+@CANTVTA WHERE CVEPROD=@CVEPROD --ORIGINAL
		--SE REDUCE EL TOTAL DE LA VENTA
		UPDATE VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))*.84 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))*.84 WHERE CVEVTA =@CVEVTA
		UPDATE VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * .16 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * .16 WHERE CVEVTA =@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		--SE REDUCE LA COMISION DEL EMPLEADO
		UPDATE DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		UPDATE FarmSAntonioVentas.dbo.DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		DELETE DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD
		DELETE FarmSAntonioVentas.dbo.DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD
		COMMIT TRAN
	END
 ELSE 
 --PRINT 'EL DETALLE NO EXISTE'
 SET @BAN=1
 END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53
 RETURN


------------------------------------------------
 ----PROCEDIMIENTOS DE ALMACENADO PARA MODIFICACIONES------
 -----------------------------------------------

 --PROCEDIMIENTO DE ALAMACENADO PARA MOD DETVTAMED


 --En nuestro caso, este detalle solo puede modificar la imgrect, ya que el proceso de alamacenado
 --que ingresa el detalle, puede controlar la cantidad 
 MODETVTAMED '','',''
 MODDETVTAMED 2,2,''
 MODDETVTAMED 4000,102,''
 MODDETVTAMED 4001,101,'C:/img/imgrect7.PDF'
 MODDETVTAMED 4000,103,'C:/img/imgrect7.PDF'
 MODDETVTAMED 4000,103,'C:/img/imgrect7.PDF',1,0
 SELECT * FROM DETVTAMED

 CREATE alter PROC MODDETVTAMED

@CVEMED INT
,@CVEVTA INT
,@IMGRECT VARCHAR (100)
,@clave int
,@BAN int OUTPUT
AS

IF @CVEMED=0 or @CVEMED=''
	--PRINT 'LA CLAVE DEL MED ESTA VACIA'
	SET @BAN=1
ELSE IF @CVEVTA=0 OR @CVEVTA=''
	--PRINT 'LA CLAVE DE LA VENTA ESTA VACIA'
	SET @BAN=2
ELSE IF (SELECT COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0
	--PRINT 'LA CVE DEL MED NO EXISTE'
	SET @BAN=3
ELSE IF (SELECT COUNT (*) FROM VENTAS WHERE CVEVTA=@CVEVTA)=0
	--PRINT 'LA CVE DE LA VENTA NO EXISTE'
	SET @BAN=4
ELSE IF @IMGRECT=''
	--PRINT 'LA RUTA DE LA IMAGEN NO DEBE DE ESTAR VACIA'
	SET @BAN=5
ELSE IF (LEN (@IMGRECT)>100)
	--PRINT 'LA RUTA DE LA IMAGEN EXCEDE LOS 100 CARACTERES'
	SET @BAN=6
ELSE IF (SELECT COUNT (*) FROM DETVTAMED WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA)=0
	--PRINT 'ESTE DETALLE NO EXISTE'
	SET @BAN=7
ELSE IF (SELECT COUNT (*) FROM DETVTAMED WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA AND IMGRECT=@IMGRECT)=1
	--PRINT 'ESTE DETALLE YA CUENTA CON LA MISMA INFO'
	SET @BAN=8
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
	BEGIN
	BEGIN TRAN
	UPDATE DETVTAMED SET IMGRECT=@IMGRECT WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA --TABLA ACTUAL
	UPDATE FarmSAntonioVentas.dbo.DETVTAMED SET IMGRECT=@IMGRECT WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA --TABLA ORIGINAL
	COMMIT TRAN
	END
	  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53


--/*************************************/
--PROCEDIMIENTO DE LAMACENADO PARA MODIFICAR EL TIPO DE PAGO EN LAS VENTAS

MODTIPOPAG '',''
MODTIPOPAG 100,''
MODTIPOPAG 100,'3erty'
MODTIPOPAG 102,'TARJETA DE DEBITO'
MODTIPOPAG 100,'TARJETA DE CREDITOOOOOOOOOO'
MODTIPOPAG 100,'TARJETA DE CREDITO',3,0
SELECT * FROM VENTAS

CREATE alter PROC MODTIPOPAG
@CVEVTA INT
,@TIPOPAG VARCHAR (21)
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEVTA='' OR @CVEVTA=0
	--PRINT 'LA CVE DE LA VENTA NO PUEDE ESTAR VACIA'
	SET @BAN=1
ELSE IF @TIPOPAG=''
	--PRINT 'EL TIPO DE PAGO NO DEBE DE ESTAR VACIO'
	SET @BAN=2
ELSE IF @TIPOPAG LIKE '%[0-9]%'
	--PRINT 'EL TIPO DE PAGO TIENE NUMEROS'
	SET @BAN = 3
ELSE IF (LEN (@TIPOPAG)>20)
	--PRINT 'EL TIPO DE PAGO EXCEDE EL RANGO'
	SET @BAN = 4
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if ((select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 or (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'V')=1)
	BEGIN
	IF (SELECT COUNT (*) FROM VENTAS WHERE CVEVTA=@CVEVTA)=1
BEGIN 
	BEGIN TRAN
	UPDATE VENTAS SET TIPOPAG=@TIPOPAG WHERE CVEVTA=@CVEVTA-- ACTUAL
	UPDATE FarmSAntonioVentas.dbo.VENTAS SET TIPOPAG=@TIPOPAG WHERE CVEVTA=@CVEVTA --LA BD ORIGINAL
	COMMIT TRAN
END
ELSE
 	--PRINT 'ESTA VENTA NO SE ENCUENTRA REGISTRADA'
	SET @BAN=5
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53



/*****************************************************/
/*******PROC DE ALMACENADO PARA MODIFICAR EL NOMBRE DEL EMPLEADO****/
/****************************************************/

MODNOMEMP '',''
MODNOMEMP 1,''
MODNOMEMP 23,'JOAQUIN VASCONSELOS'
MODNOMEMP  1,'LUIS JOSE IXTA ZAMUDIO'
MODNOMEMP  1,'LUIS MARTINES DE LA ROSA44'
MODNOMEMP  5,'RAMIRO CEJA RENTERIA',1,0
SELECT * FROM EMPLEADOS

CREATE alter PROC MODNOMEMP
@CVEEMP INT
,@NOMBRE VARCHAR (51)
,@clave int
,@BAN INT OUTPUT
AS 
IF @CVEEMP=0 OR @CVEEMP=''
	--PRINT 'LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @NOMBRE=''
	--PRINT 'LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=2
ELSE IF (LEN (@NOMBRE)>50)
	--PRINT 'EL NOMBRE EXCEDE LOS CARACTERES'
	SET @BAN=3
ELSE IF @NOMBRE LIKE '%[0-9]%'
	--PRINT 'EL NOMBRE DEL EMPLEADO TIENE NUMEROS'
	SET @BAN = 4
ELSE IF (SELECT COUNT (*) FROM USUARIOS  WHERE CVEMP = @CVEEMP AND SESION = 1)=1
	--PRINT 'EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR'
	SET @BAN=7
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
IF (SELECT COUNT (*) FROM EMPLEADOS WHERE NOMEMP=@NOMBRE)=0
	IF(SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEEMP)=1
	BEGIN 
	BEGIN TRAN
	UPDATE EMPLEADOS SET NOMEMP=@NOMBRE WHERE CVEMP=@CVEEMP --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.EMPLEADOS SET NOMEMP=@NOMBRE WHERE CVEMP=@CVEEMP --ORIGINAL
	COMMIT TRAN
	END
	ELSE
	--PRINT 'EL EMPLEADO NO EXISTE'
	SET @BAN=5
ELSE
	--PRINT 'ESTE NOMBRE YA SE ENCUENTRA REGISTRADO CON OTRO EMPLEADO'
	SET @BAN=6
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53

/********************************************************************/
/*******PROC DE ALMACENADO PARA MODIFICA EL TELEFONO DEL EMPLEADO*****/
/*******************************************************************/

MODTELEMP '',''
MODTELEMP 1,''
MODTELEMP 1,'353-12-32-32s'
MODTELEMP 23,'353-12-32-32'
MODTELEMP 1,'353-122-32-323434#232'
MODTELEMP 1,'353-122-32-32'
MODTELEMP 1,'353-122-32-32',1,0
SELECT * FROM EMPLEADOS

CREATE alter PROC MODTELEMP
@CVEEMP INT
,@TEL VARCHAR (16)
,@clave int
,@BAN INT OUTPUT
AS 
IF @CVEEMP=0 OR @CVEEMP=''
	--PRINT 'LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @TEL=''
	--PRINT 'EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @BAN=2
ELSE IF @TEL LIKE '%[A-Z]%'
	--PRINT 'EL TELEFONO TIENE LETRAS'
	SET @BAN=3
ELSE IF (LEN (@TEL) > 15)
	--PRINT 'LA LONGITUD DEL TELEFONO EXCEDE LA CANTIDAD PERMITIDA'
	SET @BAN=5
ELSE IF (SELECT COUNT (*) FROM USUARIOS  WHERE CVEMP = @CVEEMP AND SESION = 1)=1
	--PRINT 'EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR'
	SET @BAN=7
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
IF (SELECT COUNT (*) FROM EMPLEADOS WHERE TELEMP=@TEL)=0
	IF(SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEEMP)=1
	BEGIN 
	BEGIN TRAN
	UPDATE EMPLEADOS SET TELEMP=@TEL WHERE CVEMP=@CVEEMP --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.EMPLEADOS SET TELEMP=@TEL WHERE CVEMP=@CVEEMP --ORIGINAL
	COMMIT TRAN
	END
	ELSE
	--PRINT 'EL EMPLEADO NO EXISTE'
	SET @BAN=6
ELSE
	--PRINT 'ESTE TELEFONO YA SE ENCUENTRA REGISTRADO'
	SET @BAN=7
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53

/********************************************************************/
/*******PROC DE ALMACENADO PARA MODIFICAR LA EDAD DEL EMPLEADO***********/
/*******************************************************************/
MODEDAEMP 0,''
MODEDAEMP 2,''
MODEDAEMP 2,13
MODEDAEMP 23,21
MODEDAEMP 3,28,1,0
SELECT * FROM EMPLEADOS

CREATE alter PROC MODEDAEMP
@CVEEMP INT
,@EDAD INT
,@clave int
,@BAN INT OUTPUT
AS 
IF @CVEEMP=0 OR @CVEEMP=''
	--PRINT 'LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @EDAD='' OR @EDAD=0
	--PRINT 'LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=2
ELSE IF @EDAD <18
	--PRINT 'LA EDAD DEL EMPLEADO DEBE DE SER MAYOR A 18 AÑOS'
	SET @BAN=3
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
	IF(SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEEMP)=1
	BEGIN 
	BEGIN TRAN
	UPDATE EMPLEADOS SET EDADEMP=@EDAD WHERE CVEMP=@CVEEMP --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.EMPLEADOS SET EDADEMP=@EDAD WHERE CVEMP=@CVEEMP --VENTAS
	COMMIT TRAN
	END
	ELSE
	--PRINT 'EL EMPLEADO NO EXISTE'
	SET @BAN=4
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53


/********************************************************************/
/*******PROC DE ALMACENADO PARA MODIFICAR EL PUESTO DEL EMPLEADO***********/
/*******************************************************************/
MODPUEEMP '',''
MODPUEEMP 1,''
MODPUEEMP 1,'ADMIN'
MODPUEEMP 23,'MOSTRADOR'
MODPUEEMP 3,'CAJERO(A)',1,0

SELECT * FROM EMPLEADOS

CREATE alter PROC MODPUEEMP
@CVEEMP INT
,@PUESTO VARCHAR (30)
,@clave int
,@BAN INT OUTPUT
AS 
IF @CVEEMP=0 OR @CVEEMP=''
	--PRINT 'LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @BAN=1
ELSE IF @PUESTO=''
	--PRINT 'EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @BAN=2
ELSE IF (
		@PUESTO != 'CAJERO(A)'
		AND @PUESTO != 'MOSTRADOR'
		AND @PUESTO != 'ENC. DE TIENDA'
		AND @PUESTO != 'ADMINISTRADOR(A)'
		AND @PUESTO != 'CONTADOR(A)'
		AND @PUESTO != 'AUX. CONTABLE'
		)
	--PRINT 'EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A) O MOSTRADOR'
	SET @ban = 3
ELSE IF (LEN (@PUESTO)>30)
	--PRINT 'EL NOMBRE EXCEDE LOS CARACTERES'
	SET @BAN=4
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN 
	IF(SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEEMP)=1
	BEGIN 
	DECLARE @D varchar (10)
	set @D = (select DEPTO from empleados where cvemp=@CVEEMP)
	if @D != 'GERENCIA' AND (@PUESTO = 'ADMINISTRADOR(A)' OR @PUESTO = 'CONTADOR(A)'OR  @PUESTO = 'ENC. DE TIENDA')
		set @D='GERENCIA'
	ELSE IF ((@D != 'VENTAS') AND @PUESTO = 'CAJERO(A)')
		set @D='VENTAS'
	ELSE IF ((@D != 'COMPRAS' AND @D != 'VENTAS') AND (@PUESTO = 'MOSTRADOR' OR @PUESTO = 'AUX.CONTABLE'))
		set @D='COMPRAS'
	ELSE 
	BEGIN
	BEGIN TRAN
	UPDATE EMPLEADOS SET PUESTO=@PUESTO, DEPTO=@D WHERE CVEMP=@CVEEMP --ACTUAL
	UPDATE FarmSAntonioVentas.dbo.EMPLEADOS SET PUESTO=@PUESTO, DEPTO=@D WHERE CVEMP=@CVEEMP --ORIGINAL
	COMMIT TRAN
		DECLARE @TDEPTO VARCHAR (1)
		IF @D = 'COMPRAS'
		SET @TDEPTO = 'C'
		IF @D = 'VENTAS'
		SET @TDEPTO = 'V'
		IF @D = 'GERENCIA'
		SET @TDEPTO = 'G'
		BEGIN TRAN
		UPDATE USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
		UPDATE FarmSAntonioVentas.DBO.USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
		COMMIT TRAN
	END
	END
	ELSE
	--PRINT 'EL EMPLEADO NO EXISTE'
	SET @BAN=5
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53


/*PROCEDIMENTO DE ALMACENADO GENERAL PARA EMPLEADOS*/
SELECT * FROM EMPLEADOS

INSEREMP '','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','','3532101415',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415bd',32,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',10,'CAJERO(A)' 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'ADMNISTADOR'
MODEMP 5,'IGNACIO SANCHES','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',32,'CAJERO(A)'
MODEMP 5,'MAGINRRA RIDDIM GONZALES','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',32,'CAJERO(A)'
MODEMP 5,'MAGINRRA RIDDIM GONZALES','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',32,'CAJERO(A)',1,0


CREATE alter PROC MODEMP
	@CVEEMP INT
	,@NOMEMP VARCHAR(51)
	,@DIREMP VARCHAR(21)
	,@CORREOEMP VARCHAR(31)
	,@TELEMP VARCHAR(16)
	,@EDADEMP INT
	,@PUESTO VARCHAR(30)
	,@DEPTO VARCHAR (10)
	,@clave int
	,@ban INT OUTPUT
AS
IF @CVEEMP=0 OR @CVEEMP=''
	--PRINT 'LA CVE DEL EMPLEADO NO PUEDE ESTAR VACIA'
	SET @ban = 1
IF @NOMEMP = ''
	--PRINT 'EL NOMBRE DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 2
ELSE IF @DIREMP = ''
	--PRINT 'LA DIRECCION DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 3
ELSE IF @CORREOEMP = ''
	--PRINT 'EL CORREO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 4
ELSE IF @TELEMP = ''
	--PRINT 'EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 5
ELSE IF (@TELEMP LIKE '%[A-Z]%')
	--PRINT 'EL TELEFONO DEL EMPLEADO TIENE LETRAS'
	SET @ban = 6
ELSE IF @EDADEMP = ''
	--PRINT 'LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA'
	SET @ban = 7
ELSE IF (@EDADEMP < 18)
	--PRINT 'LA EDAD DEL EMPLEADO DEBE DE SER MAYOR A 18 AÑOS'
	SET @ban = 8
ELSE IF @PUESTO = ''
	--PRINT 'EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @ban = 9
ELSE IF @DEPTO = ''
	--PRINT 'EL DEPTO DEL EMPLEADO NO DEBE DE ESTAR VACIO'
	SET @BAN=21
ELSE IF (@DEPTO != 'VENTAS' AND @DEPTO != 'GERENCIA' and @DEPTO != 'COMPRAS')
	--PRINT 'EL DEPARTAMENTO NO COINCIDE CON LOS ESTABLECIDOS EN LA BD, COMPRAS, VENTAS, GERENCIA'
	SET @BAN = 22
ELSE IF (@PUESTO != 'CAJERO(A)' AND @PUESTO != 'MOSTRADOR' and @PUESTO != 'CONTADOR(A)' and @PUESTO != 'ENC. DE TIENDA'
and @PUESTO != 'ADMINISTRADOR(A)' and @PUESTO != 'AUX. CONTABLE')
	--PRINT 'EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A) AUX CONTABLE, ADMINISTRADOR(A) ENC. DE TIENDA, CONTADOR(A) O  MOSTRADOR'
	SET @ban = 10
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
ELSE IF (SELECT COUNT (*) FROM USUARIOS  WHERE CVEMP = @CVEEMP AND SESION = 1)=1
	--PRINT 'EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR'
	SET @BAN=26
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
	IF (LEN(@NOMEMP) > 50)
		--PRINT 'LA LONGITUD DEL NOMBRE NO DEBE DE SER MAYOR A 50 CARACTERES'
		SET @ban = 11
	ELSE IF (LEN(@DIREMP) > 20)
		--PRINT 'LA LONGITUD DE LA DIRECCION NO DEBE DE SER MAYOR A 20 CARACTERES'
		SET @ban = 12
	ELSE IF (LEN(@CORREOEMP) > 30)
		--PRINT 'LA LONGITUD DEL CORREO NO DEBE DE SER MAYOR A 30 CARACTERES'
		SET @ban = 13
	ELSE IF (LEN(@TELEMP) > 15)
		--PRINT 'LA LONGITUD DEL TELEFONO NO DEBE DE SER MAYOR A 15 CARACTERES'
		SET @ban = 14
	ELSE IF (LEN(@PUESTO) > 30)
		--PRINT 'LA LONGITUD DEL PUESTO NO DEBE DE SER MAYOR A 30 CARACTERES'
		SET @ban = 15
	ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CVEEMP)=0
	---PRINT 'ESTE EMPLEADO NO SE ENCUENTRA REGISTRADO'
		SET @ban = 16
	ELSE IF (SELECT COUNT(*) FROM EMPLEADOS WHERE NOMEMP = @NOMEMP AND DIREMP = @DIREMP AND CORREOEMP = @CORREOEMP AND TELEMP = @TELEMP AND EDADEMP = @EDADEMP AND PUESTO = @PUESTO and depto=@depto) > 0
		--PRINT 'NO SE REALIZO NINGUNA MODIFICACION AL CAMPO'
		SET @ban = 17 
	ELSE IF (SELECT COUNT(*) FROM EMPLEADOS WHERE NOMEMP = @NOMEMP) > 0
		SET @ban = 18 
		--PRINT 'EL NOMBRE YA SE ENCUENTRA REGISTRADO CON OTRO EMPLEADO'
	ELSE IF (SELECT COUNT(*)FROM EMPLEADOS WHERE TELEMP = @TELEMP) > 0
		SET @ban = 19 
		--PRINT 'EL CORREO ELECTRONICO YA SE ENCUENTRA REGISTRADO' 
	ELSE IF (SELECT COUNT(*)FROM EMPLEADOS WHERE CORREOEMP = @CORREOEMP) > 0
		SET @ban = 20 
		--PRINT 'EL CORREO ELECTRONICO YA SE ENCUENTRA REGISTRADO' 
	ELSE
	BEGIN
		if @DEPTO != 'GERENCIA' AND (@PUESTO = 'ADMINISTRADOR(A)' OR @PUESTO = 'CONTADOR(A)'OR  @PUESTO = 'ENC. DE TIENDA')
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =24
		ELSE IF ((@DEPTO != 'VENTAS') AND(@PUESTO = 'CAJERO(A)'))
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =25
		ELSE IF ((@DEPTO != 'COMPRAS') AND(@PUESTO = 'MOSTRADOR' OR @PUESTO = 'AUX. CONTABLE'))
		--PRINT 'EL DEPTO NO CONCUERDA CON EL PUESTO'
		SET @BAN =27
		ELSE 
		BEGIN
		BEGIN TRAN
		UPDATE EMPLEADOS SET NOMEMP=@NOMEMP, DIREMP=@DIREMP,CORREOEMP=@CORREOEMP,TELEMP=@TELEMP,EDADEMP=@EDADEMP,PUESTO=@PUESTO,DEPTO=@DEPTO WHERE CVEMP=@CVEEMP
		UPDATE FarmSAntonioVentas.dbo.EMPLEADOS SET NOMEMP=@NOMEMP, DIREMP=@DIREMP,CORREOEMP=@CORREOEMP,TELEMP=@TELEMP,EDADEMP=@EDADEMP,PUESTO=@PUESTO WHERE CVEMP=@CVEEMP
		COMMIT TRAN
		DECLARE @TDEPTO VARCHAR (1)
		IF @DEPTO = 'COMPRAS'
		SET @TDEPTO = 'C'
		IF @DEPTO = 'VENTAS'
		SET @TDEPTO = 'V'
		IF @DEPTO = 'GERENCIA'
		SET @TDEPTO = 'G'
		BEGIN TRAN
		UPDATE USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
		UPDATE FarmSAntonioVentas.DBO.USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
		COMMIT TRAN
		END
	END
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53


--------------------------------------------------------
--			REACTIVACION DE EMPLEADOS
--------------------------------------------------------
REACTEMP ''
REACTEMP 2
REACTEMP 5
REACTEMP 5,1,0
SELECT * FROM EMPLEADOS

CREATE alter PROC REACTEMP
@CVEMP INT
,@CLAVE INT
,@BAN INT OUTPUT

AS 

IF @CVEMP='' OR @CVEMP=0
	PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA'
	--SET @BAN = 1
ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP= @CVEMP)=0
	PRINT 'LA CVE DEL EMPLEADO NO EXISTE'
	--SET @BAN=2
else if(@clave = '' or @clave = 0)
	--PRINT 'LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA'
	set @ban = 50
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN 
IF(SELECT COUNT(*) FROM EMPLEADOS WHERE CVEMP=@CVEMP AND ACTIVO = 0)=1
		BEGIN 
			BEGIN TRAN
				UPDATE EMPLEADOS SET ACTIVO = 1 WHERE CVEMP=@CVEMP
				UPDATE FarmSAntonioVentas.DBO.EMPLEADOS  SET ACTIVO = 1 WHERE CVEMP=@CVEMP
			COMMIT TRAN
		END
	ELSE
		PRINT 'EL EMPLEADO YA SE ENCUENTRA DADO DE ALTA'
		--SET @BAN = 3
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53

