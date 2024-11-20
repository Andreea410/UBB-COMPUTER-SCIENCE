(defun traverse_aux (L k col)
  (cond
    ((null L) nil)
    ((= k 0) (list col L))
    (t (traverse_aux (cdr L) (- k 1) (cons (car l) col)))
  )
)

(defun traverse (L k)
  (traverse_aux L k nil)
)
