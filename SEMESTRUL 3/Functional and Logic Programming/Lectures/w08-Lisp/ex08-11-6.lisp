(defun dublare_1 (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) (cons (* 2 (car l)) (dublare_1 (cdr l))))
    ((atom (car l)) (cons (car l) (dublare_1 (cdr l))))
    (t (cons (dublare_1 (car l)) (dublare_1 (cdr l))))
  )
)

(defun dublare_2 (l)
  (cond
    ((numberp l) (* 2 l))
    ((atom l) l)
    (t (cons (dublare_2 (car l)) (dublare_2 (cdr l))))
  )
)
