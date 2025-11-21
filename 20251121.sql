/*
    날짜 변환 함수
        - DATE형에 사용하는 함수로 날짜, 기간을 반환.
        - 기간은 주로 일 단위로 계산되나, 월 단위로 계산되는 경우도 있음
        - SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, ROUND, TRUNC..
*/

select sysdate from dual;
select sysdate - 1, sysdate, sysdate + 1 from dual;
select ename, hiredate, trunc(sysdate - hiredate) from emp where deptno = 10;
select ename, hiredate, trunc(months_between(sysdate, hiredate)) from emp where deptno = 10;
select ename, hiredate, add_months(hiredate, 3) from emp;

select sysdate, next_day(sysdate, 3) from dual;
alter session set nls_language = AMERICAN;
select sysdate, next_day(sysdate, 'tue') from dual;
alter session set nls_language = KOREAN;
select sysdate, next_day(sysdate, '화') from dual;

select sysdate, last_day(sysdate) from dual;

select hiredate, round(hiredate, 'month') from emp where deptno = 10;

/*
    변환 함수
        - 자료형을 변환함.
        - TO_CHAR, TO_DATE, TO_NUMBER..
*/

select to_char(sysdate, 'YYYY-MM-DD-DY, HH:MI:SS') from dual;
select to_char(hiredate, 'YYYY-MM-DD-DAY') from emp where deptno = 20;

/*
    숫자형 -> 문자형
        0: 자릿수 표시. 자릿수가 맞지 않으면 0으로 채움
        9: 자릿수 표시.
        L: 각 지역별 통화기호를 앞에 표시
        .: 소수점
        ,: 천단위 자릿수 구분
*/

select ename, sal, to_char(sal, '000,000,000') from emp;
select ename, sal, to_char(sal, '999,999,999') from emp;

select ename, hiredate from emp where hiredate = '1981/02/20';
select ename, hiredate from emp where hiredate = to_date('1981/02/20', 'YY/MM/DD');

select trunc(sysdate - to_date('2025/01/01', 'YYYY/MM/DD')) from dual;

select to_number('10,000', '999,999') + to_number('20,000', '999,999') from dual;

/*
    일반함수: 기타함수(NVL, DECODE, CASE)
        - NVL   : 첫 번째 인자가 NULL과 같다면 두 번째 인자로 변경
          DECODE: 첫 번째 인자를 조건에 맞추어 변경
          CASE  : 조건에 맞춰 문장 수행
*/

select ename, sal, comm, job from emp;
select ename, sal, nvl(comm, 0), job from emp;
select ename, sal, comm, sal * 12 + nvl(comm, 0), job from emp;

select empno, ename, job, nvl(to_char(mgr, '9999'), 'CEO') from emp where mgr is null;

-- DECODE(식, 조건, 결과1, 결과2, 결과3, 기본결과 n)
select deptno, dname from dept;
select empno, ename, deptno,
decode (deptno, 10, 'ACCOUNTING',
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS') dname from emp;

-- CASE 표현식 WHEN 조건1 THEN 결과1 WHEN 조건2 THEN 결과2 ELSE 결과 N END
select empno, ename, deptno,
case when deptno = 10 then 'ACCOUNTING'
    when deptno = 20 then 'RESEARCH'
    when deptno = 30 then 'SALES'
    when deptno = 40 then 'OPERATIONS' end dname from emp;

select empno, ename, job, sal,
decode(job, 'MANAGER', sal * 1.15,
            'CLERK', sal * 1.05,
            sal) bonus from emp;

select empno, ename, job, sal,
case when job = 'SALESMAN' then sal * 1.05
    when job = 'CLERK' then sal * 1.2
    when job = 'ANALYST' then sal * 1.15
    when job = 'MANAGER' then sal * 1.1
    else sal end bonus from emp;
    
select sum(sal) from emp;
select trunc(avg(sal)) from emp;
select max(sal), min(sal) from emp;

select count(*) 전체인원, count(comm) 커미션 from emp;
select deptno, sum(sal), trunc(avg(sal)), max(sal), min(sal)
    from emp group by deptno having avg(sal) >= 2000;
select deptno, sum(sal), trunc(avg(sal)), max(sal), min(sal)
    from emp group by deptno having max(sal) >= 2900;

/*
    테이블 구조
    테이블 생성, 변경, 삭제 => CREATE, ALTER, DROP
    테이블 이름 변경 => RENAME
    
    데이터 타입
        - CHAR, VARCHAR2, NUMBER(W), NUMBER(W,D)
            DATE, TIMESTAMP, LONG, LOB, ROWID
            
    테이블, 칼럼명 규칙
        1. 문자로 시작
        2. 1-30자 사이로 명명
        3. 알파벳 대소문자, 0~9, 특수문자(#, &, _)
        4. 오라클에서 사용되는 예약어나 다른 객체명과 중복 불가
        5. 공백 X
*/

create table emp01(empno number(4),
                    ename varchar2(20),
                    sal number(7,2));

desc emp01;
select * from emp01;

-- 기존 테이블의 구조 및 데이터 복사
create table emp02 as select * from emp;
select * from emp02;
desc emp02;
desc emp;

-- 테이블의 구조만 복사
create table emp03 as select * from emp where 1 = 0;
select * from emp03;
select * from emp01;


/*
    테이블 구조 변경
        ALTER TABLE => 테이블의 칼럼 추가, 변경, 삭제
        
        ADD(칼럼명 데이터타입(크기))
        MODIFY(칼럼명 데이터타입(크기))
        DROP COLUMN 칼럼명
*/

alter table emp01 add(job varchar2(9));
desc emp01;

/*
    칼럼 구조 변경 시
        데이터가 없는 경우 => 데이터 타입, 크기 모두 변경 가능
        데이터가 있는 경우
            - 데이터 타입 변경 불가
            - 현재 데이터의 크기보다 더 작게 변경 불가
*/

insert into emp01 values(7369, 'SMITH', 800, 'CLERK');
alter table emp01 modify(empno number(5));
alter table emp01 modify(sal number(8, 2));

alter table emp01 drop column job;
desc emp01;

select * from tab;
drop table emp01;

select * from recyclebin;
purge recyclebin;

create table emp01 as select * from emp;
drop table emp01 purge;

rename emp01 to emp02;
delete from emp02;
rollback;
select * from emp02;

truncate table emp02;

flashback table emp01 to before drop;