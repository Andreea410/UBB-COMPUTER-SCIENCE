CREATE TABLE R
(
FK1 int,
FK2 int,
c1 varchar(50),
c2 varchar(50),
c3 varchar(50),
c4 varchar(50),
c5 decimal(10,2),
c6 int
);

INSERT INTO R(fk1,fk2,c1,c2,c3,c4,c5,c6) VALUES
(1,1,'Another Round','Cinema Victoria','A1','Danish',8.8,160),
(1,2,'McQueen','Iullius Mall','A1','British',7.5,150),
(1,3,'Safari','Cinema Victoria','A3','Indian',8.2,155),
(2,1,'Nuevo Orden','Cinema Victoria','B1','Mexixcan',7,200),
(2,2,'Nuevo Orden','Casa de Cultura','B2','Mexican',7,100),
(2,3,'Mephisto','Iullius Mall','C2','German',6.5,100),
(3,1,'Another Round','Iullius Mall','A3','Danish',8,95),
(3,2,'Safari','Casa de Cultura','C4','Indian',7.6,140),
(3,3,'Official competition','Cinema Victoria','A2','Spanish',6.8,100),
(4,1,'ALCARRAS','Cinema Victoria','A1','Danish',8.8,160),
(4,2,'ALCARRAS','Casa de Cultura','D2','Spanish',8.4,30),
(4,3,'Official competition','Casa de Cultura','A2','Spanish',5.1,100),
(5,1,'McQueen','Cinema Victoria','A3','British',8.8,200);

SELECT C3 , AVG(C6) AS AVGC6
FROM R
WHERE C2 like '%C%' OR C5 >=0
GROUP BY C3
HAVING SUM(C6) <= 250

SELECT * FROM	
( SELECT FK1 , FK2 , C6*100 C6 FROM R
WHERE FK1 = FK2 ) r1
LEFT JOIN (SELECT FK1,FK2,C5 FROM R WHERE C6 %2 = 0)r2 ON r1.fk1 = r2.fk1 and r1.fk2 = r2.FK2