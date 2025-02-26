(defun sterg (L)
  (cond  
    ((and (numberp L) (minusp L)) nil)  
    ((atom L) (list L))  
      (t (list (apply #'append (mapcar #'sterg L) ) ))  
  )  
) 
 
(defun stergere (L)  
  (car (sterg L))  
) 
