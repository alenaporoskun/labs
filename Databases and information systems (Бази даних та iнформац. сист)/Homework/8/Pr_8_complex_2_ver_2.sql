/* Пороскун О. ПМ-81   Практична робота 8  БД  версия 2   */

/*Комплексне завдання 2. «Відпустки» 
1. Створіть таблицю Vocation, приклад файлу доданий до завдання. 
2. Знайдіть керівників, які сьогодні у відпустці? 
3. В яких містах сьогодні керівники у відпустці? 
4. У яких співробітників керівники сьогодні у відпустці? 
5. У яких керівників є співробітники, що зараз у відпустці?
6. Які співробітники були в цьому місяці у відпустці, але отримують премію? 
7. Видаліть таблицю Vocation. */

-- 1. Створіть таблицю Vocation, приклад файлу доданий до завдання.

drop table vacation;

CREATE TABLE vacation (empno number, start_date date, end_date date);
INSERT INTO vacation VALUES (7839, TO_DATE ('2013-01-07', 'YYYY-MM-DD'), TO_DATE ('2013-01-15', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7839, TO_DATE ('2013-01-24', 'YYYY-MM-DD'), TO_DATE ('2013-02-17', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7698, TO_DATE ('2013-02-05', 'YYYY-MM-DD'), TO_DATE ('2013-02-24', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7934, TO_DATE ('2013-02-16', 'YYYY-MM-DD'), TO_DATE ('2013-02-19', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7839, TO_DATE ('2013-01-07', 'YYYY-MM-DD'), TO_DATE ('2013-01-08', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7782, TO_DATE ('2015-01-03', 'YYYY-MM-DD'), TO_DATE ('2015-03-16', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7566, TO_DATE ('2015-02-07', 'YYYY-MM-DD'), TO_DATE ('2015-03-08', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (8000, TO_DATE ('2015-01-19', 'YYYY-MM-DD'), TO_DATE ('2015-04-05', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7900, TO_DATE ('2015-03-01', 'YYYY-MM-DD'), TO_DATE ('2015-03-20', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7844, TO_DATE ('2015-02-25', 'YYYY-MM-DD'), TO_DATE ('2015-03-16', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7844, TO_DATE ('2013-03-07', 'YYYY-MM-DD'), TO_DATE ('2013-04-14', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (8002, TO_DATE ('2014-01-09', 'YYYY-MM-DD'), TO_DATE ('2014-01-10', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (8002, TO_DATE ('2014-09-01', 'YYYY-MM-DD'), TO_DATE ('2014-09-09', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (7902, TO_DATE ('2013-06-07', 'YYYY-MM-DD'), TO_DATE ('2013-06-09', 'YYYY-MM-DD'));
INSERT INTO vacation VALUES (8001, TO_DATE ('2013-01-17', 'YYYY-MM-DD'), TO_DATE ('2013-01-27', 'YYYY-MM-DD'));

select * from vacation;

-- 2. Знайдіть керівників, які сьогодні у відпустці? 

select mn.empno, mn.ename manager
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcmn.start_date and vcmn.end_date;

select wr.empno, wr.ename worker, wr.mgr, vcwr.start_date, vcwr.end_date,
       mn.empno, mn.ename manager, vcmn.start_date, vcmn.end_date 
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno);

-- 3. В яких містах сьогодні керівники у відпустці? 

select wr.empno, wr.ename worker, wr.mgr, vcwr.start_date, vcwr.end_date, dw.loc,
       mn.empno, mn.ename manager, vcmn.start_date, vcmn.end_date , dm.loc
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
join dept dw on (wr.deptno = dw.deptno)
join dept dm on (mn.deptno = dm.deptno);


select dm.loc
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
join dept dw on (wr.deptno = dw.deptno)
join dept dm on (mn.deptno = dm.deptno)
where sysdate between vcmn.start_date and vcmn.end_date;

-- 4. У яких співробітників керівники сьогодні у відпустці? 

select wr.empno, wr.ename worker
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcmn.start_date and vcmn.end_date;

-- 5. У яких керівників є співробітники, що зараз у відпустці?

select mn.empno, mn.ename manager
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where sysdate between vcwr.start_date and vcwr.end_date;

-- 6. Які співробітники були в цьому місяці у відпустці, але отримують премію? 

select  wr.empno, wr.ename worker
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where sysdate > vcwr.start_date
and extract(day from sysdate) > extract(day from vcwr.end_date)
and extract(month from sysdate) = extract(month from vcwr.end_date)
and extract(year from sysdate) = extract(year from vcwr.end_date)
and wr.comm is not null;

/*
select  wr.empno, wr.ename worker, wr.comm, sysdate, 
extract(day from sysdate) day_sysdate, extract(month from sysdate) month_sys, extract(year from sysdate) year_sys,
vcwr.start_date, extract(day from vcwr.start_date) day_start, extract(month from vcwr.start_date) month_start, , extract(year from vcwr.start_date) year_start, 
vcwr.end_date,   extract(day from vcwr.end_date) day_end,     extract(month from vcwr.end_date) month_end,       extract(year from vcwr.end_date) year_end
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where wr.comm is not null;
*/

select  wr.empno, wr.ename worker, wr.comm, sysdate, extract(month from sysdate) mon_sys,
vcwr.start_date, extract(month from vcwr.start_date) month_start, 
vcwr.end_date,   extract(month from vcwr.end_date) month_end
from emp wr
left outer join emp mn on (wr.mgr = mn.empno)
left outer join vacation vcwr on (wr.empno = vcwr.empno)
left outer join vacation vcmn on (mn.empno = vcmn.empno)
where wr.comm is not null;


-- 7. Видаліть таблицю Vocation. 

drop table vacation;

