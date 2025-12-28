SELECT 
    s.first_name as Student_Name , c.class_name
FROM students1 s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes1 c ON e.class_id = c.class_id;
