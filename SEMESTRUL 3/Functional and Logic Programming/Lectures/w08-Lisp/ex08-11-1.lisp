(defun suma1 (l)
  (cond
    ((null l) 0)
    ((numberp (car l)) (+ (car l) (suma1 (cdr l))))
    ((atom (car l)) (suma1 (cdr l)))
    (T (+ (suma1 (car l)) (suma1 (cdr l))))
  )
)

(defun suma2 (l)
  (cond
    ((numberp l) l)
    ((atom l) 0)
    (T (+ (suma2 (car l)) (suma2 (cdr l))))
  )
)


