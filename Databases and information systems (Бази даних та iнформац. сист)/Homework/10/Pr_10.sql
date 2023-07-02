/* Пороскун О. ПМ-81   Практична робота 10  БД*/

/* 1. Підрахуйте:
1.1.Скільки в фірмі відділів?
1.2 Скільки в фірмі співробітників?
1.3 У скількох відділах є співробітники?
1.4 Скільки у фірми аналітиків?
1.5 Скільки людей працює в Гонконзі?
1.6 Скільки людей в фірмі не мають підлеглих? */

--⮚ 1.1.Скільки в фірмі відділів?

select count(distinct deptno) department
from emp;

select count(deptno) department
from dept;

--⮚ 1.2 Скільки в фірмі співробітників?

select count(empno) worker
from emp;

--⮚1.3 У скількох відділах є співробітники?

select count(deptno) department
from emp;

--⮚1.4 Скільки у фірми аналітиків?

select * from emp;

select count(*) ANALYST
from emp
where job = 'ANALYST';

--⮚1.5 Скільки людей працює в Гонконзі?

select * from dept;

select count(*) HONKONG
from emp e, dept d
where e.deptno = d.deptno
and loc = 'HONKONG';

--⮚1.6 Скільки людей в фірмі не мають підлеглих?

select count(*) no_employees
from emp
where  empno not in 
                   (select distinct e1.empno 
                   from emp e1, emp e2
                   where e1.empno = e2.mgr);
/*
select e2.empno, e2.ename worker, e2.mgr, 
       e1.empno, e1.ename employee
from emp e1, emp e2
where e1.empno = e2.mgr;
*/

select count(distinct e1.empno) employee
from emp e1, emp e2
where e1.empno = e2.mgr;

/* Завдання 
2. Сформувати запит, що виводить мінімальну, середню, максимальну і сумарну зарплату всіх працівників. */

select min(sal) min_sal, avg(sal) avg_sal, max(sal) max_sal, sum(sal) sum_sal
from emp;


/* 3. Сформувати запит, що виводить номера і імена всіх співробітників, зарплата яких вища за середню.*/ 

select empno, ename
from emp
where sal > 
           (select avg(sal)
           from emp);

-- Перевірка
select avg(sal)
from emp;

select empno, ename, sal
from emp
where sal > 
           (select avg(sal)
           from emp);

/*4. Сформувати запит, що виводить ім'я співробітника з найбільшою премією.*/

select ename, comm
from emp
where comm = 
           (select max(comm)
           from emp);
-- Перевірка:
select ename, comm
from emp;

/*Завдання 
5. Сформуйте запит, що виводить імена керівників і суму зарплат його підлеглих. */

select e1.ename employee,  sum(e2.sal) worker_sum_sal
from emp e1, emp e2
where e1.empno = e2.mgr
group by e1.ename;

-- Перевірка:
select e2.empno, e2.ename worker, e2.mgr, e2.sal, 
       e1.empno, e1.ename employee
from emp e1, emp e2
where e1.empno = e2.mgr;


/*6. Сформуйте запит, що виводить імена керівників і середню зарплату його підлеглих за винятком підлеглих SALESMAN-ів. */

select e1.ename employee, avg(e2.sal) worker_avg_sal
from emp e1, emp e2
where e1.empno = e2.mgr
and   e2.job not like 'SALESMAN'
group by e1.ename;

/*7. Сформуйте запит, що виводить імена керівників, у яких зарплата більше ніж максимальна у його підлеглих.*/

select e1.ename employee
from emp e1
where e1.sal > 
              (select max(e2.sal)
              from emp e2
              where e1.empno = e2.mgr);

/*Завдання 
8. * В якому відділі максимальна середня зарплата?*/

select d.deptno, dname
from dept d
where (select avg(sal)
       from emp e
       where e.deptno = d.deptno) =
                                    (select max(avg(sal))
                                    from emp
                                    group by deptno);

