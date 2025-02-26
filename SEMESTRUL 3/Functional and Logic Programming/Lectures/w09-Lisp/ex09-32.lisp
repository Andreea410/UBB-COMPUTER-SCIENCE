(defun sum (n l)
  (cond
    ((null l) 0)
    ((= n 0) 0)
    (t (+ (car l) (sum (- n 1) (cdr l)))
  )
)
