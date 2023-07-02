/* Пороскун О. ПМ-81   Практична робота 4  БД*/

/* Завдання 1 
Робота з числами 
1. Відділу кадрів потрібен звіт, який містить ім'я співробітника, поточну зарплату 
і зарплату збільшену на 13,33%. Значення останнього стовпчика повинні бути округлені до цілого. 
*/

select ename, sal, round((sal + (sal/100)*13.33), 0) increased_sal
from emp;


/*2. Порівняйте результати, які повертають запити: */

/*1.*/ SELECT TRUNC(55.52,2)  FROM DUAL; -- 55.52
/*2.*/ SELECT TRUNC(55.52)    FROM DUAL; -- 55
/*3.*/ SELECT TRUNC(55.52,-1) FROM DUAL; -- 50
/*4.*/ SELECT ROUND(55.52,2)  FROM DUAL; -- 55.52
/*5.*/ SELECT ROUND(55.52)    FROM DUAL; -- 56
/*6.*/ SELECT ROUND(55.52,-1) FROM DUAL; -- 60

/* додаткові запити */
       SELECT TRUNC(355.52,-2) FROM DUAL; -- 300
	   SELECT TRUNC(355.52,-1) FROM DUAL; -- 350
       SELECT ROUND(355.52,-2) FROM DUAL; -- 400
       SELECT ROUND(355.52,-1) FROM DUAL; -- 360

/*2. Робота з рядками (запити без Like) 
3. Виберіть ім'я та довжину імені всіх співробітників, ім'я яких починається з «A», «С» або «J». 
Дайте стовпцю з довжиною імені псевдонім.  */

select ename, length(ename) length_ename
from emp
where substr(ename, 1, 1) = 'A'
or    substr(ename, 1, 1) = 'C'
or    substr(ename, 1, 1) = 'J';

/* 4. Виведіть міста, в назвах яких 4-а буква — «С» (CHICAGO). */

select loc 
from dept
where substr(loc, 4, 1) = 'C';

/*5. * Виведіть перші слова в назвах міст, якщо назва міста складається з 2-х слів. 
(Назви зберігаються в стовбці loc таблиці Dept)  
 ^ Наприклад для «New_York» виведіть «New». «Dallas» - складається з одного слова і не виводиться. */

/*select  loc,
substr(loc,-length(loc),instr(loc,'_')-1) first_city    -- || -length(loc) = 1 || 
from dept
where instr(loc, '_') != 0;
*/

select  substr(loc, 1, instr(loc,'_') - 1) first_city
from dept
where instr(loc, '_') != 0;


/* 6. * Створіть запит, який поверне колонку NAME_AND_SALARIES. К
олонка має містити ім'я працівника і кілька зірочок (*) по одній зірочці на кожні $ 250 зарплати.  
^ Наприклад «SMITH ***» - для працівникаSMITH із зарплатою $800 */

select rpad(ename, round(sal/250) + length(ename), '*') NAME_AND_SALARIES -- количество звездочек не совпадает из-за округления
from emp;

select rpad(ename, trunc(sal/250) + length(ename), '*') NAME_AND_SALARIES
from emp;

/*
7. Створіть звіт, який для кожного співробітника поверне рядок: 
< ename > earns $ < salary> monthly but wants $ < 3 * salary >
Наприклад :  «SMITH earns $ 800.00 monthly but wants $ 2400.00» 
Зарплату виводити з точністю до 2-х знаків після коми (тобто у виводі повинно бути 2400.00, а не 2400). 
Для об'єднання рядків скористайтеся функцією.

*/

--select < ename > earns $ < salary> monthly but wants $ < 3 * salary >

/*select ename ||' earns $ monthly '|| sal ||' but wants $ '|| 3*sal
from emp;*/

select concat (ename || ' earns', to_char(sal, '$99,999.99')) 
|| concat (' monthly but wants', to_char(3*sal, '$99,999.99'))
as "ENAME earns..."
from emp;

/*Робота з датами 
8. Напишіть запит, який поверне поточну дату. */

select SYSDATE from dual;

/* 9. * Сформувати запит, що виводить в порядку спадання кількість місяців, що минули з моменту найму кожного працівника. 
Кількість місяців округлити до найближчого цілого. */

select SYSDATE - hiredate 
order by       desc;


select round(months_between(SYSDATE, hiredate)) months
from emp
order by months desc;

/* 10. * Створіть запит, який поверне імена співробітників, роки коли вони були найняті та дні тижня. 
Дані впорядкувати по роках за спаданням, по іменах за зростанням.*/

select ename,  
to_char(hiredate, 'YYYY') years, 
to_char(hiredate, 'DAY') weekday
from emp
order by years desc, ename asc;

/*11. Сформувати запит, що виводить прізвище службовця і його комісійні. 
У разі відсутності комісійних в стовпці має бути виведено "No commissions". */

select ename, 
coalesce(to_char(comm), 'No commissions') comm
from emp;

