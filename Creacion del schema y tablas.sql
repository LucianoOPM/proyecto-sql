CREATE SCHEMA Proyecto_;

USE Proyecto_;

CREATE TABLE clientes(
IDCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombres VARCHAR(20) NOT NULL,
ApellidoP VARCHAR(20) NOT NULL,
ApellidoM VARCHAR(20) NOT NULL,
Correo VARCHAR(50),
Telefono VARCHAR(13),
Direccion VARCHAR(100)
);

CREATE TABLE garantia(
IDGarantia INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
IDCliente INT NOT NULL,
FechaEmision DATE NOT NULL,
	FOREIGN KEY(IDCliente) REFERENCES clientes(IDCliente)
);

CREATE TABLE pedidos(
IDPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
IDCliente INT NOT NULL,
	FOREIGN KEY(IDCliente) REFERENCES clientes(IDCliente),
FechaPedido DATE NOT NULL
);

CREATE TABLE envios(
IDEnvio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
FechaEnvio DATE NOT NULL,
EstadoEnvio VARCHAR(50),
IDPedido INT NOT NULL,
	FOREIGN KEY(IDPedido) REFERENCES pedidos(IDPedido)
);

CREATE TABLE facturas(
IDFactura INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
MontoTotal DECIMAL NOT NULL,
EstadoDePago VARCHAR(20) NOT NULL,
IDPedido INT NOT NULL,
	FOREIGN KEY(IDPedido) REFERENCES pedidos(IDPedido)
);

CREATE TABLE pagos(
IDPago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
FechaPago DATE NOT NULL,
Monto DECIMAL NOT NULL,
MetodoPago VARCHAR(20),
IDCliente INT NOT NULL,
	FOREIGN KEY(IDCliente) REFERENCES clientes(IDCliente),
IDFactura INT NOT NULL,
	FOREIGN KEY(IDFactura) REFERENCES facturas(IDFactura)
);

CREATE TABLE ofertas(
IDOferta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Duracion INT NOT NULL,
Nombre VARCHAR(20) NOT NULL,
Descuento DECIMAL
);

CREATE TABLE productos(
IDProducto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(100) NOT NULL,
Precio DECIMAL NOT NULL,
IDOferta INT,
	FOREIGN KEY(IDOferta) REFERENCES ofertas(IDOferta),
CalificacionTotal DECIMAL NOT NULL
);

CREATE TABLE review(
IDReview INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
IDCliente INT NOT NULL,
	FOREIGN KEY(IDCliente) REFERENCES clientes(IDCliente),
FechaReview DATE NOT NULL,
Calificacion INT NOT NULL,
IDProducto INT NOT NULL,
	FOREIGN KEY(IDProducto) REFERENCES productos(IDProducto)
);

CREATE TABLE productos_garantia(
IDGarantia INT NOT NULL,
	FOREIGN KEY(IDGarantia) REFERENCES garantia(IDGarantia),
IDProducto INT NOT NULL,
	FOREIGN KEY(IDProducto) REFERENCES productos(IDProducto)
);

CREATE TABLE productos_pedidos(
IDPedido INT NOT NULL,
	FOREIGN KEY(IDPedido) REFERENCES pedidos(IDPedido),
IDProducto INT NOT NULL,
	FOREIGN KEY(IDProducto) REFERENCES productos(IDProducto),
CantidadProducto INT NOT NULL
);

CREATE TABLE sucursal(
IDSucursal INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Direccion VARCHAR(100) NOT NULL,
Telefono VARCHAR(13),
Correo VARCHAR(50)
);

CREATE TABLE empleados(
IDEmpleado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombres VARCHAR(50) NOT NULL,
ApellidoP VARCHAR(20) NOT NULL,
ApellidoM VARCHAR(20) NOT NULL,
Cargo VARCHAR(20) NOT NULL,
Sueldo DECIMAL NOT NULL,
IDSucursal INT NOT NULL,
	FOREIGN KEY(IDSucursal) REFERENCES sucursal(IDSucursal)
);

CREATE TABLE almacen(
IDSucursal INT NOT NULL,
	FOREIGN KEY (IDSucursal) REFERENCES sucursal(IDSucursal),
IDProducto INT NOT NULL,
	FOREIGN KEY(IDProducto) REFERENCES productos(IDProducto),
CantidadProducto INT NOT NULL
);

CREATE TABLE proveedor(
IDProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
NombreProveedor VARCHAR(100) NOT NULL,
Email VARCHAR(30) NOT NULL,
Telefono VARCHAR(30) NOT NULL
);

CREATE TABLE envios_proveedor(
IDProveedor INT NOT NULL,
	FOREIGN KEY(IDProveedor) REFERENCES proveedor(IDProveedor),
IDSucursal INT NOT NULL,
	FOREIGN KEY(IDSucursal) REFERENCES sucursal(IDSucursal),
IDProducto INT NOT NULL,
	FOREIGN KEY(IDProducto) REFERENCES productos(IDProducto),
CantidadProducto INT NOT NULL
);