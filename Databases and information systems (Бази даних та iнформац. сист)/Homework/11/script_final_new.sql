/*
Created		15.05.2021
Modified		15.05.2021
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


Drop table "object_types";
/
Drop table "objects";
/

-- Create Types section

-- Create Tables section


Create table "objects" (
	"object_id" Number NOT NULL ,
	"parent_id" Number NOT NULL ,
	"object_type_id" Number NOT NULL ,
	"name" Varchar2 (20),
	"description" Varchar2 (20),
primary key ("object_id") 
);
/

Create table "object_types" (
	"object_type_id" Number NOT NULL ,
	"parent_id" Number NOT NULL ,
	"name" Varchar2 (20),
primary key ("object_type_id") 
);
/

-- Create Alternate keys section

-- Create section for PKs, AKs and Unique constraints, which have to be generated after Indexes

-- Create Foreign keys section

Alter table "objects" add  foreign key ("parent_id") references "objects" ("object_id");
/

Alter table "object_types" add  foreign key ("parent_id") references "object_types" ("object_type_id");
/

Alter table "objects" add  foreign key ("object_type_id") references "object_types" ("object_type_id");
/

-- Create Object Tables section

-- Create XMLType Tables section

-- Create Functions section

-- Create Sequences section

-- Create Packages section

-- Create Synonyms section

-- Create Table comments section


-- Create Attribute comments section


