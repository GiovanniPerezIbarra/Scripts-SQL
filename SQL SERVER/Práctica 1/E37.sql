USE InstitutoTich;
-- 1. ALUMNOS CON APELLIDO MENDOZA
SELECT * FROM Alumnos WHERE primerApellido='Mendoza' or segundoApellido='Mendoza';

-- 2. ALUMNOS CON ESTATUS CAPACITACION
SELECT Alumnos.*, EstatusAlumnos.nombre AS estatus FROM Alumnos INNER JOIN EstatusAlumnos
ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos WHERE EstatusAlumnos.nombre='En capacitación';

-- 3. INSTRUCTORES MAYORES DE 30 AÑOS
SELECT *, DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) AS edad
FROM Instructores WHERE DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) > 30;

-- 4. ALUMNOS ENTRE 20 Y 25 AÑOS
SELECT *, DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) AS edad
   FROM Alumnos WHERE DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) BETWEEN 20 AND 25;

-- 5. ALUMNOS DE OAXACA EN CAPACITACION O DE CAMPECHE EN PROSPECTO
SELECT Alumnos.*, Estados.nombre AS estado, EstatusAlumnos.nombre AS estatus FROM Alumnos
INNER JOIN Estados ON Alumnos.idEstadoOrigen=Estados.idEstados
INNER JOIN EstatusAlumnos ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos
WHERE (Estados.nombre='Oaxaca' AND EstatusAlumnos.nombre='En capacitación')
OR (Estados.nombre='Campeche' AND EstatusAlumnos.nombre='Prospecto');

-- 6. ALUMNOS CON CORREO GMAIL
SELECT * FROM ALUMNOS WHERE correo LIKE '%gmail%';

-- 7. ALUMNOS QUE CUMPLEN EN MARZO
SELECT * FROM ALUMNOS WHERE MONTH(fechaNacimiento)=03;

-- 8. ALUMNOS CON 30 AÑOS DENTRO DE 5 AÑOS
SELECT *, DATEDIFF(YEAR, fechaNacimiento, (DATEADD(YEAR, 5, GETDATE()))) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR, fechaNacimiento, (DATEADD(YEAR, 5, GETDATE()))),
   fechaNacimiento)>(DATEADD(MONTH, 5, GETDATE())) THEN
      1
   ELSE
      0 
   END) AS edad5años
   FROM Alumnos WHERE DATEDIFF(YEAR, fechaNacimiento, (DATEADD(YEAR, 5, GETDATE()))) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR, fechaNacimiento, (DATEADD(YEAR, 5, GETDATE()))),
   fechaNacimiento)>(DATEADD(MONTH, 5, GETDATE())) THEN
      1
   ELSE
      0 
   END) = 30;

-- 9. ALUMNOS CON NOMBRE > 10 CARACTERES
SELECT * FROM ALUMNOS WHERE LEN(nombre)>10; 

-- 10. ALUMNOS CON ULTIMO CARACTER CURP NUMERICO
SELECT * FROM Alumnos WHERE ISNUMERIC(SUBSTRING(curp, 18, 1))=1;

-- 11. ALUMNOS CON CALIFICACION MAYOR A 8
SELECT Alumnos.*, CursosAlumnos.calificacion FROM Alumnos INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno
WHERE CursosAlumnos.calificacion>8;

-- 12. ALUMNOS LIBERADOS O LABORANDO CON SUELDO>15,000
SELECT Alumnos.*, EstatusAlumnos.nombre AS estatus FROM Alumnos INNER JOIN EstatusAlumnos ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos
WHERE Alumnos.sueldo>=15000.00 AND (EstatusAlumnos.nombre='Laborando' OR EstatusAlumnos.nombre='Liberado');

-- 13. ALUMNOS NACIDOS ENTRE 1990-1995 Y APELLIDO QUE EMPIECE CON B, C, o Z
SELECT * FROM Alumnos WHERE (YEAR(fechaNacimiento) BETWEEN 1990 AND 1995) AND
(primerApellido LIKE 'B%' OR primerApellido LIKE 'C%' OR primerApellido LIKE 'Z%');

-- 14. ALUMNOS CUYA FECHA NACIMIENTO NO ES IGUAL A LA DEL CURP
SELECT nombre, curp, fechaNacimiento, (TRY_CONVERT(date, SUBSTRING(curp, 5, 6))) AS fechaCurp
FROM Alumnos WHERE (TRY_CONVERT(date, SUBSTRING(curp, 5, 6)))<>fechaNacimiento;

-- 15.ALUMNOS APELLIDO EMPIECE CON A NACIERON EN ABRIL Y QUE TENGAN ENTRE 21 Y 30 AÑOS
SELECT *, 
DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) AS edad
FROM Alumnos WHERE primerApellido LIKE 'A%' AND MONTH(fechaNacimiento)=04 AND 
(DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) BETWEEN 21 AND 30);

-- 16. ALUMNOS QUE SE LLAMEN LUIS 
SELECT * FROM Alumnos WHERE nombre LIKE '%Luis%';

-- 17. CURSOS IMPARTIDOS EN EL 2021
SELECT CatCursos.nombre, Cursos.fechaInicio, Cursos.fechaTermino, COUNT(*) AS TotalAlumnos, AVG(CursosAlumnos.calificacion)
AS PromedioCalificaciones FROM CatCursos INNER JOIN Cursos ON CatCursos.idCatCursos=Cursos.idCatCurso
INNER JOIN CursosAlumnos ON Cursos.idCursos=CursosAlumnos.idCurso WHERE YEAR(Cursos.fechaInicio)=2021
GROUP BY CatCursos.nombre, Cursos.fechaInicio, Cursos.fechaTermino;

-- 18. RESUMEN CALIFICACIONES MAYORES A 6 POR ESTADO, SOLO ESTADOS CON MAS DE 1 ALUMNO CON PROMEDIO CALIFICACION MAYOR A 6
SELECT Estados.nombre AS estado, COUNT(*) AS Total, AVG(CursosAlumnos.calificacion) AS PromedioCalif, AVG(Alumnos.sueldo) AS PromedioSueldo
FROM Estados INNER JOIN Alumnos ON Estados.idEstados=Alumnos.idEstadoOrigen
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno 
GROUP BY Estados.nombre HAVING AVG(CursosAlumnos.calificacion)>6 AND COUNT(*)>2;