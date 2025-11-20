/*
    ORDER BY
        - 행을 정렬하는 데 사용하는 쿼리문.
        - 맨 뒤에 기술해야하며 정렬 기준이 되는 컬럼명 또는 SELECT절에서는 별칭 사용 가능.
        - 오름차순(ASC), 내림차순(DESC) 정렬 가능
*/

select empno, ename from emp order by empno desc;

select empno, ename, sal from emp order by sal desc;

select empno, ename, sal from emp order by ename;

select empno, ename, hiredate from emp order by hiredate desc;

select empno, ename, sal from emp order by sal, ename;

/*
    SQL 함수
    
    DUAL 테이블
        - 한 행으로 결과를 표현하기 위한 테이블
        - 산술식을 오라클에서 바로 입력하면 에러 발생 => DUAL 테이블 이용하여 해결
        - 산술연산이나 가상컬럼등의 값을 한 번만 출력하고자 할 때 사용
*/

select deptno, sum(sal) from emp group by deptno having deptno = 30;

/*
    단일행 함수: 행마다 함수가 적용되어 결과를 반환
        
        문자함수: 문자를 다른 형태로 변환
            - LOWER, UPPER, INITCAP, CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD,
              TRIM, CONVERT, CHR, ASCII, REPLACE..
            
        숫자함수: 숫자를 다른 형태로 변환
            - ABS, COS, EXP, FLOOR, LOG, POWER, SIGN, SIN, TAN, ROUND, TRUNC, MOD..
        
        날짜함수: 날짜를 다른 형태로 변환
        
        
        변환함수: 문자, 숫자, 날짜를 서로 다른 형태로 변환
        
        
        일반함수: 기타함수(NVL, DECODE, CASE)
        
        그룹함수: 하나 이상의 행을 그룹으로 묶어 연산하여 하나의 결과로 변환
            - SUM, AVG, COUNT, MAX, MIN, STDDEV, VARIANCE
*/

select 'Database', lower('Database') from dual;
select lower(ename) from emp;
select 'Database', upper('Database') from dual;
select empno, ename, job from emp where lower(job)= 'manager';
select empno, ename, job from emp where job = upper('manager');

select initcap('DATABASE PROGRAM') from dual;
select initcap(ename), deptno from emp where deptno = 10;
select empno, ename, sal, comm from emp where initcap(ename) = 'Smith';


select concat('data', 'base') from dual;
select substr('DataBase', 1, 4) from dual;
select substr(hiredate, 1, 2) from emp;
select substr('DataBase', -4, 3) from dual;
select length('DataBase') from dual;
select instr('DataBase', 'a', 3, 1) from dual;
select lpad('DataBase', 20, ' ') from dual;
select rpad('DataBase', 20, ' ') from dual;
select trim(' ' from '               DataBase       ') from dual;
select trim('S' from trim('H' from 'SMITH')) from dual;
select trim(both from '               DataBase       ') from dual;

select floor(15.324234234) from dual;





