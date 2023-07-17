USE proyecto_;

CREATE VIEW pagos_completos AS
	SELECT f.IDPedido, pe.FechaPedido, pg.FechaPago
	FROM facturas f
	JOIN pagos pg
	ON f.IDFactura = pg.IDFactura
	JOIN pedidos pe
	ON f.IDPedido = pe.IDPedido 
	WHERE f.EstadoDePago = "Completada";

CREATE VIEW sin_pagar AS
	SELECT f.IDPedido, pe.FechaPedido
	FROM pedidos pe
	JOIN facturas f
	ON pe.IDPedido = f.IDPedido
	WHERE EstadoDePago = "Sin pagar";

CREATE VIEW pagos_pendientes AS
	SELECT fa.IDFactura, fa.IDPedido, fa.MontoTotal, pa.Monto, pe.FechaPedido, pa.FechaPago
	FROM facturas fa
	JOIN pedidos pe
	ON fa.IDPedido = pe.IDPedido
	JOIN pagos pa
	ON pa.IDFactura = fa.IDFactura
	WHERE fa.EstadoDePago = "Pendientes";

CREATE VIEW envios_recibidos AS
	SELECT pe.FechaPedido, en.FechaEnvio, cl.Correo, cl.Telefono, cl.Direccion
    FROM pedidos pe
    JOIN envios en
    ON pe.IDPedido = en.IDPedido
    JOIN clientes cl
    ON cl.IDCliente = pe.IDCliente
    WHERE en.EstadoEnvio = "Recibido";


CREATE VIEW productos_en_garantia AS
	SELECT pr.Nombre, pr.Precio, ga.FechaEmision
    FROM productos pr
    JOIN productos_garantia pg
    ON pr.IDProducto = pg.IDProducto
    JOIN garantia ga
    ON pg.IDGarantia = ga.IDGarantia;

/*
SELECT * FROM sin_pagar;
SELECT * FROM pagos_completos;
SELECT * FROM pagos_pendientes;
SELECT * FROM envios_recibidos;
SELECT * FROM productos_en_garantia;
*/