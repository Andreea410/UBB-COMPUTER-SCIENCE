USE PracticeDatabase
DROP TABLE R

CREATE TABLE R(
	FK1 int,
	FK2 int,
	c1 varchar(50),
	c2 varchar(50),
	c3 DECIMAL(10,2),
	c4 int,
	c5 varchar(50),
	PRIMARY KEY(FK1,FK2)
)
DELETE FROM R

INSERT INTO R(FK1,FK2,C1,C2,C3,C4,c5) VALUES
(5,9,'Spider Plant','Indirect light',250.99,190,'Moderate'),--
(2,5,'Succulents','Sunny and well-drained',199.99,230,'Low'),--
(7,3,'Fiddle Leaf Fig','Indirect light',219.49,185,'Moderate'),
(1,9,'Lavender','Sunny and well-drained',189.99,205,'Low'),--
(5,3,'Snake Plant','Indirect light',205.99,183,'Low'),
(10,5,'Peace Lily','Shade to indirect light',349.59,203,'High'),
(3,3,'Rosemary Plant','Sunny and well-drained',197.99,205,'Low'),--
(6,9,'Bamboo','Shade to indirect light',195.49,303,'Moderate'),--
(9,9,'Monstera Deliciosa','Indirect light',234.55,340,'Moderate'),--
(4,6,'Orchid','Shade to indirect light',189.99,280,'High'),--
(5,8,'Aloe Vera','Sunny and well-drained',248.99,196,'Low'),--
(9,5,'Pothos Plant','Direct light',199.99,265,'Low');

SELECT * FROM R

SELECT C2,C5,MIN(C3) AS MINC3 , AVG(C4) AVGC4
FROM R
WHERE C3 > 190 OR C1 LIKE '%e%'
GROUP BY C5,C2
HAVING MIN(C3) >= 198.99 
GO

CREATE OR ALTER TRIGGER TrOnUpdate
ON R
FOR UPDATE
AS
DECLARE @total INT = 0
SELECT @total = d.C4*10 - i.C4 --
FROM deleted d
INNER JOIN inserted i
ON d.FK1 = i.FK1 AND d.FK2 = i.FK2
WHERE d.c4 > i.c4 OR d.c4+50 < i.c4 --196+
PRINT @total

UPDATE R 
SET C4 = 250
WHERE FK1 <= FK2

SELECT * 
FROM (
    SELECT FK1, FK2, C4 * 10 - C3 AS Calc 
    FROM R 
    WHERE FK1 < FK2
) r1
RIGHT JOIN (
    SELECT FK1, FK2, C3 
    FROM R 
    WHERE C1 LIKE '%Plant%' OR C4 < 200
) r2
ON r1.FK1 = r2.FK1 AND r1.FK2 = r2.FK2;
