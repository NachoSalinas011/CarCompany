USE CarCompany;

DROP PROCEDURE IF EXISTS AltaConcesionario;
DROP PROCEDURE IF EXISTS ModificarConcesionario;
DROP PROCEDURE IF EXISTS BajaConcesionario;
DROP PROCEDURE IF EXISTS AltaPedido;
DROP PROCEDURE IF EXISTS ModificarPedido;
DROP PROCEDURE IF EXISTS BajaPedido;
DROP PROCEDURE IF EXISTS AltaInsumo;
DROP PROCEDURE IF EXISTS ModificarInsumo;
DROP PROCEDURE IF EXISTS BajaInsumo;
DROP PROCEDURE IF EXISTS newSupplier;
DROP PROCEDURE IF EXISTS updateSupplier;
DROP PROCEDURE IF EXISTS deleteSupplier;

DELIMITER $$

CREATE PROCEDURE AltaConcesionario(IN pNombre NVARCHAR(45), IN pPhoneNumber NVARCHAR(25), IN pAddress NVARCHAR(25))
BEGIN 
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de alta el concesionario.";
    END;
    
    IF EXISTS (SELECT 1 FROM Dealership WHERE Nombre = pNombre) THEN
        SET pResultado = -1;
        SET pMensaje = "Ya existe un concesionario con ese nombre.";
    ELSE
        INSERT INTO Dealership(Nombre, PhoneNumber, Address)
        VALUES(pNombre, pPhoneNumber, pAddress);
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE ModificarConcesionario(IN pId INT, IN pNombre NVARCHAR(45), IN pPhoneNumber NVARCHAR(25), IN pAddress NVARCHAR(25))
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar modificar el concesionario.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Dealership WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El concesionario no existe.";
    ELSE
        IF EXISTS (SELECT 1 FROM Dealership WHERE Nombre = pNombre AND Id <> pId) THEN
            SET pResultado = -1;
            SET pMensaje = "Ya existe otro concesionario con ese nombre.";
        ELSE
            UPDATE Dealership
            SET Nombre = pNombre, PhoneNumber = pPhoneNumber, Address = pAddress
            WHERE Id = pId;
            SET pResultado = 0;
            SET pMensaje = "";
        END IF;
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE BajaConcesionario(IN pId INT)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de baja el concesionario.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Dealership WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El concesionario a dar de baja no existe.";
    ELSE
        DELETE FROM Dealership WHERE Id = pId;
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE AltaPedido(IN pDealershipId INT, IN pFecha DATETIME)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de alta el pedido.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Dealership WHERE Id = pDealershipId) THEN
        SET pResultado = -1;
        SET pMensaje = "El concesionario no existe.";
    ELSE
        INSERT INTO Orden(DealershipId, fecha)
        VALUES(pDealershipId, pFecha);
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE ModificarPedido(IN pId INT, IN pDealershipId INT, IN pFecha DATETIME)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar modificar el pedido.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Orden WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El pedido a modificar no existe.";
    ELSE
        IF NOT EXISTS (SELECT 1 FROM Dealership WHERE Id = pDealershipId) THEN
            SET pResultado = -1;
            SET pMensaje = "El concesionario no existe.";
        ELSE
            UPDATE Orden
            SET DealershipId = pDealershipId, fecha = pFecha
            WHERE Id = pId;
            SET pResultado = 0;
            SET pMensaje = "";
        END IF;
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE BajaPedido(IN pId INT)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de baja el pedido.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Orden WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El pedido a dar de baja no existe.";
    ELSE
        DELETE FROM Orden WHERE Id = pId;
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE AltaInsumo(IN pNombre NVARCHAR(45), IN pPrecio DECIMAL UNSIGNED)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de alta el insumo.";
    END;
    
    IF EXISTS (SELECT 1 FROM Supplie WHERE Nombre = pNombre) THEN
        SET pResultado = -1;
        SET pMensaje = "Ya existe un insumo con el mismo nombre.";
    ELSE
        INSERT INTO Supplie(Nombre, Price)
        VALUES(pNombre, pPrecio);
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE ModificarInsumo(IN pId INT, IN pNombre NVARCHAR(45), IN pPrecio DECIMAL UNSIGNED)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar modificar el insumo.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Supplie WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El insumo a modificar no existe.";
    ELSE
        IF EXISTS (SELECT 1 FROM Supplie WHERE Nombre = pNombre AND Id <> pId) THEN
            SET pResultado = -1;
            SET pMensaje = "Ya existe otro insumo con el mismo nombre.";
        ELSE
            UPDATE Supplie
            SET Nombre = pNombre, Price = pPrecio
            WHERE Id = pId;
            SET pResultado = 0;
            SET pMensaje = "";
        END IF;
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

CREATE PROCEDURE BajaInsumo(IN pId INT)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de baja el insumo.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Supplie WHERE Id = pId) THEN
        SET pResultado = -1;
        SET pMensaje = "El insumo a dar de baja no existe.";
    ELSE
        DELETE FROM Supplie WHERE Id = pId;
        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END $$

DELIMITER ;
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

/* ******************** UPDATE PROVEEDOR ******************** */
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