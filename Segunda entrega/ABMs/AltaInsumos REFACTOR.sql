CREATE DATABASE IF NOT EXISTS CarCompany;
USE CarCompany;

/* ******************** CREATE PROVEEDOR ******************** */
DROP PROCEDURE IF EXISTS newSupplier;
DELIMITER $$
CREATE PROCEDURE newSupplier (IN pName VARCHAR(255), IN pAdress VARCHAR(255), IN pPhoneNumber VARCHAR(255))
BEGIN
	DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE valid BIT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
        SET nResultado = -1;
        SET cMensaje = 'Ocurrió un error al crear Supplier';
		SELECT nResultado, cMensaje;
	END;
	SET nResultado = 0;
    SET cMensaje =  'Supplier creado';
    SET Valid = 1;
    
   IF pName IS NULL OR pAdress IS NULL OR pPhoneNumber IS NULL OR
   pName = '' OR pAdress = '' OR pPhoneNumber = ''
   THEN
		SET nResultado = -1;
		SET cMensaje = 'Los parámetros no pueden ser nulos o vacíos';
        SET Valid = 0;
	END IF;
	
    IF Valid = 1
    THEN
		INSERT INTO carcompany.supplier(`Name`, `Adrress`, `PhoneNumber`) VALUES (pName, pAdress, pPhoneNumber);
		COMMIT;
    END IF;
    
    SELECT nResultado, cMensaje;
END$$
DELIMITER ;

/* ******************** UPDATE PROVEEDOR ******************** */
DROP PROCEDURE IF EXISTS updateSupplier;
DELIMITER $$
CREATE PROCEDURE updateSupplier (IN pId INT, IN pName VARCHAR(255), IN pAdress VARCHAR(255), IN pPhoneNumber VARCHAR(255))
BEGIN
	DECLARE nResultado INT;
    DECLARE cMensaje VARCHAR(255);
    DECLARE valid BIT;
    DECLARE existInDb INT;
    
	SET nResultado = 0;
    SET cMensaje = CONCAT('Supplier ID ', CAST(pId AS CHAR), ' actualizado');
    SET Valid = 1;
    SELECT Id INTO existInDb FROM Supplier WHERE Id = pId;
    
    IF existInDb IS NULL
    THEN
		SET nResultado = -1;
		SET cMensaje = CONCAT('No existe un Supplier con ID ', CAST(PId AS CHAR));
        SET Valid = 0;
    END IF;
    
   IF pId IS NULL OR pName IS NULL OR pAdress IS NULL OR pPhoneNumber IS NULL OR
   pName = '' OR pAdress = '' OR pPhoneNumber = ''
   THEN
		SET nResultado = -1;
		SET cMensaje = 'Los parámetros no pueden ser nulos o vacíos';
        SET Valid = 0;
	END IF;
	
    IF Valid = 1
    THEN
		UPDATE carcompany.supplier s
        SET s.Name = pName,
        s.Adrress = pAdress,
        s.PhoneNumber = pPhoneNumber
        WHERE Id = pId;
        
		COMMIT;
    END IF;
    
    SELECT nResultado, cMensaje;
END$$
DELIMITER ;

/* ******************** DELETE PROVEEDOR ******************** */
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