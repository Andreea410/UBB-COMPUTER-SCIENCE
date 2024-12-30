; 8.
; a) Write a function to return the difference of two sets.
; b) Write a function to reverse a list with its all sublists, on all levels.
; c) Write a function to return the list of the first elements of all list elements of a given list
;with an odd number of elements at superficial level. Example:
; (1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).
; d) Write a function to return the sum of all numerical atoms in a list at superficial level.


;a)

(defun checkIfElementExists(l e)
  (cond
    ((null l) nil)
    ((= (car l) e) t)
    (t (checkIfElementExists (cdr l) e))
  )
)

(print (checkIfElementExists '(1 2 3 4) 5))

(defun getDifference (s1 s2)
  (cond
    ((null s1) nil)
    ((null s2) s1)
    ((checkIfElementExists s2 (car s1)) (getDifference (cdr s1) s2))
    (t (append (list(car s1)) (getDifference (cdr s1) s2)))
  )
  
)

(print (getDifference '(1 5 2 9 10 3 12 0 11) '(2 11 9 0 3)))

;b)

(defun reverseList (l)
  (cond
    ((null l) nil)
    ((listp (car l)) (append (list (reverseList (car l))) (reverseList (cdr l))))
    (t (append  (reverseList (cdr l)) (list(car l))))
  )
)

(print (reverseList '(1 2 3 4 (5 6 (7 8 (9))))))

;c)

(defun verifyIfOddLength (l count)
  (cond
    ((and (null l) (= (mod count 2) 0)) nil)
    ((and (null l) (= (mod count 2) 1)) t)
    (t (verifyIfOddLength (cdr l) (+ count 1)))
  )
)

(print(verifyIfOddLength '(3 (4 5) (6 7) 4) 0))

(defun getFirstElement (l)
  (cond
    ((null l) nil)
    ((atom (car l)) (car l))
    (t (getFirstElement (cdr l)))
  )
)

(print(getFirstElement '(6 (7 9))))

(defun getListFirstElement (l)
  (cond
    ((null l) nil)
    ((and (listp (car l)) (verifyIfOddLength (car l) 0)) (append (list (getFirstElement (car l))) (getListFirstElement (cdr l))))
    (t (getListFirstElement (cdr l)))
  )
)

(defun getListFirstElementMain(l)
  (cond
    ((null l) nil)
    ((verifyIfOddLength l 0) (append (list (getFirstElement l)) (getListFirstElement l)))
    (t (getListFirstElement l))
  )
)

(print (getListFirstElementMain '(1 2 (3 (4 5) (6 7)) 8 (9 10 11))))

;d)

(defun returnSum (l current_sum)
  (cond
    ((null l) current_sum)
    ((numberp (car l)) (returnSum (cdr l) (+ current_sum (car l))))
    (t (returnSum (cdr l) current_sum))
  )
)

(defun returnSumMain (l)
  (cond
    ((null l) 0)
    (t (returnSum l 0))
  )
)
(print(returnSumMain '(1 2 3 4 (9 98))))
