use healthbase;

DELIMITER $$

CREATE procedure delete_gym(
	in target_address varchar(32)
)
begin
	delete from gym where address = target_address;
end $$

CREATE procedure delete_ptmember(
	in target_member_id int
)
BEGIN
	delete from ptmember where id = target_member_id;
END$$

CREATE procedure delete_trainer(
	in target_trainer_id int
)
begin
	delete from employee where EMPLOYEE_NO = target_trainer_id;
end $$

CREATE procedure delete_basicmember(
	in target_member_id int
)
BEGIN
	delete from basicmember where id = target_member_id;
END$$

CREATE procedure delete_equipment(
	in equipment_id int
)
BEGIN
	delete from Equipment where Id_equipments = equipment_id;
END$$

CREATE procedure delete_schedule(
	in target_employee_id int,
    in start_time_in datetime,
    in end_time_in datetime
)
BEGIN
	delete from schedule where (EMPLOYEE_NO = target_employee_id) and (START_TIME = start_time_in) and (END_TIME = end_time_in) ;
END$$

CREATE procedure delete_pt_schedule(
	in target_member_id int,
    in start_time_in datetime,
    in end_time_in datetime
)
BEGIN
	delete from schedule where (id = target_member_id) and (START_TIME = start_time_in) and (END_TIME = end_time_in) ;
END$$
