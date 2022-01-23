-- 1. CREAR FUNCION QUE SUME DOS NUMEROS ENTEROS
ALTER FUNCTION Suma(@valor1 INT, @valor2 INT) RETURNS INT
AS
BEGIN
	DECLARE @suma INT;
	SET @suma = (@valor1 + @valor2);
RETURN @suma
END
GO

-- 2. CREAR FUNCION OBTENER CURP Y REGRESAR GENERO
ALTER FUNCTION GetGenero(@curp CHAR(18)) RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @getGenero CHAR(1), @genero VARCHAR(20);
	SET @getGenero = SUBSTRING(@curp, 11, 1);
IF @getGenero = 'M'
	SET @genero = 'Femenino';
IF @getGenero = 'H'
	SET @genero = 'Masculino';
RETURN @genero
END
GO

-- 3. CREAR FUNCION OBTENER CURP Y REGRESAR FECHA NACIMIENTO
ALTER FUNCTION GetFechaNacimiento(@curp CHAR(18)) RETURNS DATE
AS
BEGIN
	DECLARE @fechaNacimiento VARCHAR(6), @fecha DATE;
	SET @fechaNacimiento = SUBSTRING(@curp, 5, 6);
	SET @fecha = CONVERT(DATE, @fechaNacimiento);
	RETURN @fecha
END
GO

-- 4. CREAR FUNCION OBTENER CURP Y REGRESE ID Y ESTADO
ALTER FUNCTION GetIdEstado(@curp CHAR(18)) RETURNS INT
AS
BEGIN
	DECLARE @getEstado CHAR(2), @getId INT;
	SET @getEstado = SUBSTRING(@curp, 12, 2);
IF @getEstado = 'AS'
	SET @getId = 1;
IF @getEstado = 'BC'
	SET @getId = 2;
IF @getEstado = 'BS'
	SET @getId = 3;
IF @getEstado = 'CC'
	SET @getId = 4;
IF @getEstado = 'CH'
	SET @getId = 5;
IF @getEstado = 'CS'
	SET @getId = 6;
IF @getEstado = 'CL'
	SET @getId = 7;
IF @getEstado = 'CM'
	SET @getId = 8;
IF @getEstado = 'DG'
	SET @getId = 9;
IF @getEstado = 'GT'
	SET @getId = 10;
IF @getEstado = 'GR'
	SET @getId = 11;
IF @getEstado = 'HG'
	SET @getId = 12;
IF @getEstado = 'JC'
	SET @getId = 13;
IF @getEstado = 'MC'
	SET @getId = 14;
IF @getEstado = 'MN'
	SET @getId = 15;
IF @getEstado = 'MS'
	SET @getId = 16;
IF @getEstado = 'NT'
	SET @getId = 17;
IF @getEstado = 'NL'
	SET @getId = 18;
IF @getEstado = 'OC'
	SET @getId = 19;
IF @getEstado = 'PL'
	SET @getId = 20;
IF @getEstado = 'QT'
	SET @getId = 21;
IF @getEstado = 'QR'
	SET @getId = 22;
IF @getEstado = 'SP'
	SET @getId = 23;
IF @getEstado = 'SL'
	SET @getId = 24;
IF @getEstado = 'SR'
	SET @getId = 25;
IF @getEstado = 'TC'
	SET @getId = 26;
IF @getEstado = 'TS'
	SET @getId = 27;
IF @getEstado = 'TL'
	SET @getId = 28;
IF @getEstado = 'VZ'
	SET @getId = 29;
IF @getEstado = 'YN'
	SET @getId = 30;
IF @getEstado = 'ZS'
	SET @getId = 31;
RETURN @getId
END
GO

-- 5. CREAR FUNCION CALCULADORA CON OPERACIONES + - * / % ENTRE 2 ENTEROS Y NO DIVIDIR ENTRE CERO
ALTER FUNCTION Calculadora(@valor1 INT, @operador char(1), @valor2 INT) RETURNS NUMERIC(9,2)
AS
BEGIN
	DECLARE @operacion NUMERIC(9,2), @signo char(1);
	SET @signo = @operador;
IF @signo = '+'
	SET @operacion = (@valor1 + @valor2)
IF @signo = '-'
	SET @operacion = (@valor1 - @valor2)
IF @signo = '*'
	SET @operacion = (@valor1 * @valor2) 
IF @signo = '/'
	SET @operacion = CONVERT(FLOAT, @valor1) / NULLIF(@valor2, 0)
IF @signo = '%'
	SET @operacion = (@valor1 % NULLIF(@valor2, 0))
RETURN @operacion
END
GO

-- 6. CREAR FUNCION IMPORTE A PAGAR DE DETERMINADO INSTRUCTOR Y CURSO
ALTER FUNCTION GetHonorarios(@instructor INT, @curso INT) RETURNS NUMERIC(9,2)
AS
BEGIN
	DECLARE @honorarios NUMERIC(9,2);
	SELECT @honorarios = (Instructores.cuotaHora * CatCursos.horas)*1.20 FROM Instructores
INNER JOIN CursosInstructores ON Instructores.idInstructores=CursosInstructores.idInstructor
INNER JOIN Cursos ON CursosInstructores.idCurso=Cursos.idCursos
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos
WHERE CursosInstructores.idCI=@instructor;
RETURN @honorarios
END
GO

