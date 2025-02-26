(defmacro putprop (var val prop)
  `(setf (get ,var ,prop) ,val)
) 
  
(putprop 'ion 'mihai 'parent)     ; parent (ion) = mihai
(putprop 'mihai 'george 'parent)  ; parent (michael) = george
(putprop 'george 'emil 'parent)   ; parent (george) = emil
(putprop 'mihaela 'dan 'parent)   ; parent (mihaela) = dan
(putprop 'dan 'george 'parent)    ; parent (dan) = george

(defun ancestor (a prop)
  ((lambda (v) 
    (cond
      ((null v) nil)
      (t (cons v (ancestor v prop)))
    )
   ) (get a prop)
  )
)

(defun prim (i1 i2)
  (cond
    ((null i1) nil)
    ((member (car i1) i2) (car i1))
    (t (prim (cdr i1) i2))
  )
)

(defun common (a b prop)
  (funcall #'prim (ancestor a prop) (ancestor b prop))
) 

(common 'mihaela 'ion 'parent)
(common 'ion 'emil 'parent)
