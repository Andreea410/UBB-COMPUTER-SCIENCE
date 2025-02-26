(defun atomi1 (l) 
   (cond 
    ((atom l) (list l)) 
    (t (mapcan #'atomi1 l)) 
  ) 
)  

; Remark: the same requirement could be solved using the mapcar function. 
 
(defun atomi2 (l) 
   (cond 
      ((atom l) (list l)) 
      (t (apply #'append (mapcar #'atomi2 l))) 
   ) 
) 
