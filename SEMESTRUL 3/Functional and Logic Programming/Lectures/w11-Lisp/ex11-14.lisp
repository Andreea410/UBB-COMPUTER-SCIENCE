(defun lista (L n)  
  (cond  
    ((and (= n 0) (atom L)) (list L))  
    ((= n 0) nil)  
    ((atom L) nil)  
    (t (mapcan #'(lambda(L) (lista L (- n 1)) ) L))  
  ) 
)    
