

SELECT
*
FROM `Model`

CALL `AltaPedido`(1, NOW(), 1, 3);

SELECT
o.Id AS 'OrderId',
o.dealershipId AS 'DealershipId',
o.fecha AS 'Fecha',
od.ModelId AS 'ModelId'
FROM `Order` o
LEFT JOIN `Order_detail` od ON od.OrderId = o.Id

SELECT
*
FROM `Order_detail`


USE `carcompany`;
DELETE FROM `Order_detail` WHERE Id IS NOT NULL;
DELETE FROM `Order` WHERE Id IS NOT NULL;