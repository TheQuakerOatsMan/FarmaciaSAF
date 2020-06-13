/*+++++++++++++++++++++++ FARMACIA SAN ANTONIO FRAGMENTO DE VENTAS +++++++++++++++++++++++++++++++++++++++++++++++*/
finalizasesion 'EL PODER x',0
finalizasesion 'vanila',0
SELECT * FROM DETCOMPRV
SELECT * FROM COMPRAS
select * from usuarios
SELECT * FROM VENTAS
select * from detvtamed
SELECT * FROM MEDICAMENTOS
SELECT * FROM PRODUCTOS
select cvemp from usuarios where nusuario='EL PODER X' AND contrasena ='1234'
SELECT * FROM USUARIOS


CREATE DATABASE FarmSAntonioVentas
UPDATE USUARIOS SET SESION = 0
SELECT * FROM USUARIOS
USE FarmSAntonioVentas
--------------------------------------------------------
		--FRAGMENTO DE VENTAS
		--ENCARGADO DEL FRAGMENTO: MENDIOLA CORREA CESAR PAULINO
		--NO. DE CONTROL:17420579
--------------------------------------------------------
CREATE TABLE EMPLEADOS (
	CVEMP INT PRIMARY KEY
	,NOMEMP VARCHAR(50) NOT NULL
	,DIREMP VARCHAR(20) NOT NULL
	,CORREOEMP VARCHAR(30) NOT NULL
	,TELEMP VARCHAR(15) NOT NULL
	,EDADEMP INT CHECK (EDADEMP LIKE '[1-6][0-9]') NOT NULL
	/*actualizacion del 03 de mayo 2020 se modificaron los campos y se agrego la tabla de usuarios*/
	,PUESTO VARCHAR(30) NOT NULL CHECK (PUESTO='CAJERO(A)' OR PUESTO ='MOSTRADOR' OR PUESTO = 'ENC. DE TIENDA' 
	OR PUESTO='ADMINISTRADOR(A)' OR PUESTO='AUX. CONTABLE' OR PUESTO='CONTADOR(A)')
	,DEPTO VARCHAR (10) NOT NULL check (depto='GERENCIA' or depto='VENTAS' or depto='COMPRAS')
	,ACTIVO INT
	)

CREATE TABLE MEDICAMENTOS (
	CVEMED INT PRIMARY KEY
	,NOMED VARCHAR(30) NOT NULL
	,DESCRIPCIONM VARCHAR(60) NOT NULL
	,PRECIOVTAM MONEY DEFAULT(0)
	,EXISTENCIASM INT DEFAULT(0)
	,ESTADO INT
	)

CREATE TABLE PRODUCTOS (
	CVEPROD INT PRIMARY KEY
	,NOMP VARCHAR(30) NOT NULL
	,DESCRIP VARCHAR(60) NOT NULL
	,PRECIOVTAP MONEY DEFAULT(0)
	,EXISTENCIASP INT DEFAULT(0)
	,ESTADO INT
	)

CREATE TABLE VENTAS (
	CVEVTA INT PRIMARY KEY
	,SUBTOTAL MONEY DEFAULT(0)
	,IVA MONEY DEFAULT(0)
	,TIPOPAG VARCHAR(20)
	,FECHAVTA DATE DEFAULT(GETDATE())
	)

/**CREACION DEL NUEVA TABLA DE USUARIOS**/
CREATE TABLE USUARIOS (
NUSUARIO VARCHAR (10) UNIQUE NOT NULL,
CONTRASENA varchar (12) unique not null,
TIPODEPTO VARCHAR (1) NOT NULL CHECK (TIPODEPTO='C' OR TIPODEPTO='V' OR TIPODEPTO='G'),
SESION INT DEFAULT 0 NOT NULL,
CVEMP INT FOREIGN KEY REFERENCES EMPLEADOS NOT NULL
)

--TABLAS INTERMEDIAS
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
				UPDATE FarmSAntonio.DBO.USUARIOS SET SESION=1 WHERE NUSUARIO=@NUSUARIO AND CONTRASENA=@CONTRASENA
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

