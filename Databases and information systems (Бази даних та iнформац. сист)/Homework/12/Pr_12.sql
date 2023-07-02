--------------------------------------------------------------------------------------
/* Пороскун О. ПМ-81   Практична робота 12  БД*/
--------------------------------------------------------------------------------------
/*
-- Приклад 4

drop table t4;
drop table t5;

-- Приклад базується на таблицях:
CREATE TABLE T4 (a INTEGER, b CHAR(10));
CREATE TABLE T5 (c CHAR(10), d INTEGER);

-- значенние внесенне в таблицу до того как обьявлен ТРИГЕР не заносятся потом в табл. Т5 (потому что AFTER в ТРИГЕРЕ)
insert into t4 values(5, 'five');
insert into t4 values(6, 'six');
insert into t4 values(7, 'seven');
insert into t4 values(11, 'eleven');
insert into t4 values(20, 'twenty');
insert into t4 values(30, 'thirty');

select * from t4;

         A B
---------- ----------
         5 five
         6 six
         7 seven
        11 eleven
        20 twenty
        30 thirty

6 rows selected.

-- Тригер вставляє в таблицю T5 рядки,
-- які вставляє користувач у T4 і які
-- відповідають певній умові:
CREATE TRIGGER trig1
 AFTER INSERT ON T4
 REFERENCING NEW AS newRow
 FOR EACH ROW
 WHEN (newRow.a <= 10)
 BEGIN
 INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
 END;
/

Trigger created.

select * from t5;

no rows selected


-- заносяться после обьявления ТРИГЕРА

insert into t4 values(1, 'one');
insert into t4 values(2, 'two');
insert into t4 values(3, 'three');
insert into t4 values(10, 'ten');
insert into t4 values(21, 'twenty one');
insert into t4 values(31, 'thirty one');

select * from t4;

         A B
---------- ----------
         5 five
         6 six
         7 seven
        11 eleven
        20 twenty
        30 thirty
         1 one
         2 two
         3 three
        10 ten
        21 twenty one
        31 thirty one

12 rows selected.

select * from t5;

C                   D
---------- ----------
one                 1
two                 2
three               3
ten                10 
*/
--------------------------------------------------------------------------------------

/* Завдання 
1. Створіть тригер, який відстежує зміну зарплати користувача і заносить в таблицю звітності */

drop table emp11;
drop table emp22;

create table emp11(name char(10), salary integer);
create table emp22(name char(10), old_salary integer, new_salary integer);

insert into emp11 values('Damon',  9800);
insert into emp11 values('Stafan', 5400);
insert into emp11 values('Alaric', 3700);
insert into emp11 values('Matt',   1300);
insert into emp11 values('Tyler',   900);
insert into emp11 values('Jeremy',  750);

select * from emp11;

NAME           SALARY
---------- ----------
Damon            9800
Stafan           5400
Alaric           3700
Matt             1300
Tyler             900
Jeremy            750

6 rows selected.


create or replace trigger trig_task1
 after update of salary on emp11
 referencing old as oldRow new as newRow
 for each row
 when (newRow.salary != oldRow.salary)
 begin 
 insert into emp22 values(:oldRow.name, :oldRow.salary, :newRow.salary);
 end;
/

Trigger created.

select * from emp22;

no rows selected


update emp11
set salary = salary + 200;

select * from emp11;

NAME           SALARY
---------- ----------
Damon           10000
Stafan           5600
Alaric           3900
Matt             1500
Tyler            1100
Jeremy            950

6 rows selected.


select * from emp22;

NAME       OLD_SALARY NEW_SALARY
---------- ---------- ----------
Damon            9800      10000
Stafan           5400       5600
Alaric           3700       3900
Matt             1300       1500
Tyler             900       1100
Jeremy            750        950

6 rows selected.


update emp11
set salary = salary * 2
where name in ('Damon', 'Stafan', 'Alaric');

select * from emp11;

NAME           SALARY
---------- ----------
Damon           20000
Stafan          11200
Alaric           7800
Matt             1500
Tyler            1100
Jeremy            950

6 rows selected.

select * from emp22;

NAME       OLD_SALARY NEW_SALARY
---------- ---------- ----------
Damon            9800      10000
Stafan           5400       5600
Alaric           3700       3900
Matt             1300       1500
Tyler             900       1100
Jeremy            750        950
Damon           10000      20000
Stafan           5600      11200
Alaric           3900       7800

