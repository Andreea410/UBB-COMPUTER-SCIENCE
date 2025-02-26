(defstruct student 
  (surname nil)
  (firstname nil)
  (scholarship 0)
  (group 0)
  (gpa_year_1 0)
  (gpa_year_2 0)
  (gpa_year_3 0)
)

(setf student1 (make-student)) 
(setf student2 (make-student)) 
(setf (student-surname student1) 'ionescu)
(setf (student-firstname student1) 'mihai)
(setf (student-scholarship student1) 1000)

(setq my_student (list (student-firstname student1) (student-surname student1)))
