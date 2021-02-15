USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mosley', 'mosley', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mosley', 'mosley', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mosley', 'mosley', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('mosley', "Mosley's Car Service", 1),
	('off_mosley', "Mosley's Car Service", 1)	
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mosley',0,'prodejce','Prodejce',0,'{}','{}'),
	('mosley',1,'vedouci','Vedoucí',0,'{}','{}'),
	('mosley',2,'majitel','Majitel',0,'{}','{}'),
	('off_mosley',0,'prodejce','Prodejce',0,'{}','{}'),
	('off_mosley',1,'vedouci','Vedoucí',0,'{}','{}'),
	('off_mosley',2,'majitel','Majitel',0,'{}','{}')
;