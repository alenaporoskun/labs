drop table Emp;
drop table Dept;
drop table Salgrade;

CREATE TABLE Dept(  -- описание подразделения
   deptno NUMBER(3) NOT NULL,  -- № подразделения
   dname VARCHAR(14) NOT NULL,  -- название подразделения
   loc VARCHAR(13), -- местоположение подразделения
   CONSTRAINT dept_pk PRIMARY KEY (deptno),
   CONSTRAINT dept_naem_uk UNIQUE (dname)
);

CREATE TABLE Emp( -- описание сотрудников подразделений
  empno NUMBER(4) NOT NULL, -- № сотрудника
  ename VARCHAR(20), -- имя сотрудника
  job VARCHAR(9), -- должность сотрудника
  mgr NUMBER(4), -- № начальника сотрудника
  hiredate DATE, -- дата приема на работу сотрудника 
  sal NUMBER(7, 2), -- з/п сотрудника
  comm NUMBER(7, 2), -- премия сотрудника
  deptno NUMBER(2),  -- № подразделения, где работает сотрудник
  CONSTRAINT emp_pk PRIMARY KEY (empno),
  CONSTRAINT emp_deptno_fk FOREIGN KEY (deptno) REFERENCES Dept (deptno)
);

CREATE TABLE Salgrade( -- описание диапазона з/п для различных групп сотрудников
  grade NUMBER(1) NOT NULL,  -- № группы сотрудников
  minsal NUMBER, -- min з/п
  hisal NUMBER,  -- max з/п
  CONSTRAINT salgrade_pk PRIMARY KEY (grade)
);

ALTER TABLE Emp ADD CONSTRAINT fk_Self FOREIGN KEY (mgr) REFERENCES Emp (empno) ON DELETE CASCADE;

commit;

INSERT INTO Dept  VALUES (10,'ACCOUNTING','NEW_YORK');
INSERT INTO Dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO Dept VALUES (30,'SALES','CHICAGO');
INSERT INTO Dept VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO Dept VALUES (50,'RESEARCH2','HONKONG');
INSERT INTO Dept VALUES (60,'SALES2','HONKONG');
INSERT INTO Dept VALUES (100,'SALES3','NEW_YORK');


INSERT INTO Emp VALUES (7839,'KING','PRESIDENT',null, TO_DATE('2011-11-17', 'YYYY-MM-DD'),5000,null,10);
INSERT INTO Emp VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('2011-05-01', 'YYYY-MM-DD'), 2850,null,30);
INSERT INTO Emp VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('2011-06-09', 'YYYY-MM-DD'), 1500,null,10);
INSERT INTO Emp VALUES (7566,'JONES','MANAGER',7839,TO_DATE('2011-04-02', 'YYYY-MM-DD'), 2975,null,20);
INSERT INTO Emp VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('2011-09-28', 'YYYY-MM-DD'), 1250,1400,30);
INSERT INTO Emp VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('2011-02-20', 'YYYY-MM-DD'), 1600,300,30);
INSERT INTO Emp VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('2011-09-08', 'YYYY-MM-DD'), 1500,0,30);
INSERT INTO Emp VALUES (7900,'JAMES','CLERK',7698,TO_DATE('2011-12-03', 'YYYY-MM-DD'), 950,null,30);
INSERT INTO Emp VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('2011-02-22', 'YYYY-MM-DD'), 1250,500,30);
INSERT INTO Emp VALUES (7902,'FORD','ANALYST',7566,TO_DATE('2011-12-03', 'YYYY-MM-DD'), 3000,null,20);
INSERT INTO Emp VALUES (7369,'SMITH','CLERK',7902,TO_DATE('2010-12-17', 'YYYY-MM-DD'), 800,null,20);
INSERT INTO Emp VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('2012-12-09', 'YYYY-MM-DD'), 3000,null,20);
INSERT INTO Emp VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('2013-01-12', 'YYYY-MM-DD'), 1100,null,20);
INSERT INTO Emp VALUES (7934,'MILLER','CLERK',7782,TO_DATE('2012-01-23', 'YYYY-MM-DD'), 1300,null,10);
INSERT INTO Emp VALUES (8000,'JACKIE CHAN','SALESMAN',7839,TO_DATE('2011-09-28', 'YYYY-MM-DD'), 2250,1700,60);
INSERT INTO Emp VALUES (8001,'JET LI','SALESMAN',8000,TO_DATE('2011-02-20', 'YYYY-MM-DD'), 2600,600,60);
INSERT INTO Emp VALUES (8002,'BRUCE LEE','SALESMAN',8000,TO_DATE('2011-09-08', 'YYYY-MM-DD'), 2500,null,60);
INSERT INTO Emp VALUES (8003,'DR NO','ANALYST', 7839, TO_DATE('2011-09-11', 'YYYY-MM-DD'), 2500,null,null);

commit;