--------------------------------------------------------------------------------------
/* Пороскун О. ПМ-81   Практична робота 13  БД*/
--------------------------------------------------------------------------------------

/* 1. Призначення прав 
1. Створіть таблицю My_emp на основі таблиці Emp. 
2. Перевірте, якими правами ви володієте, і до яких об'єктів у вас є доступ. 
3. Створіть користувача New_User. 
4. Передайте користувачу New_User права на читання з таблиці My_emp. 
5. Від імені користувача New_User спробуйте читати і видаляти з таблиці My_emp. */

/*
-- З лаб. 6 для сравнения
drop table My_emp1;
drop table My_emp2;

-- такая же таблица со строками в ней
create table My_emp1 as
select * from emp;

-- такая же таблице только одинаков. поля, значений нет
create table My_emp2 as
select * from emp
where 1 = 2;

describe My_emp1;
=
describe My_emp2;

 Name                                                    Null?    Type
 ------------------------------------------------------ -------- ----------------
 EMPNO                                                   NOT NULL NUMBER(4)
 ENAME                                                            VARCHAR2(20)
 JOB                                                              VARCHAR2(9)
 MGR                                                              NUMBER(4)
 HIREDATE                                                         DATE
 SAL                                                              NUMBER(7,2)
 COMM                                                             NUMBER(7,2)
 DEPTNO                                                           NUMBER(2)


select * from My_emp1;

     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING                 PRESIDENT (null)     17-NOV-11       5000 (null)             10
      ...  ...                  ...             ...  ...             ...   ...              ...
	  
18 rows selected.

select * from My_emp2;

SQL> select * from My_emp2;

no rows selected
*/

--------------------------------------------------------------------------------------
-- 1. Створіть таблицю My_emp на основі таблиці Emp. 

drop table My_emp;

create table My_emp as
select * from emp;

select * from My_emp;

     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING                 PRESIDENT (null)     17-NOV-11       5000 (null)             10
      ...  ...                  ...             ...  ...             ...   ...              ...

18 rows selected.

--------------------------------------------------------------------------------------
-- 2. Перевірте, якими правами ви володієте, і до яких об'єктів у вас є доступ. 

/* Як перевірити дозволи
Представлення Опис
ROLE_SYS_PRIVS Системні дозволи передані ролі
ROLE_TAB_PRIVS Дозволи на рівні таблиць, передані ролі
USER_ROLE_PRIVS Яким ролям належить користувач
-- USER_SYS_PRIVS Системні дозволи передані користувачу
-- USER_TAB_PRIVS_MADE Об'єктні дозволи на об'єкти користувача
USER_TAB_PRIVS_RECD Об'єктні дозволи на користувача
USER_COL_PRIVS_MADE Об'єктні дозволи на стовпці об'єктів користувача
USER_COL_PRIVS_RECD Об'єктні дозволи на стовпці для користувача
*/

-- select * from ROLE_TAB_PRIVS;
-- 5076 rows selected.

show user;

USER is "STUDENT_PM81_09"

select * from USER_SYS_PRIVS;

USERNAME                                                                                                                         PRIVILEGE                                ADM COM INH
-------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------- --- --- ---
STUDENT_PM81_09                                                                                                                  UNLIMITED TABLESPACE                     NO  NO  NO

select * from USER_TAB_PRIVS_MADE;

GRANTEE
--------------------------------------------------------------------------------------------------------------------------------
TABLE_NAME
--------------------------------------------------------------------------------------------------------------------------------
GRANTOR                                                                                                                          PRIVILEGE                                GRA HIE COM
-------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------- --- --- ---
TYPE                     INH
------------------------ ---
PUBLIC
STUDENT_PM81_09
STUDENT_PM81_09                                                                                                                  INHERIT PRIVILEGES                       NO  NO  NO
USER                     NO


-- select * from My_emp;

--------------------------------------------------------------------------------------
-- 3. Створіть користувача New_User. 
/*
Створення користувача
DBA може створити нового користувача за допомогою команди CREATE USER

CREATE USER user
IDENTIFIED BY password;

CREATE USER demo
IDENTIFIED BY demo;
*/

