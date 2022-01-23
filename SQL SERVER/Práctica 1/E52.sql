USE InstitutoTich;
-- 1. CREAR FUNCION QUE OBTENGA LA TABLA AMORTIZACIÓN DE LOS REEMBOLSOS QUINCENALES DE ALGUIEN EN 6 MESES
ALTER FUNCTION Amortizacion(@idAlumnos INT)
RETURNS @ResultTable TABLE 
(Quincena INT, SaldoAnterior DECIMAL(9,2), Pago DECIMAL(9,2), SaldoNuevo DECIMAL(9,2))
AS
BEGIN
	DECLARE @Quincena INT, @SaldoAnterior DECIMAL(9,2), @SaldoNuevo DECIMAL(9,2), @Pago DECIMAL(9,2);
	SET @Quincena = 1;
	SET @SaldoAnterior = (SELECT (a.sueldo * 2.5) FROM Alumnos a WHERE a.idAlumnos = @idAlumnos);
	SET @SaldoNuevo = (SELECT @SaldoAnterior - dbo.RembolsoQuincenal(a.sueldo) FROM alumnos a WHERE a.idAlumnos = @idAlumnos);
	SET @Pago = (SELECT dbo.RembolsoQuincenal(a.sueldo) FROM alumnos a WHERE a.idAlumnos = @idAlumnos);
	WHILE @Quincena <= 12
		BEGIN
		INSERT  @ResultTable
		SELECT @Quincena, @SaldoAnterior, @Pago, @SaldoNuevo;
		SET @Quincena = @Quincena +1;
		SET @SaldoAnterior = @SaldoNuevo;
		SET @SaldoNuevo = @SaldoAnterior - @Pago;
	END;
	RETURN
END;

SELECT * FROM dbo.Amortizacion(3);

-- 2. AMORTIZACION INSTRUCTORES
CREATE FUNCTION AmortizacionInst(@idInst INT)
RETURNS @AmortizacionTabla TABLE (Quincena INT, DineroPrestamo DECIMAL(9,2), Pago DECIMAL(9,2), Debiendo DECIMAL(9,2))
AS
 BEGIN
	DECLARE @Quincena INT, @DineroPrestamo DECIMAL(9,2), @Pago DECIMAL(9,2), @Debiendo DECIMAL(9,2), @Interes DECIMAL(9,2)
			SET @Interes = IIF((SELECT ins.cuotaHora FROM instructores ins WHERE ins.idInstructores = @idInst)>200, 1.24, 1.18)
			SET @Quincena  = 1
			SET @DineroPrestamo = (SELECT (ins.cuotaHora * 200) FROM instructores ins WHERE ins.idInstructores = @idInst)
			SET @Pago = (@DineroPrestamo / 12)*@Interes
			SET @Debiendo = @DineroPrestamo - @Pago
		WHILE @Quincena <= 12
			BEGIN
			INSERT INTO @AmortizacionTabla VALUES(@Quincena, @DineroPrestamo, @Pago, @Debiendo)
			SET @Quincena = @Quincena + 1
			SET @DineroPrestamo = @Debiendo
			SET @Debiendo = @DineroPrestamo - @Pago
		END
	RETURN
 END;

 SELECT * FROM AmortizacionInst(1);