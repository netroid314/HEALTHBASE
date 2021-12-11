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
    PREPARE stmt FROM @insert_query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END$$

CREATE procedure DUMMY_INSERT_member_100k()
BEGIN
	DECLARE i INT DEFAULT 1;

    WHILE ( i <= 100) DO
        call DUMMY_INSERT_member();
	end while;
END$$

DELIMITER ;

