(defun ad (l) 
   (cond 
      ((null (cdr l)) 0) 
      (t (+ 1 (apply #'max (mapcar #'ad (cdr l)))) 
   ) 
) 
