INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_warstock', 'warstock', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_warstock', 'warstock', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_warstock', 'warstock', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('warstock', "Warstock", 1),
	('off_warstock', "Warstock (odhlášen)", 1)	
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('warstock',0,'soldier','Soldier',0,'{}','{}'),
	('warstock',1,'mechanik','Mechanik',0,'{}','{}'),
	('warstock',2,'instruktor','Instruktor',0,'{}','{}'),
	('warstock',3,'majitel','Majitel',0,'{}','{}'),
	('off_warstock',0,'soldier','Soldier',0,'{}','{}'),
	('off_warstock',1,'mechanik','Mechanik',0,'{}','{}'),
	('off_warstock',2,'instruktor','Instruktor',0,'{}','{}'),
	('off_warstock',3,'majitel','Majitel',0,'{}','{}')
;
