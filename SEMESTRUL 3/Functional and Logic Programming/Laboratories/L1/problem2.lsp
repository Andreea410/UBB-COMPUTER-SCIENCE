;2.
;a) Write a function to return the product of two vectors.
;https://en.wikipedia.org/wiki/Dot_product
;b) Write a function to return the depth of a list. Example: the depth of a linear list is 1.
;c) Write a function to sort a linear list without keeping the double values.
;d) Write a function to return the intersection of two sets.

;a)
(defun returnProductOfTwoVectors (v1 v2)
  (cond
    ((null v1) 0)
    ((null v2) 0)
    (t (+ (*(car v1) (car v2)) (returnProductOfTwoVectors (cdr v1) (cdr v2))))
  )
)

(print(returnProductOfTwoVectors '(1 2 3) '(3 2 3)))

;b)

(defun getMax (a b) 
  (cond
  ((> a b) a)
  (t b)
  )
)

(print(getMax '10 '2))

(defun returnDepthOfList (l currentMax)
  (cond
    ((null l) currentMax)
    ((listp (car l)) (getMax (returnDepthOfList (car l) (+ 1 currentMax)) (returnDepthOfList (cdr l) currentMax)))
    (t (returnDepthOfList (cdr l) currentMax))
  )
)

(print(returnDepthOfList '(1 2 (1 (1 2) 2) (2 3) 3) '1))

;c)

(defun addToList (l e)
  (cond
    ((null l) (list e))
    ((= (car l) e) l)
    ((< e (car l)) (cons e l))
    (t (cons (car l) (addToList (cdr l) e)))
  )
)

(defun sortList (l)
  (cond
    ((null l) nil)
    (t (addToList (sortList (cdr l)) (car l)))
  )
)

(print (sortList '(1 10 4 28 2 1 15 4 3)))


;d)

(defun checkIfElementExists (l e)
  (cond
    ((null l) nil)
    ((equal (car l) e) t)
    (t (checkIfElementExists (cdr l) e))
  )
)

(print(checkIfElementExists '(1 2 3 4) '5))

(defun intersectionOfTwoSets (s1 s2)  
  (cond
    ((null s1) s2)
    ((null s2) s1)
    ((checkIfElementExists s2 (car s1)) (intersectionOfTwoSets (cdr s1) s2))
    (t (append (list (car s1)) (intersectionOfTwoSets (cdr s1) s2)))
  )
)

(print(intersectionOfTwoSets '(1 2 3 4 5 10 7 9) '(2 3 4 5 6)))
