(defun lpair (e l)
  (cond
    ((null l) nil)
    (t (cons (list e (car l)) (lpair e (cdr l))))
  )
)
