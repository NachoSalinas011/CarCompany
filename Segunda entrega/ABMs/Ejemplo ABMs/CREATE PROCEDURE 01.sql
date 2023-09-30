CREATE DATABASE IF NOT EXISTS CarCompany;
USE CarCompany;

DROP PROCEDURE IF EXISTS newSupplier;

DELIMITER $$
CREATE PROCEDURE newSupplier (IN pId INT, IN pName VARCHAR(255), IN pAdress VARCHAR(255), IN pPhoneNumber VARCHAR(255))
BEGIN
	DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE valid BIT;

	DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	BEGIN
        SET nResultado = -1;
        SET cMensaje = CONCAT('Ya existe un Supplier con ID ', CAST(pId AS CHAR));
		SELECT nResultado, cMensaje;
	END;
	SET nResultado = 0;
    SET cMensaje =  CONCAT('Supplier ID ', CAST(pId AS CHAR), ' creado');
    SET Valid = 1;
    
   IF pId IS NULL OR pName IS NULL OR pAdress IS NULL OR pPhoneNumber IS NULL OR
   pName = '' OR pAdress = '' OR pPhoneNumber = ''
   THEN
		SET nResultado = -1;
		SET cMensaje = 'Los parámetros no pueden ser nulos o vacíos';
        SET Valid = 0;
	END IF;
	
    IF Valid = 1
    THEN
		INSERT INTO carcompany.supplier(`Id`, `Name`, `Adrress`, `PhoneNumber`) VALUES (pId, pName, pAdress, pPhoneNumber);
		COMMIT;
    END IF;
    
    SELECT nResultado, cMensaje;
END$$
DELIMITER ;