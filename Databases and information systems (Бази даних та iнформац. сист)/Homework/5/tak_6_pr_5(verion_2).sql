
select empno, ename, mgr, sal
from emp
where empno in 
              (select mgr 
			  from emp
			  where sal > 2500)
and mgr <> empno;

     EMPNO ENAME                       MGR        SAL
---------- -------------------- ---------- ----------
      7566 JONES                      7839       2975
      8000 JACKIE CHAN                7839       2250

select empno, ename, mgr, sal
from emp
where empno in 
              (select mgr 
			  from emp
			  where sal > 2500)
and empno <> mgr;

     EMPNO ENAME                       MGR        SAL
---------- -------------------- ---------- ----------
      7566 JONES                      7839       2975
      8000 JACKIE CHAN                7839       2250

select empno, ename, mgr, sal
from emp
where empno in 
              (select mgr 
			  from emp
			  where sal > 2500);

     EMPNO ENAME                       MGR        SAL
---------- -------------------- ---------- ----------
      7566 JONES                      7839       2975
      7839 KING                 (null)           5000
      8000 JACKIE CHAN                7839       2250

select empno, ename, mgr, sal
from emp
where empno in 
              (select mgr 
              from emp
              where sal > 2500)
and empno not in 
                (select mgr 
                from emp
                where sal <= 2500);

     EMPNO ENAME                       MGR        SAL
---------- -------------------- ---------- ----------
      7566 JONES                      7839       2975
	  
select ename
from emp
where empno not in 
                (select mgr 
                from emp
                where sal <= 2500);

ENAME
--------------------
SMITH
ALLEN
WARD
JONES
MARTIN
TURNER
ADAMS
JAMES
MILLER
JET LI
BRUCE LEE
DR NO

12 rows selected.

--------------------------------------------------------------------------
               /*   final version         */
--------------------------------------------------------------------------

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

--------------------------------------------------------------------------
               /*   final version         */
--------------------------------------------------------------------------
