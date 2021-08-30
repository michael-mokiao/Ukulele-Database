/*
	Michael Mokiao
    2021-07-16
    IT125
    Ukulele Database
*/

# Create Database
DROP DATABASE IF EXISTS UkuleleDB;
CREATE DATABASE IF NOT EXISTS UkuleleDB;
USE UkuleleDB;

# --------------------------------------------------------------
# Create Tables w/o FK
# --------------------------------------------------------------
CREATE TABLE Size (
	SizeId    		VARCHAR(20)     PRIMARY KEY
,   SizeLength  	FLOAT		
,   SizeWidth 		FLOAT		
,   SizeHeight 		FLOAT 	
);

# Materials Tables
CREATE TABLE Wood (
	WoodId			INT				PRIMARY KEY AUTO_INCREMENT
,	WoodName		VARCHAR(30)		NOT NULL
,	WoodTone		VARCHAR(30)		
,	WoodHardness	VARCHAR(30)
);

CREATE TABLE Tuner (
	TunerId			INT				PRIMARY KEY AUTO_INCREMENT
,	TunerName		VARCHAR(45)		NOT NULL
,	TunerColor		VARCHAR(30)		NOT NULL
);

CREATE TABLE Strings (
	StringsId		INT				PRIMARY KEY AUTO_INCREMENT
,	StringsName		VARCHAR(40)		NOT NULL
,	StringsGLow		ENUM('LOW', 'HIGH')
);

CREATE TABLE Finish (
	FinishId		INT				PRIMARY KEY AUTO_INCREMENT
,	FinishType		VARCHAR(30)		NOT NULL
);

# Brands Tables
CREATE TABLE Location (
	LocationId		INT		PRIMARY KEY 
,	Country			VARCHAR(45)		NOT NULL
,	District		VARCHAR(45)		
);

