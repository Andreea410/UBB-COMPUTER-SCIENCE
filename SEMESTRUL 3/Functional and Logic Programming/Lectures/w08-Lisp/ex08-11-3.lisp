(defun myreverse_1 (l)
  (cond 
    ((atom l) l)
    (t (append (myreverse_1 (cdr l)) (list (car l)))) 
  )
)

(defun myreverse_aux (l col)
  (cond 
    ((null l) col)
    (t (myreverse_aux (cdr l) (cons (car l) col))) 
  )
)

(defun myreverse_2 (l)  
  (myreverse_aux  l ()) 
)
