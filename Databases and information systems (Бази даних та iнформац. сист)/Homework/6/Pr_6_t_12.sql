/*
*12 Завдання  
Напишіть запит, якій виведе Ялинку. 
Для виведення зірочок скористайтеся функціями CASE, LPAD(RPAD).
*/
	
create table my_fir2(
A integer default 1,
B integer default 2,
C integer default 3,
D integer default 4,
E integer default 5,
F integer default 6,
G integer default 7,
H integer default 8,
I integer default 9,
J integer default 10,
K integer default 11,
L integer default 12,      
);

create table my_fir1(string integer default 1);

select * from my_fir1;

insert into my_fir1 values (default);

select
case when string = '1' then lpad('*', 10, ' ')
end FIR
from my_fir1;


drop table my_fir1;


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

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

--drop table my_fir1;

select lpad('*', 10, ' ') from dual;

select lpad(rpad('*', 9, '0'), 19, '1') from dual;

/*

SQL> select lpad(rpad('*', 9, '0'), 10, ' ') from dual;

LPAD(RPAD(
----------
 *00000000

SQL> select lpad(rpad('*', 9, '0'), 10, '1') from dual;

LPAD(RPAD(
----------
1*00000000

SQL> select lpad(rpad('*', 9, '0'), 19, '1') from dual;

LPAD(RPAD('*',9,'0'
-------------------
1111111111*00000000

*/

create table my_fir1(string integer default 1);

insert into my_fir1 values (1);

select * from my_fir1;

--drop table my_fir1;

select lpad(rpad('*', 9, '0'), 10, '1') from dual;

select lpad(rpad('*', 10, '0'), 19, '1') from dual;



select lpad(lpad('         ', 10, '*'), 19, '1') from dual;


LPAD(LPAD('',10,'*'
-------------------
111111111*

select lpad(lpad('         ', 10, '*'), 19, ' ') from dual;

LPAD(LPAD('',10,'*'
-------------------
         *         

select lpad(lpad('        ', 11, '***'), 19, ' ') from dual;

LPAD(LPAD('',11,'**
-------------------
        ***

--select lpad(rpad'('*', 11, '0'), 19, '1') from dual;


----------------------------------------------------------------------

select concat(lpad('*', 11, '1'), rpad('0', 10, '0')) from dual; -- 1

select concat(lpad('**', 11, '1'), rpad('*', 10, '0')) from dual; -- 2

select concat(lpad('***', 11, '1'), rpad('**', 10, '0')) from dual; -- 3

select concat(lpad('****', 11, '1'), rpad('***', 10, '0')) from dual; --4

select concat(lpad('*****', 11, '1'), rpad('****', 10, '0')) from dual; --5

select concat(lpad('******', 11, '1'), rpad('*****', 10, '0')) from dual; --6

select concat(lpad('*******', 11, '1'), rpad('******', 10, '0')) from dual; --7

select concat(lpad('********', 11, '1'), rpad('*******', 10, '0')) from dual; --8

select concat(lpad('*********', 11, '1'), rpad('********', 10, '0')) from dual; --9

select concat(lpad('**********', 11, '1'), rpad('*********', 10, '0')) from dual; --10

select concat(lpad('*', 11, '1'), rpad('0', 10, '0')) from dual; -- 11

select concat(lpad('*', 11, '1'), rpad('0', 10, '0')) from dual;  -- 12

----------------------------------------------------------------------

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
case string when '1' then  concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
            when '2' then  concat(lpad('**', 11, '1'), rpad('*', 10, '0'))
			when '3' then  concat(lpad('***', 11, '1'), rpad('**', 10, '0'))
			when '4' then  concat(lpad('****', 11, '1'), rpad('***', 10, '0'))
			when '5' then  concat(lpad('*****', 11, '1'), rpad('****', 10, '0'))
			when '6' then  concat(lpad('******', 11, '1'), rpad('*****', 10, '0'))
			when '7' then  concat(lpad('*******', 11, '1'), rpad('******', 10, '0'))
			when '8' then  concat(lpad('********', 11, '1'), rpad('*******', 10, '0'))
			when '9' then  concat(lpad('*********', 11, '1'), rpad('********', 10, '0'))
			when '10' then concat(lpad('**********', 11, '1'), rpad('*********', 10, '0'))
			when '11' then concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
			when '12' then concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
end FIR
from my_fir1;


select
case string when 1 then  concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
            when 2 then  concat(lpad('**', 11, '1'), rpad('*', 10, '0'))
			when 3 then  concat(lpad('***', 11, '1'), rpad('**', 10, '0'))
			when 4 then  concat(lpad('****', 11, '1'), rpad('***', 10, '0'))
			when 5 then  concat(lpad('*****', 11, '1'), rpad('****', 10, '0'))
			when 6 then  concat(lpad('******', 11, '1'), rpad('*****', 10, '0'))
			when 7 then  concat(lpad('*******', 11, '1'), rpad('******', 10, '0'))
			when 8 then  concat(lpad('********', 11, '1'), rpad('*******', 10, '0'))
			when 9 then  concat(lpad('*********', 11, '1'), rpad('********', 10, '0'))
			when 10 then concat(lpad('**********', 11, '1'), rpad('*********', 10, '0'))
			when 11 then concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
			when 12 then concat(lpad('*', 11, '1'), rpad('0', 10, '0'))
end FIR
from my_fir1;



-----------------------------------------------------------------------------------
                                   FINAL
-----------------------------------------------------------------------------------

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

drop table my_fir1;

-----------------------------------------------------------------------------------
                                   FINAL
-----------------------------------------------------------------------------------
