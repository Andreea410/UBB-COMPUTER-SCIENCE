(defun test (l)
  (cond
    ((null l) t)
    ((test1 (car l)) (test (cdr l)))
    (t nil)
  )
)

(defun test1 (l)
  (cond 
    ((null l) t)
    ((numberp (car l)) (test1 (cdr l)))
    (t nil)
  )
)
