USE InstitutoTich;
-- 1. ALUMNO CON NOMBRE DE LONGITUD MAS GRANDE
SELECT * FROM Alumnos WHERE LEN(nombre) = (SELECT MAX(LEN(nombre)) FROM Alumnos);

-- 2. ALUMNO MENOS JOVEN
SELECT * FROM Alumnos WHERE fechaNacimiento = (SELECT MIN(fechaNacimiento) FROM Alumnos);

-- 3. LISTA DE ALUMNOS CON MAXIMA CALIFICACION
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, Alumnos.fechaNacimiento, CatCursos.nombre, Cursos.fechaInicio,
Cursos.fechaTermino, acm.calificacion FROM Alumnos
INNER JOIN (SELECT CursosAlumnos.idCurso,  CursosAlumnos.idAlumno,  CursosAlumnos.calificacion FROM CursosAlumnos
INNER JOIN (SELECT idCurso, MAX(calificacion) AS maxCal FROM CursosAlumnos GROUP BY idCurso) AS calMax
ON CursosAlumnos.idCurso = calMax.idCurso AND CursosAlumnos.calificacion = calMax.maxCal) AS acm 
ON Alumnos.idAlumnos = acm.idAlumno INNER JOIN Cursos
ON acm.idCurso = Cursos.idCursos INNER JOIN CatCursos
ON Cursos.idCatCurso = CatCursos.idCatCursos WHERE calificacion IN
(SELECT MAX(calificacion) FROM CursosAlumnos);

-- 4. OBTENER LA INFORMACION DE CADA UNO DE LOS CURSOS
SELECT cc.nombre, cu.fechaInicio, cu.fechaTermino, COUNT(A.idAlumnos) AS total, MAX(ca.calificacion) AS cmax,
MIN(ca.calificacion) AS cmin, AVG(ca.calificacion) AS promedio FROM CatCursos cc
INNER JOIN (SELECT idCursos, idCatCurso, fechaInicio, fechaTermino FROM Cursos) AS cu ON cu.idCatCurso = cc.idCatCursos
INNER JOIN (SELECT idCurso, idAlumno, idCA, calificacion FROM CursosAlumnos) AS ca ON ca.idCurso = cu.idCursos
INNER JOIN Alumnos a ON a.idAlumnos = ca.idAlumno GROUP BY cc.nombre, cu.fechaInicio, cu.fechaTermino; 

-- 5. ALUMNOS CON CALIFICACION IGUAL O MENOR QUE EL PROMEDIO
SELECT * FROM CursosAlumnos;
SELECT * FROM Alumnos WHERE idAlumnos IN (SELECT idAlumno FROM CursosAlumnos
WHERE calificacion<= (SELECT AVG(calificacion) FROM CursosAlumnos));

-- 6. LISTA DE ALUMNOS CON MAXIMA CALIFICACION POR CURSO
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, Alumnos.fechaNacimiento, CatCursos.nombre, Cursos.fechaInicio,
Cursos.fechaTermino, acm.calificacion FROM Alumnos
INNER JOIN (SELECT CursosAlumnos.idCurso,  CursosAlumnos.idAlumno,  CursosAlumnos.calificacion FROM CursosAlumnos
INNER JOIN (SELECT idCurso, MAX(calificacion) AS maxCal FROM CursosAlumnos GROUP BY idCurso) AS calMax
ON CursosAlumnos.idCurso = calMax.idCurso AND CursosAlumnos.calificacion = calMax.maxCal) AS acm
ON Alumnos.idAlumnos = acm.idAlumno INNER JOIN Cursos
ON acm.idCurso = Cursos.idCursos INNER JOIN CatCursos
ON Cursos.idCatCurso = CatCursos.idCatCursos;













