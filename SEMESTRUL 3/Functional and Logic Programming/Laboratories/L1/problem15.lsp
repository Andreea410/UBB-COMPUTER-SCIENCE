; 15.
; a) Write a function to insert an element E on the n-th position of a linear list.
; b) Write a function to return the sum of all numerical atoms of a list, at any level.
; c) Write a function to return the set of all sublists of a given linear list. Ex. For list ((1 2 3) ((4 5) 6)) => 
; ((1 2 3) (4 5) ((4 5) 6)) 
; d) Write a function to test the equality of two sets, without using the difference of two sets.


; a) Write a function to insert an element E on the n-th position of a linear list.
(defun insert_element(l e n cp)
  (cond
    ((null l) nil)
    ((= n cp) (cons e l))
    (t (cons (car l) (insert_element (cdr l) e n (+ 1 cp))))
  )
)

(print(insert_element '(1 2 3 4 5) 10 2 1))

; b) Write a function to return the sum of all numerical atoms of a list, at any level.

(defun returnSum(l cs)
  (cond
    ((null l) cs)
    ((listp (car l)) (+ (returnSum (car l) 0) (returnSum (cdr l) cs)))
    (t (returnSum (cdr l) (+ cs (car l))))
  )
)

(print (returnSum '(10 2 (3 4)) 0))

; c) Write a function to return the set of all sublists of a given linear list. Ex.
;For list ((1 2 3) ((4 5) 6)) => 
; ((1 2 3) (4 5) ((4 5) 6))

(defun getSet(l)
  (cond
    ((null l) nil)
    ((listp (car l)) (append (list (car l)) (getSet (car l)) (getSet (cdr l))))
    (t (getSet (cdr l)))
  )
)

(print(getSet '((1 2 3) ((4 5) 6))))

; d) Write a function to test the equality of two sets, without using the difference of two sets.

(defun removeElement (l e)
  (cond
    ((null l) nil)
    ((= (car l) e) (removeElement (cdr l) e))
    (t (cons (car l) (removeElement (cdr l) e)))
  )
)

(defun checkElementExists (l e)
  (cond
    ((null l) nil)
    ((= (car l) e) t)
    (t (checkElementExists (cdr l) e))
  )
)

(print(removeElement '(10 3 2 8 10 5 6) 10))

(defun checkIfEqual(s1 s2)
  (cond
    ((and (null s1) (null s2)) t)
    ((null s1) nil)
    ((null s2) nil)
    ((checkElementExists s2 (car s1)) (checkIfEqual (cdr s1) (removeElement s2 (car s1))))
    (t nil)
  )
)

(print (checkIfEqual '(10 3 4 2) '(2 10 4 3)))
