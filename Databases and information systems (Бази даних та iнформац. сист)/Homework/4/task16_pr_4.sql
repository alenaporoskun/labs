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

---------------------------------------------

select  deptno, substr(dname, instr(dname,' ', -1)) second_dname
from Dept_name
where instr(dname, ' ', -1) != 0
order by deptno;

    DEPTNO SECOND_DNAME
---------- --------------------------------------------------------------------------------
        20  NEW
        50  plus
        60  2
        90  ZZZ
       100

select  deptno, substr(dname, instr(dname,' ', -1)) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO SECOND_DNAME
---------- --------------------------------------------------------------------------------
        20  NEW
        50  plus
        60  2
        90  ZZZ
       100

select  deptno, instr(dname,' ', -1) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO SECOND_DNAME
---------- ------------
        20            9
        50           10
        60            6
        90           12
       100           12

select  deptno, instr(dname,' ', -1, instr(dname,' ')) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;
	
select  deptno, instr(dname,' ', -1, instr(dname,' ')) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;	
		
------------------------------------

select ename,
decode (instr(dname, ' ', instr(dname, ' ')+1)) k,
0,  substr(dname, instr(dname,' ')+1, length(dname)), 
substr(dname, 1, instr(dname, ' ', instr(dname, ' ') + 1) - 1 ) second_dname

------
/*
select deptno, dname,
decode (instr(dname, ' ', instr(dname, ' ')+1),
'0',  substr(dname, instr(dname,' ')+1, length(dname)), 
substr(dname, 1, (instr(dname, ' ', instr(dname, ' ')+1 )) - 1)) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

select deptno, dname,
decode (instr(dname, ' ', instr(dname, ' ')+1),
'0',  substr(dname, 1, length(dname)), 
substr(dname, instr(dname,' ')+1, (instr(dname, ' ', instr(dname, ' ')+1 )) - 1)) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;
*/

select deptno, dname,
decode (instr(dname, ' ', instr(dname, ' ')+1),
'0',  substr(dname, instr(dname,' ')+1, length(dname)), 
substr(dname, instr(dname,' ')+1, (instr(dname, ' ', instr(dname, ' ')+1 )) - 1)) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO DNAME                SECOND_DNAME
---------- -------------------- --------------------------------------------------------------------------------
        20 RESEARCH NEW         NEW
        50 RESEARCH2 plus       plus
        60 SALES 2              2
        90 PROJECT ABC ZZZ      ABC ZZZ
       100 SALES NEW 3          NEW 3

select  deptno, instr(dname, ' ', instr(dname, ' ')+1) second_dname
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO SECOND_DNAME
---------- ------------
        20            0
        50            0
        60            0
        90           12
       100           10

select  deptno, instr(dname, ' ', instr(dname, ' ')+1),
instr(dname, ' ', instr(dname, ' '))
from Dept_name
where instr(dname, ' ') != 0
order by deptno;

    DEPTNO INSTR(DNAME,'',INSTR(DNAME,'')+1) INSTR(DNAME,'',INSTR(DNAME,''))
---------- --------------------------------- -------------------------------
        20                                 0                               9
        50                                 0                              10
        60                                 0                               6
        90                                12                               8
       100                                10                               6

--------------------------------
-- final version task 16       |
-------------------------------- 

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

--------------------------------
-- final version task 16       |
--------------------------------