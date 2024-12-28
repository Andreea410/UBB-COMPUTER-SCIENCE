;1.
;a) Write a function to return the n-th element of a list, or NIL if such an element does not exist.
;b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.
;c) Write a function to determine the list of all sublists of a given list, on any level. 
 ;A sublist is either the list itself, or any element that is a list, at any level. Example: 
 ;(1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
 ;( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )
;d) Write a function to transform a linear list into a set.

;a)

(defun getN-thElement(l e pos)
  (cond
    ((null l) NIL)
    ((= pos e) (car l))
    (t (getN-thElement (cdr l) e (+ pos 1)))
  )
)


(print (getN-thElement'(1 2 3 4) 5 1))

;b)

(defun checkIfElement(l e)
  (cond 
    ((null l) NIL)
    ((and (atom (car l)) (equal (car l) e)) t)
    ((listp (car l)) (or (checkIfElement (car l) e) (checkIfElement (cdr l) e)))
    (t (checkIfElement (cdr l) e))
  )
)

(print (checkIfElement '(1 2 (4 5 6 (9 10)) 3 4) 11))

;c)

(defun getAllSublists (l)
  (cond
    ((atom l) NIL)
    (t (append (list l) (apply 'append(mapcar 'getAllSublists l))))
  )
)

(print (getAllSublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))))


;d)



(defun transformIntoSet (l)
  (cond
    ((null l) NIL)
    ((checkIfElement (cdr l) (car l)) (transformIntoSet (cdr l)))
    (t (append (list (car l)) (transformIntoSet (cdr l))))
  )
)

(print(transformIntoSet '(1 2 2 1)))
