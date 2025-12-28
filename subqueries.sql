SELECT first_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 201
);
