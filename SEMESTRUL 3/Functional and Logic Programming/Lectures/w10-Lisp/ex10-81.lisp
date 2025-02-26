(defun modif (l)
  (cond 
    ((numberp l) (* 2 l))   ; operate on digital atoms
    ((atom l) l)            ; operate on non-numerical atoms
    (t (mapcar #'modif l))  ; operate recursively 
  )
)