9 rows selected.

drop table emp11;
drop table emp22;

--------------------------------------------------------------------------------------

/*
2. * Створіть тригер, який відстежує зміну посади користувача і записує її в журнал. Журнал зберігає стару і нову посаду і час зміни. 
У разі видалення користувача він вважається звільненим, про що заноситься запис в журнал. 
У разі додавання користувача він вважається прийнятим на роботу, про що заноситься запис у журнал.
*/

--drop table emp2;
--drop table register;

create table emp2(name char(10), job char(10));
create table register(name char(10), old_job char(10), new_job char(10), time_of_change date);


/*
--когда увольняют
old_job = 'job'
new_job = 'уволен'
--когда берут 
old_job = 'принят'
new_job = 'job'
*/

create or replace trigger trig_task2
after insert or update or delete on emp2
referencing old as oldRow new as newRow
for each row
begin 
 if inserting then 
 insert into register values(:newRow.name,     'HIRED', :newRow.job, sysdate);
 elsif updating then 
 insert into register values(:oldRow.name, :oldRow.job, :newRow.job, sysdate);
 elsif deleting then 
 insert into register values(:oldRow.name, :oldRow.job, 'DISMISSED', sysdate);
end if;
end;
/

Trigger created.



insert into emp2 values('Damon',  'MANAGER');
insert into emp2 values('Stafan', 'MANAGER');
insert into emp2 values('Alaric', 'SALESMAN');
insert into emp2 values('Matt',   'CLARK');
insert into emp2 values('Tyler',  'ANALYST');
insert into emp2 values('Jeremy', 'ANALYST');

-- delete from emp2;
-- delete from register;

select * from emp2;

NAME       JOB
---------- ----------
Damon      MANAGER
Stafan     MANAGER
Alaric     SALESMAN
Matt       CLARK
Tyler      ANALYST
Jeremy     ANALYST

6 rows selected.

/*
select name, old_job, new_job, lpad(to_char(time_of_change, 'HH24:MI:SS AM'), 11) as time_of_change 
from register;
*/

select name, old_job, new_job, to_char(time_of_change, 'HH24:MI:SS AM') as time
from register;

NAME       OLD_JOB    NEW_JOB    TIME
---------- ---------- ---------- -----------
Damon      HIRED      MANAGER    20:56:58 PM
Stafan     HIRED      MANAGER    20:56:58 PM
Alaric     HIRED      SALESMAN   20:56:58 PM
Matt       HIRED      CLARK      20:56:58 PM
Tyler      HIRED      ANALYST    20:56:58 PM
Jeremy     HIRED      ANALYST    20:57:00 PM

6 rows selected.


update emp2
set job = 'PRESIDENT'
where name = 'Damon';

update emp2
set job = 'SALESMAN'
where name = 'Jeremy';

update emp2
set job = 'MANAGER'
where name = 'Alaric';

select * from emp2;

NAME       JOB
---------- ----------
Damon      PRESIDENT
Stafan     MANAGER
Alaric     MANAGER
Matt       CLARK
Tyler      ANALYST
Jeremy     SALESMAN

6 rows selected.


select name, old_job, new_job, to_char(time_of_change, 'HH24:MI:SS AM') as time
from register;

NAME       OLD_JOB    NEW_JOB    TIME
---------- ---------- ---------- -----------
Damon      HIRED      MANAGER    20:56:58 PM
Stafan     HIRED      MANAGER    20:56:58 PM
Alaric     HIRED      SALESMAN   20:56:58 PM
Matt       HIRED      CLARK      20:56:58 PM
Tyler      HIRED      ANALYST    20:56:58 PM
Jeremy     HIRED      ANALYST    20:57:00 PM
Damon      MANAGER    PRESIDENT  20:58:48 PM
Jeremy     ANALYST    SALESMAN   21:01:07 PM
Alaric     SALESMAN   MANAGER    21:01:25 PM

9 rows selected.


delete from emp2
where job in ('CLARK', 'ANALYST');

delete from emp2
where job in ('PRESIDENT');

insert into emp2 values('Klaus', 'PRESIDENT');


select * from emp2;

