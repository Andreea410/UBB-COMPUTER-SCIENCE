(defun sum (e &rest l)
  (cond 
    ((null l) e)
    (t (+ e (apply #'sum l)))
  )
)
