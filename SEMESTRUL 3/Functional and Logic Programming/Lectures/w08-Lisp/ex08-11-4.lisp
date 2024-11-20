(defun lista (e l)
  (cond
    ((null l) nil)
    (t (cons (list e (car l)) (lista e (cdr l))))
  )
)