NAME       JOB
---------- ----------
Stafan     MANAGER
Alaric     MANAGER
Jeremy     SALESMAN
Klaus      PRESIDENT


select name, old_job, new_job, to_char(time_of_change, 'HH24:MI:SS AM') as time
from register;

NAME       OLD_JOB    NEW_JOB    TIME
---------- ---------- ---------- -----------
Damon      HIRED      MANAGER    20:56:58 PM
Stafan     HIRED      MANAGER    20:56:58 PM
Alaric     HIRED      SALESMAN   20:56:58 PM
Matt       HIRED      CLARK      20:56:58 PM
Tyler      HIRED      ANALYST    20:56:58 PM
Jeremy     HIRED      ANALYST    20:57:00 PM
Damon      MANAGER    PRESIDENT  20:58:48 PM
Jeremy     ANALYST    SALESMAN   21:01:07 PM
Alaric     SALESMAN   MANAGER    21:01:25 PM
Matt       CLARK      DISMISSED  21:05:15 PM
Tyler      ANALYST    DISMISSED  21:05:15 PM
Damon      PRESIDENT  DISMISSED  21:07:36 PM
Klaus      HIRED      PRESIDENT  21:07:42 PM

13 rows selected.


drop table emp2;
drop table register;

--------------------------------------------------------------------------------------

/*
3. *Візьміть з тексту лекції приклад тригера реалізації каскадного видалення. 
Реалізуйте тригер, що видаляє всіх співробітників, які працюють у відділі, при видаленні відділу. 
*/

drop table emp3;
drop table dept3;


CREATE TABLE dept3(  -- описание подразделения
   deptno NUMBER(3) NOT NULL,  -- № подразделения
   dname VARCHAR(14) NOT NULL,  -- название подразделения
   loc VARCHAR(13), -- местоположение подразделения
   CONSTRAINT dept_pk3 PRIMARY KEY (deptno),
   CONSTRAINT dept_naem_uk3 UNIQUE (dname)
);

CREATE TABLE emp3 ( -- описание сотрудников подразделений
  empno NUMBER(4) NOT NULL, -- № сотрудника
  ename VARCHAR(20), -- имя сотрудника
  job VARCHAR(9), -- должность сотрудника
  sal NUMBER(7, 2), -- з/п сотрудника
  deptno NUMBER(2),  -- № подразделения, где работает сотрудник
  CONSTRAINT emp_pk3 PRIMARY KEY (empno),
  CONSTRAINT emp_deptno_fk3 FOREIGN KEY (deptno) REFERENCES dept3 (deptno)
);

commit;


INSERT INTO dept3 VALUES (10,'ACCOUNTING','NEW_YORK');
INSERT INTO dept3 VALUES (20,  'RESEARCH',  'DALLAS');
INSERT INTO dept3 VALUES (30,     'SALES', 'CHICAGO');
INSERT INTO dept3 VALUES (40,'OPERATIONS',  'BOSTON');
INSERT INTO dept3 VALUES (50, 'RESEARCH2', 'HONKONG');

select * from dept3;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW_YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON
        50 RESEARCH2      HONKONG

INSERT INTO emp3 VALUES (7839,  'KING','PRESIDENT', 5000, 10);
INSERT INTO emp3 VALUES (7698, 'BLAKE',  'MANAGER', 2850, 20);
INSERT INTO emp3 VALUES (7782, 'CLARK',  'MANAGER', 1500, 30);
INSERT INTO emp3 VALUES (7566, 'JONES', 'SALESMAN', 1250, 40);
INSERT INTO emp3 VALUES (7654,'MARTIN', 'SALESMAN', 2250, 50);
INSERT INTO emp3 VALUES (7499, 'ALLEN', 'SALESMAN', 1600, 10); 
INSERT INTO emp3 VALUES (7844,'TURNER', 'SALESMAN', 1500, 20);


select * from emp3;

     EMPNO ENAME                JOB              SAL     DEPTNO
---------- -------------------- --------- ---------- ----------
      7839 KING                 PRESIDENT       5000         10
      7698 BLAKE                MANAGER         2850         20
      7782 CLARK                MANAGER         1500         30
      7566 JONES                SALESMAN        1250         40
      7654 MARTIN               SALESMAN        2250         50
      7499 ALLEN                SALESMAN        1600         10
      7844 TURNER               SALESMAN        1500         20

