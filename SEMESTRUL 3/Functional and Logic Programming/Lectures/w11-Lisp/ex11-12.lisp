(defun nrap (e L)  
   (cond  
      ((equal L e) 1)  
      ((atom L) 0)  
      (t (apply #'+ (mapcar #'(lambda(L) (nrap e L) ) l ) )) 
   )
) 