-- Перевірка:   
select d.deptno, dname, avg(sal)
from emp e, dept d
where e.deptno = d.deptno
group by d.deptno, dname;		  


/* 9. * У якому місті найбільше співробітників? */
		   
select d.loc
from dept d
where (select count(empno)
       from emp e
       where e.deptno = d.deptno
       group by loc)             =
                                    (select max(count(empno))
                                    from emp
                                    group by deptno, loc);

-- Перевірка:   
select loc, count(empno)
from emp e, dept d
where e.deptno = d.deptno
group by loc;


/* 10. Виведіть назви відділів в порядку зростання сум зарплат співробітників, що працюють у них. */

select dname
from emp e, dept d
where e.deptno = d.deptno
group by dname
order by sum(sal);

DNAME
--------------
SALES2
ACCOUNTING
SALES
RESEARCH

-- Перевірка:
select d.deptno, dname, sum(sal)
from emp e, dept d
where e.deptno = d.deptno
group by d.deptno, dname
order by sum(sal);

    DEPTNO DNAME            SUM(SAL)
---------- -------------- ----------
        60 SALES2               7350
        10 ACCOUNTING           7800
        30 SALES                9400
        20 RESEARCH            10875


/* 11. * -- В якому відділі найбільша кількість співробітників, що отримують премії? 
         -- А в якому на премії йде найбільше грошей?*/

---------------------------------------------------------------------------

-- В якому відділі найбільша кількість співробітників, що отримують премії? 


select d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno
and comm is not null
group by d.deptno, dname
having count(empno) = 
                      (select max(count(empno))
                      from emp
                      where comm is not null
                      group by deptno);

    DEPTNO DNAME
---------- --------------
        30 SALES

-- 2 variant

select deptno
from emp 
where comm is not null
group by deptno
having count(empno) = 
                      (select max(count(empno))
                      from emp
                      where comm is not null
                      group by deptno);
    DEPTNO
----------
        30

-- Перевірка: 
/*
select deptno, count(empno) count_worker_with_comm
from emp
where comm is not null
group by deptno;

    DEPTNO COUNT_WORKER_WITH_COMM
---------- ----------------------
        60                      2
        30                      4                             
*/	
-------------------------------------------------------

-- А в якому на премії йде найбільше грошей?*/

select d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno
and comm =  
           (select max(comm)
            from emp
            where comm is not null);

    DEPTNO DNAME
---------- --------------
        60 SALES2

-- 2 variant

select deptno
from emp 
where comm =
             (select max(comm)
              from emp
              where comm is not null);
    DEPTNO
----------
        60
		
-- Перевірка: 

select deptno, comm
from emp
where comm is not null;

    DEPTNO       COMM
---------- ----------
        30       1400
        30        300
        30          0
        30        500
        60       1700
        60        600

6 rows selected.


---------------------------------------------------------------------

/*  Частина 2. Ранжування 
12. Виконайте ранжування відділів за кількістю співробітників. */


select deptno, count_worker,
rank() over (order by count_worker) count_rank
from 
     (select deptno, count(empno) count_worker
      from emp
      group by deptno);
	  
    DEPTNO COUNT_WORKER COUNT_RANK
---------- ------------ ----------
(null)                1          1
        60            3          2
        10            3          2
        20            5          4
        30            6          5

/*
select deptno, count_worker,
rank() over (order by count_worker) count_rank
from 
     (select deptno, count(empno) count_worker
      from emp
      where deptno is not null
      group by deptno);

    DEPTNO COUNT_WORKER COUNT_RANK
---------- ------------ ----------
        60            3          1
        10            3          1
        20            5          3
        30            6          4

select deptno, dname, count_worker,
rank() over (order by count_worker) count_rank
from 
     (select d.deptno, dname, count(empno) count_worker
     from dept d, emp e
     where e.deptno = d.deptno
     group by d.deptno, dname);

    DEPTNO DNAME          COUNT_WORKER COUNT_RANK
---------- -------------- ------------ ----------
        10 ACCOUNTING                3          1
        60 SALES2                    3          1
        20 RESEARCH                  5          3
        30 SALES                     6          4
*/

