(defun gen (f l)
  (cond 
    ((null l) t)
    ((funcall f (car l)) (gen f (cdr l)))
    (t nil)
  )
)

(defun lin (l)
  (gen #'(lambda (l)
      (gen #'numberp l)
    )
    l
  )
)
