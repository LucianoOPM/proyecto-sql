USE mysql;

CREATE USER usertest1@localhost; #Creación del usuario el cual se dedicará a solamente hacer consultas SELECT en todas las tablas del schema.
CREATE USER usertest2@localhost IDENTIFIED BY "contraseña456"; #Creación del usuario el cual se dedicará a lectura, modificación e inserción de datos en las tablas del schema.

GRANT SELECT ON proyecto_.* TO usertest1@localhost; #Aqui se le designa al usuario "test1" que solamente podrá hacer select en todas las tablas del schema "proyecto_".
GRANT SELECT, INSERT, UPDATE ON proyecto_.* TO usertest2@localhost; #Aqui se le designa al usuario "test2" que podrá realizar las tareas de inserción, seleccion y actualización sobre todas las tablas del schema "proyecto_".

DROP user usertest1@localhost;
drop user usertest2@localhost;

SELECT * FROM user