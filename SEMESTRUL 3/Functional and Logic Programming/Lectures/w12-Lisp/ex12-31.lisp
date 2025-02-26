(defun ex1 (x &optional y)
  (cond
    ((null y) x)
    (t (+ x y))
  )
)


(defun ex2 (x &rest y)
  (+ x (apply #'+ y))
)

(defun ex3 (l1 &rest l2)
  (cond
    ((null (car l2)) nil)
    (t 
      (cons 
        (mapcar #'* l1 (car l2)) 
        (apply #’ex3 (cons l1 (cdr l2))) 
      )
    )
  )
)