/*PROCEDIMIENTO DE ALMACENADO PARA VER EL PUESTO DEL EMPLEADO*/
SELECT * FROM USUARIOS
CREATE PROC VPUESTO
@CLAVE INT
,@BAN INT OUTPUT
AS
IF @CLAVE = ''
	--PRINT 'LA CLAVE NO PUEDE ESTAR VACIA'
	SET @BAN=1
	ELSE
		IF (SELECT COUNT (*) FROM  EMPLEADOS WHERE CVEMP=@CLAVE)=1
		IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'CAJERO(A)')=1
			--PRINT 'CAJERO'
			SET @BAN=3
		ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'MOSTRADOR')=1
			--PRINT 'MOSTRADOR'
			SET @BAN=4
		ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'ENC. DE TIENDA')=1
			--PRINT 'ENC. DE TIENDA'
			SET @BAN=5
		ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'ADMINISTRADOR(A)')=1
			--PRINT 'ADMINISTRADOR(A)'
			SET @BAN=6
		ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'CONTADOR(A)')=1
			--PRINT 'CONTADOR(A)'
			SET @BAN=7
		ELSE IF (SELECT COUNT (*) FROM EMPLEADOS WHERE CVEMP=@CLAVE AND PUESTO = 'AUX. CONTABLE')=1
			--PRINT 'AUX. CONTABLE'
			SET @BAN=8
		ELSE
			--PRINT 'PUESTO NO ESPECIFICADO'
			SET @BAN=9
		ELSE
		--PRINT 'EL EMPLEADO NO EXISTE DENTRO DE LA BD'
		SET @BAN=2