--------------------------------------------------------
/*
select deptno, dname, count_worker,
rank() over (order by count_worker) count_rank
from 
     (select d.deptno, dname, count(empno) count_worker
     from dept d
     left join emp e
     on e.deptno = d.deptno
     group by d.deptno, dname);

    DEPTNO DNAME          COUNT_WORKER COUNT_RANK
---------- -------------- ------------ ----------
        50 RESEARCH2                 0          1
        40 OPERATIONS                0          1
       100 SALES3                    0          1
        10 ACCOUNTING                3          4
        60 SALES2                    3          4
        20 RESEARCH                  5          6
        30 SALES                     6          7

7 rows selected.

*/
-----------------------  Примеры с лекции № 14  --------------------------------
/*
SELECT ename, sal,
dense_rank() OVER (ORDER BY sal DESC) n_rank_desc,
dense_rank()OVER (ORDER BY sal ASC) n_rank_asc,
deptno,
dense_rank() OVER (ORDER BY deptno ASC) d_rank_asc
FROM emp
ORDER BY n_rank_desc;


SELECT ename,
rank() OVER (ORDER BY sal DESC) n_rank_desc,
rank() OVER (ORDER BY sal ASC) n_rank_asc,
rank() OVER (ORDER BY deptno ASC) d_rank_asc
FROM emp
ORDER BY n_rank_desc;

*/

/*
SELECT * FROM
             (SELECT dname, job
             FROM emp e, dept d
             WHERE e.deptno = d.deptno)
PIVOT
     (COUNT(job) FOR job IN('MANAGER','SALESMAN',
     'CLERK', 'ANALYST')) pvt ;
	 
DNAME           'MANAGER' 'SALESMAN'    'CLERK'  'ANALYST'
-------------- ---------- ---------- ---------- ----------
ACCOUNTING              1          0          1          0
RESEARCH                1          0          2          2
SALES2                  0          3          0          0
SALES                   1          4          1          0
*/

/*
SELECT deptno, ename, sal,
RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS n_rank
FROM emp
ORDER BY deptno, n_rank;

SELECT deptno, ename, sal,
dense_rank() OVER (PARTITION BY deptno ORDER BY sal DESC) AS
n_rank
FROM emp
ORDER BY deptno, n_rank;

*/

-----------------------  Примеры с лекции № 14  --------------------------------

-- 13. Створіть звіт, в якому співробітники будуть пронумеровані і впорядковані за зростанням зарплати всередині відділів. 

select deptno, ename, sal,
rank() over (partition by deptno order by sal) number_rank
from emp;
	  
    DEPTNO ENAME                       SAL NUMBER_RANK
---------- -------------------- ---------- -----------
        10 MILLER                     1300           1
        10 CLARK                      1500           2
        10 KING                       5000           3
        20 SMITH                       800           1
        20 ADAMS                      1100           2
        20 JONES                      2975           3
        20 SCOTT                      3000           4
        20 FORD                       3000           4
        30 JAMES                       950           1
        30 WARD                       1250           2
        30 MARTIN                     1250           2
        30 TURNER                     1500           4
        30 ALLEN                      1600           5
        30 BLAKE                      2850           6
        60 JACKIE CHAN                2250           1
        60 BRUCE LEE                  2500           2
        60 JET LI                     2600           3
(null)     DR NO                      2500           1

18 rows selected.


-- 14. * Розставте співробітників з Нью-Йорка по заробітку (зарплата + премія) 

--select * from dept;

select deptno, loc, ename, income, 
rank() over (order by income) number_rank
from 
     (select d.deptno, loc, ename, sal + nvl(comm, 0) income
     from dept d, emp e
     where e.deptno = d.deptno
     and loc = 'NEW_YORK');


    DEPTNO LOC           ENAME                    INCOME NUMBER_RANK
