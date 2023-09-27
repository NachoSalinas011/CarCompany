CREATE DATABASE IF NOT EXISTS CarCompany;
USE CarCompany;

DROP PROCEDURE IF EXISTS newSupplier;
CREATE PROCEDURE newSupplier
(
	IN pName VARCHAR(255),
	IN pAdress VARCHAR(255),
	IN pPhoneNumber VARCHAR(255),
	OUT nResultado INT,
	OUT cMensaje VARCHAR(255))
BEGIN
	DECLARE EXIT HANDLER FOR SQLSTATE '02000'
    BEGIN
		ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar el Supplier';
    END;
    
    START TRANSACTION;
    
    INSERT INTO Supplier(Name, Adress, PhoneNumber) VALUES (pName, pAdress, pPhoneNumber);
    
    COMMIT;
    
    SET nResultado = 0, cMensaje = '';
    SELECT nResultado, cMensaje;
END;