--drop user New_User11;

create user New_User11
identified by New12345;

grant create session to New_User11;

--------------------------------------------------------------------------------------
-- 4. Передайте користувачу New_User права на читання з таблиці My_emp.

grant select
on student_pm81_09.My_emp
to New_User11;

Grant succeeded.

--------------------------------------------------------------------------------------
-- 5. Від імені користувача New_User спробуйте читати і видаляти з таблиці My_emp.

client\sqlplus.exe New_User11/New12345@195.182.202.156:15215/XEPDB1 @startup

show user;

USER is "New_User11"

select * from student_pm81_09.My_emp;

18 rows selected.

delete 
from student_pm81_09.My_emp
where empno = 8000;

from student_pm81_09.My_emp
                     *
ERROR at line 2:
ORA-01031: insufficient privileges

------------------------------------------------------------------------------------------------
/*
2. Делегування привілеїв 
1. Створіть користувача New_User2. 
2. Надайте користувачу New_User права на видалення з таблиці My_emp з можливістю передачі прав. 
3. Зайдіть від імені користувача New_User і передайте права на видалення користувачу New_User2. 
4. Від імені користувача Student відкличте права на видалення у користувача New_User. 
5. Перегляньте права користувача New_User2.
*/
--------------------------------------------------------------------------------------
-- 1. Створіть користувача New_User2.

show user;
USER is "STUDENT_PM81_09"

-- drop user New_User22;

create user New_User22
identified by New54321;

grant create session to New_User22;

-- 2. Надайте користувачу New_User права на видалення з таблиці My_emp з можливістю передачі прав.

grant delete
on student_pm81_09.My_emp
to New_User11
with grant option;

-- 3. Зайдіть від імені користувача New_User і передайте права на видалення користувачу New_User2.

show user;
USER is "NEW_USER11"

grant delete
on student_pm81_09.My_emp
to New_User22;


-- 4. Від імені користувача Student відкличте права на видалення у користувача New_User. 

show user;
USER is "STUDENT_PM81_09"

revoke delete
on student_pm81_09.My_emp
from New_User11;

Revoke succeeded.

-- 5. Перегляньте права користувача New_User2.

client\sqlplus.exe New_User22/New54321@195.182.202.156:15215/XEPDB1 @startup

show user;
USER is "New_User22"

select * from USER_SYS_PRIVS;
select * from USER_TAB_PRIVS_MADE;

-----------------------------------------------------------------------------------------------------
/*  3. Ролі  
>	Від імені Student створіть роль ROLE1 і ROLE2 з будьякими привілеями.  
>	Спробуйте призначити користувачу New_User роль ROLE1, а користувачу New_User2 ролі ROLE1 і ROLE2.  
>	Відкличте у користувача New_User2 роль ROLE2.
>	Спробуйте призначити користувачу New_User роль ROLE1.  
>	Спробуйте призначити ролі ROLE1 роль ROLE2.  
>	Спробуйте призначити ролі ROLE1 роль ROLE1. */
------------------------------------------------------------------------------------------------------
-- >	Від імені Student створіть роль ROLE1 і ROLE2 з будьякими привілеями. 
 
/*
Використання ролей
Створення ролі:
CREATE ROLE manager;

Надання дозволу ролі:
GRANT create table, create view
TO manager;

Зв'язування ролі і користувача;
GRANT manager TO BELL, KOCHHAR;
*/

--drop role ROLE1;
--drop role ROLE2;

create role ROLE1;
create role ROLE2;

grant select, insert
on My_emp
to ROLE1;

grant select, delete
on My_emp
to ROLE2;

/*
grant create session,
      create table
to ROLE1;

grant create session,
	  create view
to ROLE2;
*/

-- >	Спробуйте призначити користувачу New_User роль ROLE1, а користувачу New_User2 ролі ROLE1 і ROLE2. 

--GRANT manager TO BELL, KOCHHAR;

grant ROLE1 to New_User11, New_User22;
grant ROLE2 to New_User22;

-- >	Відкличте у користувача New_User2 роль ROLE2.
/*
REVOKE {privilege [, privilege...]|ALL}
ON object
FROM {user[, user...]|role|PUBLIC}
[CASCADE CONSTRAINTS];
*/

