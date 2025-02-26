(defun first1 (l)
  (cond
    ((null l) nil)
    ((atom (car l)) (car l))
    (t (first1 (cdr l)))
  )
)

(defun first2 (l)
  (cond
    ((null l) nil)
    ((atom (car l)) (car l))
    (t (first2 (car l)))
  )
)
