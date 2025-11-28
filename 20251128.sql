select * from tab;

create table department (
deptno number(3) not null,
dname varchar2(30) not null,
college number(3) not null,
loc varchar2(10) not null,
constraint DEPARTMENT_PK primary key(deptno) );

desc department;

commit;

show user;

select * from department;


create table professor (
profno number(5) not null,
name varchar2(10) not null,
ename varchar2(20) not null,
position varchar2(20) not null,
sal number(4) not null,
hiredate date not null,
age number(3) not null, 
deptno number(3) not null,
constraint PROFESSOR_PK primary key(profno) );

alter table professor 
add constraint PROFESSOR_FK foreign key(deptno) references department(deptno);

select * from professor;
select * from department;