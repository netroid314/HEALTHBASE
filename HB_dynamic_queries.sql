USE healthbase;

/*	헬스장 추가하기	*/
DELIMITER $$

CREATE procedure new_gym_insert(
	IN place_address VARCHAR(32),
    in place_name VARCHAR(32),
    in place_gender_limit varchar(1)
)
BEGIN
	insert into healthbase.gym(address, name, sex) values(place_address, place_name, place_gender_limit);
END$$

/*	헬스장 장비 추가하기	*/
CREATE procedure new_equip_insert(
	in equipment_name VARCHAR(50),
    in equipment_weight CHAR(8),
    in equipment_place VARCHAR(32)
)
BEGIN
	insert into equipment(Name_equipments, Weight_equipments, IsUse_equipments, Place)
	select equipment_name, equipment_weight, True, address
	  from gym
	 where address = @equipment_place;
END$$

DELIMITER $$
/*	헬스장 직원 추가하기.	*/
CREATE procedure new_employee_insert(
	in employee_name VARCHAR(50),
    in employee_age CHAR(8),
    in employee_workplace VARCHAR(32)
)
BEGIN
	insert into healthbase.employee(EMPLOYEE_NAME, age, WORKPLACE)
	select employee_name, employee_age, address
	  from gym
	 where address = employee_workplace;
 END $$
 
 CALL new_employee_insert('Ms.K',25,'Ajou Univ 1');
 
/*	헬스장 직원 일정 추가하기.	*/ 
DELIMITER $$
CREATE procedure new_employee_schedule_insert(
	in employee_id int,
    in start_time Datetime,
    in end_time Datetime
)
BEGIN
	insert into healthbase.schedule(EMPLOYEE_NO, START_TIME, END_TIME)
		select EMPLOYEE_NO, start_time, end_time from healthbase.employee where EMPLOYEE_NO = employee_id; 
END $$

CALL new_employee_schedule_insert(4, '2021-09-02 12:00:00', '2021-09-02 13:00:00');
 
/*	헬스장 이용객 추가하기.	*/
DELIMITER $$
CREATE procedure new_member_insert(
	in member_name varchar(32),
    in member_age int,
    in member_gender int
)
BEGIN
	insert into basicmember(Member_name, age, Gender) values(member_name, member_age, member_gender);
END $$

/*	PT 맴버 추가하기. member_id는 헬스장 이용객의 id, trainer_id는 헬스장 직원의 id	*/
DELIMITER $$
CREATE procedure new_pt_member_insert(
	in member_id int,
    in trainer_id int
)
BEGIN
	insert into healthbase.ptmember(id, PT_trainer_id, end_date)
	select id, EMPLOYEE_NO, DATE_ADD(current_date(), INTERVAL 7 day)
	  from basicmember, employee
	 where basicmember.id = member_id and employee.EMPLOYEE_NO = trainer_id;
END $$
 
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
SELECT * FROM SCHEDULE WHERE EMPLOYEE_NO = @employee_id; oreder by START_TIME DESC;

/* 남은 PT 날짜 조회*/
set @member_id = 200060;
SELECT DATEDIFF(end_date, current_date()) as remain_day FROM (SELECT end_date FROM healthbase.ptmember where id = @member_id) as e;


/* 특정 날짜 운영 조회 */
set @gym_addr = 'Ajou Univ';
SELECT sun_start FROM healthbase.gym_schedule WHERE address = @gym_addr and sun_start is not null and sun_end is not null;

/* pt 트레이너 가능 시간 조회 */
set @member_id = 200060;
SELECT * FROM healthbase.schedule right join healthbase.employee on healthbase.schedule.EMPLOYEE_NO = healthbase.employee.EMPLOYEE_NO where healthbase.schedule.EMPLOYEE_NO = (SELECT PT_trainer_id from healthbase.ptmember where id = @member_id);

/* 특정 시간대 PT 가능 조회 */
set @member_id = 200060;
set @start_time = '2021-12-8 11:00:00';
set @end_time = '2021-12-8 11:50:00';
SELECT if(COUNT(*)>0, FALSE, TRUE) as 이용가능 FROM (SELECT START_TIME, END_TIME FROM healthbase.pt_schedule right join healthbase.employee on healthbase.pt_schedule.EMPLOYEE_NO = healthbase.employee.EMPLOYEE_NO where healthbase.pt_schedule.EMPLOYEE_NO = (SELECT PT_trainer_id from healthbase.ptmember where id = @member_id)) as s
 where (@start_time <= s.START_TIME and s.START_TIME <= @end_time) or (@start_time <= s.END_TIME and s.END_TIME <= @end_time);


/* 특정 지역 혹은 매장 정보 조회 */
set @region = 'AJOU';
SELECT COUNT(emp.EMPLOYEE_NO) as 직원수, COUNT(DISTINCT equip.Id_equipments) as 장비수 FROM (SELECT EMPLOYEE_NO FROM healthbase.gym inner join healthbase.employee on healthbase.gym.address like CONCAT('%',@region,'%') and healthbase.gym.address = healthbase.employee.WORKPLACE) as emp,
	(SELECT Id_equipments FROM healthbase.gym inner join healthbase.equipment on healthbase.gym.address like CONCAT('%',@region,'%') and healthbase.gym.address = healthbase.equipment.Place) as equip;

 
delete from ptmember where id = 1;

delete from employee where EMPLOYEE_NO = 4;

delete from gym where address = 'Ajou Univ 1';

select * from employee;
select * from SCHEDULE;