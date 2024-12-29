; 6.
; a) Write a function to test whether a list is linear.
; b) Write a function to replace the first occurence of an element E in a given list with an other element 
; O.
; c) Write a function to replace each sublist of a list with its last element.
; A sublist is an element from the first level, which is a list.
; Example: (a (b c) (d (e (f)))) ==> (a c (e (f))) ==> (a c (f)) ==> (a c f)
; (a (b c) (d ((e) f))) ==> (a c ((e) f)) ==> (a c f)
; d) Write a function to merge two sorted lists without keeping double values

;a)

(defun checkIfListLinear (l) 
  (cond
    ((null l) t)
    ((listp (car l)) nil)
    (t (checkIfListLinear (cdr l)))
  )
)

(print(checkIfListLinear '(1 2 3 (4 1) 2)))

;b)

(defun replaceFirstOcc (l E O)
  (cond
    ((null l) nil)
    ((= (car l) E) (append (list O) (cdr l)))
    (t (append (list (car l)) (replaceFirstOcc (cdr l) E O)))
  )
)

(print (replaceFirstOcc '(1 2 3) 1 2))

;c)

(defun getLastElement(l)
  (cond
    ((and (null (cdr l)) (atom (car l))) (car l))
    ((null (cdr l)) (getLastElement (car l)))
    (t (getLastElement (cdr l)))
  )
)

(print (getLastElement '(a (b c))))

(defun replaceSublist (l)
  (cond
    ((null l) nil)
    ((listp (car l)) (append (list (getLastElement (car l))) (replaceSublist (cdr l))))
    (t (append (list (car l)) (replaceSublist (cdr l))))
  )
)

(print (replaceSublist '(a (b c (d (g))) (d (e (f))))))

;d)

(defun mergeLists (l1 l2)
  (cond
    ((null l1) l2)
    ((null l2) l1)
    ((= (car l1) (car l2)) (mergeLists (cdr l1) l2))
    ((< (car l1) (car l2)) (append (list (car l1)) (mergeLists (cdr l1) l2)))
    (t (append (list (car l2)) (mergeLists l1 (cdr l2))))
  )
)

(print (mergeLists '(1 5 6 10 ) '(6 9 11 )))
