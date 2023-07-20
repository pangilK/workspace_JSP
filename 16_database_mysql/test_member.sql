-- 실행 명령문 선택 후 , alt + x || alt + c
show databases;

use digital_jsp;
-- 테이블 목록 확인
show tables;

drop table if exists member;

create table if not exists member(
	num INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50),
	addr VARCHAR(300)
);

desc member;
describe member;

/*
*	 INSERT 	SELECT 		UPDATE 		DELETE
*	 Create  	 Read  		Update 		Delete
*/
select * from member;
insert into member(name,addr) values('홍길동','한양');