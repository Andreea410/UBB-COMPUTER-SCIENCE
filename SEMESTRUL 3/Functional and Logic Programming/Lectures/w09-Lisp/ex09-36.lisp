(defun ins (e n l)
  (cond
    ((= n 1) (cons e l))
    (t (cons (car l) (ins e (- n 1) (cdr l))))
  )
)
