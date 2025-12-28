SELECT 
    c.class_name,
    COUNT(e.student_id) AS student_count
FROM classes c
JOIN enrollments e ON c.class_id = e.class_id
GROUP BY c.class_name;
