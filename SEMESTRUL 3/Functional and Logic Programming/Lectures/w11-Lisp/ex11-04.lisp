(defun even (l) 
  (cond 
    ((= 0 (mod (length l) 2)) t) 
    (t nil) 
  ) 
) 
 
(defun nr (l) 
  (cond 
    ((atom l) 0) 
    ((even l) (+ 1 (apply #'+ (mapcar #'nr l)))) 
    (t (apply #'+ (mapcar #'nr l))) 
  ) 
)    

(defun nr1 (l) 
  (cond 
    ((atom l) 0) 
    (t (+ (if (even l) 1 0) 
       (apply #'+ (mapcar #'nr1 l)))) 
  ) 
)    
