(defun myremove (e l)
  (cond
    ((atom l) l)
    ((eql (car l) e) (myremove e (cdr l)))
    (t (cons (car l) (myremove e (cdr l))))
  )
)