revoke ROLE2 from New_User22;

-- >	Спробуйте призначити користувачу New_User роль ROLE1. 

grant ROLE1 to New_User11;
 
-- >	Спробуйте призначити ролі ROLE1 роль ROLE2.

grant ROLE2 to ROLE1;

-- >	Спробуйте призначити ролі ROLE1 роль ROLE1.

grant ROLE1 to ROLE1;

------------------------------------------------------------------------------------------------
/*4. Зачищення території
>	Видаліть таблицю My_emp.
>	Видаліть ролі ROLE1 і ROLE2.
>	Видаліть користувачів New_User і New_User2. */

drop table My_emp;
drop role ROLE1;
drop role ROLE2;
drop user New_User11;
drop user New_User22;
------------------------------------------------------------------------------------------------ 
/*5. Транзакції 
1. Створіть таблицю My_emp із таблиці Emp, скопіюйте в неї всі дані з таблиці Emp. 
2. Видаліть з таблиці 2 будь-які рядки. 
3. Відкотіться до початкового стану і перевірте чи повернулися зміни. 
4. Створіть мітку «START_POINT». 
5. Додайте в таблицю 1 рядок. 
6. Додайте в таблицю індекс по стовпцю mgr. 
7. Чи можливий відкат до мітки START_POINT? перевірте. */

-- 1. Створіть таблицю My_emp із таблиці Emp, скопіюйте в неї всі дані з таблиці Emp. 

drop table My_emp;

create table My_emp as
select * from emp;

select * from My_emp;

18 rows selected.

-- 2. Видаліть з таблиці 2 будь-які рядки. 

delete from My_emp
where ename in ('JET LI', 'BRUCE LEE');

select * from My_emp;

16 rows selected.

-- 3. Відкотіться до початкового стану і перевірте чи повернулися зміни. 

ROLLBACK;

select * from My_emp;

18 rows selected.

-- 4. Створіть мітку «START_POINT». 

SAVEPOINT START_POINT;

-- 5. Додайте в таблицю 1 рядок. 

INSERT INTO My_emp VALUES (1001,'Damon','ANALYST', 7839, TO_DATE('2012-10-19', 'YYYY-MM-DD'), 2000, 0, 10);

select * from My_emp;

19 rows selected.

-- 6. Додайте в таблицю індекс по стовпцю mgr. 

CREATE INDEX My_emp_index
on My_emp(mgr);


-- 7. Чи можливий відкат до мітки START_POINT? перевірте.

ROLLBACK TO START_POINT;

SQL> ROLLBACK TO START_POINT;
ROLLBACK TO START_POINT
*
ERROR at line 1:
ORA-01086: savepoint 'START_POINT' never established in this session or is invalid


------------------------------------------------------------------------------------------------
/*6. Завдання. Відкат до мітки 
1. Створіть мітку «START_POINT1». 
2. Додайте до таблиці 1 рядок.
3. Створіть мітку «START_POINT2». 
4. Додайте до таблиці 1 рядок. 
5. Створіть мітку «START_POINT3». 
6. Видаліть з таблиці 3 рядки. 
7. Зробіть відкат до мітки START_POINT2. Перевірте. 
8. Зробіть відкат до мітки START_POINT1. Перевірте. 
9. Видаліть з таблиці 3 рядки. 
10. Створіть мітку«START_POINT4». 
11. Додайте до таблиці 1 рядок. 
12. Застосуйте зміни. 
13. Чи можливий відкат до мітки START_POINT4? Перевірте. */
------------------------------------------------------------------------------------------------

-- 1. Створіть мітку «START_POINT1». 

SAVEPOINT START_POINT1;

Savepoint created.

select * from My_emp;

-- 2. Додайте до таблиці 1 рядок.

INSERT INTO My_emp VALUES (1002,'Alaric','MANAGER', 7499, TO_DATE('2012-06-24', 'YYYY-MM-DD'), 3000, 0, 20);

select * from My_emp;

-- 3. Створіть мітку «START_POINT2».

SAVEPOINT START_POINT2;

Savepoint created.
 
