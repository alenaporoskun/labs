
/* Пороскун О. ПМ-81   Практична робота 11  БД*/

/*
SELECT LEVEL, 2*LEVEL-1, ename AS ename
FROM emp
START WITH mgr IS NULL
CONNECT BY NOCYCLE PRIOR empno = mgr;

SELECT LPAD(' ', 2*LEVEL-1)||ename AS ename
FROM emp
START WITH mgr IS NULL
CONNECT BY NOCYCLE PRIOR empno = mgr;

ENAME
----------------------------------------------------------------------
 KING
   JONES
     SCOTT
       ADAMS
     FORD
       SMITH
   BLAKE
     ALLEN
     WARD
     MARTIN
     TURNER
     JAMES
   CLARK
     MILLER
   JACKIE CHAN
     JET LI
     BRUCE LEE
   DR NO

18 rows selected.


SELECT ename , CONNECT_BY_ISLEAF as IsLeaf
 FROM emp
 WHERE deptno = 10
 START WITH ename='KING'
 CONNECT BY PRIOR empno = mgr;

ENAME                    ISLEAF
-------------------- ----------
KING                          0
CLARK                         0
MILLER                        1

SELECT ename,
CONNECT_BY_ROOT ename as manager,
SYS_CONNECT_BY_PATH(ename,' > ') AS full_path
FROM emp
START WITH job = 'MANAGER'
CONNECT BY PRIOR empno = mgr;

ENAME MANAGER FULL_PATH
-------- -------- -------------------------
JONES JONES > JONES
SCOTT JONES > JONES > SCOTT
ADAMS JONES > JONES > SCOTT > ADAMS
FORD JONES > JONES > FORD
…
MILLER CLARK > CLARK > MILLER
13 rows selected.
*/


