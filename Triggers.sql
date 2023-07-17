USE proyecto_;

CREATE TABLE insert_logs(
idlog INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
user_log VARCHAR(100),
date_log DATETIME,
entity_log VARCHAR(100),
logged_value VARCHAR(100),
logged_id INT
);

CREATE TABLE deleted_logs(
idupdate INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
deleted_by VARCHAR(100),
deleted_date DATETIME,
deleted_entity VARCHAR(100),
deleted_value VARCHAR(100),
deleted_id INT
);

CREATE TABLE updated_logs(
idupdate INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
updated_by VARCHAR(100),
update_date DATETIME,
updated_entity VARCHAR(100),
old_value VARCHAR(100),
new_value VARCHAR(100),
id_value VARCHAR(100)
);

CREATE TRIGGER customer_insert
AFTER INSERT ON clientes
FOR EACH ROW
INSERT INTO insert_logs(user_log, date_log, entity_log, logged_value, logged_id) VALUES (user(), now(), "clientes", NEW.Nombres, NEW.IDCliente);

CREATE TRIGGER customer_delete
BEFORE DELETE ON clientes
FOR EACH ROW
INSERT INTO deleted_logs(deleted_by, deleted_date, deleted_entity, deleted_value, deleted_id) VALUES (user(), now(), "clientes", OLD.Nombres, OLD.IDCliente);

CREATE TRIGGER offer_insert
AFTER INSERT ON ofertas
FOR EACH ROW
INSERT INTO insert_logs(user_log, date_log, entity_log, logged_value, logged_id) VALUES(user(), now(), "ofertas", NEW.Nombre, NEW.IDOferta);

DELIMITER &&

CREATE TRIGGER offer_update
BEFORE UPDATE ON ofertas
FOR EACH ROW
BEGIN
	IF NEW.Duracion <> OLD.Duracion THEN
		SET @viejo = OLD.Duracion;
		SET @cambio = NEW.Duracion;
	ELSEIF NEW.nombre <> OLD.Nombre THEN
		SET @viejo = OLD.Nombre;
		SET @cambio = NEW.Nombre;
	ELSEIF NEW.Descuento <> OLD.Descuento THEN
		SET @viejo = OLD.Descuento;
        SET @cambio = NEW.Descuento;
    END IF;
    
    INSERT INTO updated_logs(updated_by, update_date, updated_entity, old_value, new_value, id_value) VALUES (USER(), NOW(), "ofertas", @viejo, @cambio, OLD.IDOferta);
END&&;

DELIMITER ;

/*
INSERT INTO clientes(Nombres, ApellidoP, ApellidoM, Correo, Telefono, Direccion)
VALUES
("Sheyla Tamara", "Velazquez", "Espinosa", "Sheyla123@gmail.com", "(888)888-8888","Ciudad de México, México");

DELETE FROM clientes WHERE IDCliente > 100;

INSERT INTO ofertas(Duracion, Nombre, Descuento)
VALUES(20, "Ofertas Inviertno", 15);

UPDATE ofertas SET Duracion = 15 WHERE IDOferta = 11;
UPDATE ofertas SET Nombre = "Ofertas Invierno" WHERE IDOferta = 11;

SELECT * FROM insert_logs;
SELECT * FROM deleted_logs;
SELECT * FROM updated_logs;
*/