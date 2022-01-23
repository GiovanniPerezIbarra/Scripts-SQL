USE InstitutoTich;
-- 1. MOSTRAR CIERTOS CAMPOS DE INSTRUCTORES
SELECT nombre, primerApellido, segundoApellido, rfc, cuotaHora, activo FROM Instructores;

-- 2. INNER JOIN COMBINAR TABLAS CURSOS Y CATCURSOS
SELECT CatCursos.nombre, CatCursos.horas, Cursos.fechaInicio, Cursos.fechaTermino
from CatCursos RIGHT JOIN Cursos ON CatCursos.idCatCursos=Cursos.idCatCurso  WHERE nombre LIKE '%Curso ASP.NET%';

-- 3. INNER JOIN COMBINAR TABLAS ALUMNOS, ESTADO Y ESTATUS
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, Alumnos.curp,
Estados.nombre AS estado, EstatusAlumnos.nombre AS estatus
FROM Alumnos INNER JOIN Estados
ON Alumnos.idEstadoOrigen=Estados.idEstados 
RIGHT JOIN EstatusAlumnos 
ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos  WHERE Alumnos.nombre IS NOT NULL;

-- 4. INNER JOIN COMBINAR INSTRUCTORES CON CATCURSOS
SELECT CONCAT(Instructores.nombre, ' ', primerApellido, ' ', segundoApellido) instructor, Instructores.cuotaHora,
CatCursos.nombre AS nombre, Cursos.fechaInicio AS fechaInicio, Cursos.fechaTermino AS fechaTermino
FROM Instructores INNER JOIN CursosInstructores ON Instructores.idInstructores= CursosInstructores.idCI
INNER JOIN Cursos ON Cursos.idCursos=CursosInstructores.idCurso
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos;

-- 5. INNER JOIN COMBINAR ALUMNOS CON CATCURSOS
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, Estados.nombre AS estado, CatCursos.nombre AS curso,
CursosAlumnos.fechaInscripcion AS fechaInscripcion, Cursos.fechaInicio AS fechaInicio, Cursos.fechaTermino AS fechaTermino,
CursosAlumnos.calificacion AS calificacion FROM Alumnos
INNER JOIN Estados ON Alumnos.idEstadoOrigen=Estados.idEstados
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno
INNER JOIN Cursos ON Cursos.idCursos=CursosAlumnos.idCurso
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos;

-- 6. LO MISMO PERO ORDENAR POR CALIFICACION MAS BAJA
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, CatCursos.nombre AS curso,
Cursos.fechaInicio AS fechaInicio, Cursos.fechaTermino AS fechaTermino,
CursosAlumnos.calificacion AS calificacion FROM Alumnos 
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno
INNER JOIN Cursos ON Cursos.idCursos=CursosAlumnos.idCurso
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos
ORDER BY CursosAlumnos.calificacion DESC;

-- 7. CURSO CON CURSO PREREQUISITO
SELECT A.clave, A.nombre, A.horas, IIF(A.idPreRequisito IS NULL, 'Sin prerequisito', B.nombre) AS preRequisito FROM CatCursos AS A
FULL JOIN CatCursos AS B ON A.idPreRequisito=B.idCatCursos WHERE A.nombre IS NOT NULL;

-- 8. CASE PARA PONERTE EXCELENTE SI SACAS 10
SELECT Alumnos.nombre, Alumnos.primerApellido, Alumnos.segundoApellido, CatCursos.nombre AS curso,
Cursos.fechaInicio AS fechaInicio, Cursos.fechaTermino AS fechaTermino,
CursosAlumnos.calificacion AS calificacion, 
nivel = CASE
WHEN CursosAlumnos.calificacion BETWEEN 9 AND 10 THEN 'Excelente'
WHEN CursosAlumnos.calificacion BETWEEN 7 AND 8 THEN 'Bien'
WHEN CursosAlumnos.calificacion = 6 THEN 'Suficiente'
WHEN CursosAlumnos.calificacion <6 THEN 'N/A'
END
FROM Alumnos 
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno
INNER JOIN Cursos ON Cursos.idCursos=CursosAlumnos.idCurso
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos;

