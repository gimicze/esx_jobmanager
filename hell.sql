INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_hell', 'Hell Fast Food', 1)
;

INSERT INTO `datastore` (name, `label`, shared) VALUES
	('society_hell', 'Hell Fast Food', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_hell', 'Hell Fast Food', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('hell', "Hell Fast Food", 1),
	('off_hell', "Hell Fast Food (odhlášen)", 1)	
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('hell',0,'zamestnanec','Zaměstnanec',0,'{}','{}'),
	('hell',1,'majitel','Majitel',0,'{}','{}'),
	('off_hell',0,'zamestnanec','Zaměstnanec',0,'{}','{}'),
	('off_hell',1,'majitel','Majitel',0,'{}','{}')
;
