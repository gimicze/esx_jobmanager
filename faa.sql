INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_faa', 'Federal Aviation Administration', 1)
;

INSERT INTO `datastore` (name, `label`, shared) VALUES
	('society_faa', 'Federal Aviation Administration', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_faa', 'Federal Aviation Administration', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('faa', "FAA", 1),
	('off_faa', "FAA (odhlášen)", 1)	
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('faa',0,'pilot','Pilot',0,'{}','{}'),
	('faa',1,'instruktor','Instruktor',0,'{}','{}'),
	('faa',2,'manager','Manager',0,'{}','{}'),
	('faa',3,'supervisor','Supervisor',0,'{}','{}'),
	('off_faa',0,'pilot','Pilot',0,'{}','{}'),
	('off_faa',1,'instruktor','Instruktor',0,'{}','{}'),
	('off_faa',2,'manager','Manager',0,'{}','{}'),
	('off_faa',3,'supervisor','Supervisor',0,'{}','{}')
;
