-- 1. CREAR VISTA
ALTER VIEW verAlumnos AS SELECT idAlumnos, Alumnos.nombre, primerApellido, segundoApellido, correo, telefono,
curp, Estados.nombre AS estados, EstatusAlumnos.nombre AS estatus FROM Alumnos
INNER JOIN Estados ON Alumnos.idEstadoOrigen=Estados.idEstados
INNER JOIN EstatusAlumnos ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos; 

SELECT * FROM verAlumnos;

-- 2. RETORNAR ESTADO O ESTADOS SI ES -1
ALTER PROCEDURE consultarEstado(@idEstado INT)
AS
BEGIN
	DECLARE @estado VARCHAR(100);
	IF @idEstado = -1
	SELECT * FROM Estados;
	ELSE
	SELECT * FROM Estados WHERE idEstados=@idEstado
END

EXECUTE consultarEstado 0;

-- 3. RETORNAR ESTATUS O TODOS LOS ESTATUS SI ES -1
ALTER PROCEDURE consultarEstatusAlumnos(@idEstatus INT)
AS
BEGIN
	DECLARE @estatus VARCHAR(100);
	IF @idEstatus = -1
	SELECT idEstatusAlumnos, nombre FROM EstatusAlumnos;
	ELSE
	SELECT idEstatusAlumnos, nombre FROM EstatusAlumnos WHERE idEstatusAlumnos=@idEstatus
END

EXECUTE consultarEstatusAlumnos 6;

-- 4. CONSULTAR ALUMNOS
ALTER PROCEDURE consultarAlumnos(@idAlumnos INT)
AS
BEGIN
	DECLARE @alumnos VARCHAR(100);
	IF @idAlumnos = -1
	SELECT idAlumnos, Alumnos.nombre, primerApellido, segundoApellido, correo, telefono, fechaNacimiento, curp,
	Estados.nombre AS estados, EstatusAlumnos.nombre AS estatus FROM Alumnos
	INNER JOIN Estados ON Alumnos.idEstadoOrigen=Estados.idEstados
	INNER JOIN EstatusAlumnos ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos;
	ELSE
	SELECT idAlumnos, Alumnos.nombre, primerApellido, segundoApellido, correo, telefono, fechaNacimiento, curp,
	Estados.nombre AS estados, EstatusAlumnos.nombre AS estatus FROM Alumnos
	INNER JOIN Estados ON Alumnos.idEstadoOrigen=Estados.idEstados
	INNER JOIN EstatusAlumnos ON Alumnos.idEstatus=EstatusAlumnos.idEstatusAlumnos WHERE idAlumnos=@idAlumnos;
END

EXECUTE consultarAlumnos -1;

-- 5. CONSULTAR E ALUMNO
ALTER PROCEDURE consultarEAlumnos(@idAlumnos INT)
AS
BEGIN
	DECLARE @alumnos VARCHAR(100);
	IF @idAlumnos = -1
	SELECT idAlumnos, nombre, primerApellido, segundoApellido, correo, telefono, fechaNacimiento, curp,
	idEstadoOrigen AS estados, idEstatus AS estatus FROM Alumnos
	ELSE
	SELECT idAlumnos, nombre, primerApellido, segundoApellido, correo, telefono, fechaNacimiento, curp,
	idEstadoOrigen AS estados, idEstatus AS estatus FROM Alumnos WHERE idAlumnos=@idAlumnos
END

EXECUTE consultarEAlumnos -1;

-- 6. CAMBIAR ESTATUS DEL ALUMNO
ALTER PROCEDURE actualizaEstatusAlumnos(@idAlumnos INT, @nuevoEstatus INT)
AS
BEGIN
	UPDATE Alumnos SET idEstatus = @nuevoEstatus WHERE idAlumnos = @idAlumnos;
END

EXECUTE actualizaEstatusAlumnos 1, 2;
SELECT * FROM Alumnos;

