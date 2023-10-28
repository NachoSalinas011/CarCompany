DELIMITER $$

CREATE PROCEDURE `newPatent`(OUT newPatent NVARCHAR(7))
BEGIN

repeatIfExists: LOOP


SET newPatent = CONCAT(
    CHAR(FLOOR(RAND() * 26) + 65), -- Primera letra aleatoria
    CHAR(FLOOR(RAND() * 26) + 65), -- Segunda letra aleatoria
    CHAR(FLOOR(RAND() * 26) + 65), -- Tercera letra aleatoria
    '-',
    LPAD(FLOOR(RAND() * 1000), 3, '0') -- Números aleatorios
);

IF EXISTS(SELECT 1 FROM Car WHERE Patent LIKE CONCAT('%',newPatent,'%')) THEN
BEGIN
	ITERATE repeatIfExists;
	END;
END IF;

LEAVE repeatIfExists;
END LOOP repeatIfExists;

END$$
DELIMITER ;
