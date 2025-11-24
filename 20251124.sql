select * from tab;

desc dept01;

create table dept01 ( deptno number(2), dname varchar2(14), loc varchar2(13) );
create table dept02 ( deptno number(2) primary key, dname varchar2(14), loc varchar2(13) );

select * from dept02;

/*
    INSERT INTO
        1. 특정 컬럼에만 데이터 추가
            - INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...);
        2. 모든 컬럼에 데이터 추가
            - INSERT INTO 테이블명 VALUES(...);
*/

insert into dept01(deptno, dname, loc) values(10, 'ACCOUNTING', 'NEW YORK');
select * from dept01;

insert into dept01 values(20, 'RESEARCH', 'DALLAS');
insert into dept01(deptno, dname, loc) values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept02(deptno, dname, loc) values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept02(deptno, dname, loc) values(null, 'ACCOUNTING', 'NEW YORK');
insert into dept02(deptno, dname, loc) values('', 'ACCOUNTING', 'NEW YORK');

/*
    UPDATE ~ SET
        UPDATE 테이블명 SET 컬럼명1 = 값1, 컬럼명2 = 값2, ... WHERE 조건;
            - WHERE절 생략시 모든 데이터가 변경되니 주의.
*/

select * from tab;
drop table dept02 purge;

create table emp01 as select * from emp;
select distinct(deptno) from emp01;
update emp01 set deptno = 30;

select * from emp01;
rollback;
drop table emp01;

update emp01 set sal = sal * 1.1;
update emp01 set hiredate = sysdate;

update emp01 set deptno = 30 where deptno = 10;
update emp01 set sal = sal * 1.1 where sal >= 3000;

update emp01 set hiredate = sysdate where substr(hiredate, 1, 2) = 87;

update emp01 set deptno = 2, job = 'MANAGER' where ename = 'SCOTT';

update emp01 set hiredate = sysdate, sal = 50, comm = 4000 where ename = 'SCOTT';

/*
    DELETE FROM
        - DELETE FROM 테이블명 WHERE 조건
*/

select * from emp01;
delete from emp01;
rollback;
delete emp01;

select * from tab;
create table dept01 as select * from dept;
select * from dept01;

delete from dept01 where deptno = 30;

/*
    DELETE 명령으로 데이터를 삭제했을 시 ROLLBACK 가능.
        - 데이터를 삭제해도 메모리공간은 사라지지 않아 ROLLBACK 가능
    TRUNCATE 명령으로 데이터를 삭제했을 시 ROLLBACK 불가능.
        - 데이터를 삭제할 경우 저장공간까지 삭제하여 되돌려도 데이터 저장할 공간이 없어 ROLLBACK 불가능.
*/

truncate table emp01;
rollback;
select * from emp01;
select * from tab;
drop table emp01;
purge recyclebin;

/*
    emp01 테이블
    
    empno               number(4)
    ename               varchar2(10)
    job                 varchar2(9)
    mjr                 number(4)
    hiredate            date
    sal                 number(7, 2)
    comm                number(7, 2)
    deptno              number(2)
*/

create table emp01 (
empno number(4),
ename varchar2(10),
job varchar2(9),
mjr number(4),
hiredate date,
sal number(7, 2),
comm number(7, 2),
deptno number(2) );

desc emp01;
select * from emp01;

insert into emp01 values (
7369, 'SMITH', 'CLERK', 7836, '80/12/17', 800, '', 20);

insert into emp01 values (
7499, 'ALLEN', 'SALESMAN', 7369, '87/12/20', 1600, 300, 30);

insert into emp01 (empno, ename, job, sal) values (
7839, 'KING', 'PRESIDENT', 5000);

/*
    트랜잭션
        - 데이터베이스에서 데이터를 처리하는 하나의 논리적인 작업 단위.
        - 데이터의 일관성 유지, 안정적으로 데이터를 복구하기 위해 사용됨
        
    COMMIT
        - 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어.
        - 트랜잭션 처리과정에서 데이터베이스에 모두 반영하기 위해 변경내용을 영구저장.
        
    ROLLBACK
        - 작업 중 문제 발생시 트랜잭션 처리과정 중 발생한 변경사항을 취소하는 명령어.
        - 트랜잭션으로 인한 하나의 묶음으로 처리 시작 이전상태로 되돌림
        
    자동 COMMIT, 자동 ROLLBACK 명령이 되는 경우
        - SQL이 정상 종료되면 COMMIT, 비정상 종료시 ROLLBACK이 자동적으로 작동.
        - DDL / DML 명령이 수행된 경우 자동 COMMIT
*/

select * from dept01;
delete from dept01;
rollback;

delete from dept01 where deptno = 20;
commit;
rollback;

/*
    무결성
        - 데이터베이스 내 데이터의 확장성을 유지하는 성질.

    무결성 제약 조건
        - 데이터 추가, 수정, 삭제 과정에서 무결성을 유지할 수 있도록 하는 제약조건.
        - 바람직하지 않은 데이터가 저장되는 것을 방지함.
        
    무결성 제약 조건 종류
        1. NOT NULL
            - NULL값 불허
        2. UNIQUE
            - 중복값 불허
        3. PRIMARY KEY
            - NULL값, 중복값 불허
        4. FOREIGN KEY
            - 참조되는 테이블 컬럼의 값이 존재하면 허용
        5. CHECK
            - 저장 가능한 데이터 값의 범위, 조건 지정하여 설정한 값만 허용
*/

select * from tab;
drop table dept01;
purge recyclebin;

create table emp01 (
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(2) );

desc emp01;
insert into emp01 values (null, null, 'salesman', 30);
select * from emp01;

create table emp02 (
empno number(4) not null,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2) );

insert into emp02 values (7499, 'allen', 'salesman', 30);
select * from emp02;

insert into emp02 values (7499, 'ones', 'manager', 20);

create table emp03 (
empno number(4) unique,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2) );

insert into emp03 values (7499, 'allen', 'salesman', 30);
insert into emp03 values (7499, 'ones', 'manager', 20);

select table_name from user_tables order by table_name desc;

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'EMP03';

/*
    제약 조건 타입
        - P (PRIMARY KEY)
        - R (FOREIGN KEY)
        - U (UNIQUE)
        - C (CHECK NOT NULL)
        
    USER_COLUMNS
        - 제약조건이 지정된 컬럼 조회
*/

select * from user_cons_columns where table_name = 'EMP03';

create table emp04 (
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2) );

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'EMP04';
select * from user_cons_columns where table_name = 'EMP04';
insert into emp04 values (7499, 'allen', 'salesman', 30);
insert into emp04 values (null, 'ones', 'manager', 20);

/*
    참조 무결성 제약조건
        - 두 테이블 사이(사원, 부서 테이블)의 주종관계에서 성립.
        - 부서 -> 소속 -> 사원
        - 소속이라는 관계는 두 테이블 간 참조무결성 개념을 포함한 외래키 제약조건 명시해야만 설정됨.
        - 자식인 사원테이블의 부서번호 컬럼에 부모인 부서테이블의 부서번호가 부모키로 설정 => 외래키 제약조건.
        - 부모키가 되기 위한 컬럼은 반드시 부모의 기본키나 유일키로 설정되어야 함.
*/










