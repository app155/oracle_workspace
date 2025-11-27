/*
    뷰(VIEW)
        - 실제 테이블에 저장된 데이터의 일부를 뷰를 통해 볼 수 있음
        - 테이블과 거의 동일하게 사용되어 가상테이블이라고도 부름
        - 하나의 테이블에 복수의 뷰를 생성 가능
        - 물리적 구조물인 테이블과 달리 데이터 저장 공간이 없음.
            => 단순히 쿼리문을 저장하는 객체
        - 뷰 정의에 사용된 기본 테이블 수에 따라 단순뷰, 복합뷰로 나뉨.
            
    사용목적
        - 직접적인 테이블 접근을 제한하기 위해 사용
        - 복잡한 질의를 간단히 만들기 위해 사용
        
        
*/

drop table emp01;
create table emp01 as select * from emp;
select * from emp01;

create view view_emp10 as select empno, ename, sal, deptno from emp01 where deptno = 10;

select * from view_emp10;

/*
    뷰 생성
        - CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW VIEW_NAME AS SUBQUERY [WITH CHECK OPTION] [WITH READ ONLY];
        
        [OR REPLACE]
            - 새로운 뷰를 만들 수 있을 뿐 아니라, 기존 뷰가 존재해도 삭제없이 변경 가능.
        [FORCE|NOFORCE]
            - 기본 테이블 존재 여부에 상관없이 뷰를 생성
        [WITH CHECK OPTION]
            - 해당 뷰를 통해 볼 수 있는 범위에 한해 UPDATE | INSERT 가능
        [WITH READ ONLY]
            - SELECT만 가능
*/

select view_name, text from user_views;

/*
    뷰 동작 원리
        1. 사용자가 뷰에 대한 질의 시 USER_VIEWS에서 뷰에 대한 정의를 조회.
        2. 기본 테이블에 대한 뷰의 접근 권한을 살핌
        3. 뷰에 대한 질의를 기본 테이블에 대한 질의로 변환
        4. 기본 테이블에 대한 질의를 통해 데이터를 검색
        5. 검색 결과 출력
        
                    단순 뷰                                    복합 뷰
                ------------------------------------------------------------
                하나의 테이블로 생성                         여러 테이블로 생성
                그룹함수 사용 불가                           그룹함수 사용 가능
                DISTINCT 사용 불가                          DISTINCT 사용 가능
                DML 사용 가능                               DML 사용 불가
*/

insert into view_emp10 values (8000, 'angel', 7000, 10);
-- 단순 뷰 대상으로 실행한 DML 명령문은 뷰를 정의할 때 사용된 기본 테이블에 적용됨

select * from emp01;
select * from view_emp01;

create or replace view view_emp(사원번호, 사원명, 급여, 부서번호) 
as select empno, ename, sal, deptno from emp01;

select * from view_emp;
select * from view_emp where 부서번호 = 10;


create view view_sal 
as select deptno, sum(sal) as SalSum, trunc(avg(sal)) as SalAvg from emp01 group by deptno;

select * from view_sal;

/*
    단순 뷰에서 DML 명령어 조작이 불가능한 경우
        - 뷰 정의에 포함되지 않은 컬럼 중 기본 테이블에서 not null 제약조건이 지정되어 있는 경우
            => INSERT INTO 사용 불가
        - 뷰에 산술 표현식으로 정의된 가상 컬럼
            => INSERT | UPDATE 사용 불가
        - 그룹함수, GROUP BY절, DISTINCT를 포함한 경우
*/


desc emp07;
desc dept07;

create table emp07 (
EMPNO       NUMBER(4) primary key,   
ENAME       VARCHAR2(10) ,
JOB         VARCHAR2(9)  ,
MGR         NUMBER(4)    ,
HIREDATE    DATE         ,
SAL         NUMBER(7,2)  ,
COMM        NUMBER(7,2)  ,
DEPTNO      NUMBER(2) );

create table dept07 (
DEPTNO          NUMBER(2)   primary key, 
DNAME           VARCHAR2(14) ,
LOC             VARCHAR2(13) );

select * from emp07;

insert into emp07 select * from emp;
insert into dept07 select * from dept;

create view view_emp07_dept07 
as select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc from emp07 e, dept07 d
where e.deptno = d.deptno order by empno desc;

select * from view_emp07_dept07;
select view_name, text from user_views;

drop view view_sal;

create or replace view view_emp10 as select empno, ename, sal, comm, deptno from emp01 where deptno = 10;
select * from view_emp10;



create or replace force view view_notable as select empno, ename, deptno from emp08 where deptno = 10;

select * from view_notable;



create or replace view view_chk20
as select empno, ename, sal, comm, deptno from emp01 where deptno = 20 with check option;

select * from view_chk20;
desc view_chk20;

update view_chk20 set deptno = 10 where sal > 1500;




create or replace view view_read30
as select empno, ename, sal, comm, deptno from emp01 where deptno = 30 with read only;

update view_read30 set comm = 1000;



/*
    시퀸스 (SEQUENCE)
        - 유일한 값을 생성해 주는 오라클 객체
        - 기본키와 같이 순차적으로 증가하는 컬럼을 자동 생성
        
    CREATE SEQUENCE 시퀀스명
    START WITH n
    INCREMENT BY k
    MAXVALUE m | NOMAXVALUE
    MINVALUE m | NOMINVALUE
    CYCLE | NOCYCLE
    CACHE | NOCACHE;
        - 메모리상 시퀀스 값의 관리여부. 기본값 20
*/

drop table emp01;

create table emp01 as select empno, ename, hiredate from emp where 1 = 0;

create sequence emp_seq 
start with 1
increment by 1
maxvalue 1000000
minvalue 1;

insert into emp01 values (emp_seq.nextval, 'JULIA', sysdate);
insert into emp01 values (emp_seq.nextval, 'JULIA', sysdate);
select * from emp01;
select emp_seq.currval from dual;

/*
    currval, nextval 사용 가능한 경우
        - 서브쿼리가 아닌 SELECT문
        - INSERT문 SELECT절
        - INSERT문 VALUES절
        - UPDATE문 SET절
        
    currval, nextval 사용 불가능한 경우
        - VIEW의 SELECT절
        - DISTINCT가 포함된 SELECT절
        - GROUP BY, HAVING, ORDER BY절이 포함된 SELECT절
        - SELECT, DELETE, UPDATE의 서브쿼리
        - CREATE TABLE, ALTER TABLE 명령의 기본값
*/

select * from tab;
create table dept04 as select * from dept where 1 = 0;
select * from dept04;

create sequence dept_seq
start with 10
increment by 10
maxvalue 30;

insert into dept04 values (dept_seq.nextval, 'ACCOUNTING', 'NEW YORK');
insert into dept04 values (dept_seq.nextval, 'RESEARCH', 'DALLAS');
insert into dept04 values (dept_seq.nextval, 'SALES', 'CHICAGO');

select sequence_name, min_value, max_value, increment_by, cycle_flag from user_sequences;

alter sequence dept_seq
maxvalue 1000000;

drop sequence dept_seq;


























