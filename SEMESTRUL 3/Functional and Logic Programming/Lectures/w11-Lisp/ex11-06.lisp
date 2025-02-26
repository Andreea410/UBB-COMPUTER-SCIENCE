(defun elim (l) 
   (cond 
      ((and (atom l) (minusp l)) nil) 
      ((atom l) (list l)) 
    (t (list (mapcan #'elim l))) 
  ) 
) 
 
(defun elimin (l) 
  (car (elim l)) 
)
