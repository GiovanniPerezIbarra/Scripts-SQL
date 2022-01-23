USE InstitutoTich;
-- 1. ALUMNOS POR ESTADO
SELECT Estados.nombre AS estado, COUNT(*) AS TotalAlumnos FROM Alumnos INNER JOIN Estados
ON Alumnos.idEstadoOrigen=Estados.idEstados GROUP BY Estados.nombre; 

-- 2. ALUMNOS POR ESTATUS
SELECT EstatusAlumnos.nombre AS estatus, COUNT(*) AS Total FROM Alumnos INNER JOIN EstatusAlumnos
ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos GROUP BY EstatusAlumnos.nombre; 

-- 3. TOTAL, MINIMO, MAXIMO Y PROMEDIO DE CALIFICACIONES
SELECT 'Calificaciones alumnos' AS resumenCalificaciones, COUNT(calificacion) AS total, MAX(calificacion) AS maxima,
MIN(calificacion) AS minima, AVG(calificacion) AS promedio FROM CursosAlumnos;

-- 4. RESUMEN DE CALIFICACIONES POR CURSO
SELECT nombre AS curso, Cursos.fechaInicio, Cursos.fechaTermino, COUNT(CursosAlumnos.calificacion) AS total,
MAX(CursosAlumnos.calificacion) AS maxima, MIN(CursosAlumnos.calificacion) AS minima, AVG(CursosAlumnos.calificacion)
AS promedio FROM CatCursos INNER JOIN Cursos ON CatCursos.idCatCursos=Cursos.idCatCurso
INNER JOIN CursosAlumnos ON CursosAlumnos.idCurso=Cursos.idCursos GROUP BY nombre, Cursos.fechaInicio, Cursos.fechaTermino;

-- 5. RESUMEN DE CALIFICACIONES POR ESTADO Y MAYORES A 6
SELECT Estados.nombre AS estado, COUNT(CursosAlumnos.calificacion) AS total,
MAX(CursosAlumnos.calificacion) AS maxima, MIN(CursosAlumnos.calificacion) AS minima, AVG(CursosAlumnos.calificacion)
AS promedio FROM Estados INNER JOIN Alumnos ON Estados.idEstados=Alumnos.idEstadoOrigen
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno GROUP BY Estados.nombre HAVING AVG(CursosAlumnos.calificacion)>6;