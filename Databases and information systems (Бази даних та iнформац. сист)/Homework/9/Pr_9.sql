/* Пороскун О. ПМ-81   Практична робота 9  БД*/

/* Операції над множинами  */
/* 1. Створіть звіт, який містить номери відділів, в яких немає клерків.  */

/*
select e.deptno
from emp e
where  e.deptno not in 
                      (select e1.deptno
                      from emp e1
                      where e1.job = 'CLERK')
intersect
select d.deptno
from dept d;

    DEPTNO
----------
        60
*/
----  або 2 варіант

select e1.deptno
from emp e1
where  e1.deptno not in 
                      (select e2.deptno
                      from emp e2
                      where e2.job = 'CLERK')
intersect
select ee.deptno
from emp ee;

    DEPTNO
----------
        60

-- перевірка ↓

select deptno
from emp
where job = 'CLERK';

    DEPTNO
----------
        30
        20
        20
        10
/*
select e1.empno, e1.ename, e1.job, e1.deptno
from emp e1
where  e1.deptno not in 
                      (select e2.deptno
                      from emp e2
                      where e2.job = 'CLERK')
intersect
select ee.empno, ee.ename, ee.job, ee.deptno
from emp ee;

     EMPNO ENAME                JOB           DEPTNO
---------- -------------------- --------- ----------
      8000 JACKIE CHAN          SALESMAN          60
      8001 JET LI               SALESMAN          60
      8002 BRUCE LEE            SALESMAN          60
*/


/* 2. Створіть звіт, який містить номери відділів, в яких немає співробітників.  */

select d.deptno
from dept d
minus
select e.deptno
from emp e;

/* 3. Створіть звіт, який містить номер відділу, посади, які є у відділах № 10, 30, і 20.
 Номери відділів повинні бути в зазначеному порядку (10, 30, 20)  */


select e1.job , e1.deptno
from emp e1
where e1.deptno = 10
union all
select e2.job, e2.deptno
from emp e2
where e2.deptno = 30
union  all
select e3.job, e3.deptno
from emp e3
where e3.deptno = 20;

-- перевірка ↓

select e1.ename, e1.job , e1.deptno
from emp e1
where e1.deptno = 10
union all
select e2.ename, e2.job, e2.deptno
from emp e2
where e2.deptno = 30
union  all
select e3.ename, e3.job, e3.deptno
from emp e3
where e3.deptno = 20;


/* 4. Створіть звіт, який містить імена і номери всіх співробітників відділу №10 і всіх співробітників у яких зарплата вище $ 1500. 
Відсортуйте дані за спаданням імен співробітників */

select e1.empno, e1.ename
from emp e1
where e1.deptno = 10
union
select e2.empno, e2.ename
from emp e2
where e2.sal > 1500
order by ename desc;

-- перевірка ↓

select e1.empno, e1.ename, e1.deptno, e1.sal
from emp e1
where e1.deptno = 10
union
select e2.empno, e2.ename, e2.deptno, e2.sal
from emp e2
where e2.sal > 1500
order by ename desc;


/* 5. Складні вибірки  
⮚	Створіть представлення Emp_USA, яке містить всіх співробітників, що працюють в США (Нью Йорку, Далласі, Бостоні, Чикаго)  
⮚	Створіть представлення Emp_SALES яке містить всіх співробітників, що працюють у відділах та містять в назві «SALE»  
⮚	Складіть звіти, які містять: 
1. Список, в якому не повторюються імена співробітників , що працюють в Emp_USA або Emp_SALES 
2. Перелік всіх співробітників, які працюють в Emp_USA або Emp_SALES 
3. Список співробітників, які працюють і в Emp_USA, і в Emp_SALES 
4. Перелік співробітників які працюють в Emp_SALES але не в Emp_USA.  
⮚	Видаліть представлення.*/

-- черновик 

