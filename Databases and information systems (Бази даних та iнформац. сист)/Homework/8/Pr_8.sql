/* Пороскун О. ПМ-81   Практична робота 8  БД*/

/* Natural join 
1. Створіть звіт який містить ім'я співробітника і місто, в якому він працює. */

select ename name, loc city
from emp
natural join dept;

/*2. Виконайте завдання 2 тричі: використовуючи 
NATURAL JOIN, JOIN ... ON і JOIN ... USING: 
Відділу кадрів потрібен звіт, якій містить ім'я, зарплату, номер відділу для всіх співробітників з Dallas.*/

--1
select ename name, sal salary, deptno
from emp
natural join dept
where loc = 'DALLAS';

--2
select ename name, sal salary, e.deptno
from emp e
join dept d on (d.deptno=e.deptno)
where loc = 'DALLAS';

--3
select ename name, sal salary, deptno
from emp e
join dept using (deptno)
where loc = 'DALLAS';


/*Join з використанням (On або Using) 
3. Сформувати запит, що виводить номер і прізвище працівника, номер і прізвище його менеджера 
для тих співробітників, у яких є менеджер. */

select worker.empno, worker.ename worker, manager.empno, manager.ename manager
from emp worker
join emp manager on (worker.mgr = manager.empno);

/* 4. Сформувати запит, що виводить співробітників, що працюють в місті, назва якого містить 'O'.*/

select ename name, loc city
from emp e
join dept using (deptno)
where loc like '%O%';

select ename name
from emp e
join dept using (deptno)
where loc like '%O%';

/*
Left (Right) Join 
Виконайте завдання 5 двічі: використовуючи LEFT JOIN і RIGHT JOIN. 
5. Сформувати запит, що виводить номер і прізвище працівника, номер і прізвище його менеджера, 
включно з працівниками, які не мають менеджерів. */

select worker.empno, worker.ename worker, manager.empno, manager.ename manager
from emp manager
right outer join emp worker
on (worker.mgr = manager.empno);


select worker.empno, worker.ename worker, manager.empno, manager.ename manager
from emp worker
left outer join emp manager 
on (worker.mgr = manager.empno);

/* 6. Створіть запит, який повертає номер і назву відділу, в якому немає співробітників. */

select d.deptno, dname
from emp e
right outer join dept d
on (d.deptno = e.deptno)
where e.deptno is null;

    DEPTNO DNAME
---------- --------------
        50 RESEARCH2
       100 SALES3
        40 OPERATIONS
/*
select d.deptno, dname, e.deptno
from emp e
right outer join dept d
on (d.deptno = e.deptno)
where e.deptno is null;

    DEPTNO DNAME              DEPTNO
---------- -------------- ----------
        50 RESEARCH2      (null)
       100 SALES3         (null)
        40 OPERATIONS     (null)

select d.deptno, dname, e.deptno
from dept d
left outer join emp e
on (d.deptno = e.deptno)
where e.deptno is null;

    DEPTNO DNAME              DEPTNO
---------- -------------- ----------
        50 RESEARCH2      (null)
       100 SALES3         (null)
        40 OPERATIONS     (null)

select e.ename, d.deptno, d.dname
from emp e
left outer join dept d
on (e.deptno = d.deptno)
where e.deptno is null;

ENAME                    DEPTNO DNAME
-------------------- ---------- --------------
DR NO                (null)     (null)
*/
		
-------------------------------------------------
-------------------------------------------------

/* 7. Створіть запит, який повертає співробітників, у яких немає підлеглих. */

-- на основе зад. 5

select manager.empno, manager.ename
from emp worker
right outer join emp manager 
on (worker.mgr = manager.empno)
where worker.empno is null;
-----------------------------------
select manager.empno, manager.ename
from emp manager
left outer join emp worker 
on (worker.mgr = manager.empno)
where worker.empno is null;

/* Cross Join
8. Виведіть на екран таблицю множення для чисел від 1 до 10. 
(Можливо для цього вам доведеться створити додаткову таблицю. 
Не забудьте її видалити) */

create table my_table(num integer default 1);

insert into my_table values (1);
insert into my_table values (2);
insert into my_table values (3);
insert into my_table values (4);
insert into my_table values (5);
insert into my_table values (6);
insert into my_table values (7);
insert into my_table values (8);
insert into my_table values (9);
insert into my_table values (10);

select * from my_table;

select tb.num A, ta.num B, tb.num*ta.num as "A*B"
from my_table ta
cross join my_table tb;

drop table my_table;

/*
Використання декількох Join в одному запиті
9. Виведіть імена співробітників, у яких начальники працюють в інших містах. */
/*
select worker.empno, worker.ename worker, dw.loc, manager.empno, manager.ename manager, dm.loc
from emp worker
join emp manager on (worker.mgr = manager.empno)
join dept dw on (worker.deptno = dw.deptno)
join dept dm on (manager.deptno = dm.deptno);
-------
select worker.empno, worker.ename worker, dw.loc, manager.empno, manager.ename manager, dm.loc
from emp worker
join emp manager on (worker.mgr = manager.empno)
join dept dw on (worker.deptno = dw.deptno)
join dept dm on (manager.deptno = dm.deptno)
where dw.deptno != dm.deptno;
*/
select worker.ename worker
from emp worker
join emp manager on (worker.mgr = manager.empno)
join dept dw on (worker.deptno = dw.deptno)
join dept dm on (manager.deptno = dm.deptno)
where dw.deptno != dm.deptno;


/* 10. Виведіть імена начальників, у яких співробітники працюють в інших містах. */
/*
select worker.empno, worker.ename worker, dw.loc, manager.empno, manager.ename manager, dm.loc
from emp manager
join emp worker on (worker.mgr = manager.empno)
join dept dw on (worker.deptno = dw.deptno)
join dept dm on (manager.deptno = dm.deptno)
where dw.deptno != dm.deptno;
*/
select manager.ename manager
from emp manager
join emp worker on (worker.mgr = manager.empno)
join dept dw on (worker.deptno = dw.deptno)
join dept dm on (manager.deptno = dm.deptno)
where dw.deptno != dm.deptno;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:

Завдання: виведіть імена всіх працівників, у яких підлеглі заробляють загалом(зарплата+премія) за місяць більше 3000. 
Для наглядності імена підлеглих та заробіток теж вкажіть в селекті.*/

select  mn.empno, mn.ename manager, wr.empno, wr.ename worker, wr.mgr, wr.sal, wr.comm
from emp mn
join emp wr 
on (wr.mgr = mn.empno)
where wr.sal + wr.comm > 3000;

     EMPNO MANAGER                   EMPNO WORKER                      MGR        SAL       COMM
---------- -------------------- ---------- -------------------- ---------- ---------- ----------
      7839 KING                       8000 JACKIE CHAN                7839       2250       1700
      8000 JACKIE CHAN                8001 JET LI                     8000       2600        600
  