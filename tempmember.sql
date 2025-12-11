create table tempmember (
id varchar2(20) primary key,
passwd varchar2(20),
name varchar2(20),
mem_num1 varchar2(6),
mem_num2 varchar2(7),
e_mail varchar2(40),
phone varchar2(30),
zipcode varchar2(7),
address varchar2(60),
job varchar2(30) );

insert into tempmember values ('aaaa', '1111', '가길동', '123456', '7654321', 'ga@naver.com', '02-1234-1234', '100-100', '서울특별시 영등포구 영등포동 신한빌딩', '개발자');
insert into tempmember values ('bbbb', '2222', '나길동', '234567', '6543210', 'na@google.com', '032-1234-5678', '150-100', '인천광역시 머시기 저시기', '대표이사');
insert into tempmember values ('cccc', '3333', '다길동', '663456', '6435765', 'da@daum.com', '033-4324-6431', '760-231', '강원도 ㅇㄷㅇㄷ ㅈㄱㅈㄱ', '프로그래머');

select * from tempmember;

commit;