/*
create view Emp_USA
as select empno, ename, deptno
from emp
union
select dname, loc, deptno
from dept
where loc in ('NEW_YORK', 'DALLAS', 'BOSTON', 'CHICAGO');


select e.deptno, ename
from emp e
union
select d.deptno, '0'
from dept d;


select e.deptno, e.ename, d.loc
from emp e, dept d
where e.deptno = d.deptno
union
select d1.deptno, e1.ename, d1.loc
from dept d1, emp e1
where e1.deptno = d1.deptno;

    DEPTNO ENAME                LOC
---------- -------------------- -------------
        10 CLARK                NEW_YORK
        10 KING                 NEW_YORK
        10 MILLER               NEW_YORK
        20 ADAMS                DALLAS
        20 FORD                 DALLAS
        20 JONES                DALLAS
        20 SCOTT                DALLAS
        20 SMITH                DALLAS
        30 ALLEN                CHICAGO
        30 BLAKE                CHICAGO
        30 JAMES                CHICAGO
        30 MARTIN               CHICAGO
        30 TURNER               CHICAGO
        30 WARD                 CHICAGO
        60 BRUCE LEE            HONKONG
        60 JACKIE CHAN          HONKONG
        60 JET LI               HONKONG

17 rows selected.
*/

--  ⮚	Створіть представлення Emp_USA, яке містить всіх співробітників, що працюють в США (Нью Йорку, Далласі, Бостоні, Чикаго) 

create view Emp_USA
as select e.ename, e.deptno, d.loc
from emp e, dept d
where e.deptno = d.deptno
and d.loc in ('NEW_YORK', 'DALLAS', 'BOSTON', 'CHICAGO');

select * from Emp_USA;

-- drop view Emp_USA;

--  ⮚	Створіть представлення Emp_SALES яке містить всіх співробітників, що працюють у відділах та містять в назві «SALE» 

create view Emp_SALES
as select e.ename, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and d.dname like 'SALE%';

select * from Emp_SALES;

-- drop view Emp_SALES;

/*⮚	Складіть звіти, які містять: 
1. Список, в якому не повторюються імена співробітників , що працюють в Emp_USA або Emp_SALES */

select ename, deptno
from Emp_USA 
union
select ename, deptno
from Emp_SALES;

select ename
from Emp_USA 
union
select ename
from Emp_SALES;

-- 2. Перелік всіх співробітників, які працюють в Emp_USA або Emp_SALES 

select ename, deptno
from Emp_USA 
union all
select ename, deptno
from Emp_SALES;

select ename
from Emp_USA 
union all
select ename
from Emp_SALES;

-- 3. Список співробітників, які працюють і в Emp_USA, і в Emp_SALES 

select ename
from Emp_USA 
intersect
select ename
from Emp_SALES;

select ename, deptno
from Emp_USA 
intersect
select ename, deptno
from Emp_SALES;

-- 4. Перелік співробітників які працюють в Emp_SALES але не в Emp_USA.  

select ename
from Emp_SALES
minus
select ename
from Emp_USA;

select ename, deptno
from Emp_SALES
minus
select ename, deptno
from Emp_USA;

-- ⮚  Видаліть представлення.*/

drop view Emp_USA;
drop view  Emp_SALES;

/*
--drop view Emp_USA_1;
--drop view Emp_USA_2
--drop view Emp_USA_21;

create view Emp_USA_1
as select e.ename, e.deptno, d.loc
from emp e, dept d
where e.deptno = d.deptno
and loc in ('NEW_YORK', 'DALLAS', 'BOSTON', 'CHICAGO');
--
select * from Emp_USA_1;
--
--
create view Emp_USA_2
as (select ename, e.deptno, d.loc
from emp e
join dept d on (d.deptno = e.deptno)
where loc in ('NEW_YORK', 'DALLAS')
union
select ename, e.deptno, d.loc
from emp e
join dept d on (d.deptno = e.deptno)
where loc in ('BOSTON', 'CHICAGO'))
order by deptno;
--
select * from Emp_USA_2;
--
--
create view Emp_USA_21
as select ename, e.deptno, d.loc
from emp e
join dept d on (d.deptno = e.deptno)
where loc in ('NEW_YORK', 'DALLAS', 'BOSTON', 'CHICAGO');
--
select * from Emp_USA_21;
--
drop view Emp_USA_1;
drop view Emp_USA_2
drop view Emp_USA_21;

*/


