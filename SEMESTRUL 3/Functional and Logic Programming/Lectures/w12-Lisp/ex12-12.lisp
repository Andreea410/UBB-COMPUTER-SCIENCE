(defun gencar1 (f l)
  (prog (r rez) ; both variables are local; initialized with nil
    cycle
    (cond
      ((null l) nil)
      (t
        (setq r (funcall f (car l)))
        (setq rez (cons r rez) l (cdr l))
        (go cycle)
      )
    )
    (return (reverse rez))
  )
)
