create database EmployeeManagement;

use employeemanagement;

create table employees(
	employeeId INT primary key,
    firstName varchar(50),
    lastName varchar(50),
    age int,
    email varchar(100) unique,
    departmentId int,
    foreign key (departmentId) references departments (departmentId)
);

create table departments(
	departmentId int primary key,
    departmentName varchar(100)
);

create table projects(
	projectId int primary key,
    projectName varchar(100),
    projectBudget decimal,
    managerId int,
    foreign key (managerId) references employees (employeeId)
);

#2
insert into departments (departmentId,departmentName) values
(1,'Human resources'),
(2,'Engineering'),
(3, 'Marketing');

insert into employees (employeeId,firstName,lastName,age,email,departmentId) values
(1,'Alice','Johnson',30,'alice.johnson@example.com',1),
(2,'Bob','Smith',45,'bob.smith@example.com',2),
(3,'Israel','Fonseca',24,'israel.fonseca@example.com',2),
(4,'Carlos','Acevedo',55,'carlos.a@example.com',2),
(5,'Cesar','Fonseca',63,'cesar.fonseca@example.com',3);

insert into projects (projectId,projectName,projectBudget,managerId) values
(101,'Website Redesign',5000.00,2),
(102,'Autonomous car research',10000.00,3),
(103,'Payments', 2300.00,4);

select employees.firstname, employees.lastname, departments.departmentname
from employees
inner join departments on employees.departmentId = departments.departmentId;

select projects.projectname, employees.firstname, employees.lastname 
from projects
inner join employees on projects.managerId=employees.employeeId;

select employees.firstname, employees.lastname, departments.departmentname
from employees
inner join departments on employees.departmentId = departments.departmentId
where departments.departmentname='Engineering' and employees.age>=40;

#3
create view employeeDetails as
select employees.employeeId,employees.firstname, employees.lastname, departments.departmentname
from employees
inner join departments on employees.departmentId=departments.departmentId;

select employeeDetails.*, projects.projectname
from employeedetails
inner join projects on employeedetails.employeeId = projects.managerId;

create view activeprojects as
select projectname,projectbudget,managerId
from projects
where projectbudget > 3000;

select *
from activeprojects;