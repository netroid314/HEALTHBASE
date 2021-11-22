USE healthbase;

/*	헬스장 추가하기	*/
set @place_address = "Ajou Univ";
set @place_name = "아주대점";
set @place_sex_limit = "U";
insert into healthbase.gym(address, name, sex) values(@place_address, @place_name, @place_sex_limit);

/*	헬스장 장비 추가하기	*/
set @equipment_name = "아령";
set @equipment_weight = "10kg";
set @equipment_place = "Ajou Univ";
insert into equipment(Name_equipments, Weight_equipments, IsUse_equipments, Place)
select @equipment_name, @equipment_weight, FALSE, address
  from gym
 where address = @equipment_place;

/*	헬스장 직원 추가하기.	*/
set @employee_name = "Mr.J";
set @employee_age = 25;
set @employee_workplace = 'Ajou Univ';
insert into healthbase.employee(EMPLOYEE_NAME, age, WORKPLACE)
select @employee_name, @employee_age, address
  from gym
 where address = @employee_workplace;
 
/*	헬스장 이용객 추가하기.	*/
set @member_name = "Mr.J";
set @member_age = 25;
set @member_sex = 1;
insert into basicmember(Member_name, age, Gender) values(@member_name, @member_age, @member_sex);
 
/*	PT 맴버 추가하기. member_id는 헬스장 이용객의 id, trainer_id는 헬스장 직원의 id	*/
set @member_id = 4;
set @trainer_id = 1;
insert into ptmember(id, PT_trainer_id)
select id, EMPLOYEE_NO
  from basicmember, employee
 where basicmember.id = @member_id and employee.EMPLOYEE_NO = @trainer_id;
 
 
 
 SELECT * FROM ptmember;
 
 delete from ptmember where id = 1;