---------- ------------- -------------------- ---------- -----------
        10 NEW_YORK      MILLER                     1300           1
        10 NEW_YORK      CLARK                      1500           2
        10 NEW_YORK      KING                       5000           3


-- 15. * Виведіть ім'я, відділ і зарплату для співробітників, які отримують найменшу зарплату у відділі.


select ename, deptno, sal min_sal,
rank() over (order by sal) number_rank
from emp
where sal =
            (select min(sal)
             from emp e
             where e.deptno = emp.deptno);
			

/* Зведені таблиці 
16. Складіть звіт який відображає середню зарплату по кожній з посад кожного відділу. */

select * 
from 
     (select d.deptno, dname, sal, job
      from emp e, dept d
      where e.deptno = d.deptno)
pivot 
(avg(sal) for job 
in ('PRESIDENT', 'MANAGER', 'SALESMAN', 'CLERK', 'ANALYST')) pvt
order by deptno;

    DEPTNO DNAME          'PRESIDENT'  'MANAGER' 'SALESMAN'    'CLERK'  'ANALYST'
---------- -------------- ----------- ---------- ---------- ---------- ----------
        10 ACCOUNTING            5000       1500 (null)           1300 (null)
        20 RESEARCH       (null)            2975 (null)            950       3000
        30 SALES          (null)            2850       1400        950 (null)
        60 SALES2         (null)      (null)           2450 (null)     (null)

-- Перевірка:

select ename, job, sal, deptno from emp;

ENAME                JOB              SAL     DEPTNO
-------------------- --------- ---------- ----------
KING                 PRESIDENT       5000         10
BLAKE                MANAGER         2850         30
CLARK                MANAGER         1500         10
JONES                MANAGER         2975         20
MARTIN               SALESMAN        1250         30
ALLEN                SALESMAN        1600         30
TURNER               SALESMAN        1500         30
JAMES                CLERK            950         30
WARD                 SALESMAN        1250         30
FORD                 ANALYST         3000         20
SMITH                CLERK            800         20
SCOTT                ANALYST         3000         20
ADAMS                CLERK           1100         20
MILLER               CLERK           1300         10
JACKIE CHAN          SALESMAN        2250         60
JET LI               SALESMAN        2600         60
BRUCE LEE            SALESMAN        2500         60
DR NO                ANALYST         2500 (null)

18 rows selected.

--select * from emp;
--select * from dept;

--------------------------------------------------------
/*
-- Кількість співробітників у відділах за посадами:

select * 
from 
     (select dname, job
      from emp e, dept d
      where e.deptno = d.deptno)
pivot 
(count(job) for job 
in ('MANAGER','SALESMAN','CLERK', 'ANALYST')) pvt;

DNAME           'MANAGER' 'SALESMAN'    'CLERK'  'ANALYST'
-------------- ---------- ---------- ---------- ----------
ACCOUNTING              1          0          1          0
RESEARCH                1          0          2          2
SALES2                  0          3          0          0
SALES                   1          4          1          0
*/
----------------------------------------------------------------------------------------------------------------


/* 17. Складіть звіт який містить зарплати співробітників з підсумковими рядками, 
які відображають суму зарплат групувати по «відділ і посаду» і по «відділ». 
(Стовпці звіту: відділ, посада, сумарна зарплата). */

select nvl(deptno, 0) deptno, nvl(job, '--- SUMA -->') job, sum(sal) sum_sal
from emp
group by ROLLUP(deptno, job);

    DEPTNO JOB             SUM_SAL
