use `carcompany`;

DELETE FROM `Car`;
DELETE FROM `order_detail`;
DELETE FROM `order`;
DELETE FROM `Model`;

DELETE FROM `dealership`;

CALL `carcompany`.`AltaConcesionario`('Consesionaria Grupo 9', '1175698719', 'Calle Falsa 123');
SET @newDealershipId = LAST_INSERT_ID();

INSERT INTO `Model` (Id, Name)
VALUES
('1', 'Ford Mustang'),
('2', 'Toyota Camry'),
('3', 'Fiat 500'),
('4', 'Nissan Leaf'),
('5', 'Mercedes-Benz Clase GLE'),
('6', 'Chevrolet Bolt EV');

CALL `carcompany`.`AltaPedido`( @newDealershipId, NOW() , 2, 3);
SET @pedidoUno = (SELECT Id FROM `Order` ORDER BY Id DESC LIMIT 1);

CALL `carcompany`.`AltaPedido`( @newDealershipId, NOW() , 5, 4);
SET @pedidoDos = (SELECT Id FROM `Order` ORDER BY Id DESC LIMIT 1);

CALL GenerateCarByOrderId(@pedidoUno);
CALL GenerateCarByOrderId(@pedidoDos);

SELECT
*
FROM `Car`;