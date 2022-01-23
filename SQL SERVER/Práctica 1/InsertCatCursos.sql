USE InstitutoTich
SET IDENTITY_INSERT [dbo].[CatCursos] ON 
INSERT [dbo].[CatCursos] ([idCatCursos], [clave], [nombre], [descripcion], [horas], [idPreRequisito], [activo]) VALUES (1, '1A', 'Curso SQL Server', 'El objetivo de este curso es preparar al estudiante en tecnologías de SQL Server', 45, 1, 1)
INSERT [dbo].[CatCursos] ([idCatCursos], [clave], [nombre], [descripcion], [horas], [idPreRequisito], [activo]) VALUES (2, '2A', 'Curso Introducción ASP.NET Y C#', 'El objetivo de este curso es preparar al estudiante en tecnologías ASP.NET', 45, 2, 0)
INSERT [dbo].[CatCursos] ([idCatCursos], [clave], [nombre], [descripcion], [horas], [idPreRequisito], [activo]) VALUES (3, '3A', 'Curso ASP.NET C#', 'El objetivo de este curso es desarrollar las habilidades del estudiante en C# ASP.NET', 45, 3, 0)
INSERT [dbo].[CatCursos] ([idCatCursos], [clave], [nombre], [descripcion], [horas], [idPreRequisito], [activo]) VALUES (4, '4A', 'Curso ASP.NET - MVC', 'El objetivo de este curso es introducir al estudiante en tecnologías MVC', 45, 4, 0)

SET IDENTITY_INSERT [dbo].[CatCursos] OFF 

select * from CatCursos;