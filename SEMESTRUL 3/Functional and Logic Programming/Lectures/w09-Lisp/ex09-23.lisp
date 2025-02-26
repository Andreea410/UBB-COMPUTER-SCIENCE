(defun f (l)
  (cond
    ((atom l) nil)
    (t t)
  )
)

(setq l '(1 (2) (3 (4)))

(remove-if 'f l)
