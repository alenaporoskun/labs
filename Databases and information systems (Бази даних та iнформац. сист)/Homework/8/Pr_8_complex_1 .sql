/* Пороскун О. ПМ-81   Практична робота 8  БД*/

/*Комплексне завдання 1. «Межі» 

1. Створіть таблицю Job_Salegrade: 
2. Знайдіть співробітників, які отримують більше, ніж максимальна зарплата за посадою. 
3. Знайдіть співробітників, які отримують більше або менше встановлених меж зарплати. 
4. Створіть представлення (view) empl_and_salegrade на основі з'єднання таблиць Job_Salegrage і emp. 
5. Визначте, в яких містах службовцям недоплачують або переплачують: 
А) використовуючи з'єднання таблиць
 Б) використовуючи таблицю dept і представлення empl_and_salegrade. 
6. Визначте, в яких містах все службовці отримують зарплату в встановлених межах. 
7. Видаліть представлення empl_and_salegrade і таблицю Job_Salegrade.
*/

-- 1. Створіть таблицю Job_Salegrade
drop table Job_Salegrade;

create table Job_Salegrade(job varchar(20) not null,
                           min_salary NUMBER(4) not null,
                           max_salary NUMBER(4) not null);

insert into Job_Salegrade values('MANAGER',  1000, 2000);
insert into Job_Salegrade values('SALESMAN', 1000, 5000);
insert into Job_Salegrade values('CLERK',     500, 1200);
insert into Job_Salegrade values('ANALYST',  2000, 5000);

select * from Job_Salegrade;

-- 2. Знайдіть співробітників, які отримують більше, ніж максимальна зарплата за посадою.
/*
select * from emp;

select ename name, e.job, sal salary, min_salary, max_salary
from emp e
join Job_Salegrade j on (j.job = e.job);
*/

select ename name, e.job, sal salary, max_salary
from emp e
join Job_Salegrade j on (j.job = e.job)
where sal > max_salary;

-- 3. Знайдіть співробітників, які отримують більше або менше встановлених меж зарплати. 

select ename name, e.job, sal salary, min_salary, max_salary
from emp e
join Job_Salegrade j on (j.job = e.job)
where sal not between min_salary and max_salary;

-- 4. Створіть представлення (view) empl_and_salegrade на основі з'єднання таблиць Job_Salegrage і emp. 

create view empl_and_salegrade
as select empno, ename, e.job, mgr, hiredate, sal, min_salary, max_salary, comm, deptno
from emp e
join Job_Salegrade j on (j.job = e.job);

select * from empl_and_salegrade;

/* 2 вариант
create view empl_and_salegrade
as select *
from emp
natural join Job_Salegrade;

select * from empl_and_salegrade;

drop view empl_and_salegrade;
*/

/*
5. Визначте, в яких містах службовцям недоплачують або переплачують: 
А) використовуючи з'єднання таблиць
Б) використовуючи таблицю dept і представлення empl_and_salegrade. 
*/

-- А

select ename name, sal salary, min_salary, max_salary, e.deptno, loc
from emp e
join dept d on (d.deptno = e.deptno)
join Job_Salegrade j on (j.job = e.job);

select loc
from emp e
join dept d on (d.deptno = e.deptno)
join Job_Salegrade j on (j.job = e.job)
where sal not between min_salary and max_salary;

-- Б

select ename name, sal salary, min_salary, max_salary, es.deptno, loc
from empl_and_salegrade es
join dept d on (d.deptno = es.deptno);

select loc
from empl_and_salegrade es
join dept d on (d.deptno = es.deptno)
where sal not between min_salary and max_salary;

/*
select ename name, sal salary, min_salary, max_salary, es.deptno, loc
from empl_and_salegrade es
join dept d on (d.deptno = es.deptno)
where sal between min_salary and max_salary;

select ename name, sal salary, min_salary, max_salary, es.deptno, loc
from empl_and_salegrade es
join dept d on (d.deptno = es.deptno)
where sal > min_salary and sal < max_salary;
*/

-- 6. Визначте, в яких містах все службовці отримують зарплату в встановлених межах. 

select es1.ename name, es1.sal salary, es1.min_salary, es1.max_salary, es1.deptno, loc
from empl_and_salegrade es1
join dept d on (d.deptno = es1.deptno)
where es1.sal between es1.min_salary and es1.max_salary
and es1.deptno not in 
                     (select es2.deptno
                      from empl_and_salegrade es2
                      where es2.sal not between es2.min_salary and es2.max_salary);

select loc
from empl_and_salegrade es1
join dept d on (d.deptno = es1.deptno)
where es1.sal between es1.min_salary and es1.max_salary
and es1.deptno not in 
                     (select es2.deptno
                      from empl_and_salegrade es2
                      where es2.sal not between es2.min_salary and es2.max_salary);

-- 7. Видаліть представлення empl_and_salegrade і таблицю Job_Salegrade.

drop view empl_and_salegrade;

drop table Job_Salegrade;


