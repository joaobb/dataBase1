create table employee (
fname varchar(15) not null,
minit char,                                     
lname varchar(15),
ssn char(9),
bdate date,                                                                                 
address varchar(30),
sex char,
salary decimal(10,2),
super_ssn char(9),
dno int not null,
PRIMARY KEY(ssn));

create table department (
dname varchar(15) not null,
dnumber int not null,
mgr_ssn char(9) not null,
mgr_start_date date,
Primary key (dnumber),
unique(dname),
foreign key (mgr_ssn) references employee(ssn));

create table dept_locations (
dnumber int,
dlocation varchar(15),
primary key (dnumber, dlocation),
foreign key (dnumber) references department(dnumber));

create table project (
pname varchar(15),
pnumber int,
plocation varchar(15),
dnum int,
primary key (pnumber),
unique(pname),
foreign key (dnum) references department (dnumber));

create table works_on (
essn char(9),
pno int,
hours decimal(3,1),
primary key (essn, pno),
foreign key (essn) references employee(ssn),
foreign key (pno) references project(pnumber));

create table dependent (
essn char(9),
dependent_name varchar(15),
sex char,
bdate date,
relatioship varchar(8),
primary key (essn, dependent_name),
foreign key (essn) references employee(ssn));