/*12. Створіть звіт, який містить ім'я співробітника, заробіток (зарплата + премія) та коментар. 
Поле коментар містить значення «SAL + COM», якщо у співробітника є премія, 
або «SAL», якщо премія не встановлена
*/

-- earnings comment income

select ename, (sal+nvl(comm, 0)) income, 
nvl2(comm, 'SAL + COM', 'SAL') comments
from emp;

/* 13. * Створіть звіт, який містить ім'я співробітника і його премію. 
Якщо премія не встановлена поле повинно містити номер керівника (mgr). 
Якщо у співробітника немає премії і керівника поле повинно містити «No value» */
/*
select ename, empno, comm, 
coalesce(to_char(comm), to_char(mgr), 'No value')
from emp;
*/
select ename,
coalesce(to_char(comm), to_char(mgr), 'No value') comm
from emp;

/*Використання CASE і DECODE 
14. * Всім співробітникам вирішили надати рівень допуску, згідно з посадою:  
	PRESIDENT – A  
	MANAGER – B
	SALESMAN – C  
	Для всіх інших – 0. 
Використовуючи CASE складіть звіт, який містить ім'я співробітника і його рівень допуску.*/

select ename,
case job 
when 'PRESIDENT' then 'A'
when 'MANAGER'   then 'B'
when 'SALESMAN'  then 'C'
else '0' end l
from emp;

/* 15. * Реалізуйте попереднє завдання за допомогою DECODE.*/

select ename,
decode (job, 
'PRESIDENT', 'A',
'MANAGER',   'B',
'SALESMAN',  'C',
'0') l
from emp;

/*16* Завдання 
Однією командою SELECT вивести інформацію про підрозділи компанії, що мають в назві більше одного слова. 
Звіт повинен містити: 
a. ідентифікатор підрозділу; 
b. друге слово в назві підрозділу. 
Слова в назві підрозділу розділяються пробілами. 
Дані необхідно впорядкувати по зростанню ідентифікаторів підрозділів компанії. 
У назві підрозділу може бути більше 2-х слів, потрібно тільки 2-е. 
Для виконання завдання може стати в нагоді функція INSTR.*/

drop table Dept_name;
CREATE TABLE Dept_name(  -- описание подразделения
   deptno NUMBER(3) NOT NULL,  -- № подразделения
   dname VARCHAR(20) NOT NULL,  -- название подразделения
   loc VARCHAR(13), -- местоположение подразделения
   CONSTRAINT dept_pk_ PRIMARY KEY (deptno),
   CONSTRAINT dept_naem_uk_ UNIQUE (dname)
);
INSERT INTO Dept_name  VALUES (10,'ACCOUNTING','NEW_YORK');
INSERT INTO Dept_name VALUES (20,'RESEARCH NEW','DALLAS');
INSERT INTO Dept_name VALUES (30,'SALES','CHICAGO');
INSERT INTO Dept_name VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO Dept_name VALUES (50,'RESEARCH2 plus','HONKONG');
INSERT INTO Dept_name VALUES (60,'SALES 2','HONKONG');
INSERT INTO Dept_name VALUES (100,'SALES NEW 3 ','NEW_YORK');
INSERT INTO Dept_name  VALUES (90,'PROJECT ABC ZZZ','NEW_YORK');
commit;
SELECT * FROM Dept_name;
/
----
SQL> SELECT * FROM Dept_name;

    DEPTNO DNAME                LOC
---------- -------------------- -------------
        10 ACCOUNTING           NEW_YORK
        20 RESEARCH NEW         DALLAS
        30 SALES                CHICAGO
        40 OPERATIONS           BOSTON
        50 RESEARCH2 plus       HONKONG
        60 SALES 2              HONKONG
       100 SALES NEW 3          NEW_YORK
        90 PROJECT ABC ZZZ      NEW_YORK

--------
select deptno, dname,
decode (instr(dname, ' ', instr(dname, ' ')+1),
'0',  substr(dname, instr(dname,' ')+1, length(dname)), 
substr(dname, instr(dname,' ')+1, 
instr(dname, ' ', instr(dname, ' ')+1) - instr(dname, ' ', instr(dname, ' ')))) 
second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO DNAME                SECOND_DNAME
---------- -------------------- --------------------------------------------------------------------------------
        20 RESEARCH NEW         NEW
        50 RESEARCH2 plus       plus
        60 SALES 2              2
        90 PROJECT ABC ZZZ      ABC
       100 SALES NEW 3          NEW

select deptno,
decode (instr(dname, ' ', instr(dname, ' ')+1),
'0',  substr(dname, instr(dname,' ')+1, length(dname)), 
substr(dname, instr(dname,' ')+1, 
instr(dname, ' ', instr(dname, ' ')+1) - instr(dname, ' ', instr(dname, ' ')))) 
second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO SECOND_DNAME
---------- --------------------------------------------------------------------------------
        20 NEW
        50 plus
        60 2
        90 ABC
       100 NEW
