/* Завдання 11*  
1. Створіть запит, який виведе всі пари імен співробітників, що працюють в одному відділі.
 При цьому, не включати в список комбінації імен співробітників самих з собою (тобто комбінацію типу «Іванов-Іванов») 
 і комбінації імен співробітників, що відрізняються порядком розташування (тобто включати одну з двох комбінацій типу «ІвановПетров» і «Петров-Іванов»).  
2. Модифікуйте запит 12.1, так щоб пари будувалися для співробітників, які працюють в одному місті, а не в одному відділі.*/

--1
select w1.ename ||' - '|| w2.ename as "WORKER - WORKER"
from emp w1, emp w2
where w1.deptno = w2.deptno
  and w1.ename != w2.ename;
  
  
select w1.ename ||' - '|| w2.ename as "WORKER - WORKER"
from emp w1, emp w2
from w1.deptno = w2.deptno
  and w1.ename != w2.ename;
  
  
  
select distinct w1.ename||'-'||w2.ename as "WORKER - WORKER"
from emp w1 , emp w2
from w1.deptno = 10 
AND e.deptno = 10 
AND w1.ename != w2.ename
AND SUBSTR(w1.ename||'-'||w2.ename,1,INSTR(w1.ename||'-'||w2.ename ,'-',1,1)-1) <>
SUBSTR(w1.ename||'-'||w2.ename,INSTR(w1.ename||'-'||w2.ename ,'-',1,1)+1,LENGTH(w1.ename||'-'||e.ename)-INSTR(w1.ename||'-'||w2.ename ,'-',1,1));
  
  
SELECT DISTINCT s.ename||'-'||e.ename as Pair
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename!=e.ename
AND SUBSTR(s.ename||'-'||e.ename,1,INSTR(s.ename||'-'||e.ename ,'-',1,1)-1) <>
SUBSTR(s.ename||'-'||e.ename, INSTR(s.ename||'-'||e.ename ,'-',1,1)+1, LENGTH(s.ename||'-'||e.ename)-INSTR(s.ename||'-'||e.ename ,'-',1,1));
  
  
SELECT INSTR(s.ename||'-'||e.ename ,'-',1,1)-1), INSTR(s.ename||'-'||e.ename ,'-',1,1)+1, 
SUBSTR(s.ename||'-'||e.ename,1,INSTR(s.ename||'-'||e.ename ,'-',1,1)-1),

FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename!=e.ename
AND SUBSTR(s.ename||'-'||e.ename, 1, INSTR(s.ename||'-'||e.ename ,'-') - 1) <>
SUBSTR(s.ename||'-'||e.ename, INSTR(s.ename||'-'||e.ename ,'-')+1, LENGTH(s.ename||'-'||e.ename)-INSTR(s.ename||'-'||e.ename ,'-'));
 


 
  
SELECT s.ename||'-'||e.ename, 
SUBSTR(s.ename||'-'||e.ename, 1, INSTR(s.ename||'-'||e.ename ,'-') - 1)
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename!=e.ename;

S.ENAME||'-'||E.ENAME
-----------------------------------------
SUBSTR(S.ENAME||'-'||E.ENAME,1,INSTR(S.ENAME||'-'||E.ENAME,'-')-1)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
KING-CLARK
KING

KING-MILLER
KING

CLARK-KING
CLARK

CLARK-MILLER
CLARK

MILLER-KING
MILLER

MILLER-CLARK
MILLER 


SELECT s.ename||'-'||e.ename, 
SUBSTR(s.ename||'-'||e.ename, 1, INSTR(s.ename||'-'||e.ename ,'-') - 1),
SUBSTR(s.ename||'-'||e.ename, INSTR(s.ename||'-'||e.ename ,'-')+1, LENGTH(s.ename||'-'||e.ename)-INSTR(s.ename||'-'||e.ename ,'-'))
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename!=e.ename;

S.ENAME||'-'||E.ENAME
-----------------------------------------
SUBSTR(S.ENAME||'-'||E.ENAME,1,INSTR(S.ENAME||'-'||E.ENAME,'-')-1)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUBSTR(S.ENAME||'-'||E.ENAME,INSTR(S.ENAME||'-'||E.ENAME,'-')+1,LENGTH(S.ENAME||'-'||E.ENAME)-INSTR(S.ENAME||'-'||E.ENAME,'-'))
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
KING-CLARK
KING
CLARK

KING-MILLER
KING
MILLER

CLARK-KING
CLARK
KING

CLARK-MILLER
CLARK
MILLER

MILLER-KING
MILLER
KING

MILLER-CLARK
MILLER
CLARK

SELECT DISTINCT s.ename||'-'||e.ename
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename! = e.ename
AND SUBSTR(s.ename||'-'||e.ename, 1, INSTR(s.ename||'-'||e.ename ,'-') - 1) <>
SUBSTR(s.ename||'-'||e.ename, INSTR(s.ename||'-'||e.ename ,'-')+1, LENGTH(s.ename||'-'||e.ename)-INSTR(s.ename||'-'||e.ename ,'-'));

SELECT DISTINCT s.ename||'-'||e.ename
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename! = e.ename;

SELECT DISTINCT s.ename||'-'||e.ename,  e.ename||'-'||s.ename
FROM emp s , emp e
WHERE s.deptno = 10 
AND e.deptno = 10 
AND s.ename! = e.ename;


--2
select distinct w1.ename ||' - '||  w2.ename as "WORKER - WORKER"
from emp w1, emp w2, dept d1, dept d2
where d1.loc = d2.loc
  and w1.deptno is not null
  and w2.deptno is not null
  and w1.ename != w2.ename;



