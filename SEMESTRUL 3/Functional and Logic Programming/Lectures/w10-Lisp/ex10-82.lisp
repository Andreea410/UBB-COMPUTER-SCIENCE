(defun lgm (l)
  (cond 
    ((atom l) 0)
    (t (max (length l) (apply #'max (mapcar #'lgm l))))
  )
)