--------------------------------------------------------
--			PROCEDIMIENTOS DE ALMACENADO INSERCION
--------------------------------------------------------
INSEREMP '','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)',1,0
INSEREMP 'IGNACIO SANCHES','','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)',1,0
INSEREMP 'IGNACIO SANCHES','VENECIA#58','','3532101415',32,'CAJERO(A)',1,0 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','',32,'CAJERO(A)',1,0 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415bd',32,'CAJERO(A)',1,0 
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',10,'CAJERO(A)',1,0
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'ADMINISTRADOR(A)','GERENCIA','EL PODER XD','1234',1,0
INSEREMP 'IGNACIO SANCHES','VENECIA#58','IGCHES_1986@hotmail.com','3532101415',32,'CAJERO(A)',1,0
INSEREMP 'ESTOI ARMANDO ESTEBAN QUITO','VENECIA#58','ESARESBAQU_1986@hotmail.com','3532101415',32,'CAJERO(A)','VENTAS','ELPODER3','123',1,0
INSEREMP 'RAMIRO GARCIA','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',30,'MOSTRADOR','COMPRAS','ELPODER2','12345',1,0 --CON EL SE HARAN PRUEBAS DE ELIMINARLO
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
		--HACEMOS EL UPDATE DE EMPLEADOS A LA ORIGINAL
		--------------------------------------------------------
		INSERT INTO FarmSAntonio.DBO.EMPLEADOS
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
			--HACEMOS EL UPDATE DE VENTA DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE  FarmSAntonio.DBO.DETVTAPRO
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
			--HACEMOS EL UPDATE DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
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
			--HACEMOS EL UPDATE DE VENTAS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE FarmSAntonio.DBO.VENTAS
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
			--HACEMOS EL UPDATE DETALLE VENTA EMPLEADO (ORIGINAL)
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETVTAEMP
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
			--HACEMOS EL UPDATE DETALLE VENTA DE PRODUCTO AL ORIGINAL
			--------------------------------------------------------
			INSERT INTO FarmSAntonio.DBO.DETVTAPRO (
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
			--HACEMOS EL UPDATE DE RESTA DE PRODUCTO AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.PRODUCTOS
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
			--HACEMOS EL UPDATE DE VENTAS AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.VENTAS
			SET SUBTOTAL = SUBTOTAL + (
					@CANTVP * (
						SELECT PRECIOVTAP
						FROM PRODUCTOS
						WHERE CVEPROD = @CVEPROD
						)
					) * .84
			WHERE CVEVTA = @CVEVTA --los productos tienen iva

			UPDATE FarmSAntonio.DBO.VENTAS
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
			UPDATE FarmSAntonio.DBO.DETVTAEMP
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

DETVME '',4000,3,'C:/img/imgrect1.PDF',1,0
DETVME 100,'',1,'C:/img/imgrect3.PDF',1,0
DETVME 112,4000,1,'C:/img/imgrect6.PDF',1,0
DETVME 100,'',1,'C:/img/imgrect7.PDF',1,0
DETVME 100,4000,0,'C:/img/imgrect8.PDF',1,0
DETVME 100,4000,1,'',1,0
DETVME 100,4002,1,'C:/img/imgrect8.PDF',1,0
DETVME 100,4000,1,'C:/img/imgrect8.PDF',1,0
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
			UPDATE FarmSAntonio.DBO.DETVTAMED SET CANTVM = CANTVM + @CANTVM	WHERE CVEMED = @CVEMED AND CVEVTA = @CVEVTA

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE MEDICAMENTOS	SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS AL ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.MEDICAMENTOS SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE EXISTENCIAS DE MEDICAMENTOS A COMPRAS
			--------------------------------------------------------
			UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET EXISTENCIASM = EXISTENCIASM - @CANTVM WHERE CVEMED = @CVEMED

			--------------------------------------------------------
			--HACEMOS EL UPDATE DE SUBTOTAL DE PRODUCTOS (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS SET SUBTOTAL = SUBTOTAL + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS	WHERE CVEMED = @CVEMED)) WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE SUBTOTAL DE PRODUCTOS A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.VENTAS SET SUBTOTAL = SUBTOTAL + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS WHERE CVEMED = @CVEMED)) WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE IVA  (ACTUAL)
			--------------------------------------------------------
			UPDATE VENTAS
			SET IVA = IVA + (@CANTVM * (SELECT PRECIOVTAM FROM MEDICAMENTOS	WHERE CVEMED = @CVEMED)) * 0
			WHERE CVEVTA = @CVEVTA --Los medicamentos no tienen iva (o tiene tasa 0%)
			--------------------------------------------------------
			--HACEMOS EL UPDATE DE IVA  A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.VENTAS SET IVA = IVA + (
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
			--HACEMOS EL UPDATE DE IVA  A LA ORIGINAL
			--------------------------------------------------------
			UPDATE FarmSAntonio.DBO.DETVTAEMP
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
				--INSERCION DE DEETVMED  A LA ORIGINAL
				--------------------------------------------------------
				INSERT INTO FarmSAntonio.DBO.DETVTAMED (
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
				--UPDATE A LA EXISTENCIA DE MEDICAMENTOS DESPUÉS DE VENTA A LA ORIGINAL
				--------------------------------------------------------
				UPDATE FarmSAntonio.DBO.MEDICAMENTOS
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
				UPDATE FarmSAntonio.DBO.VENTAS
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
				--UPDATE AL IVA DE VENTA  A LA ORIGINAL
				--------------------------------------------------------
				UPDATE FarmSAntonio.DBO.VENTAS
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
				--UPDATE A LA COMISION DEL EMPLEADO  A LA ORIGINAL
				--------------------------------------------------------
				UPDATE FarmSAntonio.DBO.DETVTAEMP
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
	--UPDATE DE VENTAS  A LA ORIGINAL
	--------------------------------------------------------
	INSERT INTO FarmSAntonio.DBO.VENTAS (
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
	INSERT INTO FarmSAntonio.DBO.DETVTAEMP (
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
BAJAEMP '' --VACIO
BAJAEMP 35 --NO EXISTE
BAJAEMP 1 --TIENE RELACIONES
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
					DELETE FarmSAntonio.DBO.EMPLEADOS WHERE CVEMP=@CVEMP
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
				UPDATE FarmSAntonio.DBO.EMPLEADOS SET ACTIVO = 0 WHERE CVEMP=@CVEMP
			COMMIT TRAN
END
ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53



----------------------------------------------------
--PROCEDIMENTO DE ALAMACENADO PARA ELIMNAR VENTAS
----------------------------------------------------

/*ACTUALIZACION, EN ESTE CASO SOLO PUEDE ELIMINAR LOS EMPLEADOS CON PUESTO EN GERENCIA*/
BAJAVTAS ''
BAJAVTAS 233
BAJAVTAS 102,0 --EL BUENO


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
			DELETE FarmSAntonio.dbo.DETVTAEMP WHERE CVEVTA=@CVEVTA
			DELETE VENTAS WHERE CVEVTA=@CVEVTA
			DELETE FarmSAntonio.dbo.VENTAS WHERE CVEVTA=@CVEVTA
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

BAJADETMED 100,4001,'C:/img/imgrect8.PDF'
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
		UPDATE FarmSAntonio.dbo.MEDICAMENTOS SET EXISTENCIASM =EXISTENCIASM+@CANTVTA WHERE CVEMED=@CVEMED --ORIGINAL
		--SE REDUCE EL TOTAL DE LA VENTA
		UPDATE VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonio.dbo.VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))WHERE CVEVTA =@CVEVTA
		UPDATE VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * 0 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonio.dbo.VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX)) * 0 WHERE CVEVTA =@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		--SE REDUCE LA COMISION DEL EMPLEADO
		UPDATE DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		UPDATE FarmSAntonio.dbo.DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		COMMIT TRAN
		BEGIN TRAN 
		DELETE DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED =@CVEMED and imgrect = @rect
		DELETE FarmSAntonio.dbo.DETVTAMED WHERE CVEVTA=@CVEVTA AND CVEMED= @CVEMED and imgrect = @rect
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

 BAJADETPROD 100,2 --no existe
 BAJADETPROD 100,1 --el bueno

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
		UPDATE FarmSAntonio.dbo.PRODUCTOS SET EXISTENCIASP =EXISTENCIASP+@CANTVTA WHERE CVEPROD=@CVEPROD --ORIGINAL
		--SE REDUCE EL TOTAL DE LA VENTA
		UPDATE VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))*.84 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonio.dbo.VENTAS SET SUBTOTAL=SUBTOTAL-(@CANTVTA* (@AUX))*.84 WHERE CVEVTA =@CVEVTA
		UPDATE VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * .16 WHERE CVEVTA =@CVEVTA
		UPDATE FarmSAntonio.dbo.VENTAS SET IVA=IVA-(@CANTVTA* (@AUX)) * .16 WHERE CVEVTA =@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		--SE REDUCE LA COMISION DEL EMPLEADO
		UPDATE DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		UPDATE FarmSAntonio.dbo.DETVTAEMP SET COMISION =((SELECT SUBTOTAL FROM VENTAS WHERE CVEVTA=@CVEVTA)+(SELECT IVA FROM VENTAS WHERE CVEVTA=@CVEVTA))*0.03 WHERE CVEVTA=@CVEVTA
		COMMIT TRAN
		BEGIN TRAN
		DELETE DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD
		DELETE FarmSAntonio.dbo.DETVTAPRO WHERE CVEVTA=@CVEVTA AND CVEPROD=@CVEPROD
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
 MODDETVTAMED 4000,103,'C:/img/imgrect7.PDF'
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
	UPDATE FarmSAntonio.dbo.DETVTAMED SET IMGRECT=@IMGRECT WHERE CVEMED=@CVEMED AND CVEVTA=@CVEVTA --TABLA ORIGINAL
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
	UPDATE FarmSAntonio.dbo.VENTAS SET TIPOPAG=@TIPOPAG WHERE CVEVTA=@CVEVTA --LA BD ORIGINAL
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
MODNOMEMP  5,'RAMIRO CEJA RENTERIA'
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
	UPDATE FarmSAntonio.dbo.EMPLEADOS SET NOMEMP=@NOMBRE WHERE CVEMP=@CVEEMP --ORIGINAL
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
MODTELEMP 1,'353-122-32-32'
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
	UPDATE FarmSAntonio.dbo.EMPLEADOS SET TELEMP=@TEL WHERE CVEMP=@CVEEMP --ORIGINAL
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
MODEDAEMP 3,28
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
	UPDATE FarmSAntonio.dbo.EMPLEADOS SET EDADEMP=@EDAD WHERE CVEMP=@CVEEMP --ORIGINAL
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
MODPUEEMP 3,'CAJERO(A)'

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
	UPDATE FarmSAntonio.dbo.EMPLEADOS SET PUESTO=@PUESTO, DEPTO=@D WHERE CVEMP=@CVEEMP --ORIGINAL
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
		UPDATE FarmSAntonio.DBO.USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
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
MODEMP 5,'MAGINRRA RIDDIM GONZALES','SANTA SOFIA#225','RAMIGARCIA@hotmail.com','3531204789',32,'CAJERO(A)'


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
		UPDATE FarmSAntonio.dbo.EMPLEADOS SET NOMEMP=@NOMEMP, DIREMP=@DIREMP,CORREOEMP=@CORREOEMP,TELEMP=@TELEMP,EDADEMP=@EDADEMP,PUESTO=@PUESTO WHERE CVEMP=@CVEEMP
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
		UPDATE FarmSAntonio.DBO.USUARIOS SET TIPODEPTO=@TDEPTO WHERE CVEMP=@CVEEMP
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
REACTEMP 5
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
				UPDATE FarmSAntonio.DBO.EMPLEADOS  SET ACTIVO = 1 WHERE CVEMP=@CVEMP
			COMMIT TRAN
		END
	ELSE
		PRINT 'EL EMPLEADO YA SE ENCUENTRA DADO DE ALTA'
		--SET @BAN = 3
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53

