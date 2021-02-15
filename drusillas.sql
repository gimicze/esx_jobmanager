INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_drusillas', "Drusilla's", 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_drusillas', "Drusilla's", 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_drusillas', "Drusilla's", 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('drusillas', "Drusilla's", 1),
	('off_drusillas', "Drusilla's (odhlášen)", 1)	
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('drusillas',0,'cisnik','Číšník',0,'{}','{}'),
	('drusillas',1,'kuchar','Pomocný kuchař',0,'{}','{}'),
	('drusillas',2,'sefkuchar','Šéfkuchař',0,'{}','{}'),
	('drusillas',3,'zastupce','Zástupce',0,'{}','{}'),
	('drusillas',4,'boss','Majitelka',0,'{}','{}'),
	('off_drusillas',0,'cisnik','Číšník',0,'{}','{}'),
	('off_drusillas',1,'kuchar','Pomocný kuchař',0,'{}','{}'),
	('off_drusillas',2,'sefkuchar','Šéfkuchař',0,'{}','{}'),
	('off_drusillas',3,'zastupce','Zástupce',0,'{}','{}'),
	('off_drusillas',4,'boss','Majitelka',0,'{}','{}')
;
