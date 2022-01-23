USE InstitutoTich;

-- 1. CAMBIAR ESTATUS
UPDATE Alumnos SET idEstatus=3 WHERE idEstatus=2;
SELECT * FROM Alumnos;

-- 2. CAMBIAR APELLIDO A MAYUSCULAS
UPDATE Alumnos SET segundoApellido = UPPER(segundoApellido);
SELECT * FROM Alumnos;

-- 3. ACTUALIZAR APELLIDO PRIMER MAYUSCULA DEMÁS MINUSCULAS
UPDATE Alumnos SET segundoApellido = UPPER(LEFT(segundoApellido, 1)) + LOWER(SUBSTRING(segundoApellido, 2, LEN(segundoApellido)));
SELECT * FROM Alumnos;

-- 4. ACTUALIZAR TELEFONO DE INSTRUCTORES QUE EMPIECEN CON 55
UPDATE Instructores SET telefono = REPLACE(telefono, SUBSTRING(telefono, 1, 2), '55') WHERE SUBSTRING(curp, 12, 2)='DF';
SELECT * FROM Instructores;

/* 5. SUBIR 1 DE CALIFICACION A LOS DE HIDALGO Y OAXACA DEL PRIMER CURSO
SE DEBERÁ CONSIDERAR QUE NO SE PUEDE EXCEDER EL MAXIMO DE LA CALIFICACION PERMITIDA */
SELECT * FROM CursosAlumnos; --IdAlumno 1, 3, 4 y 6 son de Oaxaca-Hidalgo
UPDATE CursosAlumnos SET calificacion = IIF(calificacion>=10, calificacion, calificacion+1)
WHERE idAlumno IN (SELECT idAlumnos FROM Alumnos
WHERE (idEstadoOrigen=19 OR idEstadoOrigen=12) AND idCurso=1);

-- 6. SUBIR 10% EN CUOTAHORA A LOS PROFESORES QUE HAYAN IMPARTIDO CURSO .NET C#
SELECT * FROM Instructores; -- Ese curso corresponde al instructor con id=2 y id=4
SELECT * FROM CursosInstructores; -- Curso 3 -> Instructores 2 y 4
SELECT * FROM Cursos;
SELECT * FROM CatCursos;
UPDATE Instructores SET cuotaHora = round(cuotaHora*1.10, LEN(cuotaHora))
WHERE idInstructores IN (SELECT idInstructor FROM CursosInstructores WHERE idCurso=3);

-- 7A. COPIAR TABLA ALUMNOS A ALUMNOSTODOS
SELECT * INTO AlumnosTodos FROM Alumnos;
-- 7B.  COPIAR DE ALUMNOS A LOS DE HIDALGO A ALUMNOSHGO
SELECT * FROM Estados; -- Hidalgo = 12
SELECT * INTO AlumnosHgo FROM Alumnos WHERE idEstadoOrigen=12;
-- 7C. EN ALMNOSHGO CAMBIARLES LA LADA A 77
SELECT * FROM AlumnosHgo;
UPDATE AlumnosHgo SET telefono = REPLACE(telefono, SUBSTRING(telefono, 1, 2), '77');
-- 7D. ACTUALIZAR EL TELEFONO DE LOS DE HIDALGO EN TABLA ALUMNOS DESDE TABLA ALUMNOSHGO
SELECT * FROM Alumnos;
UPDATE Alumnos SET telefono = (SELECT AlumnosHgo.telefono FROM AlumnosHgo)
WHERE idEstadoOrigen = (SELECT AlumnosHgo.idEstadoOrigen FROM AlumnosHgo);