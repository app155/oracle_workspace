/*
    참조 무결성 제약조건
        - 두 테이블 사이(사원, 부서 테이블)의 주종관계에서 성립.
        - 부서 -> 소속 -> 사원
        - 소속이라는 관계는 두 테이블 간 참조무결성 개념을 포함한 외래키 제약조건 명시해야만 설정됨.
        - 자식인 사원테이블의 부서번호 컬럼에 부모인 부서테이블의 부서번호가 부모키로 설정 => 외래키 제약조건.
        - 부모키가 되기 위한 컬럼은 반드시 부모의 기본키나 유일키로 설정되어야 함.
*/

select * from tab;
select * from emp04;
insert into emp04 values (7566, 'jones', 'manager', 50);
select * from dept01;
create table dept01 as select * from dept;

drop table dept01;

create table dept01 (
DEPTNO number(2) primary key,
DNAME varchar2(14),
LOC varchar2(13) );

desc dept01;
select * from dept01;
select * from dept;

insert into dept01 values (10, 'ACCOUNTING', 'NEW YORK');
insert into dept01 values (20, 'RESEARCH', 'DALLAS');
insert into dept01 values (30, 'SALES', 'CHICAGO');
insert into dept01 values (40, 'OPERATIONS', 'BOSTON');

create table emp05 (
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2) references dept01(deptno) );

desc emp05;

select * from user_constraints where table_name = 'EMP05';

insert into emp05 values (7499, 'allen', 'salesman', 30);
insert into emp05 values (7566, 'jones', 'manager', 50);

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints where table_name = 'EMP05';

drop table dept01;

create table emp06 (
empno number(4) primary key,
ename varchar2(10) not null,
gender varchar2(1) check(gender in('M', 'F')) );

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints where table_name = 'EMP06';
insert into emp06 values(7566, 'jones', 'M');
insert into emp06 values(7499, 'allen', 'F');

select constraint_name, constraint_type, table_name, search_condition from user_constraints where table_name = 'EMP06';

select * from tab;
drop table emp05;

create table emp05 (
empno number(4) constraint emp05_empno_pk primary key,
ename varchar2(10) constraint com05_ename_nn not null,
job varchar2(9)constraint com05_job_uk unique,
deptno number(2) constraint com05_deptno_fk references dept01(deptno) );

insert into emp05 values (7499, 'allen', 'salesman', 30);

select * from emp05;

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints where table_name = 'EMP05';

insert into emp05 values (7498, '', 'salesman', 50);

drop table emp03;

create table emp04 (
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(2),
primary key(empno),
unique(job),
foreign key(deptno) references dept01(deptno) );

create table emp03 (
empno number(4),
ename varchar2(10) constraint emp03_ename_nn not null,
job varchar2(9),
deptno number(2),
constraint emp03_empno_pk primary key(empno),
constraint emp03_ename_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno) references dept01(deptno) );

select constraint_name, constraint_type, table_name, r_constraint_name from user_constraints where table_name = 'EMP03';


drop table emp01;

create table emp01 (
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(2) );

alter table emp01 add primary key(empno);

alter table emp05 add constraint emp05_deptno_fk foreign key(deptno) references dept01(deptno);

select constraint_name, constraint_type, table_name, r_constraint_name, status from user_constraints where table_name = 'EMP05';

alter table emp05 drop constraint emp05_empno_pn;

select * from emp05;

alter table emp05 add constraint emp05_ename_nn check(ename is not null);





create table dept02 (
deptno number(2) constraint dept02_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13) );

insert into dept02 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept02 values(20, 'RESEARCH', 'DALLAS');

drop table emp01;

create table emp01 (
empno number(4) constraint emp01_empno_pk primary key,
ename varchar2(10) constraint emp01_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp01_deptno_fk references dept02(deptno) );

select constraint_name, constraint_type, table_name, r_constraint_name, status from user_constraints where table_name = 'EMP01';

insert into emp01 values (7499, 'ALLEN', 'SALESMAN', 10);
insert into emp01 values (7369, 'SMITH', 'CLERK', 20);

select * from emp01;
select * from dept02;

delete from dept02 where deptno = 10;

alter table emp01 disable constraint emp01_deptno_fk;
alter table emp01 enable constraint emp01_deptno_fk;
rollback;

alter table dept02 disable primary key cascade;

select constraint_name, constraint_type, table_name, r_constraint_name, status from user_constraints where table_name in ('DEPT02', 'EMP01');

alter table dept02 drop primary key cascade;



/*
    JOIN
        - 한 개 이상의 테이블에서 원하는 결과를 얻기 위해 사용
        - WHERE절에 명시하는 조건이 FROM절에 명시된 여러 테이블을 묶는 조건이 됨.
    
    규칙
        - PRIMARY KEY와 FOREIGN KEY컬럼을 통한 다른 테이블의 행과 연결
        - 연결 KEY를 사용하여 테이블과 테이블이 결합
        - WHERE절에서 JOIN조건을 사용
        - 명확성을 위해 컬럼 이름 앞에 테이블 또는 테이블 별칭을 사용
        
    종류
    1. EQUI JOIN
        - 동일 컬럼 기준으로 조인    
    2. NONEQUI JOIN
        - 동일 컬럼 없이 다른 조건 사용하여 조인
    3. OUTER JOIN
        - 조건에 만족하지 않는 행도 출력
    4. SELF JOIN
        - 한 테이블 내에서 조인
*/

--------------EQUI JOIN------------
select e.empno, e.ename, e.job, d.deptno, d.dname, d.loc from emp01 e, dept02 d where e.deptno = d.deptno;

select e.empno, e.ename, e.job, d.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno and e.ename = 'SCOTT';



--------------NONEQUI JOIN------------
select * from salgrade;
select * from emp, salgrade;

select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal >= s.losal and e.sal <= s.hisal;
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;









