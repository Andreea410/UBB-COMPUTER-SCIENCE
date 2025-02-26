(defun verif (l) 
   (defun myand (l) 
      (cond 
         ((null l) t) 
         ((not (car l)) nil) 
         (t (myand (cdr l))) 
      ) 
   ) 
   (cond 
      ((atom l) t) 
      ((not (even l)) nil) 
      (t (funcall #'myand (mapcar #'verif l))) 
   ) 
) 
