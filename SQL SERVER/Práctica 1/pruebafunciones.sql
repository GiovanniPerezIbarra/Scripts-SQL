-- SUMA DE NUMEROS
SELECT dbo.Suma(5, 9);

-- OBTENER SEXO DEL CURP
SELECT dbo.GetGenero(A.curp) FROM Alumnos A;

-- OBTENER FECHA NACIMIENTO DEL CURP
SELECT dbo.GetFechaNacimiento(A.curp) FROM Alumnos A;

-- OBTENER ID ESTADO DEL CURP
SELECT dbo.GetIdEstado(A.curp) FROM Alumnos A;

-- CALCULADORA
SELECT dbo.Calculadora(100, '%', 9);

-- HONORARIOS
SELECT dbo.GetHonorarios(8,1);

SELECT Instructores.curp, Instructores.cuotaHora, CatCursos.horas FROM Instructores
INNER JOIN CursosInstructores ON Instructores.idInstructores=CursosInstructores.idInstructor
INNER JOIN Cursos ON CursosInstructores.idCurso=Cursos.idCursos
INNER JOIN CatCursos ON Cursos.idCatCurso=CatCursos.idCatCursos;

-- EDAD
SELECT dbo.GetEdad('1992-09-30', '2022-01-14');

-- FACTORIAL
SELECT dbo.GetFactorial(4)

-- REMBOLSO QUINCENAL
SELECT dbo.RembolsoQuincenal(25000);

-- OBTENER IMPUESTO DEPENDE LE ESTADO
SELECT dbo.GetSueldoImpuesto(8, 1);

-- EDAD ACTUAL Y CUANDO SE INSCRIBIERON LOS ALUMNOS MAYORES DE 25 
SELECT Alumnos.*, dbo.GetEdad(Alumnos.fechaNacimiento, CursosAlumnos.fechaInscripcion) AS EdadInscripcion,
dbo.GetEdad(Alumnos.fechaNacimiento, CURRENT_TIMESTAMP) AS EdadActual FROM Alumnos
INNER JOIN CursosAlumnos ON Alumnos.idAlumnos=CursosAlumnos.idAlumno 
WHERE dbo.GetEdad(Alumnos.fechaNacimiento, CURRENT_TIMESTAMP)>25;

-- REMBOLSO
SELECT dbo.RembolsoDescuento(31000, 6);

-- CONVERTIR A MAYUSCULAS LA PRIMERA DE CADA PALABRA
SELECT dbo.Mayusculas('anita lava la tina');