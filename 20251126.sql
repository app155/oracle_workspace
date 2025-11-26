
-----------OUTER JOIN-----------

select deptno from dept;
select distinct(deptno) from emp;

select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno(+) = d.deptno;


------------SELF JOIN------------
select ename, mgr from emp;
select w.ename 사원, m.ename 매니저 from emp w, emp m where w.mgr = m.empno;
 
select w.ename || '의 매니저는 ', m.ename || '이다' from emp w, emp m where w.mgr = m.empno; 


select * from emp;
select * from dept;

-- 1. 사원들 사원이름, 부서번호, 부서이름      EQUI JOIN
select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno = d.deptno;

-- 2. 부서번호 30인 사원 이름, 직급, 부서번호, 부서위치
select e.ename, e.job, d.deptno, d.loc from emp e, dept d where e.deptno = d.deptno and e.deptno = 30;

-- 3. 커미션 받는 사원 이름, 커미션, 부서이름, 부서위치
select e.ename, e.comm, d.deptno, d.loc from emp e, dept d where e.deptno = d.deptno and e.comm not in 0;

-- 4. DALLAS근무 사원이름, 직급, 부서번호, 부서이름
select e.ename, e.job, d.deptno, d.dname from emp e, dept d where e.deptno = d.deptno and d.loc = 'DALLAS';

-- 5. 이름에 a가 들어가는 사원 이름, 부서이름
select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno and e.ename like '%A%';

-- 6. 사원이름, 직급, 급여, 급여등급          NONEQUI JOIN
select e.ename, e.job, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;

-- 7. 사원이름, 부서번호, 해당사원과 같은 부서에서 근무하는 사원          SELF JOIN
select e1.ename as self, e1.deptno, e2.ename as co, e2.deptno from emp e1, emp e2 where e1.ename != e2.ename and e1.deptno = e2.deptno order by e1.ename;



/*
    서브쿼리
        - 하나의 SELECT문장 안에 포함된 또 하나의 SELECT문장
*/

select deptno from emp where ename = 'SCOTT';
select dname from dept where deptno = 20;

select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

select * from emp where deptno = (select deptno from emp where ename = 'SMITH');
select dname from dept where deptno = (select deptno from emp where ename = 'SMITH');

select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno and e.deptno = 10;
select e.ename, d.dname from emp e, (select deptno, dname from dept where deptno = 10) d where e.deptno = d.deptno;

select ename, sal from emp;
select trunc(avg(sal)) from emp;
select ename, sal from emp where sal > (select trunc(avg(sal)) from emp);


select distinct(deptno) from emp where sal >= 3000;
select ename, sal, deptno from emp where deptno in (select distinct(deptno) from emp where sal >= 3000);

select ename, sal from emp;
select sal from emp where deptno = 30;

select ename, sal from emp where sal > some (select sal from emp where deptno = 30);
select ename, sal from emp where sal > any (select sal from emp where deptno = 30);

select ename, sal from emp where sal > all (select sal from emp where deptno = 30);

select dname from dept where deptno = 10;
select * from dept where dname = 'ACCOUNTING';
select * from emp where exists (select dname from dept where deptno = 10);

select * from tab;

create table dept03 as select * from dept where 1 = 0;
select * from dept03;
insert into dept03 select * from dept;

select loc from dept03 where deptno = 40;
update dept03 set loc = (select loc from dept03 where deptno = 40) where deptno = 10;
rollback;

select * from emp;
-- 1.
select ename, sal from emp where sal >= (select sal from emp where ename = 'SCOTT');

-- 2.
select deptno, dname, loc from dept where deptno in (select deptno from emp where job = 'CLERK');

-- 3.
select empno, ename from emp where deptno in (select deptno from emp where ename like '%T%');

-- 4.
select ename, deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');

-- 5.
select ename, sal from emp where deptno = (select deptno from dept where dname = 'SALES');

-- 6.
select ename, sal from emp where mgr = (select empno from emp where ename = 'KING');

-- 7.
select empno, ename, sal from emp 
where sal > (select avg(sal) from emp) and deptno in (select deptno from emp where ename like '%S%');









