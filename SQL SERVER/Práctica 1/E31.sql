USE InstitutoTich;
SELECT primerApellido, segundoApellido, nombre, telefono, correo FROM Alumnos;
SELECT nombre, primerApellido, segundoApellido, rfc, cuotaHora FROM Instructores;
SELECT clave, nombre, descripcion, horas FROM CatCursos;

-- 4. SELECCIONAR A LOS 5 MAS JOVENES
SELECT TOP 5 * FROM Alumnos order by fechaNacimiento desc;

-- 5. CREAR BD EJERCICIOS
CREATE DATABASE Ejercicios;

-- 6. Copiar las tablas de Alumnos e Instructores desde la Base de Datos InstitutoTich a la de Ejercicios
SELECT * INTO Ejercicios.dbo.Alumnos_Copia from Alumnos; 
SELECT * INTO Ejercicios.dbo.Instructores_Copia from Instructores; 

USE Ejercicios;
SELECT * INTO Alumnos_Copia from InstitutoTich.dbo.Alumnos;

-- 7. En la Base de Datos Ejercicios copia los registros de Alumnos dentro de la Tabla de Instructores
