USE proyecto_;

SHOW TABLES;

#VISTAS
#VISTA PARA EL ALMACEN
SELECT * FROM envios_recibidos;
SELECT * FROM pagos_completos;
SELECT * FROM pagos_pendientes;
SELECT * FROM productos_en_garantia;
SELECT * FROM sin_pagar;

#Stored procedures
CALL ordenamiento('facturas', 'IDPedido', 'ASC'); #Este es un procedure para ordenar la tabla que quieras, por la columna deseada y del metodo ascendente o descendente
CALL ordenamiento("clientes", "Nombres", "DESC");
CALL ordenamiento("empleados", "Sueldo", "DESC");
CALL ordenamiento("pagos", "Monto", "ASC");

SELECT * FROM clientes;

call insercion_de_clientes("Ana Paula", "Montiel", "Bustos", "aanaa1502@gmail.com", "(444)444-4444", "Fueginrola, España"); #Este es un stored procedure que sirve para insertar registros en la tabla de clientes.
CALL insercion_de_clientes("Maria Fernanda", "Santos", "Espinoza", "mfse@gmail.com", "(333)333-3333", "Tamaulipas, México");

#Funciones
SELECT cantidad_cliente("Red Winfred", "Winfred") AS compras_del_cliente;
SELECT cantidad_cliente("Dahlia Greenacre", "Wilmott") AS compras_del_cliente;#Esta funcion cuantifica las compras que el cliente ah realizado
SELECT compras_mensuales(05,2023) AS compras_mensuales;#Esta funcion cuantifica las compras que se han hecho a lo largo del mes
SELECT compras_mensuales(07,2023) AS compras_mensuales;

#Triggers

SELECT * FROM insert_logs;
SELECT * FROM deleted_logs;
SELECT * FROM updated_logs;

SELECT * FROM almacen;