SELECT select_list
FROM table_expression
[ WHERE ... ]
[ START WITH start_expression ]
CONNECT BY
{ PRIOR parent_expr = child_expr
| child_expr = PRIOR parent_expr }
[ ORDER SIBLINGS BY
column1 [ ASC | DESC ] [, column2 [ ASC | DESC ] ] ...

--------------------------------------------------------------------------------------
/* 1. Задания 
Напишіть запит, який би повертав з таблиці emp інформацію:  
>	про ім'я співробітника;  
>	про рівні підпорядкованості (найвищий рівень - головний начальник, який нікому не підпорядковується - рівень 0);  
>	про шляхи підзвітності в форматі:
				/ Керівник 1 / керівник 2 / рядовий співробітник
>	Звіт повинен бути відсортований за рівнем підпорядкованості.
*/

select ename, level - 1 "LEVEL", SYS_CONNECT_BY_PATH(ename, '/') "PATH" 
from emp
start with mgr is null
connect by nocycle prior empno = mgr
order by level;

--------------------------------------------------------------------------------------
/* 2. Начальники  
Виберіть всі імена начальників співробітника на ім'я «JET LI»  */

select ename, level
from emp
where ename != 'JET LI'
start with ename = 'JET LI'
connect by nocycle prior empno = mgr;

no rows selected

select ename, level
from emp
where ename != 'JET LI'
start with ename = 'JET LI'
connect by nocycle prior mgr = empno;

ENAME                     LEVEL
-------------------- ----------
JACKIE CHAN                   2
KING                          3
--------------------------------------------------------------------------------------

/*   3*. Пропуски 
1. Створіть таблицю А 
2. Видаліть з таблиці рядки 4 і 6. 
3. Напишіть запит, який виведе віддалені числа. 
4. * Як буде виглядати запит, якщо максимальний елемент наперед не відомий 
5. * Як буде виглядати запит якщо максимальний і мінімальний елемент наперед невідомі? 
6. Видаліть таблицю А. 
Підказка: числову послідовність можна згенерувати запитом 
	Select rownum From dual Connect by level <= 7*/
	
--------------------------------------------------------------------------------------
-- 1. Створіть таблицю А 

-- drop table my_A;

create table my_A
as (select rownum A
    from dual 
    connect by level <= 7);

select * from my_A;

-- 2. Видаліть з таблиці рядки 4 і 6.

delete from my_A
where A in (4, 6);

select * from my_A;

-- 3. Напишіть запит, який виведе віддалені числа. 

select * from my_A
as of timestamp(systimestamp - interval '1' minute)
minus
select * from my_A;

/*
select * from my_A
  2  as of timestamp(systimestamp - interval '5' minute)
  3  minus
  4  select * from my_A;
*/

-- 4. * Як буде виглядати запит, якщо максимальний елемент наперед не відомий 

select rownum A from dual
connect by level <= 
                   (select max(A) from my_A)
minus
select * from my_A;


-- 5. * Як буде виглядати запит якщо максимальний і мінімальний елемент наперед невідомі? 

select rownum + 
               (select min(A) from my_A) - 1 A			
from dual
connect by level <= 
                   (select max(A) - min(A) from my_A)
minus
select * from my_A;


-- 6. Видаліть таблицю А. 

drop table my_A;

--------------------------------------------------------------------------------------

/*
4*. Втекти звідси 
Створіть таблицю відстаней між містами (не менше 8 рядків), наприклад: або так: 
1. Куди можна доїхати за 2 пересадки з обраного вами міста? 
2. * Знайдіть маршрут з мінімальною кількістю пересадок між двома вибраними вами містами. 
3. * Знайдіть найкоротший маршрут між обраними вами містами. (Підказки на наступних слайдах) 
Видаліть таблицю.
*/

/*
CREATE TABLE Dept(  -- описание подразделения
   deptno NUMBER(3) NOT NULL,  -- № подразделения
   dname VARCHAR(14) NOT NULL,  -- название подразделения
   loc VARCHAR(13), -- местоположение подразделения
   CONSTRAINT dept_pk PRIMARY KEY (deptno),
   CONSTRAINT dept_naem_uk UNIQUE (dname)
);
*/

-- drop table my_table;

create table my_table(point_A varchar(13), 
                      point_B varchar(13),
                      distance integer);
			
insert into my_table values ('Chernihiv', 'Vinnytsia', 423);
insert into my_table values ('Chernihiv', 'Dnipro', 585);
insert into my_table values ('Dnipro', 'Chernivtsi', 891);
insert into my_table values ('Chernivtsi', 'Vinnytsia', 312);
insert into my_table values ('Kyiv', 'Dnipro', 533);
insert into my_table values ('Simferopol', 'Odesa', 392);
insert into my_table values ('Sumy', 'Lviv', 896);
insert into my_table values ('Odesa', 'Sumy', 800);
insert into my_table values ('Lviv', 'Simferopol', 1173);
insert into my_table values ('Kherson', 'Kyiv', 551);
insert into my_table values ('Simferopol', 'Poltava', 635);

select * from my_table;

POINT_A       POINT_B         DISTANCE
------------- ------------- ----------
Chernihiv     Vinnytsia            423
Chernihiv     Dnipro               585
Dnipro        Chernivtsi           891
Chernivtsi    Vinnytsia            312
Kyiv          Dnipro               533
Simferopol    Odesa                392
Sumy          Lviv                 896
Odesa         Sumy                 800
Lviv          Simferopol          1173
Kherson       Kyiv                 551
Simferopol    Poltava              635

11 rows selected.


-- 1. Куди можна доїхати за 2 пересадки з обраного вами міста? 

select distinct point_B, level transfer
from my_table
where level = 2
and point_B != 'Sumy'
start with point_A = 'Sumy'
connect by nocycle prior point_B = point_A
order by point_B;

POINT_B         TRANSFER
------------- ----------
Simferopol             2

-- Перевірка:

select distinct point_B, level transfer
from my_table
where point_B != 'Sumy'
start with point_A = 'Sumy'
connect by nocycle prior point_B = point_A
order by point_B;

POINT_B         TRANSFER
------------- ----------
Lviv                   1
Odesa                  3
Poltava                3
Simferopol             2


/*
select distinct point_B, level transfer
from my_table
where point_B != 'Odesa'
start with point_A = 'Odesa'
connect by nocycle prior point_B = point_A
order by point_B;

POINT_B         TRANSFER
------------- ----------
Lviv                   2
Poltava                4
Simferopol             3
Sumy                   1

select distinct point_B, level transfer
from my_table
where level = 2
and point_B != 'Odesa'
start with point_A = 'Odesa'
connect by nocycle prior point_B = point_A
order by point_B;

POINT_B         TRANSFER
------------- ----------
Lviv                   2
*/

-- 2. * Знайдіть маршрут з мінімальною кількістю пересадок між двома вибраними вами містами. 

select *
from 
    (select level transfer, 
    sys_connect_by_path(point_A,' -> ') || ' ==> ' || point_B full_path
    from my_table
    where point_B = 'Vinnytsia'
    start with point_A = 'Chernihiv'
    connect by nocycle prior point_B = point_A
    order by transfer)
where rownum = 1;

-- Перевірка:

select *
from 
    (select level transfer, 
    sys_connect_by_path(point_A,' -> ') || ' ==> ' || point_B full_path
    from my_table
    where point_B = 'Vinnytsia'
    start with point_A = 'Chernihiv'
    connect by nocycle prior point_B = point_A
    order by transfer);


-- 3. * Знайдіть найкоротший маршрут між обраними вами містами. (Підказки на наступних слайдах) 

/*
CREATE OR REPLACE FUNCTION calc(pi_val VARCHAR2) RETURN NUMBER IS
v_return NUMBER;
BEGIN
EXECUTE IMMEDIATE 'select '||pi_val||' from dual' INTO v_return;
RETURN v_return;
END;
/
SELECT calc('2*6*10') FROM dual;
*/

create or replace function new_user.calc(pi_val varchar2) return number
is
  v_return number;
begin
  execute immediate  'select '||pi_val||' from dual' INTO v_return;
  return v_return;
end;
/
--grant execute on new_user.calc to tuinstoel;

select new_user.calc('2+3') from dual;

NEW_USER.CALC('2+3')
--------------------
                   5

select *
from 
    (select level transfer,   
    new_user.calc('0' || sys_connect_by_path(distance, '+')) distance,
    sys_connect_by_path(point_A,' -> ') || ' ==> ' || point_B full_path
    from my_table
    where point_B = 'Vinnytsia'
    start with point_A = 'Chernihiv'
    connect by nocycle prior point_B = point_A
    order by distance)
where rownum = 1;	

-- Перевірка:

select level transfer,   
new_user.calc('0' || sys_connect_by_path(distance, '+')) distance,
sys_connect_by_path(point_A,' -> ') || ' ==> ' || point_B full_path
from my_table
where point_B = 'Vinnytsia'
start with point_A = 'Chernihiv'
connect by nocycle prior point_B = point_A
order by distance;	

--Видаліть таблицю.

-- drop table my_table;

--------------------------------------------------------------------------------------
/*
5.1**. Підготовчий етап
Напишіть скрипт для створення таблиць Objects і Object_types.

5.2**. Предметна область 
Опис предметної області: місто, вулиця, будинок, обладнання. 
Дані таблиці Objects описуються деревом: 
 
Дані таблиці Object_types описуються деревом: 
 
Напишіть скрипт для заповнення таблиць Objects і Object_types.
 
5.3**. Завдання  
1. Виведіть назви об'єктів, що належать до типу «Обладнання»; 
2. Виведіть назву типу об'єкта з ім'ям «Будинок»; 
3. Виведіть назви об'єктів, які мають тип, що успадкований від типу «Контейнер»; 
4. Вивести гілку дерева у вигляді: -> Суми -> вул. Супруна -> Будинок 4 -> Кавоварка.
*/
--------------------------------------------------------------------------------------
/*  5.1**. Підготовчий етап
Напишіть скрипт для створення таблиць Objects і Object_types. */


Drop table objects11;
Drop table object_types11;


Create table object_types11 (
	"object_type_id" Number(20) NOT NULL,
	"parent_id" Number(20) default null,
	"name" Varchar2 (20),
primary key ("object_type_id") 
);

Create table objects11 (
	"object_id" Number(20) NOT NULL ,
	"parent_id" Number(20) default null,
	"object_type_id" Number(20) NOT NULL,
	"name" Varchar2 (20),
	"description" Varchar2 (20),
primary key ("object_id") 
);

Alter table objects11 add  foreign key ("parent_id") references objects11("object_id");
Alter table object_types11 add  foreign key ("parent_id") references object_types11 ("object_type_id");
Alter table objects11 add  foreign key ("object_type_id") references object_types11 ("object_type_id");

describe object_types11;
describe objects11;

/* 5.2**. Предметна область 
Опис предметної області: місто, вулиця, будинок, обладнання. 
Дані таблиці Objects описуються деревом: 
 
Дані таблиці Object_types описуються деревом: 
 
Напишіть скрипт для заповнення таблиць Objects і Object_types. */

select * from object_types11;
select * from objects11;

insert into object_types11 values(31, default, 'CONTAINER');
insert into object_types11 values(32, 31, 'HOUSING');
insert into object_types11 values(33, 31, 'EQUIPMENT');

-- delete from object_types11;

select * from object_types11;

object_type_id  parent_id name
-------------- ---------- --------------------
            31 (null)     CONTAINER
            32         31 HOUSING
            33         31 EQUIPMENT


insert into objects11 values(101, default, 32, 'SUMY', 'HOUSING');
insert into objects11 values(100,  101, 31, null,  'CONTAINER');
insert into objects11 values(102,  101, 32, 'SUPRUN STREET', 'HOUSING');
insert into objects11 values(103,  102, 32, 'HOUSE 4', 'HOUSING');
insert into objects11 values(104,  103, 33, 'COFFEE MAKER', 'EQUIPMENT');
insert into objects11 values(105,  103, 33, 'FRIDGE', 'EQUIPMENT');
insert into objects11 values(106,  103, 33, 'TV', 'EQUIPMENT');

-- delete from objects11;

select * from objects11;

 object_id  parent_id object_type_id name                 description
---------- ---------- -------------- -------------------- --------------------
       101 (null)                 32 SUMY                 HOUSING
       100        101             31 (null)               CONTAINER
       102        101             32 SUPRUN STREET        HOUSING
       103        102             32 HOUSE 4              HOUSING
       104        103             33 COFFEE MAKER         EQUIPMENT
       105        103             33 FRIDGE               EQUIPMENT
       106        103             33 TV                   EQUIPMENT

7 rows selected.

--------------------------------------------------------------------------------------

/* 5.3**. Завдання  
1. Виведіть назви об'єктів, що належать до типу «Обладнання»; 
2. Виведіть назву типу об'єкта з ім'ям «Будинок»; 
3. Виведіть назви об'єктів, які мають тип, що успадкований від типу «Контейнер»; 
4. Вивести гілку дерева у вигляді: -> Суми -> вул. Супруна -> Будинок 4 -> Кавоварка.
*/

--------------------------------------------------------------------------------------
-- 1. Виведіть назви об'єктів, що належать до типу «Обладнання»; 

select  obj."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and tp."name" = 'EQUIPMENT';

name
--------------------
COFFEE MAKER
FRIDGE
TV

-- Перевірка:

select "object_id", obj."parent_id", obj."object_type_id", obj."name", "description", tp."object_type_id", tp."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and tp."name" = 'EQUIPMENT';

 object_id  parent_id object_type_id name                 description          object_type_id name
---------- ---------- -------------- -------------------- -------------------- -------------- --------------------
       104        103             33 COFFEE MAKER         EQUIPMENT                        33 EQUIPMENT
       105        103             33 FRIDGE               EQUIPMENT                        33 EQUIPMENT
       106        103             33 TV                   EQUIPMENT                        33 EQUIPMENT

-- 2. Виведіть назву типу об'єкта з ім'ям «Будинок»; 

select  tp."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and obj."name" like 'HOUSE%';

name
--------------------
HOUSING

-- Перевірка:

select "object_id", obj."parent_id", obj."object_type_id", obj."name", "description", tp."object_type_id", tp."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and obj."name" like 'HOUSE%';

 object_id  parent_id object_type_id name                 description          object_type_id name
---------- ---------- -------------- -------------------- -------------------- -------------- --------------------
       103        102             32 HOUSE 4              HOUSING                          32 HOUSING


-- Перевірка:

select "object_id", obj."parent_id", obj."object_type_id", obj."name", "description", tp."object_type_id", tp."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and obj."name" like 'HOUSE%';

 object_id  parent_id object_type_id name                 description          object_type_id name
---------- ---------- -------------- -------------------- -------------------- -------------- --------------------
       103        102             32 HOUSE 4              HOUSING                          32 HOUSING


-- 3. Виведіть назви об'єктів, які мають тип, що успадкований від типу «Контейнер»; 

select obj."name"
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
and level >= 2
start with tp."parent_id" is null
connect by nocycle prior tp."object_type_id" = tp."parent_id"
order by level;

name
--------------------
SUMY
HOUSE 4
FRIDGE
COFFEE MAKER
TV
SUPRUN STREET

6 rows selected.

-- Перевірка:

select level, "object_id", obj."parent_id", obj."object_type_id", obj."name", "description",
              tp."object_type_id", tp."parent_id", tp."name",  SYS_CONNECT_BY_PATH(tp."name", '/') "PATH object_types" 
from object_types11 tp, objects11 obj
where tp."object_type_id" = obj."object_type_id"
start with tp."parent_id" is null
connect by nocycle prior tp."object_type_id" = tp."parent_id"
order by level;

----------------------------------------------------------------------------------------------------------
/*
select level, tp."object_type_id", tp."parent_id", tp."name",  SYS_CONNECT_BY_PATH(tp."name", '/') "PATH" 
from object_types11 tp
start with tp."parent_id" is null
connect by nocycle prior tp."object_type_id" = tp."parent_id"
order by level;

     LEVEL object_type_id  parent_id name
---------- -------------- ---------- --------------------
PATH
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1             31 (null)     CONTAINER
/CONTAINER

         2             33         31 EQUIPMENT
/CONTAINER/EQUIPMENT

         2             32         31 HOUSING
/CONTAINER/HOUSING

select level, "object_id", obj."parent_id", obj."name",  SYS_CONNECT_BY_PATH(obj."name", '/') "PATH" 
from objects11 obj
start with obj."parent_id" is null
connect by nocycle prior "object_id" = obj."parent_id"
order by level;

     LEVEL  object_id  parent_id name
---------- ---------- ---------- --------------------
PATH
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1        101 (null)     SUMY
/SUMY

         2        100        101 (null)
/SUMY/

         2        102        101 SUPRUN STREET
/SUMY/SUPRUN STREET

         3        103        102 HOUSE 4
/SUMY/SUPRUN STREET/HOUSE 4

         4        104        103 COFFEE MAKER
/SUMY/SUPRUN STREET/HOUSE 4/COFFEE MAKER

         4        105        103 FRIDGE
/SUMY/SUPRUN STREET/HOUSE 4/FRIDGE

         4        106        103 TV
/SUMY/SUPRUN STREET/HOUSE 4/TV

7 rows selected.
*/

-- 4. Вивести гілку дерева у вигляді: -> Суми -> вул. Супруна -> Будинок 4 -> Кавоварка.

select SYS_CONNECT_BY_PATH(obj."name", ' -> ') "PATH object name" 
from objects11 obj
where obj."name" = 'COFFEE MAKER'
start with obj."parent_id" is null
connect by nocycle prior obj."object_id" = obj."parent_id"
order by level;

PATH object name
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -> SUMY -> SUPRUN STREET -> HOUSE 4 -> COFFEE MAKER

-- Перевірка:

select level, "object_id", obj."parent_id", obj."object_type_id", obj."name", "description",
              SYS_CONNECT_BY_PATH(obj."name", ' -> ') "PATH object" 
from objects11 obj
start with obj."parent_id" is null
connect by nocycle prior obj."object_id" = obj."parent_id"
order by level;

     LEVEL  object_id  parent_id object_type_id name                 description
---------- ---------- ---------- -------------- -------------------- --------------------
PATH object
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1        101 (null)                 32 SUMY                 HOUSING
 -> SUMY

         2        100        101             31 (null)               CONTAINER
 -> SUMY ->

         2        102        101             32 SUPRUN STREET        HOUSING
 -> SUMY -> SUPRUN STREET

         3        103        102             32 HOUSE 4              HOUSING
 -> SUMY -> SUPRUN STREET -> HOUSE 4

         4        104        103             33 COFFEE MAKER         EQUIPMENT
 -> SUMY -> SUPRUN STREET -> HOUSE 4 -> COFFEE MAKER

         4        105        103             33 FRIDGE               EQUIPMENT
 -> SUMY -> SUPRUN STREET -> HOUSE 4 -> FRIDGE

         4        106        103             33 TV                   EQUIPMENT
 -> SUMY -> SUPRUN STREET -> HOUSE 4 -> TV


7 rows selected.


Drop table objects11;
Drop table object_types11;

-----------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
/*
Завдання додаткове:
Створіть тригер, який при додаванні нового працівника додає 100 до премії його начальника.
І потім виведіть весь ланцюжок підпорядкування від Кінга до цього нового працівника.
*/

drop table My_emp;

create table My_emp as
select * from emp;

update My_emp
set comm = 0
where comm is null;

select * from My_emp;

drop trigger trig_dop_task1;

create or replace trigger trig_dop_task1
 before insert on My_emp
 referencing old as oldRow new as newRow
 for each row
 begin 
 update My_emp
 set comm = comm + 100
 where empno = :newRow.mgr;
 end;
/

INSERT INTO My_emp VALUES (1001,'Damon','ANALYST', 7839, TO_DATE('2012-10-19', 'YYYY-MM-DD'), 2000, 0, 10);

select * from My_emp;

INSERT INTO My_emp VALUES (1002,'Alaric','MANAGER', 7499, TO_DATE('2012-06-24', 'YYYY-MM-DD'), 3000, 0, 20);

select * from My_emp;

select ename, SYS_CONNECT_BY_PATH(ename, '/') "PATH" 
from My_emp
where ename = 'Damon'
start with mgr is null
connect by nocycle prior empno = mgr
order by level;


select ename, SYS_CONNECT_BY_PATH(ename, '/') "PATH" 
from My_emp
where ename = 'Alaric'
start with mgr is null
connect by nocycle prior empno = mgr
order by level;

------------------------------------------------------------------------------------------------------