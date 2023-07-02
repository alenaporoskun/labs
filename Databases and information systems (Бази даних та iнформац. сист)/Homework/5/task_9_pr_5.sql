-------------------------------------------------------
/*Підзапит в списку полів 
9. Створіть запит, що виводить номер і прізвище працівника, номер і прізвище його менеджера. */

------------------

select manager.empno, manager.ename
from emp manager 
where manager.mgr in
                       (select employee.empno
                        from emp employee);									
						
select employee.empno, employee.ename
from emp employee
where employee.empno in
                       (select manager.mgr
                        from emp manager);						
     EMPNO ENAME
---------- --------------------
      7839 KING
      7698 BLAKE
      7566 JONES
      7902 FORD
      7788 SCOTT
      7782 CLARK
      8000 JACKIE CHAN

7 rows selected.						
						
select manager.empno, manager.ename
from emp manager
where manager.mgr in
                       (select employee.empno
                        from emp employee);						
						
     EMPNO ENAME
---------- --------------------
      7698 BLAKE
      7782 CLARK
      7566 JONES
      7654 MARTIN
      7499 ALLEN
      7844 TURNER
      7900 JAMES
      7521 WARD
      7902 FORD
      7369 SMITH
      7788 SCOTT
      7876 ADAMS
      7934 MILLER
      8000 JACKIE CHAN
      8001 JET LI
      8002 BRUCE LEE
      8003 DR NO

17 rows selected.				
						
						
select manager.empno, manager.ename
from emp manager
where manager.empno  in
                       (select employee.mgr
                        from emp employee);							
						
     EMPNO ENAME
---------- --------------------
      7839 KING
      7698 BLAKE
      7566 JONES
      7902 FORD
      7788 SCOTT
      7782 CLARK
      8000 JACKIE CHAN

7 rows selected.

						----------------------
/*
2 связанных подзапроса в списке полей, первый для номера, второй для имени
Селект будет длинным, не пугайтесь
Это хорошо увидеть перед лекцией о соединени таблиц
*/
				
--------------------------------			
				
select manager.empno, manager.ename manager
from emp manager
where manager.empno in
                       (select employee.mgr
                        from emp employee);
								
     EMPNO MANAGER
---------- --------------------
      7839 KING
      7698 BLAKE
      7566 JONES
      7902 FORD
      7788 SCOTT
      7782 CLARK
      8000 JACKIE CHAN

7 rows selected.
	  
	  
select worker.empno, worker.ename worker
from emp worker
where worker.mgr in
                       (select manager.empno
                        from emp manager);	  
	  
     EMPNO WORKER
---------- --------------------
      7698 BLAKE
      7782 CLARK
      7566 JONES
      7654 MARTIN
      7499 ALLEN
      7844 TURNER
      7900 JAMES
      7521 WARD
      7902 FORD
      7369 SMITH
      7788 SCOTT
      7876 ADAMS
      7934 MILLER
      8000 JACKIE CHAN
      8001 JET LI
      8002 BRUCE LEE
      8003 DR NO

17 rows selected.	  

	  
select worker.ename
in (select  manager.ename 
from emp manager)					
from emp worker
where worker.mgr in
                       (select manager.empno
                        from emp manager);	 	  
	  
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
