-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: proyecto_
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `deleted_logs`
--

LOCK TABLES `deleted_logs` WRITE;
/*!40000 ALTER TABLE `deleted_logs` DISABLE KEYS */;
INSERT INTO `deleted_logs` VALUES (1,'root@localhost','2023-01-12 14:48:43','clientes','Sheyla Tamara',106),(2,'root@localhost','2023-01-17 11:41:31','clientes','Ana Paula',107);
/*!40000 ALTER TABLE `deleted_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `insert_logs`
--

LOCK TABLES `insert_logs` WRITE;
/*!40000 ALTER TABLE `insert_logs` DISABLE KEYS */;
INSERT INTO `insert_logs` VALUES (1,'root@localhost','2023-01-12 14:44:30','clientes','Sheyla Tamara',105),(2,'root@localhost','2023-01-12 14:48:40','clientes','Sheyla Tamara',106),(3,'root@localhost','2023-01-12 16:50:31','ofertas','Ofertas Inviertno',11),(4,'usertest2@localhost','2023-01-17 11:39:26','clientes','Ana Paula',107);
/*!40000 ALTER TABLE `insert_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `updated_logs`
--

LOCK TABLES `updated_logs` WRITE;
/*!40000 ALTER TABLE `updated_logs` DISABLE KEYS */;
INSERT INTO `updated_logs` VALUES (1,'root@localhost','2023-01-12 16:53:30','ofertas','Ofertas Inviertno','Ofertas Invierno','11'),(2,'root@localhost','2023-01-12 16:55:37','ofertas','20','15','11');
/*!40000 ALTER TABLE `updated_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'proyecto_'
--
/*!50003 DROP FUNCTION IF EXISTS `cantidad_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `cantidad_cliente`(nombre_cliente VARCHAR(100), apellido_cliente VARCHAR(100)) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `compras_mensuales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `compras_mensuales`(mes INT, año INT) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insercion_de_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insercion_de_clientes`(IN nombres VARCHAR(100), apellidop VARCHAR(100), apellidom VARCHAR(100), correo VARCHAR(100), telefono VARCHAR(100), direccion VARCHAR(100))
BEGIN

	IF nombres <>  " " AND apellidop <> " " AND apellidom <> " " AND correo <> " " AND telefono <> " " AND direccion <> " " THEN
    INSERT INTO clientes(Nombres, ApellidoP, ApellidoM, Correo, Telefono, Direccion) VALUES (nombres, apellidop, apellidom, correo, telefono, direccion);
    END IF;
	
    SET @comprobacion = "SELECT * FROM clientes ORDER BY IDCliente DESC ";
    PREPARE runSQL FROM @comprobacion;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordenamiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ordenamiento`(IN tabla VARCHAR(200), campo VARCHAR(200), orden VARCHAR(20))
BEGIN

	IF tabla <> " " AND campo <> " " AND orden <> " " THEN
		SET @MODO_DE_ORDEN = CONCAT("SELECT * FROM ", tabla, " ORDER BY ", campo," ", orden);
    END IF;

	PREPARE stmt FROM @MODO_DE_ORDEN;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pagos_completos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pagos_completos`(IN estado_pago VARCHAR(20))
BEGIN
	IF estado_pago = "Sin Pagar" or "sin pagar" THEN
		SELECT f.IDPedido, pe.FechaPedido
		FROM pedidos pe
		JOIN facturas f
		ON pe.IDPedido = f.IDPedido
		WHERE EstadoDePago = estado_pago;
    ELSEIF estado_pago = "Pendientes" or "pendientes" THEN
		SELECT  pe.IDPedido, pe.FechaPedido, fa.MontoTotal, pa.FechaPago, pa.Monto
        FROM pedidos pe
        JOIN facturas fa
        ON pe.IDPedido = fa.IDPedido
        JOIN pagos pa
        ON fa.IDFactura = pa.IDFactura
        WHERE EstadoDePago = estado_pago;
	ELSEIF estado_pago = "Completada" OR "completada" THEN
		SELECT f.IDPedido, pe.FechaPedido, pg.FechaPago
		FROM facturas f
		JOIN pagos pg
		ON f.IDFactura = pg.IDFactura
		JOIN pedidos pe
		ON f.IDPedido = pe.IDPedido 
        WHERE f.EstadoDePago = estado_pago;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-24 23:28:23
