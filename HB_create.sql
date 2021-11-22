CREATE database HealthBase_re;
Use HealthBase_re;

CREATE TABLE gym(
    address varchar(32) not null primary key,
    name varchar(32) not null,
    sex varchar(1),
    businesshour int,
    shower bool,
    aerobic bool,
    anaerobic bool,
    locker bool,
    machine bool,
    area int
); 

CREATE table Employee (
	EMPLOYEE_NO int AUTO_INCREMENT,
	AGE int not NULL,
	EMPLOYEE_NAME varchar(32) not NULL,
	WORKPLACE varchar(32),
	PRIMARY KEY (EMPLOYEE_NO),
	FOREIGN KEY (WORKPLACE) REFERENCES gym (address) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE Table SCHEDULE (
	Item_id int AUTO_INCREMENT,
	EMPLOYEE_NO int,
	START_TIME Datetime,
	END_TIME Datetime,
	PRIMARY KEY (Item_id),
	FOREIGN KEY (EMPLOYEE_NO) REFERENCES Employee (EMPLOYEE_NO) ON DELETE CASCADE
);

Create Table Equipment(
	Id_equipments INT NOT NULL AUTO_INCREMENT,
	Name_equipments VARCHAR(50) NOT NULL,
	Weight_equipments CHAR(8),
	IsUse_equipments BOOLEAN NOT NULL,
    Place VARCHAR(32) NOT NULL,
	PRIMARY KEY (Id_equipments),
	FOREIGN KEY (Place) references gym (address) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table BasicMember
(
	id int NOT NULL auto_increment, 
	Member_name varchar(32) NOT NULL,
	Age int,
	Gender int,
    PRIMARY KEY (id)
);

Create table PTMember
(
	id int NOT NULL,
    PT_trainer_id int NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (id) references BasicMember (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PT_trainer_id) references Employee (EMPLOYEE_NO)
);



