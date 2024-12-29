; 5.
; a) Write twice the n-th element of a linear list. Example: for (10 20 30 40 50) and n=3 will produce (10 
; 20 30 30 40 50).
; b) Write a function to return an association list with the two lists given as parameters. 
; Example: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)).
; c) Write a function to determine the number of all sublists of a given list, on any level. 
; A sublist is either the list itself, or any element that is a list, at any level. Example: 
; (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists:
; (list itself, (3 ...), (4 5), (6 7), (9 10)).
; d) Write a function to return the number of all numerical atoms in a list at superficial level.

;a)
(defun writeTwiceN-thElement(l n pos)
  (cond
    ((null l) nil)
    ((= n pos) (append (list(car l) (car l)) (cdr l)))
    (t (append (list (car l)) (writeTwiceN-thElement (cdr l) n (+ 1 pos))))
  )
)

(print (writeTwiceN-thElement '(10 20 30 40 50 ) 3 1 ))

;b)
(defun getAssociationList (l1 l2)
  (cond
    ((null l1) nil)
    (t (cons (cons (car l1) (car l2)) (getAssociationList (cdr l1) (cdr l2))))
  )
)

(print (getAssociationList '(A B C) '(X Y Z)))

;c)
(defun countSublists (l count)
  (cond
    ((null l) count)
    ((listp (car l)) (+ (countSublists (car l) 0) (countSublists (cdr l) (+ count 1))))
    (t (countSublists (cdr l) count))
  )
)

(print (countSublists '(1 2 (3 (4 5) (6 (10) 7)) 8 (9 10)) 1))

;d)
(defun getCountNumericalAtoms (l count)
  (cond
    ((null l) count)
    ((numberp (car l)) (getCountNumericalAtoms (cdr l) (+ 1 count)))
    (t (getCountNumericalAtoms (cdr l) count))
  )
)
(print (getCountNumericalAtoms '(1 2 3 1 2 (1 2 3) a b) 0))
