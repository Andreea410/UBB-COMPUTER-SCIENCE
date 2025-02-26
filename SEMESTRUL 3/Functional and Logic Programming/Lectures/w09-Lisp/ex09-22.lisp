(defun mysubst (e1 e2 e3)
  (cond
    ((equal e2 e3) e1)
    ((atom e3) e3)
    (t (cons (mysubst e1 e2 (car e3)) (mysubst e1 e2 (cdr e3))))
  )
)
