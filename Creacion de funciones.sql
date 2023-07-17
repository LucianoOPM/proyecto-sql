USE proyecto_;

DELIMITER $$

CREATE FUNCTION cantidad_cliente(nombre_cliente VARCHAR(100), apellido_cliente VARCHAR(100))
RETURNS INT
READS SQL DATA
BEGIN

	IF nombre_cliente = " " OR apellido_cliente = " " THEN
		SET @err = "Empty values";
		RETURN @err;
	ELSE
		SET @err = " ";
        IF NOT EXISTS(SELECT IDCliente FROM clientes WHERE Nombres = nombre_cliente) THEN
			SET @err = "Hay un error con el nombre";
		END IF;
        IF NOT EXISTS(SELECT IDCliente FROM clientes WHERE ApellidoM = apellido_cliente OR ApellidoP = apellido_cliente) THEN
			SET @err = "Hay un error con los apellidos";
		END IF;
        
        IF @err != " " THEN
			RETURN @err;
		ELSE
			RETURN(SELECT SUM(CantidadProducto)
				FROM productos_pedidos pp
				JOIN pedidos pe
				ON pp.IDPedido = pe.IDPedido
				WHERE pe.IDCliente = (SELECT IDCliente from clientes where Nombres = nombre_cliente AND ApellidoP = apellido_cliente OR ApellidoM = apellido_cliente));
		END IF;
	END IF;
END$$;

DELIMITER ;

DELIMITER $$

CREATE FUNCTION compras_mensuales(mes INT, año INT)
RETURNS INT
READS SQL DATA
BEGIN
	
	IF mes = "" OR año = "" THEN
		SET @err = "Hay datos vacios";
        RETURN @err;
	
    ELSE
		SET @err = "";
        IF NOT EXISTS(SELECT IDPedido FROM pedidos WHERE MONTH(FechaPedido) = mes) THEN
			SET @err = "No hay datos registrados";
		END IF;
        IF NOT EXISTS(SELECT IDPedido FROM pedidos WHERE YEAR(FechaPedido) = año) THEN
			SET @err = "No hay datos registrados";
		END IF;
        IF @err <> "" THEN
			RETURN @err;
		ELSE
			RETURN(SELECT COUNT(FechaPedido) FROM pedidos WHERE MONTH(FechaPedido) = mes  AND YEAR(FechaPedido) = año);
		END IF;
	
    END IF;
END$$;

DELIMITER ;



/*
SELECT cantidad_cliente("Red Winfred", "Winfred") AS compras_del_cliente;
SELECT cantidad_cliente("Dahlia Greenacre", "Wilmott") AS compras_del_cliente;
SELECT compras_mensuales(05,2023) AS compras_mensuales;
SELECT compras_mensuales(11,2023) AS compras_mensuales;
*/