-- 4. Додайте до таблиці 1 рядок. 

INSERT INTO My_emp VALUES (1003,'Matt','CLERK', 1002, TO_DATE('2013-08-12', 'YYYY-MM-DD'), 780, 0, 20);

select * from My_emp;

21 rows selected.

-- 5. Створіть мітку «START_POINT3». 

SAVEPOINT START_POINT3;

-- 6. Видаліть з таблиці 3 рядки. 

delete from My_emp
where empno in (1001, 1002, 1003);

select * from My_emp;

-- 7. Зробіть відкат до мітки START_POINT2. Перевірте. 

ROLLBACK TO START_POINT2;

select * from My_emp;

      8002 BRUCE LEE            SALESMAN        8000 08-SEP-11       2500 (null)             60
      8003 DR NO                ANALYST         7839 11-SEP-11       2500 (null)     (null)
      1001 Damon                ANALYST         7839 19-OCT-12       2000          0         10
      1002 Alaric               MANAGER         7499 24-JUN-12       3000          0         20

20 rows selected.

-- 8. Зробіть відкат до мітки START_POINT1. Перевірте. 

ROLLBACK TO START_POINT1;

select * from My_emp;

      8002 BRUCE LEE            SALESMAN        8000 08-SEP-11       2500 (null)             60
      8003 DR NO                ANALYST         7839 11-SEP-11       2500 (null)     (null)
      1001 Damon                ANALYST         7839 19-OCT-12       2000          0         10

19 rows selected.

-- 9. Видаліть з таблиці 3 рядки.

delete from My_emp
where empno in (1001, 8001, 8002);

select * from My_emp;

      7788 SCOTT                ANALYST         7566 09-DEC-12       3000 (null)             20
      7876 ADAMS                CLERK           7788 12-JAN-13       1100 (null)             20
      7934 MILLER               CLERK           7782 23-JAN-12       1300 (null)             10
      8000 JACKIE CHAN          SALESMAN        7839 28-SEP-11       2250       1700         60
      8003 DR NO                ANALYST         7839 11-SEP-11       2500 (null)     (null)

16 rows selected.
 
-- 10. Створіть мітку«START_POINT4». 

SAVEPOINT START_POINT4;

-- 11. Додайте до таблиці 1 рядок. 

INSERT INTO My_emp VALUES (1004,'Tyler','CLERK', 8003, TO_DATE('2013-09-27', 'YYYY-MM-DD'), 640, 0, 20);

select * from My_emp;

-- 12. Застосуйте зміни. 

commit;

-- 13. Чи можливий відкат до мітки START_POINT4? Перевірте.

ROLLBACK TO START_POINT4;

select * from My_emp;

     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING                 PRESIDENT (null)     17-NOV-11       5000 (null)             10
      7698 BLAKE                MANAGER         7839 01-MAY-11       2850 (null)             30
      7782 CLARK                MANAGER         7839 09-JUN-11       1500 (null)             10
      7566 JONES                MANAGER         7839 02-APR-11       2975 (null)             20
      7654 MARTIN               SALESMAN        7698 28-SEP-11       1250       1400         30
      7499 ALLEN                SALESMAN        7698 20-FEB-11       1600        300         30
      7844 TURNER               SALESMAN        7698 08-SEP-11       1500          0         30
      7900 JAMES                CLERK           7698 03-DEC-11        950 (null)             30
      7521 WARD                 SALESMAN        7698 22-FEB-11       1250        500         30
      7902 FORD                 ANALYST         7566 03-DEC-11       3000 (null)             20
      7369 SMITH                CLERK           7902 17-DEC-10        800 (null)             20
      7788 SCOTT                ANALYST         7566 09-DEC-12       3000 (null)             20
      7876 ADAMS                CLERK           7788 12-JAN-13       1100 (null)             20
      7934 MILLER               CLERK           7782 23-JAN-12       1300 (null)             10
      8000 JACKIE CHAN          SALESMAN        7839 28-SEP-11       2250       1700         60
      8003 DR NO                ANALYST         7839 11-SEP-11       2500 (null)     (null)

16 rows selected.

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
/*
Завдання додаткове:


*/




