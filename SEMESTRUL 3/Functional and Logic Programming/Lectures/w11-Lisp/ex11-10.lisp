; a. recursive, without MAP functions 
 
(defun invers1 (l) 
  (cond 
    ((null l) nil) 
    ((atom (car l)) (append (invers1 (cdr l)) (list (car l)))) 
     (t (append (invers1 (cdr l)) (invers1 (car l)))) 
  ) 
) 
 
; b. using map functions 
 
(defun invers2 (l) 
  (cond 
     ((atom l) (list l)) 
      (t (mapcan #'invers2 (reverse l))) 
   ) 
) 

; c. wrong versionn using mapcar

(defun invers3 (l) 
  (cond 
     ((atom l) l) 
      (t (mapcar #'invers3 (reverse l))) 
   ) 
) 
