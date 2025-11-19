select * from tab;

-- 테이블 구조확인
desc emp;
select * from emp order by ename desc;

desc dept;
select * from dept;

/*
    select => 데이터 조회
    select [distinct] 컬럼 from 테이블;
*/

select * from emp;
select empno, ename, sal from emp;

select ename 이름, sal as 급여, hiredate "입사일" from emp;
-- 별칭에는 공백문자, 특수문자($, #, _), 영문 대소문자 사용 가능.

-- 중복 데이터 한 번씩만 출력하기 위해 DISTINCT 예약어 사용
select distinct job from emp;

select * from emp where deptno = 30;

/*
    where => 조건과 비교연산
    select 컬럼 from 테이블 where 조건;
*/

select empno, ename, sal from emp where sal >= 3000;

select * from emp where deptno = 10;

select empno, ename, sal from emp where sal < 2000;


-- 문자 데이터 조회 => '' 안에 표시. 대소문자 구분.
select empno, ename, sal from emp where ename = 'SCOTT';

select empno, ename, job from emp where ename = 'MILLER';

-- 날짜 데이터 => '' 안에 표시. 년/월/일로 표시
select hiredate from emp;

select ename, hiredate from emp where hiredate >= '85/01/01';

/*
    논리연산자: and, or, not
    범위연산자: between and
    in
    Like (eqauls, startwith)
*/

select ename, deptno, job from emp where deptno = 10 and job = 'MANAGER';
select * from emp where sal >= 1000 and sal <= 3000;
select * from emp where sal between 1000 and 3000;

select ename, deptno, job from emp where deptno = 10 or job = 'MANAGER';
select empno, ename from emp where empno = 7844 or empno = 7654 or empno = 7521;

select ename, deptno, job from emp where deptno = 10;
select ename, deptno, job from emp where not deptno = 10;

select ename, sal from emp where sal between 1000 and 3000;
select empno, ename, sal from emp where sal between 1500 and 2500;
select empno, ename from emp where empno in (7844, 7654, 7521);
select ename, sal, comm from emp where comm in (300, 500, 1400);

/*
    Like (equals, startswith)
        %: 문자가 없거나, 하나 이상의 문자가 어떤 값이 오든 상관X
        _: 하나의 문자가 어떤 값이든 상관X
*/

select empno, ename from emp where ename not like 'K%';
select empno, ename from emp where ename like '%K';

select empno, ename from emp where ename like '_A%';

select empno, ename from emp where ename not like '%A%';

select 100 + 0 from dual;

/*
    오라클에서는 null값이 저장되는것을 허용함.
    
    NULL
        - 미확정 or 알 수 없는 값
        - 연산, 할당, 비교 불가능
        - is null, is not null 사용.
*/

select comm from emp;
select ename, comm, job from emp where comm is null;
select ename, comm, job from emp where comm is not null;

select * from emp;
select ename, job, mgr from emp where mgr is null;


