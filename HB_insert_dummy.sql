Drop procedure DUMMY_INSERT_GYM;
Drop procedure DUMMY_INSERT_member;

DELIMITER $$
CREATE procedure DUMMY_INSERT_GYM()
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE ( i <= 10) DO
		set @place_address = "Ajou Univ 1";
		set @place_name = "아주대점";
		set @place_gender_limit = "U";
		insert into healthbase.gym(address, name, sex) values(@place_address, @place_name, @place_gender_limit);
        set i = i+1;
	end while;
END$$


DELIMITER $$
CREATE procedure DUMMY_INSERT_member()
BEGIN
	DECLARE i INT DEFAULT 1;
    set @member_name = "Mr.J";
	set @member_age = 25;
	set @member_gender = 1;
        
    set @insert_query = 'insert into basicmember(Member_name, age, Gender) values("Mr.J",25,1)';
    WHILE ( i <= 1000) DO
        set @value_query = CONCAT(',("',@member_name,'",',@member_age,',',@member_gender,')');
        set @insert_query = concat(@insert_query,@value_query);
        set i = i+1;
	end while;
    SELECT @insert_query;
    PREPARE stmt FROM @insert_query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

DELETE FROM healthbase.basicmember WHERE id > -1;
CALL DUMMY_INSERT_member();
SELECT count(*) FROM healthbase.basicmember;

CALL new_gym_insert('Ajou Univ', 'GYM','U');
SELECT * FROM pt_schedule;

SELECT * FROM employee;