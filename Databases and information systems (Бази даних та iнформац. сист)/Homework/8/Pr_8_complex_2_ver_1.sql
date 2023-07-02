/* Пороскун О. ПМ-81   Практична робота 8  БД  версия 1   */

/*Комплексне завдання 2. «Відпустки» 
1. Створіть таблицю Vocation, приклад файлу доданий до завдання. 
2. Знайдіть керівників, які сьогодні у відпустці? 
3. В яких містах сьогодні керівники у відпустці? 
4. У яких співробітників керівники сьогодні у відпустці? 
5. У яких керівників є співробітники, що зараз у відпустці?
6. Які співробітники були в цьому місяці у відпустці, але отримують премію? 
7. Видаліть таблицю Vocation. */

-- 1. Створіть таблицю Vocation, приклад файлу доданий до завдання.

drop table Vocation;

create table Vocation(empno number(4) not null,
                      beginning date, 
                      ending  date);

insert into Vocation values(7839,  to_date('2013-01-07', 'YYYY-MM-DD'), to_date('2013-01-15', 'YYYY-MM-DD'));
insert into Vocation values(7839,  to_date('2013-01-24', 'YYYY-MM-DD'), to_date('2013-02-17', 'YYYY-MM-DD'));
insert into Vocation values(7698,  to_date('2013-02-15', 'YYYY-MM-DD'), to_date('2013-02-24', 'YYYY-MM-DD'));
insert into Vocation values(7934,  to_date('2013-02-16', 'YYYY-MM-DD'), to_date('2013-02-19', 'YYYY-MM-DD'));

select * from Vocation;

-- describe Vocation;


-- 2. Знайдіть керівників, які сьогодні у відпустці? 

select mn.empno, mn.ename manager
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcmn.beginning and vcmn.ending;

select wr.empno, wr.ename worker, wr.mgr, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno);

-- 3. В яких містах сьогодні керівники у відпустці? 

select wr.empno, wr.ename worker, wr.mgr, vcwr.beginning, vcwr.ending, dw.loc,
       mn.empno, mn.ename manager, vcmn.beginning, vcmn.ending , dm.loc
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
join dept dw on (wr.deptno = dw.deptno)
join dept dm on (mn.deptno = dm.deptno);


select dm.loc
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
join dept dw on (wr.deptno = dw.deptno)
join dept dm on (mn.deptno = dm.deptno)
where sysdate between vcmn.beginning and vcmn.ending;

-- 4. У яких співробітників керівники сьогодні у відпустці? 

select wr.empno, wr.ename worker
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcmn.beginning and vcmn.ending;

-- 5. У яких керівників є співробітники, що зараз у відпустці?

select mn.empno, mn.ename manager
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcwr.beginning and vcwr.ending;


-- 6. Які співробітники були в цьому місяці у відпустці, але отримують премію? 

select  wr.empno, wr.ename worker, wr.comm
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcwr.beginning and vcwr.ending
and wr.comm is not null;

select  wr.empno, wr.ename worker, wr.mgr, wr.comm, vcwr.beginning, vcwr.ending,
        mn.empno, mn.ename manager, mn.comm, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno);

-- 7. Видаліть таблицю Vocation. 

drop table Vocation;

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

/*
create table Vocation2(empno number(4) not null,
                      beginning date, 
                      ending  date);

describe Vocation2;					  

insert into Vocation2 values(7839,  to_date('2013-01-07', 'YYYY-MM-DD'), to_date('2013-01-15', 'YYYY-MM-DD'));
insert into Vocation2 values(7698,  to_date('2013-02-15', 'YYYY-MM-DD'), to_date('2013-02-24', 'YYYY-MM-DD'));
insert into Vocation2 values(7934,  to_date('2013-02-16', 'YYYY-MM-DD'), to_date('2013-02-19', 'YYYY-MM-DD'));

select * from Vocation2;

select empno, ename, mgr, hiredate, beginning, ending
from emp
join Vocation2 using (empno);

     EMPNO ENAME                       MGR HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- ---------
      7698 BLAKE                      7839 01-MAY-11 15-FEB-13 24-FEB-13
      7839 KING                 (null)     17-NOV-11 07-JAN-13 15-JAN-13
      7934 MILLER                     7782 23-JAN-12 16-FEB-13 19-FEB-13

select wr.empno, wr.ename worker, wr.mgr, wr.hiredate, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, mn.hiredate, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation2 vcwr on (wr.empno = vcwr.empno)
left outer join Vocation2 vcmn on (mn.empno = vcmn.empno);

     EMPNO WORKER                      MGR HIREDATE  BEGINNING ENDING         EMPNO MANAGER              HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- --------- ---------- -------------------- --------- --------- ---------
      7566 JONES                      7839 02-APR-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7698 BLAKE                      7839 01-MAY-11 15-FEB-13 24-FEB-13       7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7782 CLARK                      7839 09-JUN-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      8000 JACKIE CHAN                7839 28-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      8003 DR NO                      7839 11-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7499 ALLEN                      7698 20-FEB-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7521 WARD                       7698 22-FEB-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7654 MARTIN                     7698 28-SEP-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7844 TURNER                     7698 08-SEP-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7900 JAMES                      7698 03-DEC-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7839 KING                 (null)     17-NOV-11 07-JAN-13 15-JAN-13 (null)     (null)               (null)    (null)    (null)
      7788 SCOTT                      7566 09-DEC-12 (null)    (null)          7566 JONES                02-APR-11 (null)    (null)
      7902 FORD                       7566 03-DEC-11 (null)    (null)          7566 JONES                02-APR-11 (null)    (null)
      7876 ADAMS                      7788 12-JAN-13 (null)    (null)          7788 SCOTT                09-DEC-12 (null)    (null)
      7934 MILLER                     7782 23-JAN-12 16-FEB-13 19-FEB-13       7782 CLARK                09-JUN-11 (null)    (null)
      7369 SMITH                      7902 17-DEC-10 (null)    (null)          7902 FORD                 03-DEC-11 (null)    (null)
      8001 JET LI                     8000 20-FEB-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)
      8002 BRUCE LEE                  8000 08-SEP-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)

18 rows selected.

select wr.empno, wr.ename worker, wr.mgr, wr.hiredate, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, mn.hiredate, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation2 vcwr on (wr.empno = vcwr.empno)
left outer join Vocation2 vcmn on (mn.empno = vcmn.empno)
where mn.hiredate between '25-SEP-11' and '29-SEP-11';

     EMPNO WORKER                      MGR HIREDATE  BEGINNING ENDING         EMPNO MANAGER              HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- --------- ---------- -------------------- --------- --------- ---------
      8001 JET LI                     8000 20-FEB-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)
      8002 BRUCE LEE                  8000 08-SEP-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)

*/


