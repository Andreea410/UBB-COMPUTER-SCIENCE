(defun colsVar (l) 
  (cond 
    ((null (car l)) nil) 
    (t (cons (mapcar #'car l) (cols (mapcar #'cdr l)))) 
  )
) 
 
(defun cols (l)
  (apply #'mapcar #'list l)
)

(defun pr1 (l1 l2)
  (apply #'+ (mapcar #'* l1 l2))
)
  
(defun pr2 (l1 m2)
  (mapcar #'(lambda (l) (pr1 l1 l)) m2)
)

(defun pr (m1 m2)
  (mapcar #'(lambda (l) (pr2 l m2)) m1)
)

(defun product (m1 m2) 
  (pr m1 (cols m2))
)
