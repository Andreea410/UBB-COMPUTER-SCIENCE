(defun add (e l)
  (cond
    ((null l) (list e)) ; (list e) or (cons e nil) 
    (t (cons (car l) (add e (cdr l))))
   )
)