select wr.empno, wr.ename worker, wr.mgr, wr.hiredate, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, mn.hiredate, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno);


     EMPNO WORKER                      MGR HIREDATE  BEGINNING ENDING         EMPNO MANAGER              HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- --------- ---------- -------------------- --------- --------- ---------
      7566 JONES                      7839 02-APR-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7698 BLAKE                      7839 01-MAY-11 15-FEB-13 24-FEB-13       7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7782 CLARK                      7839 09-JUN-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      8000 JACKIE CHAN                7839 28-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      8003 DR NO                      7839 11-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 07-JAN-13 15-JAN-13
      7566 JONES                      7839 02-APR-11 (null)    (null)          7839 KING                 17-NOV-11 24-JAN-13 17-FEB-13
      7698 BLAKE                      7839 01-MAY-11 15-FEB-13 24-FEB-13       7839 KING                 17-NOV-11 24-JAN-13 17-FEB-13
      7782 CLARK                      7839 09-JUN-11 (null)    (null)          7839 KING                 17-NOV-11 24-JAN-13 17-FEB-13
      8000 JACKIE CHAN                7839 28-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 24-JAN-13 17-FEB-13
      8003 DR NO                      7839 11-SEP-11 (null)    (null)          7839 KING                 17-NOV-11 24-JAN-13 17-FEB-13
      7499 ALLEN                      7698 20-FEB-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7521 WARD                       7698 22-FEB-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7654 MARTIN                     7698 28-SEP-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7844 TURNER                     7698 08-SEP-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7900 JAMES                      7698 03-DEC-11 (null)    (null)          7698 BLAKE                01-MAY-11 15-FEB-13 24-FEB-13
      7839 KING                 (null)     17-NOV-11 07-JAN-13 15-JAN-13 (null)     (null)               (null)    (null)    (null)
      7839 KING                 (null)     17-NOV-11 24-JAN-13 17-FEB-13 (null)     (null)               (null)    (null)    (null)
      7788 SCOTT                      7566 09-DEC-12 (null)    (null)          7566 JONES                02-APR-11 (null)    (null)
      7902 FORD                       7566 03-DEC-11 (null)    (null)          7566 JONES                02-APR-11 (null)    (null)
      7876 ADAMS                      7788 12-JAN-13 (null)    (null)          7788 SCOTT                09-DEC-12 (null)    (null)
      7934 MILLER                     7782 23-JAN-12 16-FEB-13 19-FEB-13       7782 CLARK                09-JUN-11 (null)    (null)
      7369 SMITH                      7902 17-DEC-10 (null)    (null)          7902 FORD                 03-DEC-11 (null)    (null)
      8001 JET LI                     8000 20-FEB-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)
      8002 BRUCE LEE                  8000 08-SEP-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)

24 rows selected.



select wr.empno, wr.ename worker, wr.mgr, wr.hiredate, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, mn.hiredate, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where mn.hiredate = '28-SEP-11';

     EMPNO WORKER                      MGR HIREDATE  BEGINNING ENDING         EMPNO MANAGER              HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- --------- ---------- -------------------- --------- --------- ---------
      8001 JET LI                     8000 20-FEB-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)
      8002 BRUCE LEE                  8000 08-SEP-11 (null)    (null)          8000 JACKIE CHAN          28-SEP-11 (null)    (null)
	  


select empno, ename, mgr, hiredate, beginning, ending
from emp
join Vocation using (empno);


     EMPNO ENAME                       MGR HIREDATE  BEGINNING ENDING
---------- -------------------- ---------- --------- --------- ---------
      7698 BLAKE                      7839 01-MAY-11 15-FEB-13 24-FEB-13
      7839 KING                 (null)     17-NOV-11 07-JAN-13 15-JAN-13
      7839 KING                 (null)     17-NOV-11 24-JAN-13 17-FEB-13
      7934 MILLER                     7782 23-JAN-12 16-FEB-13 19-FEB-13


select wr.empno, wr.ename worker, wr.mgr, wr.hiredate, vcwr.beginning, vcwr.ending,
       mn.empno, mn.ename manager, mn.hiredate, vcmn.beginning, vcmn.ending 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join Vocation vcwr on (wr.empno = vcwr.empno)
left outer join Vocation vcmn on (mn.empno = vcmn.empno)
where mn.hiredate between '25-SEP-11' and '29-SEP-11';