7 rows selected.

commit;

------------------
-- delete from dept3;
-- delete from ept3;
------------------


create or replace trigger trig_task3
after delete on dept3
referencing old as oldRow new as newRow
for each row
begin 
 delete from emp3
 where emp3.deptno = :oldRow.deptno;
end;
/



delete from dept3
where loc in ('NEW_YORK', 'CHICAGO');


select * from dept3;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        20 RESEARCH       DALLAS
        40 OPERATIONS     BOSTON
        50 RESEARCH2      HONKONG

select * from emp3;

     EMPNO ENAME                JOB              SAL     DEPTNO
---------- -------------------- --------- ---------- ----------
      7698 BLAKE                MANAGER         2850         20
      7566 JONES                SALESMAN        1250         40
      7654 MARTIN               SALESMAN        2250         50
      7844 TURNER               SALESMAN        1500         20


delete from dept3
where loc in ('BOSTON');


select * from dept3;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        20 RESEARCH       DALLAS
        50 RESEARCH2      HONKONG


select * from emp3;

     EMPNO ENAME                JOB              SAL     DEPTNO
---------- -------------------- --------- ---------- ----------
      7698 BLAKE                MANAGER         2850         20
      7654 MARTIN               SALESMAN        2250         50
      7844 TURNER               SALESMAN        1500         20



drop table emp3;
drop table dept3;

--------------------------------------------------------------------------------------

/*  4. * Перевірте, що при цьому спрацьовує тригер із завдання 2.  */

select * from dept3;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        20 RESEARCH       DALLAS
        50 RESEARCH2      HONKONG


select * from emp3;

     EMPNO ENAME                JOB              SAL     DEPTNO
---------- -------------------- --------- ---------- ----------
      7698 BLAKE                MANAGER         2850         20
      7654 MARTIN               SALESMAN        2250         50
      7844 TURNER               SALESMAN        1500         20

--drop table register2;

create table register2(ename char(10), old_job char(10), new_job char(10), time_of_change date);

create or replace trigger trig_task2_4
after insert or update or delete on emp3
referencing old as oldRow new as newRow
for each row
begin 
 if inserting then 
  insert into register2 values(:newRow.ename,     'HIRED', :newRow.job, sysdate);
 elsif updating then 
  insert into register2 values(:oldRow.ename, :oldRow.job, :newRow.job, sysdate);
 elsif deleting then 
  insert into register2 values(:oldRow.ename, :oldRow.job, 'DISMISSED', sysdate);
 end if;
end;
/


delete from dept3
where loc in ('DALLAS');

select * from dept3;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        50 RESEARCH2      HONKONG
		
		
select * from emp3;


     EMPNO ENAME                JOB              SAL     DEPTNO
---------- -------------------- --------- ---------- ----------
      7654 MARTIN               SALESMAN        2250         50


select ename, old_job, new_job, to_char(time_of_change, 'HH24:MI:SS AM') as time
from register2;

ENAME      OLD_JOB    NEW_JOB    TIME
---------- ---------- ---------- -----------
BLAKE      MANAGER    DISMISSED  23:40:10 PM
TURNER     SALESMAN   DISMISSED  23:40:10 PM


drop table emp3;
drop table dept3;
drop table register2;


-------------------------------------------------------------------------------------------------

/*
Приклад 3 с CASCADE UPDATE
При оновленні стовпця deptno таблиці dept каскадно оновлюється
стовпець deptno в таблиці emp
*/