# --------------------------------------------------------------
# Create Tables w/ FK
# --------------------------------------------------------------
CREATE TABLE Brand (
	BrandId    			INT 			PRIMARY KEY AUTO_INCREMENT
,	BrandName			VARCHAR(45)     NOT NULL
,	BrandDateFounded	YEAR
,	LocationId			INT				NOT NULL
,	CONSTRAINT Brand_Location_FK FOREIGN KEY (LocationId) 
		REFERENCES Location (LocationId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Ukulele (
	UkuleleId    	INT 				PRIMARY KEY	AUTO_INCREMENT
,	UkuleleName		VARCHAR(40)     	NOT NULL
,	SizeId			VARCHAR(20)			NOT NULL
,	BrandId			INT					NOT NULL
,	BodyWoodId		INT					NOT NULL
,	TopWoodId		INT					NOT NULL
,	NeckWoodId		INT					NOT NULL
,	FretWoodId		INT					NOT NULL
,	StringsId		INT					
,	TunerId			INT					
,	SlottedHead		ENUM('YES', 'NO')
,	Price			DECIMAL(6,2)		NOT NULL
,	CONSTRAINT Ukulele_SizeId_FK FOREIGN KEY (SizeId) 
		REFERENCES Size (SizeId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_BrandId_FK FOREIGN KEY (BrandId) 
		REFERENCES Brand (BrandId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_BodyWoodId_FK FOREIGN KEY (BodyWoodId) 
		REFERENCES Wood (WoodId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_TopWoodId_FK FOREIGN KEY (TopWoodId) 
		REFERENCES Wood (WoodId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_NeckWoodId_FK FOREIGN KEY (NeckWoodId) 
		REFERENCES Wood (WoodId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_FretWoodId_FK FOREIGN KEY (FretWoodId) 
		REFERENCES Wood (WoodId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_StringsId_FK FOREIGN KEY (StringsId) 
		REFERENCES Strings (StringsId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT Ukulele_TunerId_FK FOREIGN KEY (TunerId) 
		REFERENCES Tuner (TunerId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE UkuleleFinish (
	UkuleleId  	INT 	NOT NULL
,	FinishId	INT     NOT NULL
,   CONSTRAINT PRIMARY KEY (UkuleleId, FinishId)
,	CONSTRAINT UkuleleFinish_UkuleleId_FK FOREIGN KEY (UkuleleId) 
		REFERENCES Ukulele (UkuleleId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
,	CONSTRAINT UkuleleFinish_Finish_FK FOREIGN KEY (FinishId) 
		REFERENCES Finish (FinishId)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
# --------------------------------------------------------------
# Populate Tables
# --------------------------------------------------------------
# Populate Tables w/o FKs
INSERT Size
VALUES	('Soprano',		21, 	6.75,	2.375),
		('Concert', 	24,		8.25,	2.75),
        ('Tenor',		26,		9.25,	2.75);
        
INSERT Tuner
VALUES	(1,	'Gotoh UPT Tuners',			'Black'),
		(2,	'Grover Geared Tuners',		'Silver'),
		(3,	'Kala tuning keys',			'Silver'),
        (4,	'Koaloha Friction Tuner',	'Silver'),
		(5,	'Machine Head Gear Pegs', 	'Silver');

INSERT Strings
VALUES	(1,	'Aquila Nylgut',	'HIGH'),
		(2,	'Clear Water', 		'HIGH'),
		(3,	'Koolau Alohi',		'HIGH');

INSERT Finish
VALUES	(1, 'Gloss'),
		(2,	'Satin');

INSERT Wood
VALUES	(1,	'Acacia',	'Balanced',	'Hard'),
		(2,	'Cedar',	'Warm',		'Soft'),
		(3,	'Ebony',	NULL,		'Hard'),
        (4,	'Koa',		'Balanced',	'Hard'),
		(5,	'Mahogany',	'Balanced',	'Hard'),
		(6,	'Mango',	'Warm',		'Hard'),
        (7,	'Maple',	'Bright',	'Hard'),
        (8,	'Rosewood',	'Warm',		'Hard'),
        (9,	'Spruce',	'Bright',	'Soft'),
        (10,'Walnut',	NULL,		'Hard');
        
INSERT Location
VALUES	(1,	'China',		NULL),
		(2,	'Indonesia',	'Java'),
        (3,	'Thailand',		NULL),
		(4,	'USA',			'Hawaii');

# Tables w/ FKs
INSERT Brand
VALUES	(1,	'aNueNue', 	'2020',	1),
		(2,	'Kala',		'2005',	1),
        (3,	'Kanilea',	'1998',	4),
		(4,	'Koaloha',	'1995',	4),
        (5,	'Rebel',	'2011',	3),
		(6,	'Pono',		NULL,	2),
        (7,	'Kamaka',	'1916',	4);

# Id, Name, Size, BrandId, BodyId, TopId, NeckId, FretId, String, Tuner, Slotted, Price
INSERT Ukulele
VALUES	(1,		'S4 HDS',		'Soprano',	1,	5,	2,	5,	8,	2,		5,		'NO',	209.00),
		(2,		'KSM-02',		'Soprano',	4,	4,	4,	5,	3,	NULL,	4,		'NO',	981.00),
        (3,		'ASD 2785',		'Soprano',	6,	1,	1,	5,	3,	3,		2,		'NO',	447.00),
		(4,		'MSSD 1319',	'Soprano',	6,	5,	5,	5,	3,	3,		2,		'NO',	399.00),
        (5,		'KA-FMCG',		'Concert',	2,	7,	9,	5,	10,	1,		NULL,	'NO',	259.99),
        (6,		'HF-2',			'Concert',	7,	4,	4,	5,	8,	NULL,	1,		'NO',	1345.00),
        (7,		'KSC-C',		'Concert',	3,	4,	4,	5,	3,	1,		1,		'YES',	1707.00),
        (8,		'MGCD 3157',	'Concert',	6,	6,	6,	5,	3,	3,		2,		'NO',	439.00),
        (9,		'DB-Cheese',	'Concert',	5,	5,	9,	5,	3,	NULL,	1,		'NO',	625.00),
        (10,	'DB-Creme-C',	'Concert',	5,	6,	6,	5,	3,	NULL,	1,		'NO',	625.00),
        (11,	'KA-SMHT',		'Tenor',	2,	5,	5,	5,	10,	1,		3,		'YES',	259.99),
        (12,	'KA-SSEBY-T',	'Tenor',	2,	3,	9,	5,	3,	1,		NULL,	'NO',	259.99),
        (13,	'K1-T',			'Tenor',	3,	4,	4,	5,	3,	1,		1,		'NO',	1355.00),
        (14,	'KTM-00',		'Tenor',	4,	6,	6,	5,	3,	NULL,	1,		'NO',	1216.00),
        (15,	'KTM-25',		'Tenor',	4,	4,	4,	5,	3,	NULL,	1,		'NO',	1501.00),
        (16,	'RTSH-PC',		'Tenor',	6,	8,	2,	5,	3,	3,		2,		'YES',	1199.00),
        (17,	'DB-Creme-M-T',	'Tenor',	5,	6,	6,	5,	3,	NULL,	1,		'NO',	845.00);

INSERT UkuleleFinish
VALUES	(1,		2),
		(2,		1),
        (3,		1),
        (4,		1),
        (5,		1),
        (6,		1),
        (7,		1),
        (7,		2),
        (8,		1),
        (9,		1),
        (10,	1),
        (11,	2),
        (12,	2),
        (13,	1),
        (13,	2),
        (14,	1),
        (15,	1),
        (16,	1),
        (17,	2);

# --------------------------------------------------------------
# 	Views
# --------------------------------------------------------------
/* 
create a view looking at potential price differences of ukuleles 
based on what country they are manufactured in.	
*/
CREATE OR REPLACE VIEW UkuleleCountry AS
	SELECT	UkuleleName AS `Model Name`, Price, BrandName	AS `Brand`, Country
	FROM	Ukulele JOIN	Brand 		USING 	(BrandId)
					JOIN	Location	USING	(LocationId)
	ORDER BY Price;

/* 
create a view to look at the different top wood and tones in various sizes
*/
CREATE OR REPLACE VIEW UkuleleTones AS
	SELECT	UkuleleName AS `Model Name`, SizeId, TopWoodId AS `Wood Top`, 
			WoodTone AS `Wood Tone`,	FinishType
	FROM	Ukulele JOIN	Size 			USING 	(SizeId)
					JOIN	Wood			ON		Ukulele.TopWoodId = Wood.WoodId
                    JOIN	UkuleleFinish	USING	(UkuleleId)
                    JOIN	Finish			USING	(FinishId);

# --------------------------------------------------------------
# 	Queries
# --------------------------------------------------------------
/*
Query 1 - Customer would like to find Hawaii made ukuleles under $1000
*/
SELECT UkuleleName AS `Model`, SizeId AS `Size`, Price, District
FROM	Ukulele	JOIN	Size	USING		(SizeId)
				JOIN	Brand	USING		(BrandId)
                JOIN	Location	USING	(LocationId)
WHERE	Price < 1000.00 AND District = 'Hawaii'
ORDER BY Price;

/*
Query 2 - Customer wants a concert or tenor sized ukulele from a newer brand 
	(founded after 2000) with a gloss finish
*/
SELECT UkuleleName AS `Model`, BrandName AS `Brand`, BrandDateFounded,	Price
FROM	Ukulele	JOIN	Size			USING	(SizeId)
				JOIN	Brand			USING	(BrandId)
                JOIN	UkuleleFinish	USING	(UkuleleId)
                JOIN	Finish			USING	(FinishId)
WHERE	FinishType = 'Gloss' AND BrandDateFounded > '2000' AND (SizeId = 'Concert' OR SizeId = 'Tenor')
ORDER BY Price DESC;

/*
Query 3 - Customer wants a balanced tone top ukulele with a slotted head stock
*/
SELECT UkuleleName AS `Model`, TopWoodId AS `Top Wood`, WoodTone AS `Tone`, Price
FROM	Ukulele	JOIN	Wood	ON	Ukulele.TopWoodId = Wood.WoodId
WHERE	WoodTone = 'Balanced' AND SlottedHead = 'YES';

/*
Query 4 - Customer wants a non-chinese made tenor ukulele between $500-$1000
	with a mango or koa body
*/
SELECT UkuleleName AS `Model`, BrandName AS `Brand`, BodyWoodId AS `Body Wood`, Price
FROM	Ukulele	JOIN	Brand		USING	(BrandId)
				JOIN	Location	USING	(LocationId)
				JOIN	Wood		ON		Ukulele.BodyWoodId = Wood.WoodId
WHERE	Country != 'China'	AND SizeId = 'Tenor'
							AND (Price BETWEEN 500.00 AND 1500.00)
                            AND (WoodName = 'Mango' OR WoodName = 'Koa')
ORDER BY WoodName, Price;