-- 7. CREAR FUNCION EDAD OBTENIENDO FECHA DE NACIMIENTO Y FECHA EN DONDE SE QUIERE LA EDAD
ALTER FUNCTION GetEdad(@fechanacimiento DATE, @fechafutura DATE) RETURNS INT
AS
BEGIN
	DECLARE @edad INT;
	SET @edad = (DATEDIFF(YEAR, @fechanacimiento, @fechafutura) - (CASE
	WHEN DATEADD(YY,DATEDIFF(YEAR, @fechanacimiento, @fechafutura),
	@fechanacimiento)>(@fechafutura) THEN
      1
	ELSE
      0 
	END))
RETURN @edad
END
GO

-- 8. CREAR FUNCION FACTORIAL DE UN ENTERO
ALTER FUNCTION GetFactorial(@numero INT) RETURNS INT
AS
BEGIN
	DECLARE @factorial INT;
	IF @numero <= 1
        SET @factorial = 1
    ELSE
        SET @factorial = @numero * dbo.GetFactorial(@numero - 1)
RETURN @factorial
END
GO

-- 9. CREAR FUNCION DE REEMBOLSO MEDIANTE SUELDO MENSUAL
ALTER FUNCTION RembolsoQuincenal(@sueldo NUMERIC(9,2)) RETURNS NUMERIC(9,2)
AS
BEGIN
	DECLARE @rembolso NUMERIC(9,2);
	SET @rembolso = (@sueldo * 2.5)/12
RETURN @rembolso
END
GO

-- 10. APLICAR IMPUESTO AL SUELDO DEL INSTRUCTOR DEPENDIENDO ESTADO DE NACIMIENTO
ALTER FUNCTION GetSueldoImpuesto(@instructor INT, @curso INT) RETURNS NUMERIC(9,2)
AS
BEGIN
	DECLARE @sueldo NUMERIC(9,2), @estado CHAR(2), @impuesto NUMERIC(9,2);
	SELECT @sueldo = (Instructores.cuotaHora * CatCursos.horas)*1.20 FROM Instructores
		INNER JOIN CursosInstructores ON Instructores.idInstructores=CursosInstructores.idInstructor
		INNER JOIN Cursos ON CursosInstructores.idCurso=Cursos.idCursos
		INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos
		WHERE CursosInstructores.idCI=@instructor;
	SET @estado = SUBSTRING((SELECT curp FROM Instructores WHERE idInstructores=@instructor), 12, 2)
	IF @estado = 'CS'
	SET @impuesto = @sueldo-(@sueldo*0.05);
	ELSE IF @estado = 'SR'
	SET @impuesto = @sueldo-(@sueldo*0.10);
	ELSE IF @estado = 'VZ'
	SET @impuesto = @sueldo-(@sueldo*0.07);
	ELSE
	SET @impuesto = @sueldo-(@sueldo*0.08);
RETURN @impuesto
END
GO

-- 11. OBTENER ALUMNOS CON SU EDAD CUANDO SE INSCRIBIERON Y LA EDAD ACTUAL DE LOS MAYORES DE 25 
SELECT Alumnos.*, dbo.GetEdad(Alumnos.fechaNacimiento, CursosAlumnos.fechaInscripcion) AS EdadInscripcion,
dbo.GetEdad(Alumnos.fechaNacimiento, CURRENT_TIMESTAMP) AS EdadActual FROM Alumnos
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno 
WHERE dbo.GetEdad(Alumnos.fechaNacimiento, CURRENT_TIMESTAMP)>25;

-- 12. CREAR FUNCION PORCENTAJE A DESCONTAR DE LOS REMBOLSOS EN BASE A LOS MESES Y EL SUELDO MENSUAL
ALTER FUNCTION RembolsoDescuento(@sueldo NUMERIC(9,2), @meses INT) RETURNS CHAR(20)
AS
BEGIN
	DECLARE @rembolso CHAR(20), @porcentaje NUMERIC(9,2);
	SET @porcentaje = @sueldo/1000;
	IF @meses = '1'
	SET @rembolso = CONVERT(VARCHAR, @porcentaje) + '%';
	IF @meses = '2'
	SET @rembolso = CONVERT(VARCHAR, @porcentaje/2) + '%';
		IF @meses = '3'
	SET @rembolso = CONVERT(VARCHAR, @porcentaje/4) + '%';
		IF @meses = '4'
	SET @rembolso = CONVERT(VARCHAR, @porcentaje/8) + '%';
		IF @meses = '5'
	SET @rembolso = CONVERT(VARCHAR, @porcentaje/16) + '%';
		IF @meses = '6'
	SET @rembolso = 'No hay descuento :(';
RETURN @rembolso
END
GO

-- 13. CREAR FUNCION CONVERTIR A MAYUSCULAS LA PRIMER LETRA DE CADA PALABRA DE LA CADENA RECIBIDA
ALTER FUNCTION Mayusculas(@texto AS VARCHAR(255)) RETURNS VARCHAR(255)
AS
BEGIN
  DECLARE @reseteo BIT, @regreso VARCHAR(255), @i INT, @conversion char(1);
  SELECT @reseteo = 1, @i = 1, @regreso = '';
  WHILE (@i <= LEN(@texto))
    SELECT @conversion = SUBSTRING(@texto, @i, 1),
      @regreso = @regreso + CASE WHEN @reseteo = 1 THEN UPPER(@conversion) ELSE LOWER(@conversion) END,
      @reseteo = CASE WHEN @conversion LIKE '[a-zA-Z]' THEN 0 ELSE 1 END,
      @i = @i + 1
RETURN @regreso
END
GO