---------- ------------ ----------
         0 ANALYST            2500
         0 --- SUMA -->       2500
        10 CLERK              1300
        10 MANAGER            1500
        10 PRESIDENT          5000
        10 --- SUMA -->       7800
        20 CLERK              1900
        20 ANALYST            6000
        20 MANAGER            2975
        20 --- SUMA -->      10875
        30 CLERK               950
        30 MANAGER            2850
        30 SALESMAN           5600
        30 --- SUMA -->       9400
        60 SALESMAN           7350
        60 --- SUMA -->       7350
         0 --- SUMA -->      37925

17 rows selected.

-- 2 вариант

select deptno, job, sum(sal) sum_sal
from emp
group by ROLLUP(deptno, job);

    DEPTNO JOB          SUM_SAL
---------- --------- ----------
(null)     ANALYST         2500
(null)     (null)          2500
        10 CLERK           1300
        10 MANAGER         1500
        10 PRESIDENT       5000
        10 (null)          7800
        20 CLERK           1900
        20 ANALYST         6000
        20 MANAGER         2975
        20 (null)         10875
        30 CLERK            950
        30 MANAGER         2850
        30 SALESMAN        5600
        30 (null)          9400
        60 SALESMAN        7350
        60 (null)          7350
(null)     (null)         37925

17 rows selected.

--------------------------------------------------------

/* Проміжні підсумки */
/*
select deptno, job, count(empno) headcount
from emp
group by ROLLUP(deptno, job);


    DEPTNO JOB        HEADCOUNT
---------- --------- ----------
(null)     ANALYST            1
(null)     (null)             1
        10 CLERK              1
        10 MANAGER            1
        10 PRESIDENT          1
        10 (null)             3
        20 CLERK              2
        20 ANALYST            2
        20 MANAGER            1
        20 (null)             5
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4
        30 (null)             6
        60 SALESMAN           3
        60 (null)             3
(null)     (null)            18

17 rows selected.


select deptno, job, count(empno) headcount
from emp
group by CUBE(deptno, job);

    DEPTNO JOB        HEADCOUNT
---------- --------- ----------
(null)     (null)             1
(null)     (null)            18
(null)     CLERK              4
(null)     ANALYST            1
(null)     ANALYST            3
(null)     MANAGER            3
(null)     SALESMAN           7
(null)     PRESIDENT          1
        10 (null)             3
        10 CLERK              1
        10 MANAGER            1
        10 PRESIDENT          1
        20 (null)             5
        20 CLERK              2
        20 ANALYST            2
        20 MANAGER            1
        30 (null)             6
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4
        60 (null)             3
        60 SALESMAN           3

22 rows selected.
*/
----------------------------------------------------------------------------------------------------------------

/*18. Складіть звіт який містить зарплати співробітників з підсумковими рядками, які відображають суми зарплат, 
що згруповані по «місто, відділ, посада», «відділ і посада», «відділ». */

-- select d.deptno, nvl(loc, ' ') loc, nvl(job, ' ') job, sum(sal) sum_sal

select d.deptno, nvl(loc, '-   -   -   >') loc, nvl(job,  '-   -   -   >') job, sum(sal) sum_sal
from emp e, dept d 
where e.deptno = d.deptno
group by
grouping sets ((loc, d.deptno, job), (d.deptno, job), (d.deptno));


/*
select d.deptno, loc, job, sum(sal) sum_sal
from emp e, dept d 
where e.deptno = d.deptno
group by
grouping sets ((loc, d.deptno, job), (d.deptno, job), (d.deptno));
*/


/*
SELECT loc, job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY
GROUPING SETS ((loc,job),(job));

LOC           JOB         SUM(SAL)
------------- --------- ----------
DALLAS        CLERK           1900
CHICAGO       CLERK            950
NEW_YORK      CLERK           1300
(null)        CLERK           4150
DALLAS        ANALYST         6000
(null)        ANALYST         6000
DALLAS        MANAGER         2975
CHICAGO       MANAGER         2850
NEW_YORK      MANAGER         1500
(null)        MANAGER         7325
CHICAGO       SALESMAN        5600
HONKONG       SALESMAN        7350
(null)        SALESMAN       12950
NEW_YORK      PRESIDENT       5000
(null)        PRESIDENT       5000

15 rows selected.
*/
-------------------------------------------------------------------------------------------------------------------------------

