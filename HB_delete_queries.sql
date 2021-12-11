use healthbase;

DELIMITER $$

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

delete from gym where address = 'Ajou Univ 1';