; 11.
; a) Determine the least common multiple of the numerical values of a nonlinear list.
; b) Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain" 
; aspect if the items increase to a certain point and then decreases. 
; Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria.
; c) Remove all occurrences of a maximum numerical element from a nonlinear list.
; d) Write a function which returns the product of numerical even atoms from a list, to any level.

;a)

(defun my_gcd (e1 e2)
  (cond
    ((= e1 e2) e1)
    ((> e2 e1) (my_gcd e2 e1))
    (t (my_gcd (- e1 e2) e2))
  )
)

(print (my_gcd 15 20))

(defun my_lcm (e1 e2)
(cond
  ((or (= e1 0) (= e2 0)) 0)
  (t (floor (* e1 e2) (my_gcd e1 e2) ))
)
)

(print(my_lcm 4 2))

(defun lcmList(l)
  (cond
    ((null l) 0)
    ((null (cdr l)) (car l))
    (t (my_lcm (car l) (lcmList (cdr l))))
  )
)

(print(lcmList '(2 5 4 10)))


;b)

;;;;

;c)

(defun returnMax(e1 e2)
  (cond
    ((> e1 e2) e1)
    (t e2)
  )
)

(defun getMax (l current_max)
  (cond
    ((null l) current_max)
    ((and (atom (car l)) (> (car l) current_max)) (getMax (cdr l) (car l)))
    ((listp (car l)) (returnMax (getMax (car l) 0) (getMax (cdr l) current_max)))
    (t (getMax (cdr l) current_max))
  )
)

(print (getMax '(1 2 (10 2 (15 1))) 0))

(defun remove_occ(l e)
  (cond
    ((null l) nil)
    ((and (atom (car l)) (= e (car l))) (remove_occ (cdr l) e))
    ((listp (car l)) (append (list (remove_occ (car l) e)) (remove_occ (cdr l) e)))
    (t (append (list (car l)) (remove_occ (cdr l) e)))
  )
)

(print (remove_occ '(1 10 (2 1 (1 5)) 20 1) 1))

(defun removeOccMax(l)
  (cond
    ((null l) nil)
    (t (remove_occ l (getMax l 0))) 
  )
)

(print (removeOccMax '(1 10 3 4 (10 2 (10 3)) 10 1 2) ))


; d) Write a function which returns the product of numerical even atoms from a list, to any level.

(defun getProductEvenNumbers(l  p)
  (cond
    ((null l) p)
    ((and (numberp (car l)) (=(mod (car l) 2) 0)) (getProductEvenNumbers (cdr l) (* p (car l))))
    ((listp (car l)) (* (getProductEvenNumbers (car l) 1) (getProductEvenNumbers (cdr l) p)))
    (t (getProductEvenNumbers (cdr l) p))
  )
)

(print(getProductEvenNumbers '(1 3 4 (3 2 (1 10) 2)) 1))



