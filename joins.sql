SELECT 
    s.first_name,
    c.class_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes c ON e.class_id = c.class_id;