/* 6. Складні вибірки  
Складіть звіт, який відповідає всім наступним вимогам: 
- ⮚ Звіт містить ім'я співробітника і номер відділу для всіх співробітників, незалежно від того чи належать вони до якогось відділу (без Set-операцій); 
- ⮚ Звіт містить назву і номер відділу для всіх відділів, незалежно від того чи є у відділі хоча б один співробітник (без Set-операцій);  
- ⮚ Звіт повинен містити 2 стовпчика (ім'я співробітника і номер відділу або назва відділу і номер відділу) і формуватися одним запитом. */

select ename, deptno
from emp
where deptno is null
or deptno in 
               (select e.deptno
               from emp e
               union
               select d.deptno
               from dept d);

-- однаковий результат (union all тоже)

select ename, deptno
from emp
where deptno in 
               (select e.deptno
               from emp e
               union 
               select d.deptno
               from dept d)
or deptno is null;

-- Перевірка:

select e.deptno
from emp e
union
select d.deptno
from dept d;

/*
select d.deptno
from dept d
union
select e.deptno
from emp e;
*/

    DEPTNO
----------
        10
        20
        30
        40
        50
        60
       100
(null)

8 rows selected.

-------------------- або 2 варіант --------------------

select dname, deptno
from dept
where deptno in 
               (select e.deptno
               from emp e
               union 
               select d.deptno
               from dept d);


/* 7 * Складні вибірки 
Створіть запит, якій виведе імена, номер відділу і зарплатою 2-х співробітників з відділу №20, 
які йдуть на 2-му та 3-му місті за рівнем зарплати у цьому відділі.
Зверніть, увагу, що найбільшу зарплату (3000) в цьому відділі отримують дві людини. 
Отже вивести потрібно Adams і Joins. 
Підказка: 
Для того, щоб обмежити кількість стрічок що виводяться в підзапитах, можна використати умову: where rownum<=3.*/
		   
select ename, deptno, sal 
from emp
where deptno = 20
and sal >= any
              (select sal 
               from emp
               where deptno = 20)
and rownum <= 4
minus
select ename, deptno, sal 
from emp
where deptno = 20
and sal >= any
              (select sal 
               from emp
               where deptno = 20)
and rownum <= 2;


ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
ADAMS                        20       1100
JONES                        20       2975


-- Перевірка:

-- упорядучуется за счет sal >= any / sal <= any

select ename, deptno, sal 
from emp
where deptno = 20
and sal >= any
              (select sal 
               from emp
               where deptno = 20);
			   
ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
FORD                         20       3000
SCOTT                        20       3000
JONES                        20       2975
ADAMS                        20       1100
SMITH                        20        800

/*
select ename, deptno, sal 
from emp
where deptno = 20
and sal <= any
              (select sal 
               from emp
               where deptno = 20);


ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
SMITH                        20        800
ADAMS                        20       1100
JONES                        20       2975
FORD                         20       3000
SCOTT                        20       3000

*/

-------------------- або 2 варіант --------------------
/* Ми спочатку обрали зарплату, яка  більше ніж сама маленька зарплата у від. 20 (sal >= any ...)
потім убрали перші 2 рядка с максимальними зарплатами 
*/

select ename, deptno, sal 
from emp
where deptno = 20
and sal > any
              (select sal 
               from emp
               where deptno = 20)
minus
select ename, deptno, sal 
from emp
where deptno = 20
and sal > any
              (select sal 
               from emp
               where deptno = 20)
and rownum <= 2;

ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
ADAMS                        20       1100
JONES                        20       2975


/*
8* Складні вибірки 
Створіть запит, якій виведе імена, номер відділу і зарплату двох співробітників з відділу №10 та двох з відділу №20 з найбільшими зарплатами. 
Підказки: 
1) Для того, щоб обмежити кількість рядків, що виводяться у підзапитах, можна скористатися умовою: where rownum<=2 
2) Запити до співробітників відділів 10 і 20 можна об’еднати використовуючи Union 
3) Для того, щоб мати можливість використовувати сортування в запитах всередині команди Union, їх потрібно обернути в Select.*/

