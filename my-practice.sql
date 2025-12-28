CREATE DATABASE PetersDB;

USE PetersDB;


CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Firstname VARCHAR(50) NOT NULL,
Gender CHAR(1) NOT NULL Check(Gender IN('M' , 'F')),
Age INT CHECK(Age > 3)
);
select * from Students;
ALTER TABLE Students
ADD Email NVARCHAR(100);
ALTER TABLE Students
DROP COLUMN Email;

ALTER TABLE Students
ADD Email VARCHAR(100);

ALTER TABLE Students
MODIFY Email NVARCHAR(100);

ALTER TABLE Students
CHANGE Email StudentEmail NVARCHAR(100);

select * from Students;

insert into Students values(1, 'Abhiram', 'M', 20, 'abhiram@gmail.com');
insert into Students values(2, 'Praneeth', 'M', 21, 'praneeth@gmail.com');
insert into Students values(3, 'Girl', 'F', 22, 'girl@gmail.com'); 
insert into Students values(4, 'Kashyap', 'M', 40, 'kashyap@gmail.com');

select * from PetersStudents;

RENAME TABLE Students to PetersStudents;

UPDATE PetersStudents
set Age = 30
where StudentID = 4;

select * from PetersStudents
where Gender = 'M';

delete from PetersStudents
where StudentID = 4;

select * from PetersStudents;
select StudentID , Firstname, Age , Gender from PetersStudents;

ALTER TABLE PetersStudents
CHANGE COLUMN Firstname StudentName VARCHAR(55);

select * from PetersStudents;

ALTER TABLE PetersStudents
CHANGE COLUMN StudentName First_Name VARCHAR(55);

ALTER TABLE PetersStudents
ADD Last_Name VARCHAR(55);

select * from PetersStudents;

update PetersStudents
SET Last_Name = 'ABC'
WHERE StudentID = 1;

update PetersStudents
SET Last_Name = 'XYZ'
WHERE StudentID = 2;

update PetersStudents
SET Last_Name = 'GGG'
WHERE StudentID = 3;

USE PetersDB;
select * from PetersStudents;




