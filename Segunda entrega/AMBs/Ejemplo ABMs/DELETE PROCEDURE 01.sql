CREATE DATABASE IF NOT EXISTS CarCompany;
USE CarCompany;

DROP PROCEDURE IF EXISTS deleteSupplier;

DELIMITER $$
CREATE PROCEDURE deleteSupplier (IN pId INT)
BEGIN
	DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE valid BIT;
    DECLARE existInDb INT;
    
	SET nResultado = 0;
    SET cMensaje = CONCAT('Supplier ID ', CAST(pId AS CHAR), ' eliminado');
    SET Valid = 1;
    SELECT Id INTO existInDb FROM Supplier WHERE Id = pId;
    
    IF existInDb IS NULL
    THEN
		SET nResultado = -1;
		SET cMensaje = CONCAT('No existe un Supplier con ID ', CAST(PId AS CHAR));
        SET Valid = 0;
    END IF;
        
    IF Valid = 1
    THEN
		DELETE FROM carcompany.supplier s
        WHERE Id = pId;
    END IF;
    
    SELECT nResultado, cMensaje;
END$$
DELIMITER ;