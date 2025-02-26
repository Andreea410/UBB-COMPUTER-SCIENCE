DROP TABLE R

CREATE TABLE R (
    FK1 INT,
    FK2 INT,
    C1 VARCHAR(50),
    C2 VARCHAR(50),
    C3 FLOAT,
    C4 FLOAT,
    C5 VARCHAR(10),
    PRIMARY KEY (FK1, FK2)
);

INSERT INTO R (FK1, FK2, C1, C2, C3, C4, C5) VALUES
(10, 5, 'Everything She Wants', 'George Michael', 550, 250.5, 'YT200'),
(13, 7, 'Love of My Life', 'Freddie Mercury', 800, 75.25, 'YT105'),
(11, 16, 'Chain of Fools', 'Aretha Franklin', 925, 150.75, 'YT221'),
(12, 15, 'I Have Nothing', 'Whitney Houston', 450, 125.5, 'YT100'),
(5, 2, 'Human Nature', 'Michael Jackson', 275, 125, 'YT125'),
(2, 2, 'All I Do', 'Stevie Wonder', 425, 125.75, 'YT250'),
(16, 8, 'My Cherie Amour', 'Stevie Wonder', 375, 250.25, 'YT210'),
(14, 8, 'R-e-s-p-e-c-t', 'Aretha Franklin', 450, 180.5, 'YT26'),
(16, 18, 'Bohemian Rhapsody', 'Freddie Mercury', 725, 195.5, 'YT80'),
(18, 16, 'Father Figure', 'George Michael', 190, 210.75, 'YT91'),
(11, 1, 'Man in the Mirror', 'Michael Jackson', 200, 195.5, 'YT120'),
(18, 12, 'Billie Jean', 'Michael Jackson', 190, 200, 'YT129');

DELETE FROM R

SELECT C2,AVG(C3) avgC3,MIN(C4) MinC4
FROM R 
WHERE C1 LIKE '%of%' OR C4 <200
GROUP BY C2
HAVING AVG(C3) >=400

SELECT * FROM (SELECT FK1 , FK2,C3-C4 C3DIFC4 FROM R
					WHERE FK1 >= FK2) r1
						INNER JOIN
						(SELECT FK1,FK2,C5 
						FROM R WHERE C5 LIKE 'YT2%' AND C4 > 170)r2
						ON r1.FK1 = r2.FK1 and r2.FK2 = r1.FK2

GO
CREATE OR ALTER TRIGGER TrOnUpdate
ON R
FOR UPDATE
AS
DECLARE @total INT = 0;
SELECT @total = SUM(i.C4 + d.C4)
FROM deleted d
INNER JOIN inserted i
ON d.FK1 = i.FK1 AND d.FK2 = i.FK2
WHERE d.C4 < i.C4;
PRINT @total;
GO

UPDATE R
SET C4 = 525
WHERE FK1 <= FK2


