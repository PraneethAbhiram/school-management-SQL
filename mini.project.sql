CREATE DATABASE SchoolDB;
USE SchoolDB;
CREATE TABLE students1 (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    age INT,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100),
    subject VARCHAR(50)
);

CREATE TABLE classes1 (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    class_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students1(student_id),
    FOREIGN KEY (class_id) REFERENCES classes1(class_id)
);

-- select all the tables cmd + shift + return --
select * from students1;
select * from classes1;
select * from teachers;
select * from enrollments;

INSERT INTO students1 VALUES
(1, 'Abhiram', 'Reddy', 'M', 20, 'abhiram@gmail.com'),
(2, 'Praneeth', 'Kumar', 'M', 21, 'praneeth@gmail.com'),
(3, 'Ananya', 'Sharma', 'F', 22, 'ananya@gmail.com');

INSERT INTO teachers VALUES
(101, 'Mr. Rao', 'Mathematics'),
(102, 'Ms. Iyer', 'Science');

INSERT INTO classes1 VALUES
(201, 'Maths 101', 101),
(202, 'Science 101', 102);

INSERT INTO enrollments VALUES
(301, 1, 201, '2024-01-10'),
(302, 2, 201, '2024-01-12'),
(303, 3, 202, '2024-01-15');

SELECT first_name 
FROM students1
WHERE Age > 18;


SELECT s.first_name AS Student_Name , c.class_name
FROM students1 s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes1 c ON e.class_id = c.class_id;

SELECT c.class_name , t.teacher_name
FROM classes1 c
INNER JOIN teachers t ON c.teacher_id = t.teacher_id;

SELECT s.first_name AS STUDENT_NAME , e.enrollment_date
FROM students1 s
INNER JOIN enrollments e ON s.student_id = e.student_id; 

SELECT s.first_name AS STUDENT_NAME , c.class_name AS CLASS_NAME , t.teacher_name AS TEACHER_NAME
FROM enrollments e
JOIN students1 s ON e.student_id = s.student_id
JOIN classes1 c ON c.class_id = e.class_id
JOIN teachers t ON c.teacher_id = c.teacher_id;

SELECT DISTINCT s.first_name , t.teacher_name
FROM students1 s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes1 c ON e.class_id = c.class_id
JOIN teachers t ON c.teacher_id = t.teacher_id
WHERE t.teacher_name = 'Mr. Rao';


SELECT DISTINCT s.first_name
FROM students1 s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes1 c ON e.class_id = c.class_id
JOIN teachers t ON c.teacher_id = t.teacher_id
WHERE t.teacher_name = 'Mr. Rao';


SELECT c.class_name , count(e.student_id) AS Students
FROM classes1 c
LEFT JOIN enrollments e ON c.class_id = e.class_id
group by c.class_name;

-- Find students not enrolled in any class --
SELECT s.first_name 
FROM students1 s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id is NULL;

-- Find classes with no students --
SELECT c.class_name
FROM classes1 c
LEFT JOIN enrollments e ON c.class_id = e.class_id
WHERE e.class_id IS NULL;

/* Show teachers who teach more than one student, 
and how many students they teach */
SELECT t.teacher_name,
       COUNT(e.student_id) AS StudentCount
FROM teachers t
LEFT JOIN classes1 c ON c.teacher_id = t.teacher_id
LEFT JOIN enrollments e ON c.class_id = e.class_id
GROUP BY t.teacher_name
HAVING COUNT(DISTINCT(e.student_id)) > 1;

-- Show students enrolled in the same class (SELF JOIN) --
SELECT DISTINCT
	s1.first_name AS student1,
    s2.first_name AS student2,
    c.class_name AS class
FROM enrollments e1
JOIN enrollments e2 ON e1.class_id = e2.class_id AND e1.student_id < e2.student_id
JOIN students1 s1 ON e1.student_id = s1.student_id
JOIN students1 s2 ON e2.student_id = s2.student_id
JOIN classes1 c ON c.class_id = e1.class_id;


-- Count unique students enrolled
SELECT COUNT(DISTINCT student_id)
FROM enrollments;

-- Count students older than 20
SELECT COUNT(*) 
FROM students1
WHERE age > 20;

-- Students per Math class per age EX.1
SELECT DISTINCT(c.class_name) AS subject , COUNT(*) AS Students , s.age , s.first_name AS Name
FROM classes1 c
JOIN enrollments e ON c.class_id = e.class_id
JOIN students1 s ON s.student_id = e.student_id
WHERE c.class_name = 'Maths 101'
GROUP BY c.class_name , s.age , s.first_name;

-- Students per class per age EX.2
SELECT c.class_name, s.age, COUNT(*)
FROM students1 s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes1 c ON e.class_id = c.class_id
GROUP BY c.class_name , s.age;

-- classes with more than one student EX.1
SELECT c.class_name AS class , COUNT(e.student_id) AS students
FROM enrollments e
JOIN classes1 c ON c.class_id = e.class_id
GROUP BY c.class_name
HAVING COUNT(e.student_id) > 1;

-- Classes with more than 1 student EX.2
SELECT class_id, COUNT(student_id)
FROM enrollments
GROUP BY class_id
HAVING COUNT(student_id) > 1;

-- Classes with >=2 students and avg age > 20
SELECT c.class_name AS class,
	COUNT(s.student_id) AS count,
    AVG(s.age) AS avgAGE
FROM classes1 c
JOIN enrollments e ON c.class_id = e.class_id
JOIN students1 s ON e.student_id = s.student_id
GROUP BY c.class_name
HAVING COUNT(s.student_id) >= 1
	AND AVG(s.age) > 20;
-- HAVING is used to filter aggregated results after GROUP BY.


-- select all the tables cmd + shift + return --
select * from students1;
select * from classes1;
select * from teachers;
select * from enrollments;


/* GROUP_CONCAT
Group rows → Collect values → Join them into text 
Works only with GROUP BY

Used for reporting

Avoid in data pipelines 

GROUP_CONCAT is an aggregate function that:

Takes multiple row values

Belonging to the same group

And merges them into a single string*/

SELECT GROUP_CONCAT(first_name)
FROM students1;  -- works but creates one big group

-- GROUP_CONCAT(NULL) --> ignored

/*| DB         | Equivalent     |
| ---------- | -------------- |
| MySQL      | `GROUP_CONCAT` |
| PostgreSQL | `STRING_AGG`   |
| SQL Server | `STRING_AGG`   |*/


SELECT c.class_name,
       GROUP_CONCAT(s.first_name ORDER BY s.first_name SEPARATOR ', ')
FROM classes1 c
JOIN enrollments e ON c.class_id = e.class_id
JOIN students1 s ON e.student_id = s.student_id
GROUP BY c.class_name;

-- Show only classes with more than 1 student
SELECT c.class_name,
       COUNT(s.student_id) AS total_students,
       GROUP_CONCAT(s.first_name ORDER BY s.first_name SEPARATOR ' | ') AS students
FROM classes1 c
JOIN enrollments e ON c.class_id = e.class_id
JOIN students1 s ON e.student_id = s.student_id
GROUP BY c.class_name
HAVING COUNT(s.student_id) > 1;










