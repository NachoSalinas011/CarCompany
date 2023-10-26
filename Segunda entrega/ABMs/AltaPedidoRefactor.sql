USE `carcompany`;
DROP procedure IF EXISTS `AltaPedido`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AltaPedido`(IN pDealershipId INT, IN pFecha DATETIME, IN pModelId INT, IN pCant INT)
BEGIN
    DECLARE pResultado INT;
    DECLARE pMensaje VARCHAR(255);
    DECLARE countPedido INT;
    DECLARE lastInsertedId INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pResultado = -1;
        SET pMensaje = "Error al intentar dar de alta el pedido.";
    END;
    
    IF NOT EXISTS (SELECT 1 FROM Dealership WHERE Id = pDealershipId) THEN
        SET pResultado = -1;
        SET pMensaje = "El concesionario no existe.";
    ELSE
		SET countPedido = 0;
        
        INSERT INTO `Order` (DealershipId, fecha) VALUES(pDealershipId, pFecha);
        SET lastInsertedId = LAST_INSERT_ID();
        newPedido: LOOP
        
        SELECT 'Se intentará hacer el insert je';
        INSERT INTO `order_detail` (OrderId, ModelId) VALUES (lastInsertedId, pModelId);
        SET countPedido = countPedido + 1;
        IF countPedido < pCant THEN
			ITERATE newPedido;
			END IF;
        LEAVE newPedido;
		END LOOP newPedido;

        SET pResultado = 0;
        SET pMensaje = "";
    END IF;
    
    SELECT pResultado AS Resultado, pMensaje AS Mensaje;
END$$

DELIMITER ;
;

