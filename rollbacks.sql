USE proyecto_;

SELECT @@AUTOCOMMIT;
SET AUTOCOMMIT = 0;

START TRANSACTION;
DELETE FROM envios WHERE EstadoEnvio = "Recibido";

#ROLLBACK;Cuando se hace un rollback sin especificar se "deshacen" todos los cambios realizados después de la transacción.
#COMMIT;


START TRANSACTION;
INSERT INTO productos(Nombre, Precio, IDOferta, CalificacionTotal) VALUES
	("Procesador Intel 11th Gen", 3000, null, 3),
	("Gabinete NZXT H100", 2000, null, 4),
	("Teclado membrana Logitech", 250, 2, 3),
	("Mouse inalambrico gamer", 700, 2, 3);
SAVEPOINT lote_1;
INSERT INTO productos(Nombre, Precio, IDOferta, CalificacionTotal)
VALUES
	("Tarjeta de video AMD RX7700", 5900, 3, 5),
    ("Procesador AMD Ryzen 3600", 3300, null, 4),
    ("Procesador AMD Ryzen 3 3200G", 2300, null, 5),
    ("Silla Gamer Corsair", 4500, 10, 3);
SAVEPOINT lote_2;


#RELEASE SAVEPOINT lote_1;