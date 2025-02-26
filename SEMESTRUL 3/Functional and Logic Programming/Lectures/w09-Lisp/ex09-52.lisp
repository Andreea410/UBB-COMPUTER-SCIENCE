(defun find_left (tree nodes edges)
  (cond
   	((null tree) nil)
    ((= nodes (+ 1 edges)) nil)
    (t (cons (car tree) 
             (cons (cadr tree) 
                   (find_left (cddr tree) (+ 1 nodes) (+ (cadr tree) edges))
             )
       )
    )
  )
)

(defun left (tree)
  (find_left (cddr tree) 0 0)
)

(defun find_right (tree nodes edges)
  (cond
   	((null tree) nil)
    ((= nodes (+ 1 edges)) tree)
    (t (find_right (cddr tree) (+ 1 nodes) (+ (cadr tree) edges)))
  )
)

(defun right (tree)
  (find_right (cddr tree) 0 0)
)