-- 7. AGREGAR ALUMNOS
ALTER PROCEDURE agregarAlumnos(@nombre VARCHAR(60), @primerApellido VARCHAR(50), @segundoApellido VARCHAR(50),
@correo VARCHAR(80), @telefono NCHAR(10), @fechaNacimiento DATE, @curp CHAR(18), @sueldo DECIMAL(9,2), @idEstadoOrigen INT,
@idEtatus INT)
AS
BEGIN
	INSERT INTO ALUMNOS  VALUES(@nombre, @primerApellido, @segundoApellido,
	@correo, @telefono, @fechaNacimiento, @curp, @sueldo, @idEstadoOrigen, @idEtatus)
	SELECT MAX(idAlumnos) FROM Alumnos;
END

EXECUTE agregarAlumnos 'Gabriela Aislinn', 'Cuevas', 'Maya', 'gabi@gmail.com', '5576493045', '1998-07-15', 'CMGA980715MMC43206',
30000, 15, 1;
SELECT * FROM Alumnos;

-- 8. ACTUALIZAR CAMPOS DE ESE ALUMNO
ALTER PROCEDURE actualizarAlumnos(@idAlumno INT, @nombre VARCHAR(60), @primerApellido VARCHAR(50), @segundoApellido VARCHAR(50),
@correo VARCHAR(80), @telefono NCHAR(10), @fechaNacimiento DATE, @curp CHAR(18), @sueldo DECIMAL(9,2), @idEstadoOrigen INT,
@idEtatus INT)
AS
BEGIN
	UPDATE ALUMNOS SET nombre=@nombre, primerApellido=@primerApellido, segundoApellido=@segundoApellido,
	correo=@correo, telefono=@telefono, fechaNacimiento=@fechaNacimiento, curp=@curp, sueldo=@sueldo,
	idEstadoOrigen=@idEstadoOrigen, idEstatus=@idEtatus WHERE idAlumnos=@idAlumno;
	SELECT @idAlumno
END

EXECUTE actualizarAlumnos 19, 'Gabriela', 'Cueva', 'Mayas', 'laais@gmail.com', '5576493033', '1998-06-15', 'CMGA980715MMC43207',
33000, 13, 5;
SELECT * FROM Alumnos;

-- 9. ELIMINAR ALUMNOS
ALTER PROCEDURE eliminarAlumnos(@idAlumno INT)
AS
BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM CursosAlumnos WHERE idAlumno=@idAlumno;
		DELETE FROM Alumnos WHERE idAlumnos=@idAlumno;
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	IF(ERROR_MESSAGE()=0)
	SELECT 'No hay registros que borrar';
END CATCH

EXECUTE eliminarAlumnos -1;
SELECT * FROM Alumnos;

-- 10. TRIGGER QUE PASE EL ALUMNO ELIMINADO A ALUMNOS BAJA 
ALTER TRIGGER eliminarAlumnoBaja ON Alumnos AFTER DELETE
AS
BEGIN
	INSERT INTO AlumnosBaja (nombre, primerApellido, segundoApellido, fechaBaja)
	SELECT B.nombre, B.primerApellido, B.segundoApellido, GETDATE() FROM deleted B;
END

DELETE FROM Alumnos WHERE idAlumnos = 20;
SELECT * FROM AlumnosBaja

-- 11. BACKUP DE LA BASE DE DATOS (VISUAL)
-- 12. CREAR NUEVA BASE (VISUAL)

-- 13. ELIMINAR ALUMNOS DE UN CURSO MEDIANTE ID CURSO
ALTER PROCEDURE spEliminaAlumnosCurso (@nombre VARCHAR(50))
AS
BEGIN
DELETE FROM CursosAlumnos WHERE idAlumno IN (SELECT A.idAlumnos FROM alumnos A, CursosAlumnos CA, Cursos C, CatCursos CAT
    WHERE 1 = 1 AND CAT.idCatCursos = C.idCatCurso AND C.idCursos = CA.idCurso	AND CA.idAlumno = A.idAlumnos
	AND CAT.nombre = @nombre);
	DELETE FROM Alumnos WHERE idAlumnos IN (SELECT A.idAlumnos FROM alumnos A, CursosAlumnos CA, Cursos C, CatCursos CAT
    WHERE 1 = 1 AND CAT.idCatCursos = C.idCatCurso AND C.idCursos = CA.idCurso	AND CA.idAlumno = A.idAlumnos
	AND CAT.nombre = @nombre);
END

EXECUTE spEliminaAlumnosCurso @nombre = 'Curso SQL Server';
