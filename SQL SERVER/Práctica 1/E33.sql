USE InstitutoTich;
-- 1. EDAD EN 5 MESES
SELECT idAlumnos, nombre, primerApellido, segundoApellido, fechaNacimiento, CURRENT_TIMESTAMP AS Hoy,

DATEDIFF(YEAR, fechaNacimiento, GETDATE()) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,fechaNacimiento,GETDATE()),
   fechaNacimiento)>GETDATE() THEN
      1
   ELSE
      0 
   END) AS Edad,	

   DATEADD(MONTH, 5, GETDATE()) AS Fecha5meses,

   DATEDIFF(YEAR, fechaNacimiento, (DATEADD(MONTH, 5, GETDATE()))) - (CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR, fechaNacimiento, (DATEADD(MONTH, 5, GETDATE()))),
   fechaNacimiento)>(DATEADD(MONTH, 5, GETDATE())) THEN
      1
   ELSE
      0 
   END) AS Edad5meses FROM Alumnos;