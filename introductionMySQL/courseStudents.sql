#1
CREATE DATABASE StudentRecords;
#2
USE studentrecords;
CREATE TABLE Students(
	studentId INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

#3
INSERT INTO students (studentId,firstName,lastName,age,email) VALUES
(1,'John','Doe',20,'john.doe@example.com'),
(2,'Jane','Smith',22,'jane.smith@example.com'),
(3,'Israel','Fonseca',24,'israel.fonseca@example.com'),
(4,'Cesar','Ponce',43,'cesar.fonseca@example.com'),
(5,'Carlos','Arce',19,'carlos.arce@example.com');

#
CREATE TABLE courses(
	courseId INT PRIMARY KEY,
    courseName VARCHAR(50),
    courseDescription VARCHAR(200)
);

CREATE TABLE coursesStudents(
	courseId INT,
    studentId INT,
    PRIMARY KEY (courseId,studentId),
    foreign key (courseId) references courses(courseId),
    foreign key (studentId) references students(studentId)
);

insert into courses values
(1,'Java Training','Learn full stack dev with java and spring'),
(2,'Python','------');

insert into coursesStudents values
(1,3),
(1,4),
(2,2);

select * from students;

select students.*,courses.* from students inner join coursesStudents on students.studentId = coursesStudents.studentId 
	inner join courses on coursesStudents.courseId = courses.courseId;

select students.*,courses.* from students inner join coursesStudents on students.studentId = coursesStudents.studentId 
	inner join courses on coursesStudents.courseId = courses.courseId where courses.courseId=1;

#
insert into students values
(6,'Emily','Clark',19,'emily.clark@example.com'),
(7,'Michael','Brown',21,'michael.brown@example.com');

select * from students;

update students set age=21 where studentId=1;

select * from students;