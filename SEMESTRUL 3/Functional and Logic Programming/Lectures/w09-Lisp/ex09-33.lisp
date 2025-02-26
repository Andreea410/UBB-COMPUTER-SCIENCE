(defun sum1 (l)
  (cond
    ((null l) 0)
    ((numberp (car l)) (+ (car l) (sum1 (cdr l))))
    (t (sum1 (cdr l)))
  )
)

(defun sum2 (l)
  (cond
    ((null l) 0)
    ((numberp (car l)) (+ (car l) (sum2 (cdr l))))
    ((atom (car l)) (sum2 (cdr l)))
    (t (+ (sum2 (car l)) (sum2 (cdr l))))
  )
)

(defun sum2a (l)
  (cond
    ((numberp l) l)
    ((atom l) 0)
    (t (+ (sum2a (car l)) (sum2a (cdr l))))
  )
)

