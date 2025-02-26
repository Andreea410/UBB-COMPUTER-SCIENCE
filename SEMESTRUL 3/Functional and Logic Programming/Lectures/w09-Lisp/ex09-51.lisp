(defun inorder (l)
  (cond
    ((null l) nil)
    (t (append (inorder (cadr l)) (list (car l)) (inorder (caddr l)))) 
  )
)
