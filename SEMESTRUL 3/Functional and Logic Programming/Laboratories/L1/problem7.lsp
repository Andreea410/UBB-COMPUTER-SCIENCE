; 7.
; a) Write a function to eliminate the n-th element of a linear list.
; b) Write a function to determine the successor of a number represented digit by digit as a list, without 
; transforming the representation of the number from list to number. Example: (1 9 3 5 9 9) --> (1 9 3 6 0 
; 0)
; c) Write a function to return the set of all the atoms of a list.
; Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)
; d) Write a function to test whether a linear list is a set.


;a)

(defun eliminateN-thElement (l n pos)
  (cond
    ((null l) nil)
    ((= pos n ) (cdr l))
    (t (append (list (car l)) (eliminateN-thElement (cdr l) n (+ 1 pos))))
  )
)

(print (eliminateN-thElement '(1 2 3 4) 2 1))

(defun eliminateN-thElementMain (l n)
  (cond
    ((null l) nil)
    (t (eliminateN-thElement l n 1))
  )
)

(print (eliminateN-thElementMain '(1 2 3 4) 1 ))

;b)

(defun invertList (l)
  (cond
    ((null l) nil)
    (t (append (invertList (cdr l)) (list (car l))))
  )
)

(print (invertList '(1 9 3 5 9 9)))

(defun determineSuccesor (l carry)
  (cond
    ((and (null l) (> carry 0)) (list carry))
    ((null l) nil)
    (t (cons (mod (+ (car l) carry) 10) (determineSuccesor (cdr l) ( floor (+(car l) carry) 10))))
  )
)

(print (determineSuccesor '(9 2 3) 1))

(defun determineSuccesorMain (l)
  (cond
    ((null l) nil)
    (t (invertList (determineSuccesor (invertList l) 1)))
  )
)

(print (determineSuccesorMain '(1 9 3 5 9 9)))

;c)

(defun checkIfExists (l e)
  (cond
  ((null l) nil)
  ((and (atom (car l)) (= (car l) e)) t)
  ((listp (car l)) (or (checkIfExists (car l) e) (checkIfExists (cdr l) e)))
  (t (checkIfExists (cdr l) e))
)
)

(print (checkIfExists '(1 2 (10 11 (12))) 3))

(defun returnSetAtoms (l)
  (cond
    ((null l) nil)
    ((atom (car l)) (cons (car l) (returnSetAtoms (cdr l))))
    (t (append (returnSetAtoms (car l)) (returnSetAtoms (cdr l))))
  )
)

(print (returnSetAtoms '(1 (2 (1 3 (2 4) 3) 1) (1 4))))

(defun removeDuplicates (l)
  (cond
    ((null l) nil)
    ((checkIfExists (cdr l) (car l)) (removeDuplicates (cdr l)))
    (t (append (list (car l)) (removeDuplicates (cdr l))))
  )
)

(defun returnSetAtomsMain (l)
  (cond
    ((null l) nil)
    (t (removeDuplicates (returnSetAtoms l)))
  )
)

(print (returnSetAtomsMain '(1 (2 (1 3 (2 4) 3) 1) (1 4))))

;d)

(defun testIfSet(l)
(cond
  ((null l) t)
  ((checkIfExists (cdr l) (car l)) nil)
  (t (testIfSet (cdr l)))
)
)

(print (testIfSet '(1 2 3 4 2 5 6)))
