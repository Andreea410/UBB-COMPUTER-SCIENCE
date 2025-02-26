(defun insFirst (e l)
  (cond
    ((null l) nil)
    (t (cons (cons e (car l)) (insFirst e (cdr l))))
  )
)

(defun subm (l)
  (cond
    ((null l) (list nil))
    (t ((lambda (s)
          (append s (insPrimaPoz (car l) s))
        )
        (subm (cdr l))
       )
    )
  )
)
