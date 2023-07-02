/* Пороскун О. ПМ-81   Практична робота 5  БД*/

/*Підзапит в умові WHERE 
1. Створіть запит, що виводить імена всіх підлеглих KING. */

select ename --, ename, mgr
from emp
where mgr = 
           (select empno
            from emp
            where ename = 'KING');

/*2. Створіть запит, що виводить список співробітників компанії, які працюють в одному відділі зі SMITH.  */

select ename, deptno
from emp
where deptno = 
               (select deptno
                from emp
                where ename = 'SMITH');

/*3. * Сформулюйте запит, що виводить імена співробітників, найнятих після SMITH в його відділ.  */

select ename --, hiredate, deptno
from emp 
where hiredate > 
               (select hiredate
                from emp
                where ename = 'SMITH')
and deptno =				
             (select deptno
			  from emp
			  where ename = 'SMITH');

/*Використання In, Any, All 
4. Створіть запит, що виводить імена співробітників найнятих після службовців відділу №30. */

select ename, hiredate
from emp 
where hiredate > any
					(select hiredate
					 from emp
					 where deptno = 30);
					 
select ename, hiredate   
from emp   
where hiredate > all  
                    (select hiredate
                     from emp
                     where deptno = 30);					 


/*5. Сформуйте запит, що виводить прізвище, номер підрозділу і зарплату працівників які працюють у відділах, 
де деяким співробітником виплачують премію. */

select ename, deptno, sal 
from emp  
where deptno = any   
                  (select deptno
                   from emp
                   where comm is not null);

/*6. * Створіть запит, що виводить прізвища керівників, у яких всі підлеглі отримують більше $ 2500.*/ 

select ename
from emp
where empno in 
              (select mgr 
              from emp
              where sal > 2500)
and empno not in 
                (select mgr 
                from emp
                where sal <= 2500);

ENAME
--------------------
JONES				   

/*7. Сформуйте запит, що виводить інформацію про працівників, зарплата яких більше зарплати будь-якого з клерків. */
				
select * 
from emp  
where sal > any   
               (select sal
                from emp
                where job = 'CLERK');	

select * 
from emp  
where sal > all   
               (select sal
                from emp
                where job = 'CLERK');					

/*8. * Відділу кадрів потрібен звіт, який містить ім'я і зарплату всіх співробітників з Dallas.*/

select ename, sal
from emp  
where deptno = all   
               (select deptno
                from dept
                where loc = 'DALLAS');	

/*Підзапит в списку полів 
9. Створіть запит, що виводить номер і прізвище працівника, номер і прізвище його менеджера. */

--------------------------------------------------------------------------
               /*   not   final version         */
--------------------------------------------------------------------------
	  
select worker.empno, worker.ename worker, manager.empno, manager.ename manager
from emp worker
join emp manager on (worker.mgr = manager.empno);

     EMPNO WORKER                    EMPNO MANAGER
---------- -------------------- ---------- --------------------
      7698 BLAKE                      7839 KING
      7782 CLARK                      7839 KING
      7566 JONES                      7839 KING
      8000 JACKIE CHAN                7839 KING
      8003 DR NO                      7839 KING
      7654 MARTIN                     7698 BLAKE
      7499 ALLEN                      7698 BLAKE
      7844 TURNER                     7698 BLAKE
      7900 JAMES                      7698 BLAKE
      7521 WARD                       7698 BLAKE
      7934 MILLER                     7782 CLARK
      7902 FORD                       7566 JONES
      7788 SCOTT                      7566 JONES
      7369 SMITH                      7902 FORD
      7876 ADAMS                      7788 SCOTT
      8001 JET LI                     8000 JACKIE CHAN
      8002 BRUCE LEE                  8000 JACKIE CHAN

17 rows selected.
- - - - - - - - - - - - - - - - - - - - - - - 

--------------------------------------------------------------------------
               /*   final version         */
--------------------------------------------------------------------------

select emp.empno, emp.ename worker, mng.empno, mng.ename manager
from emp, emp mng
where mng.job = 'MANAGER'
and emp.mgr = mng.empno;


SQL> select emp.empno, emp.ename worker, mng.empno, mng.ename manager
  2  from emp, emp mng
  3  where mng.job = 'MANAGER'
  4  and emp.mgr = mng.empno;

     EMPNO WORKER                    EMPNO MANAGER
---------- -------------------- ---------- --------------------
      7902 FORD                       7566 JONES
      7788 SCOTT                      7566 JONES
      7499 ALLEN                      7698 BLAKE
      7521 WARD                       7698 BLAKE
      7654 MARTIN                     7698 BLAKE
      7844 TURNER                     7698 BLAKE
      7900 JAMES                      7698 BLAKE
      7934 MILLER                     7782 CLARK

8 rows selected.

--------------------------------------------------------------------------
               /*   final version         */
--------------------------------------------------------------------------

/*10. * Створіть запит, що виводить прізвище працівника і місто в якому він працює.*/

select ename, 
             (select loc
              from dept
              where emp.deptno = dept.deptno) locs
from emp;			   

/*Підзапит у списку FROM 
11. Створіть запит, який виведе імена, номер відділу і зарплату співробітників з відділу №10. */

select ename, deptno, sal 
from (select * from emp where deptno = 10);


/*12. Створіть запит, який вибере всіх службовців з зарплатою вище $ 1500 з результатів запиту 11.*/ 

select ename, deptno, sal 
from (select * from emp where deptno = 10)
where sal > 1500;
						
ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
KING                         10       5000

/*13. * Створіть представлення my_view на основі запиту 11.*/ 

create view my_view 
as select ename, deptno, sal 
from (select * from emp where deptno = 10);

select * from my_view;

/*14. * Створіть запит, який вибере всіх службовців з зарплатою вище $ 1500 із представлення my_view. */

select * from my_view
where sal > 1500;

/*15. * Видаліть представлення my_view.*/

drop view my_view;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:

 максим зарплата у вдл продал SAL...
*/
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------



select ename, sal, deptno
from emp 
where deptno = any
                          (select deptno
                           from  dept
                           where dname like 'SALES%')
and sal > any
                          (select e.sal
                           from  emp e, dept d
                           where d.dname like 'SALES%');

ENAME                       SAL     DEPTNO
-------------------- ---------- ----------
BLAKE                      2850         30
JET LI                     2600         60
BRUCE LEE                  2500         60
JACKIE CHAN                2250         60
ALLEN                      1600         30
TURNER                     1500         30
MARTIN                     1250         30
WARD                       1250         30
JAMES                       950         30

9 rows selected.











