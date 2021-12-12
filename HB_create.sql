CREATE database HealthBase;
Use HealthBase;

CREATE TABLE gym(
    address varchar(32) not null primary key,
    name varchar(32) not null,
    sex varchar(2) not null,
    shower bool not null default false,
    aerobic bool not null default false,
    anaerobic bool not null default false,
    locker bool not null default false,
    machine bool not null default false,
    constraint gender_validation check (sex in ('m','f','mf'))
);

CREATE TABLE gym_schedule(
	address varchar(32),
	mon_start time default null,
    mon_end time default null,
	tue_start time default null,
    tue_end time default null,
    wed_start time default null,
    wed_end time default null,
    thu_start time default null,
    thu_end time default null,
	fri_start time default null,
    fri_end time default null,
    sat_start time default null,
    sat_end time default null,
    sun_start time default null,
    sun_end time default null,
    FOREIGN KEY (address) REFERENCES gym (address) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE table Employee (
	EMPLOYEE_NO int AUTO_INCREMENT,
	AGE int not NULL,
    GENDER char(1) not NULL,
	EMPLOYEE_NAME varchar(32) not NULL,
	WORKPLACE varchar(32),
	PRIMARY KEY (EMPLOYEE_NO),
	FOREIGN KEY (WORKPLACE) REFERENCES gym (address) ON DELETE SET NULL ON UPDATE CASCADE,
    constraint people_gender_validation check (Gender in ('m','f')),
    constraint employee_age_const check (AGE >= 15)
);

CREATE Table SCHEDULE (
	EMPLOYEE_NO int not null,
	START_TIME Datetime not null,
	END_TIME Datetime not null,
	FOREIGN KEY (EMPLOYEE_NO) REFERENCES Employee (EMPLOYEE_NO) ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Equipment(
	Id_equipments INT NOT NULL AUTO_INCREMENT,
	Name_equipments VARCHAR(50) not null,
	Weight_equipments int not null,
	IsUse_equipments BOOLEAN not null default true,
    Place VARCHAR(32) not null,
	PRIMARY KEY (Id_equipments),
	FOREIGN KEY (Place) references gym (address) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table BasicMember
(
	id int NOT NULL auto_increment, 
	Member_name varchar(32) NOT NULL,
	Age int,
	Gender char(1) not null,
    PRIMARY KEY (id),
    constraint member_gender_validation check (Gender in ('m','f'))
);

Create table PTMember
(
	id int NOT NULL,
    PT_trainer_id int NOT NULL,
    end_date datetime not null,
    PRIMARY KEY (id),
	FOREIGN KEY (id) references BasicMember (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PT_trainer_id) references Employee (EMPLOYEE_NO)
);

CREATE Table PT_SCHEDULE (
	Item_id int AUTO_INCREMENT,
	EMPLOYEE_NO int not null,
    MEMBER_ID int not null,
	START_TIME Datetime not null,
	END_TIME Datetime not null,
	PRIMARY KEY (Item_id),
	FOREIGN KEY (EMPLOYEE_NO) REFERENCES Employee (EMPLOYEE_NO) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MEMBER_ID) REFERENCES PTMember (id) ON DELETE CASCADE ON UPDATE CASCADE
);



