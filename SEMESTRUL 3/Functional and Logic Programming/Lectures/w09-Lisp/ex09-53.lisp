(defun insFirst (e l)
  (cond
    ((null l) nil)
    (t (cons (cons e (car l)) (insFirst e (cdr l))))
  )
)

(defun subSet(l)
  (cond
    ((null l) (list nil))
    (t (append (subSet (cdr l)) (insFirst (car l) (subSet (cdr l)))))
  )
)
