USE InstitutoTich;

-- 1. CONSULTA NOMBRES, APELLIDOS, MES Y DIA DE NACIMIENTO DE ALUMNOS Y PROFESORES ORDENADOS POR MES Y DIA
SELECT 'Alumno' AS tipopersona, nombre, primerApellido, segundoApellido, MONTH(fechaNacimiento) AS mes, DAY(fechaNacimiento) AS dia
FROM Alumnos
UNION
SELECT 'Instructor' AS tipopersona, nombre, primerApellido, segundoApellido, MONTH(fechaNacimiento) AS mes, DAY(fechaNacimiento) AS dia
FROM Instructores ORDER BY mes, dia;