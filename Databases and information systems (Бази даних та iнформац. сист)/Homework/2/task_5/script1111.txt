/*
Created		04.02.2021
Modified		16.02.2021
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/






Drop table "Osobystist"
/
Drop table "Typ_rahunku"
/
Drop table "Posady"
/
Drop table "Operacia"
/
Drop table "Spivrobitnuk"
/
Drop table "Rahunok"
/
Drop table "Klient_"
/


-- Create Types section





-- Create Tables section


Create table "Klient_" (
	"ID_klient" Varchar2 (20) NOT NULL ,
	"Status" Varchar2 (20),
	"ID_osoba" Varchar2 (20) NOT NULL ,
primary key ("ID_klient") 
) 
/

Create table "Rahunok" (
	"Nomer_rahunku" Varchar2 (20) NOT NULL ,
	"ID_klient" Varchar2 (20) NOT NULL ,
	"Nomer_typu" Number NOT NULL ,
	"Data_vidkrut" Varchar2 (20),
primary key ("Nomer_rahunku") 
) 
/

Create table "Spivrobitnuk" (
	"ID_robitnuk" Varchar2 (20) NOT NULL ,
	"Data_vlashtyv" Varchar2 (8),
	"ID_osoba" Varchar2 (20) NOT NULL ,
	"Nomer_posady" Varchar2 (20) NOT NULL ,
primary key ("ID_robitnuk") 
) 
/

Create table "Operacia" (
	"Nomer_oper" Number NOT NULL ,
	"Data_oper" Varchar2 (8),
	"Vid_oper" Varchar2 (20),
	"Spivrobitnuk_obslug" Varchar2 (20),
	"Rahunok_klienta" Varchar2 (20),
	"Suma" Number,
	"Nomer_rahunku" Varchar2 (20) NOT NULL ,
	"ID_robitnuk" Varchar2 (20) NOT NULL ,
primary key ("Nomer_oper") 
) 
/

Create table "Posady" (
	"Nomer_posady" Varchar2 (20) NOT NULL ,
	"Nazva_posady" Varchar2 (20),
	"Zarplata" Number,
primary key ("Nomer_posady") 
) 
/

Create table "Typ_rahunku" (
	"Nomer_typu" Number NOT NULL ,
	"Nazva_typu" Varchar2 (20),
	"Dostupna_suma" Number,
primary key ("Nomer_typu") 
) 
/

Create table "Osobystist" (
	"ID_osoba" Varchar2 (20) NOT NULL ,
	"Nomer_telef" Number,
	"Adresa" Varchar2 (20),
	"Prizvishe" Varchar2 (20),
	"Data_narodg" Varchar2 (20),
primary key ("ID_osoba") 
) 
/


-- Create Alternate keys section


-- Create section for PKs, AKs and Unique constraints, which have to be generated after Indexes



-- Create Foreign keys section

Alter table "Rahunok" add  foreign key ("ID_klient") references "Klient_" ("ID_klient") 
/

Alter table "Operacia" add  foreign key ("Nomer_rahunku") references "Rahunok" ("Nomer_rahunku") 
/

Alter table "Operacia" add  foreign key ("ID_robitnuk") references "Spivrobitnuk" ("ID_robitnuk") 
/

Alter table "Spivrobitnuk" add  foreign key ("Nomer_posady") references "Posady" ("Nomer_posady") 
/

Alter table "Rahunok" add  foreign key ("Nomer_typu") references "Typ_rahunku" ("Nomer_typu") 
/

Alter table "Klient_" add  foreign key ("ID_osoba") references "Osobystist" ("ID_osoba") 
/

Alter table "Spivrobitnuk" add  foreign key ("ID_osoba") references "Osobystist" ("ID_osoba") 
/


-- Create Object Tables section



-- Create XMLType Tables section



-- Create Functions section



-- Create Sequences section




-- Create Packages section





-- Create Synonyms section



-- Create Table comments section


-- Create Attribute comments section



