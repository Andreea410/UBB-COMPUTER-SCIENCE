(defun myset (varlist vallist)
  (mapc #'set varlist vallist)
)

(myset '(a b c) '(1 2 3))
