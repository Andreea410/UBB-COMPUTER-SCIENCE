(defun gencar1 (f l)
  (prog (r)
    (cond
      ((null l) nil)
      ((setq r (funcall f (car l)))
       (return (cons r (gencar1 f (cdr l)))))
    )
  )
)