/* лекция 9 (37 из 39 сл.)

1 SELECT * from (
2 SELECT e.ename, e.sal
3 FROM emp e
4 ORDER BY sal DESC
5 )
6 WHERE ROWNUM <= 5
*/

select ename, deptno, sal 
from 
    (select *
    from emp
    where deptno = 10
    order by sal desc)
where rownum <= 2
union
select ename, deptno, sal 
from 
    (select *
    from emp
    where deptno = 20
    order by sal desc)
where rownum <= 2
order by deptno, sal desc;

-- Перевірка: 

select ename, deptno, sal 
from 
    (select *
    from emp
    where deptno = 10
    order by sal desc)
union
select ename, deptno, sal 
from 
    (select *
    from emp
    where deptno = 20
    order by sal desc)
order by deptno, sal desc;


/*
9* Складні вибірки  
У компанії вирішили влаштувати обмін досвідом між співробітниками. Для цього кожен день один із співробітників робить доповідь. 
Співробітники виступають в алфавітному порядку. Після того, як всі співробітники зробили доповідь, доповідачем стає перший співробітник. 
Створіть запит який повертає ім'я доповідача, якщо відомо ім'я попереднього доповідача.*/

-- speaker, next_speaker

select rpad('&my_ename', 20, ' ') as speaker, ename  as next_speaker
from 
     (select ename 
     from 
          (select ename 
          from emp
          where ename > '&my_ename'
          order by ename)
     union all
     select ename 
     from 
          (select ename
          from emp
          order by ename)
     where rownum < 2)
where rownum < 2;

Enter value for my_ename: KING
old   1: select rpad('&my_ename', 20, ' ') as speaker, ename  as next_speaker
new   1: select rpad('KING', 20, ' ') as speaker, ename  as next_speaker
Enter value for my_ename: KING
old   7:           where ename > '&my_ename'
new   7:           where ename > 'KING'

SPEAKER              NEXT_SPEAKER
-------------------- --------------------
KING                 MARTIN


-- Перевірка:

select ename
from emp
order by ename;

ENAME
--------------------
ADAMS
ALLEN
BLAKE
BRUCE LEE
CLARK
DR NO
FORD
JACKIE CHAN
JAMES
JET LI
JONES
KING
MARTIN
MILLER
SCOTT
SMITH
TURNER
WARD

18 rows selected.

------------------------------------------------------------
------------------------------------------------------------
-- Тема 14. Агрегатні функції
------------------------------------------------------------
------------------------------------------------------------

-- 2 раза вводить имя докладчика(ename)
select rpad('&my_ename', 20, ' ') speaker, 
       nvl(
           (select min(ename) from emp where ename > '&my_ename'),
           (select min(ename) from emp)) next_speaker
from dual;

-- 1 раз вводить имя докладчика(ename)
select nvl(
           (select min(ename) from emp where ename > '&my_ename'),
           (select min(ename) from emp)) next_speaker
from dual;


/*
select
  nvl((select min(ename) from emp where ename > '&ename'),
      (select min(ename) from emp)) next_speaker
from dual;


select &sal salary, 
nvl((select min(sal) from emp where sal > '&sal'),
	(select min(sal) from emp)) next_salary
from dual;

Enter value for sal: 800
old   1: select &sal salary, nvl(
new   1: select 800 salary, nvl(
Enter value for sal: 800
old   4:    where sal > '&sal'),
new   4:    where sal > '800'),

    SALARY NEXT_SALARY
---------- -----------
       800         950

*/
------------------------------------------------------------
------------------------------------------------------------

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:

Створіть звіт, який містить імена і номери всіх співробітників SALESMAN і всіх співробітників у яких премія вище $300. 
Відсортуйте дані за спаданням імен співробітників

*/

select e1.empno, e1.ename
from emp e1
where e1.job like 'SALESMAN'
union
select e2.empno, e2.ename
from emp e2
where e2.comm > 300
order by ename desc;

-- Перевірка:

select e1.empno, e1.ename, e1.job, e1.comm
from emp e1
where e1.job like 'SALESMAN'
union
select e2.empno, e2.ename, e2.job, e2.comm
from emp e2
where e2.comm > 300
order by ename desc;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------