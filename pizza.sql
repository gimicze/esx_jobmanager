USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_pizza', 'pizza', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_pizza', 'pizza', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_pizza', 'pizza', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('pizza', "Guido's Pizza", 1),
	('off_pizza', "Guido's Pizza", 1)	
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('pizza',0,'brigadnik','Brigádník',0,'{}','{}'),
	('pizza',1,'zamestnanec','Zaměstnanec',0,'{}','{}'),
	('pizza',2,'pizzar','Pizzař',0,'{}','{}'),
	('pizza',3,'sef','Šéf',0,'{}','{}'),
	('pizza',4,'boss','Majitel',0,'{}','{}'),
	('off_pizza',0,'brigadnik','Brigádník',0,'{}','{}'),
	('off_pizza',1,'zamestnanec','Zaměstnanec',0,'{}','{}'),
	('off_pizza',2,'pizzar','Pizzař',0,'{}','{}'),
	('off_pizza',3,'sef','Šéf',0,'{}','{}'),
	('off_pizza',4,'boss','Majitel',0,'{}','{}')
;
