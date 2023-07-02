/* Пороскун О. ПМ-81   Практична робота 7  БД*/

/* Екві-з’єднання 
1. Створіть звіт, який містить ім'я співробітника і місто, в якому він працює. */

select ename name, loc city
from emp, dept
where emp.deptno = dept.deptno;

/* 2. Відділу кадрів потрібен звіт що містить ім'я і зарплату для всіх співробітників з Dallas */

select ename name, sal salary
from emp, dept
where emp.deptno = dept.deptno
  and loc = 'DALLAS';

/*Не-екві з’єднання 
3. Створіть запит, який виведе імена і зарплату всіх співробітників із зарплатою вище ніж у Turner. */

select e.ename name, e.sal salary
from emp e, emp t
where e.sal > t.sal
  and t.ename = 'TURNER';
  
-- проверка с помощью подзапроса

select ename name, sal salary
from emp
where sal > (select sal
             from emp
             where ename = 'TURNER');
			 
----------------------------------------

/* 4. Створіть запит, який виведе співробітників із зарплатою нижче ніж у будь-якого з клерків.*/

select distinct e.ename name, e.job, e.sal salary
from emp e, emp cl
where e.sal < cl.sal
  and cl.job = 'CLERK';
  
-- проверка с помощью подзапроса
/*
select ename name, job, sal salary
from emp
where sal < all
            (select sal
             from emp
             where job = 'CLERK');
 */		 
select ename name, job, sal salary
from emp
where sal < any
            (select sal
             from emp
             where job = 'CLERK');

/* Само-з’єднання 
5. Виведіть на екран таблицю множення для чисел від 1 до 10 використовуючи само-з'єднання. 
Можливо для цього вам доведеться створити додаткову таблицю. Видаліть її після завершення роботи.*/

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
from my_table ta, my_table tb;

drop table my_table;

/*
--------------------------------

create table tb11(num integer default 1);

insert into tb11 values (1);
insert into tb11 values (2);
insert into tb11 values (3);

select * from tb11;

/*
select ta.num A, tb.num B, ta.num*tb.num AxB
from tb11 ta, tb11 tb;
*/
/*

select tb.num A, ta.num B, tb.num*ta.num  as "A*B"
from tb11 ta, tb11 tb;

drop table tb11;

*/
----------------------------------

/* Завдання 
6. Сформувати запит, що виводить номер і прізвище працівника, номер і прізвище його начальника, якщо у працівника є начальник.*/

select w.empno , w.ename worker, e.empno, e.ename employer
from emp w, emp e
where w.mgr = e.empno;

/*7. Сформуйте запит, який повертає номера і назви відділів, в яких є співробітники.*/

select d.deptno, d.dname 
from emp e, dept d
where e.deptno = d.deptno 
  and e.empno is not null;

/*Завдання 8
1. Створіть таблицю My_emp,що містить дані про всіх співробітників у яких зарплата більше $ 2500.
2. Переконайтеся що всі співробітники додані правильно.
3. Виведіть список співробітників, які є в таблиці emp і в таблиці My_emp.*/

select * from emp;

create table My_emp as
select * from emp
where sal > 2500;

select * from My_emp;

select e.empno, e.ename
from emp e, My_emp me
where e.ename = me.ename;

/* Завдання 9 
1. Додайте в таблиці My_emp працівникам відділів №10 та №20 $200 зарплати. 
2. Виведіть список працівників My_emp, їх нову зарплату та зарплату з таблиці emp. 
3. * Змініть номери відділів у 5 будь-яких (на ваш вибір) працівників из My_emp. 
4. * Виведіть працівників, у яких змінився відділ, їх старий та новий відділ. 
5. Видаліть таблицю My_emp.*/

-- 1
update My_emp
set sal = sal + 200
where deptno = 10 or deptno = 20;

select * from My_emp;

-- 2
select me.ename, me.sal, e.sal 
from emp e, My_emp me
where e.empno = me.empno;

--3
update My_emp
set deptno = 3
where comm is null;

select * from My_emp;

--4
select me.ename, e.deptno, me.deptno
from emp e, My_emp me
where e.deptno != me.deptno
  and e.empno = me.empno;

--5
drop table My_emp;

/* Завдання 10
1. * Виведіть список співробітників, які є начальниками.
2. Виведіть список підрозділів, в яких працює хоча б один начальник.
3. * Виведіть список міст, в яких працює хоча б один начальник. */

--1
select e.empno, e.ename employer
from emp w, emp e
where w.mgr = e.empno;

select distinct e.empno, e.ename employer
from emp w, emp e
where w.mgr = e.empno;

--2

select e.deptno
from emp w, emp e
where w.mgr = e.empno;

select distinct e.deptno
from emp w, emp e
where w.mgr = e.empno;

--3
  
select d.loc
from emp w, emp e, dept d
where w.mgr = e.empno
  and e.deptno = d.deptno;

select distinct d.loc
from emp w, emp e, dept d
where w.mgr = e.empno
  and e.deptno = d.deptno;


/* Завдання 11*  
1. Створіть запит, який виведе всі пари імен співробітників, що працюють в одному відділі.
При цьому, не включати в список комбінації імен співробітників самих з собою (тобто комбінацію типу «Іванов-Іванов») 
і комбінації імен співробітників, що відрізняються порядком розташування 
(тобто включати одну з двох комбінацій типу «ІвановПетров» і «Петров-Іванов»).  
2. Модифікуйте запит 12.1, так щоб пари будувалися для співробітників, які працюють в одному місті, а не в одному відділі.*/

--1
select w1.ename ||' - '|| w2.ename as "WORKER - WORKER"
from emp w1, emp w2
where w1.deptno = w2.deptno
  and w1.ename != w2.ename;

--2
select distinct w1.ename ||' - '||  w2.ename as "WORKER - WORKER"
from emp w1, emp w2, dept d1, dept d2
where d1.loc = d2.loc
  and w1.deptno is not null
  and w2.deptno is not null
  and w1.ename != w2.ename;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:

Виведіть назви міст і відділів, де працюють clerk
*/

/*
select ename, job, e.deptno, loc, dname
from emp e, dept d
where e.deptno = d.deptno
  and job = 'CLERK';
*/
select loc, dname
from emp e, dept d
where e.deptno = d.deptno
  and job = 'CLERK';
