(defun myappend (l1 l2)
	(cond
		((null l1) l2)
		(t (cons (car l1) (myappend (cdr l1) l2)))
	)
)

(defun mymember (el li)
	(cond
		((atom li) nil)
		((equal el (car li)) li)
		(t (mymember el (cdr li)))
	)
)
