(defmacro inc1 (n)
  (list 'setf n (list '+ 1 n))
)

(defmacro inc2 (n)
  (subst n 'n '(setf n (+ 1 n)))
)

(defmacro inc3 (n)
  `(setf ,n (+ 1 ,n))
)
