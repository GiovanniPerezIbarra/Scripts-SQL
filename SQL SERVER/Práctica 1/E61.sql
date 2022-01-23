-- 1. CREAR STORE PROCEDURE DEL CODIGO ASCII QUE IMPRIMA CARACTERES CON SU RESPECITVO CODIGO EN DECIMAL SOLO PARA LOS MAYORES A 32
ALTER PROCEDURE CODIGOASCII
AS
BEGIN
	DECLARE @codigo VARCHAR(20), @texto VARCHAR(255), @i INT, @valor INT;
	SET @i = 32;
	WHILE @i <= 255
	BEGIN
	    SET @i = @i+1
		SET @codigo = CHAR(@i)
		SET @valor = ASCII(@codigo)
		SET @texto = @codigo + ' ASCII => ' + CAST(@valor AS NCHAR(10));
		PRINT @texto
	END
END

EXECUTE CODIGOASCII

-- 2. FACTORIAL
ALTER PROCEDURE Factorial(@numero INT)
AS
BEGIN
    DECLARE @i  NUMERIC
    IF @numero <= 1
        SET @i = 1
    ELSE
        SELECT @i = @numero * dbo.GetFactorial(@numero - 1)
	PRINT @i
END

EXECUTE Factorial 5;

-- 3. CREAR TABLAS (VISUAL)
-- 4. TRANSACCIONES CON ESAS TABLAS
ALTER PROCEDURE Transaccion (@idOrigen INT, @idDestino INT, @monto NUMERIC(18,2))
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE saldos SET nombre = 'transacción', saldo = saldo - @monto WHERE id = @idOrigen;
			UPDATE saldos SET nombre = 'transaccion', saldo = saldo + @monto WHERE id = @idDestino;
			INSERT INTO Transacciones (idOrigen, idDestino, monto) VALUES (@idOrigen, @idDestino, @monto);			
		COMMIT TRANSACTION
		PRINT 'Transacción exitosa';
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION
		PRINT 'Error en la transacción';
	END CATCH
END


EXECUTE dbo.Transaccion 2, 1, 25000;

SELECT * FROM saldos;
SELECT * FROM Transacciones;