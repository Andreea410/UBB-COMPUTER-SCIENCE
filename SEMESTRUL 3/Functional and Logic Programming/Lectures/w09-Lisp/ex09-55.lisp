(defun inserare (e tree)
  (cond
    ((null tree) (list e))
    ((<= e (car tree)) (list (car tree) (inserare e (cadr tree)) (caddr tree)))
    (t (list (car tree) (cadr tree) (inserare e (caddr tree))))
  )
)

(defun construire (l)
  (cond
    ((null l) nil)
    (t (inserare (car l) (construire (cdr l))))
  )
)

(defun inordine (arb)
  (cond
    ((null arb) nil)
    (t (append (inordine (cadr arb)) (list (car arb)) (inordine (caddr arb))))
  )
)

(defun sort (l)
  (inordine 
    (construire l)
  )
)