/*19. * Складіть звіт який містить зарплати співробітників з підсумковими рядками, які відображають суми зарплат, 
що згруповані по «місто, відділ, посада», «відділ і посада», «місто, посада», «місто, відділ», «місто», «відділ» , «посада». */

select d.deptno, nvl(loc, '-   -   -   >') loc, nvl(job,  '-   -   -   >') job, sum(sal) sum_sal
from emp e, dept d 
where e.deptno = d.deptno
group by
grouping sets ((loc, d.deptno, job), (d.deptno, job), (loc, job), 
               (loc, d.deptno), (loc), (d.deptno), (job));

/*20. * Складіть звіт, який містить тільки підсумкові рядки, які відображають суми зарплат,
 що згруповані по «місто, відділ, посада», «відділ, посада», «місто». */


select sum(sal) sum_sal
from emp e, dept d 
where e.deptno = d.deptno
group by
grouping sets ((loc, d.deptno, job), (d.deptno, job), (loc)); 

-------------------------------------------------------------------


select deptno, 
       nvl(loc, '-   -   -   >') loc, 
       nvl(job, '-   -   -   >') job, 
       sum_sal
from 
     (select d.deptno, loc, job, sum(sal) sum_sal
     from emp e, dept d 
     where e.deptno = d.deptno
     group by
     grouping sets ((loc, d.deptno, job), (d.deptno, job), (loc)))
where job is null or loc is null or deptno is null;

----------------------------------------------------------------------

select *
from 
     (select d.deptno, loc, job, sum(sal) sum_sal
     from emp e, dept d 
     where e.deptno = d.deptno
     group by
     grouping sets ((loc, d.deptno, job), (d.deptno, job), (loc)))
where job is null or loc is null or deptno is null;

    DEPTNO LOC           JOB          SUM_SAL
---------- ------------- --------- ----------
(null)     HONKONG       (null)          7350
(null)     CHICAGO       (null)          9400
(null)     NEW_YORK      (null)          7800
(null)     DALLAS        (null)         10875
        10 (null)        CLERK           1300
        10 (null)        MANAGER         1500
        10 (null)        PRESIDENT       5000
        20 (null)        CLERK           1900
        20 (null)        ANALYST         6000
        20 (null)        MANAGER         2975
        30 (null)        CLERK            950
        30 (null)        MANAGER         2850
        30 (null)        SALESMAN        5600
        60 (null)        SALESMAN        7350

14 rows selected.

--------------------------------------------------------------

select d.deptno, loc, job, sum(sal) sum_sal
from emp e, dept d 
where e.deptno = d.deptno
group by
grouping sets ((loc, d.deptno, job), (d.deptno, job), (loc));


------------------------------------------------------------


