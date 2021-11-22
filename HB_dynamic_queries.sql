USE healthbase;

/*	헬스장 추가하기	*/
set @place_address = "Ajou Univ";
set @place_name = "아주대점";
set @place_gender_limit = "U";
insert into healthbase.gym(address, name, sex) values(@place_address, @place_name, @place_gender_limit);

/*	헬스장 장비 추가하기	*/
set @equipment_name = "아령";
set @equipment_weight = "10kg";
set @equipment_place = "Ajou Univ";
insert into equipment(Name_equipments, Weight_equipments, IsUse_equipments, Place)
select @equipment_name, @equipment_weight, True, address
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
 
/*	헬스장 직원 일정 추가하기.	*/
set @start_time = "2021-11-22 09:00:00";
set @end_time = "2021-11-22 18:00:00";
set @employee_id = 1;
insert into schedule(EMPLOYEE_NO, START_TIME, END_TIME)
	select EMPLOYEE_NO, @start_time, @end_time from Employee where EMPLOYEE_NO = @employee_id; 

/*	헬스장 이용객 추가하기.	*/
set @member_name = "Mr.J";
set @member_age = 25;
set @member_gender = 1;
insert into basicmember(Member_name, age, Gender) values(@member_name, @member_age, @member_gender);
 
/*	PT 맴버 추가하기. member_id는 헬스장 이용객의 id, trainer_id는 헬스장 직원의 id	*/
set @member_id = 4;
set @trainer_id = 1;
insert into ptmember(id, PT_trainer_id)
select id, EMPLOYEE_NO
  from basicmember, employee
 where basicmember.id = @member_id and employee.EMPLOYEE_NO = @trainer_id;
 
 
 set @member_gender = 1;
 SELECT * FROM gym WHERE SEX = @member_gender;
 
 /*  체육관 영업시간 관련해서는 전면적인 수정이 필요  */
 UPDATE gym SET BUSINESSHOUR = 0 WHERE ADDRESS='경기도 수원시 영통구 월드컵로 206';
 
 /* 사용가능 운동기구 조회 */
SELECT * FROM equipment
	WHERE IsUse_equipments = True; 

/* 운동기구 사용 가능 상태 전환 */
set @id = 1;
set @equip_status = True;
UPDATE equipment SET IsUse_equipments = @equip_status WHERE Id_equipments = @id;

/* PT 등록한 이용객 조회 */
Select Member_name From basicmember, ptmember
	Where basicmember.id=ptmember.id;

/* 직원의 직장 정보 조회 */
set @id = 1;
SELECT address, name, sex FROM gym, EMPLOYEE WHERE gym.address =  EMPLOYEE.WORKPLACE and EMPLOYEE.EMPLOYEE_NO = @id;

/* 특정 트레이너의 PT 관리 회원 조회 */
set @employee_id = 1;
SELECT * FROM basicmember, PTMEMBER WHERE PTMEMBER.PT_trainer_id = @employee_id and basicmember.id = PTMEMBER.id;

/* 특정 직원의 근무 일정 조회 */
set @employee_id = 1;
SELECT * FROM SCHEDULE WHERE EMPLOYEE_NO = @employee_id;

SELECT * FROM ptmember;
 
delete from ptmember where id = 1;