USE proyecto_;

DELIMITER $$

CREATE PROCEDURE ordenamiento(IN tabla VARCHAR(200), campo VARCHAR(200), orden VARCHAR(20))
BEGIN

	IF tabla <> " " AND campo <> " " AND orden <> " " THEN
		SET @MODO_DE_ORDEN = CONCAT("SELECT * FROM ", tabla, " ORDER BY ", campo," ", orden);
    END IF;

	PREPARE stmt FROM @MODO_DE_ORDEN;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;
/*
El primer S.P. es un método de ordenamiento que te permite ordenar la tabla que tu le indiques por la columna que desees y el método de ordenamiento que necesites por medio de 3 párametros. El primer párametro será el nombre
de la tabla la cual quieres ordenar, el segundo párametro es la columna por la cual deseas ordenarla, y el tercer parametro es el método de ordenamiento ya sea ascendente o descendente. 

A continuación dejo algunos ejemplos para aplicar la consulta.


CALL ordenamiento('facturas', 'MontoTotal', 'ASC');
CALL ordenamiento("clientes", "Nombres", "DESC");
CALL ordenamiento("empleados", "Sueldo", "DESC");
CALL ordenamiento("pagos", "FechaPago", "DESC");
*/

DELIMITER $$

CREATE PROCEDURE insercion_de_clientes(IN nombres VARCHAR(100), apellidop VARCHAR(100), apellidom VARCHAR(100), correo VARCHAR(100), telefono VARCHAR(100), direccion VARCHAR(100))
BEGIN

	IF nombres <>  " " AND apellidop <> " " AND apellidom <> " " AND correo <> " " AND telefono <> " " AND direccion <> " " THEN
    INSERT INTO clientes(Nombres, ApellidoP, ApellidoM, Correo, Telefono, Direccion) VALUES (nombres, apellidop, apellidom, correo, telefono, direccion);
    END IF;
	
    SET @comprobacion = "SELECT * FROM clientes ORDER BY IDCliente DESC ";
    PREPARE runSQL FROM @comprobacion;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
    
END$$;

DELIMITER ;

/*
En este S.P. se hace una insercion de datos a la columna de clientes, otorgandole los parametros necesarios para que se pueda hacer la insercion correctamente los cuales son: El nombre, los apellidos, el correo, el telefono,
la direccion y automaticamente muestra los datos insertados ordenandolos por el ID de manera descendiente. A continuacion dejo unos ejemplos para ejecutar el Stored Procedure.

call insercion_de_clientes("Ana Paula", "Montiel", "Bustos", "aanaa1502@gmail.com", "(444)444-4444", "Fueginrola, España");
CALL insercion_de_clientes("Maria Fernanda", "Santos", "Espinoza", "mfse@gmail.com", "(333)333-3333", "Tamaulipas, México");
*/