/*

select deptno,
case GROUPING_ID(deptno, job)
 when 0 then job
 when 1 then '**dept **'
 when 2 then '**total**'
end job
, count(empno) headcount
from emp
group by rollup(deptno, job);

    DEPTNO JOB        HEADCOUNT
---------- --------- ----------
(null)     ANALYST            1
(null)     **dept **          1
        10 CLERK              1
        10 MANAGER            1
        10 PRESIDENT          1
        10 **dept **          3
        20 CLERK              2
        20 ANALYST            2
        20 MANAGER            1
        20 **dept **          5
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4
        30 **dept **          6
        60 SALESMAN           3
        60 **dept **          3
(null)     (null)            18

17 rows selected.



select deptno,
case GROUPING(job)
     when 0 then job
     when 1 then '**total**'
     end job,
count(empno) headcount
from emp
group by
rollup(deptno, job);

    DEPTNO JOB        HEADCOUNT
---------- --------- ----------
(null)     ANALYST            1
(null)     **total**          1
        10 CLERK              1
        10 MANAGER            1
        10 PRESIDENT          1
        10 **total**          3
        20 CLERK              2
        20 ANALYST            2
        20 MANAGER            1
        20 **total**          5
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4
        30 **total**          6
        60 SALESMAN           3
        60 **total**          3
(null)     **total**         18

17 rows selected.


select deptno,
case GROUPING_ID(deptno, job)
 when 0 then job
 when 1 then '**dept **'
 when 3 then '**total**'
end job,
count(empno) headcount
from emp
group by rollup(deptno, job);

    DEPTNO JOB        HEADCOUNT
---------- --------- ----------
(null)     ANALYST            1
(null)     **dept **          1
        10 CLERK              1
        10 MANAGER            1
        10 PRESIDENT          1
        10 **dept **          3
        20 CLERK              2
        20 ANALYST            2
        20 MANAGER            1
        20 **dept **          5
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4
        30 **dept **          6
        60 SALESMAN           3
        60 **dept **          3
(null)     **total**         18

17 rows selected.

*/
-------------------------------------------------------------------------------------------------------------------------------

/*21 * «Понти дорожчі за гроші» */

--drop table oligarchs_property;

create table oligarchs_property(owner varchar(20) not null,
                                luxury_items varchar(20) not null,
                                cost int not null);

insert into oligarchs_property values('The oligarch Ivanov', 'Yacht', 100000);
insert into oligarchs_property values('The oligarch Ivanov', 'Yacht', 200000);
insert into oligarchs_property values('The oligarch Ivanov', 'Country house', 1000000);
insert into oligarchs_property values('The oligarch Petrov', 'Car', 200000);

--select * from oligarchs_property;

---drop table oligarchs_property;

-- number_of_yachts, cost_of_yachts,
-- number_of_dachas, cost_of_dachas,
-- number_of_cars, cost_of_cars

select owner, luxury_items, to_char(cost, '9,999,999') cost
from oligarchs_property;


SQL> select owner, luxury_items, to_char(cost, '9,999,999') cost
  2  from oligarchs_property;

OWNER                LUXURY_ITEMS         COST
-------------------- -------------------- ----------
The oligarch Ivanov  Yacht                   100,000
The oligarch Ivanov  Yacht                   200,000
The oligarch Ivanov  Country house         1,000,000
The oligarch Petrov  Car                     200,000



select *
from 
     (select owner, luxury_items
      from oligarchs_property)
pivot 
(count(luxury_items) for luxury_items 
in ('Yacht', 'Country house', 'Car')) pvt; 

SQL> select *
  2  from
  3       (select owner, luxury_items
  4        from oligarchs_property)
  5  pivot
  6  (count(luxury_items) for luxury_items
  7  in ('Yacht', 'Country house', 'Car')) pvt;

OWNER                   'Yacht' 'Country house'      'Car'
-------------------- ---------- --------------- ----------
The oligarch Ivanov           2               1          0
The oligarch Petrov           0               0          1


select *
from 
     (select owner, luxury_items, cost
      from oligarchs_property)
pivot 
(sum(cost) for luxury_items 
in ('Yacht', 'Country house', 'Car')) pvt;

OWNER                   'Yacht' 'Country house'      'Car'
-------------------- ---------- --------------- ----------
The oligarch Ivanov      300000         1000000 (null)
The oligarch Petrov  (null)     (null)              200000


drop table oligarchs_property;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:
Для захисту у кого зі співробітників (окрім Кінга) максимальний прибуток(зарплата+премія).
*/

select empno, ename, sal + nvl(comm, 0) income
from emp 
where sal + nvl(comm, 0) = 
      (select max(sal + nvl(comm, 0))
      from 
          (select empno, ename, sal, comm
          from emp
          where ename != 'KING'));

-- Перевірка:

select empno, ename, sal + nvl(comm, 0) income
from emp
order by income desc;
