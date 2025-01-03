; 14.
; a) Write a function to return the union of two sets.
; b) Write a function to return the product of all numerical atoms in a list, at any level.
; c) Write a function to sort a linear list with keeping the double values.
; d) Build a list which contains positions of a minimum numeric element from a given linear list


;a)
(defun checkIfElement (l e)
  (cond
    ((null l) nil)
    ((= e (car l)) t)
    (t (checkIfElement (cdr l) e))
  )
)

(defun unionSets(s1 s2)
(cond
  ((null s2) s1)
  ((null s1) s2)
  ((checkIfElement s2 (car s1)) (unionSets (cdr s1) s2))
  (t (cons (car s1) (unionSets (cdr s1) s2)))
)
)

(print(unionSets '(1 2 3 4 10 8 ) '(8 1 10 3 2)))

; b) Write a function to return the product of all numerical atoms in a list, at any level.

(defun getProduct (l cp)
  (cond
    ((null l) cp)
    ((listp (car l)) (* (getProduct (car l) 1) (getProduct (cdr l) cp)))
    (t (getProduct (cdr l) (* cp (car l))))
  )
)

(print (getProduct '(1 2 3 (4 5 (1))) 1))

; c) Write a function to sort a linear list with keeping the double values.

(defun sortList (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) 
     (let ((sorted-rest (sortList (cdr l))))  
       (insert-in-order (car l) sorted-rest))) 
    (t (sortList (cdr l)))))

(defun insert-in-order (elem lst)
  (cond
    ((null lst) (list elem)) 
    ((< elem (car lst)) (cons elem lst))  
    (t (cons (car lst) (insert-in-order elem (cdr lst)))))) 

(print (sortList '(10 3 8 2 9 7 2 3)))  

;d)  Build a list which contains positions of a minimum numeric element from a given linear list

(defun my_min(e1 e2)
  (cond
    ((< e1 e2) e1)
    (t e2)
  )
)


(defun minimumList(l cm)
  (cond
    ((null l) cm)
    ((< (car l) cm) (minimumList (cdr l) (car l)))
    (t (minimumList (cdr l) cm))
  )
)

(print(minimumList '(10 3 2 7 9 1 32) most-positive-fixnum))

(defun getPos (l e cp)
(cond
  ((null l) nil)
  ((= (car l) e) (cons cp (getPos (cdr l) e (+ 1 cp))))
  (t (getPos (cdr l) e (+ 1 cp)))
)
)

(defun getPosMain(l)
  (cond
    (t (getPos l (minimumList l most-positive-fixnum) 1))
  )
)

(print(getPosMain '(10 2 3 4 2 5 2)))

