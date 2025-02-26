(defun nr (l) 
   (cond 
      ((null (cdr l)) 1) 
      (t (+ 1 (apply #'+ (mapcar #'nr (cdr l)))) 
   ) 
) 
