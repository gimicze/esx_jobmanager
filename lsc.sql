INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_lsc', 'lsc', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_lsc', 'lsc', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_lsc', 'lsc', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('lsc', "Los Santos Customs", 1),
	('off_lsc', "Los Santos Customs", 1)	
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('lsc',0,'nemakacenko','Nemakačenko',0,'{}','{}'),
	('lsc',1,'brigadnik','Brigádník',0,'{}','{}'),
	('lsc',2,'mechanik','Mechanik',0,'{}','{}'),
	('lsc',3,'pokrocilymechanik','Pokročilý mechanik',0,'{}','{}'),
	('lsc',4,'sefmechanik','Šéf mechanik',0,'{}','{}'),
	('lsc',5,'manager','Manažer',0,'{}','{}'),
	('lsc',6,'boss','Boss',0,'{}','{}'),
	('off_lsc',0,'nemakacenko','Nemakačenko',0,'{}','{}'),
	('off_lsc',1,'brigadnik','Brigádník',0,'{}','{}'),
	('off_lsc',2,'mechanik','Mechanik',0,'{}','{}'),
	('off_lsc',3,'pokrocilymechanik','Pokročilý mechanik',0,'{}','{}'),
	('off_lsc',4,'sefmechanik','Šéf mechanik',0,'{}','{}'),
	('off_lsc',5,'manager','Manažer',0,'{}','{}'),
	('off_lsc',6,'boss','Boss',0,'{}','{}')
;
