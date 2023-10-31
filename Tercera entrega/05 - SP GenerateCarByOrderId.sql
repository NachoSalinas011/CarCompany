DELIMITER $$

-- DROP PROCEDURE GenerateCarByOrderId

CREATE PROCEDURE `GenerateCarByOrderId`(IN pOrderId INT)
BEGIN
    DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE modelCursor INT;
    DECLARE generatedPatent NVARCHAR(7);
	DECLARE acabado BOOLEAN DEFAULT FALSE; 
	DECLARE insertInCar CURSOR FOR SELECT ModelId FROM `order_detail` WHERE OrderId = pOrderId;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET acabado = TRUE; 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET nResultado = -1;
        SET cMensaje = "Error al intentar generar los registros.";
    END;
    
    OPEN insertInCar;
    REPEAT
    FETCH insertInCar INTO modelCursor;
    
    
    IF NOT acabado THEN
		BEGIN
			CALL newPatent(generatedPatent);
            
			INSERT INTO `car` (Patent, Modelid, OrderId, FinishDate)
            VALUES (generatedPatent, modelCursor, pOrderId, DATE_ADD(NOW(), INTERVAL 7 DAY));
		END;
    END IF;
    
    UNTIL acabado END REPEAT;
    
    SET nResultado = 0;
    SET cMensaje = "";
    SELECT nResultado AS Resultado, cMensaje AS Mensaje;
END$$

DELIMITER ;