/*REACTIVACION DE MEDICAMENTOS*/
REACTMED ''
REACTMED 40024
REACTMED 4000
REACTMED 4002

SELECT * FROM MEDICAMENTOS

CREATE alter PROC REACTMED
@CVEMED INT
,@clave int
,@BAN INT OUTPUT
AS
IF @CVEMED='' OR @CVEMED=0
	--PRINT 'LA CLAVE DEL MEDICAMENTO NO PUEDE ESTAR VACIA'
	SET @BAN = 1
ELSE IF (SELECT COUNT(*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=0
	--PRINT 'LA CLAVE DEL MEDICAMENTO NO EXISTE'
	SET @BAN = 2
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
begin
	IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED)=1
		IF (SELECT  COUNT (*) FROM MEDICAMENTOS WHERE CVEMED=@CVEMED AND ESTADO=0)=1
			BEGIN
				BEGIN TRAN
					UPDATE MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonio.DBO.MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
					UPDATE FarmSAntonioCompras.DBO.MEDICAMENTOS SET ESTADO=1 WHERE CVEMED=@CVEMED
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EL MEDICAMENTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE'
			SET @BAN=3
	ELSE 
		--PRINT 'EL MEDICAMENTO NO SE ENCUENTRA DADO DE ALTA '
		SET @BAN=4 
end
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53
/*REACTIVACION DE PRODUCTOS*/

REACTPROD ''
REACTPROD 34343
REACTPROD 5
REACTPROD 5
SELECT * FROM PRODUCTOS

CREATE alter PROC REACTPROD
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
else if (select count (*) from USUARIOS where CVEMP =@clave)=0
	--print 'EL USUARIO NO EXISTE'
	set @ban = 51
else if (select count (*) from USUARIOS where cvemp=@clave and sesion=1)=0 /*condicion que hay que repetir*/
	--print 'SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR'
	set @ban = 52
else if (select count (*) from USUARIOS where cvemp=@clave and tipodepto = 'G')=1 
BEGIN
	IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD)=1
		IF (SELECT  COUNT (*) FROM PRODUCTOS WHERE CVEPROD=@CVEPROD AND ESTADO=0)=1
			BEGIN
				BEGIN TRAN
					UPDATE PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonio.DBO.PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
					UPDATE FarmSAntonioCompras.DBO.PRODUCTOS SET ESTADO=1 WHERE CVEPROD=@CVEPROD
				COMMIT TRAN
			END
		ELSE
			--PRINT 'EL PRODUCTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE'
			SET @BAN=3
	ELSE 
		--PRINT 'EL PRODUCTO NO SE ENCUENTRA DADO DE ALTA '
		SET @BAN=4
END
  ELSE
--PRINT 'EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION'
SET @BAN=53