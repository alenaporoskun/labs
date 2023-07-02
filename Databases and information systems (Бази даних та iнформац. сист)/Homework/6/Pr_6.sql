/* Пороскун О. ПМ-81   Практична робота 6  БД*/

/*
CREATE TABLE My_emp AS
SELECT * FROM EMP
WHERE 1=2;
*/

create table My_emp as
select * from emp
where 1 = 2;

select * from emp;

select * from My_emp;


/* INSERT 
1. Додайте в таблицю My_emp відомості про нового співробітника: 

empno - 665 
ename - IVAN 
job – SALESMAN 
mgr - 7839 
hiredate – текущая дата 
sal - 9999 
comm - NULL 
deptno – 20 
Переконайтеся, що співробітник доданий.*/



insert into My_emp(empno,    ename,  job,  mgr,
                   hiredate, sal,    comm, deptno)
values             (665,    'IVAN', 'SALESMAN', 7839,
                    sysdate, 9999,   null,      20);

1 row created.


select * from My_emp;

     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
       665 IVAN                 SALESMAN        7839 16-MAR-21       9999 (null)             20
	   

/*INSERT 
2. Додайте в таблицю My_emp відомості про нового співробітника: 
empno - 667 
ename - IGOR 
hiredate – поточна дата 
sal – 9999 
deptno – 10 
Переконайтеся, що співробітник доданий.
*/

insert into My_emp(empno,    ename,
                   hiredate, sal,    deptno)
values             (667,    'IGOR',
                    sysdate, 9999,   10);

select * from My_emp;

/* TRUNCATE 
3. Очистіть таблицю My_emp за допомогою Truncate table. 
Переконайтеся, що таблиця My_emp порожня.*/

Truncate table.

truncate table My_emp;

select * from My_emp;

/*

SQL> truncate table My_emp;

Table truncated.

SQL> select * from My_emp;

no rows selected
*/

--  describe My_emp;


/* INSERT 
4. Додайте всі дані з таблиці Emp в таблицю My_emp. 
Переконайтесь, що всі співробітники додані.*/


insert into My_emp
select * from emp;


select * from My_emp;


/*UPDATE 
5. Додайте всім службовцям з таблиці My_emp $ 200 зарплати.*/

update My_emp
set sal = sal + 200;

select * from My_emp;

/*6. * Одним запитом додайте всім службовцям ще $ 200 зарплати і встановіть премію $ 100.*/ 

update My_emp
set sal = sal + 200,
    comm = 100;

select * from My_emp;

/*7. Заберіть у всіх службовців премію. Переконайтеся, що всі зміни проведені правильно.*/

update My_emp
set comm = null;

select * from My_emp;

/*DELETE 
8. Видаліть працівників 10 відділу з таблиці My_emp. 
Переконайтеся, що працівники видалені. */

delete from My_emp
where deptno = 10;

select * from My_emp;

/* Завершення роботи 
9. Видаліть таблицю My_emp.*/

drop table My_emp;

/*
NULL vs DEFAULT 
10. Створимо таблицю: CREATE TABLE TBL1 (A integer, B integer DEFAULT 5); 
Якими будуть результати команд: 
a. Insert into tbl1 values (default, default); 
b. Insert into tbl1 values (null, null); 
c. Insert into tbl1(a) values (default); 
d. Insert into tbl1(b) values (default); 
e. Insert into tbl1(a) values (null); 
f. Insert into tbl1(b) values (null);
*/

CREATE TABLE TBL1 (A integer, B integer DEFAULT 5);
--
Insert into tbl1 values (default, default); 
select * from tbl1;
--
Insert into tbl1 values (null, null); 
select * from tbl1;
--
Insert into tbl1(a) values (default);
select * from tbl1;
--
Insert into tbl1(b) values (default); 
select * from tbl1;
--
Insert into tbl1(a) values (null); 
select * from tbl1;
--
Insert into tbl1(b) values (null);
select * from tbl1;

--drop table tbl1;


/*
*11. Корельовані підзапити в UPDATE і DELETE 
a. Створіть таблицю MY_EMP на основі таблиці EMP і скопіюйте в неї всі дані. 
b. Денормалізуйте таблицю MY_EMP додавши до неї стовпець dname. 
c. Заповніть цей стовпець на основі даних таблиці DEPT. 
d. Видаліть відомості з таблиці MY_EMP про службовців, які працюють в HONKONG. 
e. Видаліть таблицю MY_EMP.
*/

-- a
create table My_emp as
select * from emp;

select * from My_emp;
-- b
alter table My_emp 
add dname varchar(20);

update My_emp
set dname =
           (select dname
            from dept
            where dept.deptno = My_emp.deptno);

select * from My_emp;

delete 
from My_emp 
where dname = any
                 (select dname
                  from dept
                  where loc = 'HONKONG');				  

drop table My_emp;


/*
*12 Завдання  
Напишіть запит, якій виведе Ялинку. 
Для виведення зірочок скористайтеся функціями CASE, LPAD(RPAD).
*/

--drop table my_fir1;

create table my_fir1(string integer default 1);

insert into my_fir1 values (1);
insert into my_fir1 values (2);
insert into my_fir1 values (3);
insert into my_fir1 values (4);
insert into my_fir1 values (5);
insert into my_fir1 values (6);
insert into my_fir1 values (7);
insert into my_fir1 values (8);
insert into my_fir1 values (9);
insert into my_fir1 values (10);
insert into my_fir1 values (11);
insert into my_fir1 values (12);

select * from my_fir1;

select
case string when 1 then  concat(lpad('*', 11, ' '), rpad(' ', 10, ' '))
            when 2 then  concat(lpad('**', 11, ' '), rpad('*', 10, ' '))
			when 3 then  concat(lpad('***', 11, ' '), rpad('**', 10, ' '))
			when 4 then  concat(lpad('****', 11, ' '), rpad('***', 10, ' '))
			when 5 then  concat(lpad('*****', 11, ' '), rpad('****', 10, ' '))
			when 6 then  concat(lpad('******', 11, ' '), rpad('*****', 10, ' '))
			when 7 then  concat(lpad('*******', 11, ' '), rpad('******', 10, ' '))
			when 8 then  concat(lpad('********', 11, ' '), rpad('*******', 10, ' '))
			when 9 then  concat(lpad('*********', 11, ' '), rpad('********', 10, ' '))
			when 10 then concat(lpad('**********', 11, ' '), rpad('*********', 10, ' '))
			when 11 then concat(lpad('*', 11, ' '), rpad(' ', 10, ' '))
			when 12 then concat(lpad('*', 11, ' '), rpad(' ', 10, ' '))
end FIR
from my_fir1;


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
/*
Завдання додаткове:

Видаліть працівника без відділу. (В таблиці він названий  Dr.No)
*/
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

create table My_emp as
select * from emp;

select * from My_emp;

delete 
from My_emp 
where deptno is null;

select * from My_emp;

drop table My_emp;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------