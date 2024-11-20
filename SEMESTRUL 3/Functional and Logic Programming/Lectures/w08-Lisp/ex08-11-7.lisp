(defun lista_1 (l) 
  (cond
    ((null l) nil)
    ((numberp (car l)) (cons (car l) (lista_1 (cdr l))))
    (t (lista_1 (cdr l)))
  )
)

(defun lista_aux (l col)
  (cond
    ((null l) col)
    ((numberp (car l)) (lista_aux (cdr l) (append col (list (car l)))))
    (t (lista_aux (cdr l) col))
  )
)

(defun lista_2 (l)
  (lista_aux l nil)
)
