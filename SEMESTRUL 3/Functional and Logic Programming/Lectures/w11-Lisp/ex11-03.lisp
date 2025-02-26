(defun lg (l) 
  (cond 
      ((atom l) 1) 
      (t (apply #'+ (mapcar 'lg l))) 
   ) 
) 
