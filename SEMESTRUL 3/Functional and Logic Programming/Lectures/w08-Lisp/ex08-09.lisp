(defun myfirst (x)
  (cond
    ((atom x) x)
    ((null x) nil) ; useless
    (t (car x))
  )
)

(defun mymax (x y)
	(cond
		((> x y) x)
		(t y)
	)
)

(defun mylast (x)
	(cond
		((atom x) x)
		((null (cdr x)) (car x))
		(t (mylast (cdr x)))
	)
)

(defun xcar (x)
	(cond
		((atom x) nil)
		(t (car x))
	)
)

