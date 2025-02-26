(defun length (l)
  (prog ((lung 0))
    cycle
    (cond
      ((null l) (return lung))
      (t
        (setq lung (+ lung 1))
        (setq l (cdr l))
        (go cycle)
      )
    )
  )
)
