use `carcompany`;

DELETE FROM `Car`;
DELETE FROM `assemblyline`;
DELETE FROM `order_detail`;
DELETE FROM `order`;
DELETE FROM `Model`;
DELETE FROM `dealership`;

CALL `carcompany`.`AltaConcesionario`('Consesionaria Grupo 9', '1175698719', 'Calle Falsa 123');
SET @newDealershipId = LAST_INSERT_ID();

CALL AltaModelo('Ford Mustang');
SET @ModeloUno = (SELECT Id FROM `Model` ORDER BY Id DESC LIMIT 1);
CALL AltaModelo('Toyota Camry');
CALL AltaModelo('Fiat 500');
CALL AltaModelo('Nissan Leaf');
CALL AltaModelo('Mercedes-Benz Clase GLE');
SET @ModeloDos =  (SELECT Id FROM `Model` ORDER BY Id DESC LIMIT 1);
CALL AltaModelo('Chevrolet Bolt EV');

-- DealershipId, Date, ModelId, Cantidad
CALL `carcompany`.`AltaPedido`( @newDealershipId, NOW() , @ModeloUno, 3);
SET @pedidoUno = (SELECT Id FROM `Order` ORDER BY Id DESC LIMIT 1);
-- DealershipId, Date, ModelId, Cantidad
CALL `carcompany`.`AltaPedido`( @newDealershipId, NOW() , @ModeloDos, 4);
SET @pedidoDos = (SELECT Id FROM `Order` ORDER BY Id DESC LIMIT 1);

CALL GenerateCarByOrderId(@pedidoUno);
CALL GenerateCarByOrderId(@pedidoDos);

SELECT
*
FROM `Car`;