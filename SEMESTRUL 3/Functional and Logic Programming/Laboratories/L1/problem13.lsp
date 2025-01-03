; 13.
; a) A linear list is given. Eliminate from the list all elements from N to N steps, N-given.
; b) Write a function to test if a linear list of integer numbers has a "valley" aspect (a list has a valley 
; aspect if the items decrease to a certain point and then increase. Eg. 10 8 6 17 19 20). A list must have 
; at least 3 elements to fullfill this condition.
; c) Build a function that returns the minimum numeric atom from a list, at any level.
; d) Write a function that deletes from a linear list of all occurrences of the maximum element.

; a) A linear list is given. Eliminate from the list all elements from N to N steps, N-given.

(defun eliminateFromSteps (l N current_pos)
  (cond
    ((null l) nil)
    ((= (mod current_pos N) 0) (eliminateFromSteps (cdr l) N (+ 1 current_pos)))
    (t (cons (car l) (eliminateFromSteps (cdr l) N (+ 1 current_pos))))
  )
)

(print (eliminateFromSteps '(1 2 3 4 5 6) 2 1))

;b)
;--------------

;c)
(defun my_min(e1 e2)
  (cond
    ((< e1 e2) e1)
    (t e2)
  )
)


(defun getMinimum (l current_min)
  (cond
    ((null l) current_min)
    ((listp (car l)) (my_min (getMinimum (car l) current_min) (getMinimum (cdr l) current_min)))
    ((and (atom (car l)) (< (car l) current_min)) (getMinimum (cdr l) (car l)))
    (t (getMinimum (cdr l) current_min))
  )
)

(defun getMinimumMain(l)
  (cond
    (t (getMinimum l most-positive-fixnum))
  )
)

(print (getMinimumMain '(10 12 34 (12 1))))

; d) Write a function that deletes from a linear list of all occurrences of the maximum element.

(defun my_max(e1 e2)
  (cond
    ((> e1 e2) e1)
    (t e2)
  )
)

(defun getMaximum(l current_max)
  (cond
    ((null l) current_max)
    ((listp (car l)) (my_max (getMaximum (car l) current_max) (getMaximum (cdr l) current_max)))
    ((and (atom (car l)) (> (car l) current_max)) (getMaximum (cdr l) (car l)))
    (t (getMaximum (cdr l) current_max))
  )
)

(defun deleteOccMaxNumber (l e)
  (cond
    ((null l) nil)
    ((= (car l) e) (deleteOccMaxNumber (cdr l) e))
    (t (cons (car l) (deleteOccMaxNumber (cdr l) e)))
  )
)

(defun deleteOccMain(l)
  (cond
    (t (deleteOccMaxNumber l (getMaximum l most-negative-fixnum)))
  )
)

(print (deleteOccMain '(1 2 10 2 10)))
