(defun inc1 (number)
  (+ number 1)
)

(defun inc2 (number increment)
  (+ increment number)
)

(defun inc3 (number &optional increment)
  (cond
    ((null increment) (+ number 1))
    (t (+ increment number))
  )
)

(defun inc4 (number &optional (increment 1))
  (+ increment number)
)

(defun inc5 (number &rest increment)
  (cond
    ((null increment) (+ number 1))
    (t (+ number (apply #'+ increment)))
  )
)
