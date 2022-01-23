USE InstitutoTich;
-- 1. NOMBRE Y APELLIDOS EN MAYUSCULAS
SELECT idAlumnos, UPPER(nombre) AS nombre, UPPER(primerApellido) AS primerApellido,
UPPER(segundoApellido) AS segundoApellido, fechaNacimiento, CURRENT_TIMESTAMP AS Hoy,

DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) AS Edad,	

   DATEDIFF(YEAR, fechaNacimiento, (DATEADD(MONTH, 5, GETDATE()))) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR, fechaNacimiento, (DATEADD(MONTH, 5, GETDATE()))),
   fechaNacimiento)>(DATEADD(MONTH, 5, GETDATE())) THEN
      1
   ELSE
      0 
   END) AS Edad5meses FROM Alumnos;

-- 2. EXTRAER LA FECHA DE NACIMIENTO DEL CURP
SELECT idAlumnos, UPPER(nombre) AS nombre, UPPER(primerApellido) AS primerApellido,
UPPER(segundoApellido) AS segundoApellido, fechaNacimiento, curp, (TRY_CONVERT(date, SUBSTRING(curp, 5, 6)))
AS fechaCurp FROM Alumnos;


-- 3. MOSTRAR SI ES HOMBRE O MUJER SEGUN EL CURP
SELECT idAlumnos, UPPER(nombre) AS nombre, UPPER(primerApellido) AS primerApellido,
UPPER(segundoApellido) AS segundoApellido, fechaNacimiento, curp,  genero = CASE
WHEN SUBSTRING(curp, 11, 1)='M' THEN 'Mujer'
WHEN SUBSTRING(curp, 11, 1)='H' THEN 'Hombre'
ELSE 'Ni idea jaja'
END
FROM Alumnos;

-- 4. CAMBIAR GMAIL POR HOTMAIL
SELECT idAlumnos, nombre, primerApellido, segundoApellido, fechaNacimiento, correo, 
REPLACE(correo, 'gmail', 'hotmail') AS correoHotmail FROM Alumnos;

