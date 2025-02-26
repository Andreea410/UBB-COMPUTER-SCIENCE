(defun lis1 (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) (lis1 (cdr l)))
    ((atom (car l)) (cons (car l) (lis1 (cdr l))))
    (t (append (lis1 (car l)) (lis1 (cdr l))))
  )
)

(defun lis2 (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) (lis2 (cdr l)))
    ((atom (car l)) (cons (car l) (lis2 (cdr l))))
    (t (cons (lis2 (car l)) (lis2 (cdr l))))
  )
)