/*
drop table Emp11;
drop table Dept11;


CREATE TABLE Dept11(  -- описание подразделения
   deptno NUMBER(3) NOT NULL,  -- № подразделения
   dname VARCHAR(14) NOT NULL,  -- название подразделения
   loc VARCHAR(13), -- местоположение подразделения
   CONSTRAINT dept_pk11 PRIMARY KEY (deptno),
   CONSTRAINT dept_naem_uk11 UNIQUE (dname)
);

CREATE TABLE Emp11 ( -- описание сотрудников подразделений
  empno NUMBER(4) NOT NULL, -- № сотрудника
  ename VARCHAR(20), -- имя сотрудника
  job VARCHAR(9), -- должность сотрудника
  mgr NUMBER(4), -- № начальника сотрудника
  hiredate DATE, -- дата приема на работу сотрудника 
  sal NUMBER(7, 2), -- з/п сотрудника
  comm NUMBER(7, 2), -- премия сотрудника
  deptno NUMBER(2),  -- № подразделения, где работает сотрудник
  CONSTRAINT emp_pk11 PRIMARY KEY (empno),
  CONSTRAINT emp_deptno_fk11 FOREIGN KEY (deptno) REFERENCES Dept11 (deptno)
);


ALTER TABLE Emp11 ADD CONSTRAINT fk_Self11 FOREIGN KEY (mgr) REFERENCES Emp11 (empno) ON DELETE CASCADE;

commit;

INSERT INTO Dept11  VALUES (10,'ACCOUNTING','NEW_YORK');
INSERT INTO Dept11 VALUES (20,'RESEARCH','DALLAS');
INSERT INTO Dept11 VALUES (30,'SALES','CHICAGO');
INSERT INTO Dept11 VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO Dept11 VALUES (50,'RESEARCH2','HONKONG');

select * from Dept11;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW_YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON
        50 RESEARCH2      HONKONG

INSERT INTO Emp11 VALUES (7839,'KING','PRESIDENT',null, TO_DATE('2011-11-17', 'YYYY-MM-DD'),5000,null,10);
INSERT INTO Emp11 VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('2011-05-01', 'YYYY-MM-DD'), 2850,null,20);
INSERT INTO Emp11 VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('2011-06-09', 'YYYY-MM-DD'), 1500,null,30);
INSERT INTO Emp11 VALUES (7566,'JONES','MANAGER',7839,TO_DATE('2011-04-02', 'YYYY-MM-DD'), 2975,null,40);
INSERT INTO Emp11 VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('2011-09-28', 'YYYY-MM-DD'), 1250,1400,50);
INSERT INTO Emp11 VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('2011-02-20', 'YYYY-MM-DD'), 1600,300,10);
INSERT INTO Emp11 VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('2011-09-08', 'YYYY-MM-DD'), 1500,0,20);

select * from Emp11;


     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING                 PRESIDENT (null)     17-NOV-11       5000 (null)             10
      7698 BLAKE                MANAGER         7839 01-MAY-11       2850 (null)             20
      7782 CLARK                MANAGER         7839 09-JUN-11       1500 (null)             30
      7566 JONES                MANAGER         7839 02-APR-11       2975 (null)             40
      7654 MARTIN               SALESMAN        7698 28-SEP-11       1250       1400         50
      7499 ALLEN                SALESMAN        7698 20-FEB-11       1600        300         10
      7844 TURNER               SALESMAN        7698 08-SEP-11       1500          0         20

7 rows selected.

commit;

CREATE TRIGGER tu_dept
AFTER UPDATE OF deptno ON Dept11
FOR EACH ROW
BEGIN
if (:old.deptno != :new.deptno) then
begin
update Emp11
set deptno = :new.deptno
where Emp11.deptno = :old.deptno ;
end;
end if;
END;
/ 

update dept11
set deptno = deptno * 10;


update dept11
set deptno = deptno / 10
where loc != 'NEW_YORK';


select * from Dept11;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW_YORK
         2 RESEARCH       DALLAS
         3 SALES          CHICAGO
         4 OPERATIONS     BOSTON
         5 RESEARCH2      HONKONG
		 
select * from Emp11;

SQL> select * from Emp11;

     EMPNO ENAME                JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING                 PRESIDENT (null)     17-NOV-11       5000 (null)             10
      7698 BLAKE                MANAGER         7839 01-MAY-11       2850 (null)              2
      7782 CLARK                MANAGER         7839 09-JUN-11       1500 (null)              3
      7566 JONES                MANAGER         7839 02-APR-11       2975 (null)              4
      7654 MARTIN               SALESMAN        7698 28-SEP-11       1250       1400          5
      7499 ALLEN                SALESMAN        7698 20-FEB-11       1600        300         10
      7844 TURNER               SALESMAN        7698 08-SEP-11       1500          0          2

7 rows selected.


drop table Emp11;
drop table Dept11;
*/
-------------------------------------------------------------------------------------------------


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

--------------------------------------------------------------------------------------

