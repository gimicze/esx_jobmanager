USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_casey', 'casey', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_casey', 'casey', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_casey', 'casey', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('casey', "Casey's Diner", 1),
	('off_casey', "Casey's Diner", 1)	
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('casey',0,'driver','Driver',0,'{}','{}'),
	('casey',1,'cisnik','Číšník',0,'{}','{}'),
	('casey',2,'kuchar','Kuchař',0,'{}','{}'),
	('casey',3,'zastupce','Zástupce',0,'{}','{}'),
	('casey',4,'reditel','Ředitel',0,'{}','{}'),
	('off_casey',0,'driver','Driver',0,'{}','{}'),
	('off_casey',1,'cisnik','Číšník',0,'{}','{}'),
	('off_casey',2,'kuchar','Kuchař',0,'{}','{}'),
	('off_casey',3,'zastupce','Zástupce',0,'{}','{}'),
	('off_casey',4,'reditel','Ředitel',0,'{}','{}')
;
