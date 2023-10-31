USE `carcompany`;
DROP PROCEDURE IF EXISTS AltaModelo;

DELIMITER $$
CREATE PROCEDURE AltaModelo(IN pName NVARCHAR(255))
BEGIN
	DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE valid BIT;
    DECLARE lastInsertId INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
        SET nResultado = -1;
        SET cMensaje = 'Ocurrió un error al crear Modelo';
		SELECT nResultado, cMensaje;
	END;
	SET nResultado = 0;
    SET cMensaje =  CONCAT('Modelo creado');
    SET Valid = 1;
    
   IF pName IS NULL OR pName = '' 
   THEN
		SET nResultado = -1;
		SET cMensaje = 'Los parámetros no pueden ser nulos o vacíos';
        SET Valid = 0;
	END IF;
	
    IF Valid = 1
    THEN
		INSERT INTO carcompany.Model(`Name`) VALUES (pName);
        SET lastInsertId = LAST_INSERT_ID();
        
        INSERT INTO carcompany.assemblyline(`ModelId`) VALUES (lastInsertId);
		COMMIT;
    END IF;
    
    SELECT nResultado, cMensaje;
END$$
DELIMITER ;