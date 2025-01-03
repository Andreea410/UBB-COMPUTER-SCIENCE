; 12.
; a) Write a function to return the dot product of two vectors. https://en.wikipedia.org/wiki/Dot_product
; b) Write a function to return the maximum value of all the numerical atoms of a list, at any level.
; c) All permutations to be replaced by: Write a function to compute the result of an arithmetic expression
; memorised 
; in preorder on a stack. Examples:
; (+ 1 3) ==> 4 (1 + 3)
; (+ * 2 4 3) ==> 11 [((2 * 4) + 3)
; (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))
; d) Write a function to return T if a list has an even number of elements on the first level, and NIL on the 
; contrary case, without counting the elements of the list


;a)

(defun my_dot_product(v1 v2 p)
  (cond
    ((null v1) p)
    (t (my_dot_product (cdr v1) (cdr v2) (+ p (* (car v1) (car v2)))))
  )
)

(print(my_dot_product '(1 3 -5) '(4 -2 -1) 0))

;b)

(defun my_max(e1 e2)
  (cond
    ((> e1 e2) e1)
    (t e2)
  )
)

(defun getMaxValue(l  current_max)
  (cond
    ((null l) current_max)
    ((listp (car l)) (my_max (getMaxValue (car l) 0) (getMaxValue (cdr l) current_max)))
    ((> (car l) current_max) (getMaxValue (cdr l) (car l)))
    (t (getMaxValue (cdr l) current_max))
  )
)

(print(getMaxValue '(1 2 3 10 (20 15)) 0))

;c)

(defun evalExpression(op e1 e2)
  (cond
    ((string= op "+") (+ e1 e2))
    ((string= op "-") (- e1 e2))
    ((string= op "*") (* e1 e2))
    ((string= op "/") (floor e1 e2))
  )
)

(defun find_exp(l)
  (cond
    ((null l)nil)
    ((and (atom (car l)) (numberp (cadr l)) (numberp (caddr l))) (append (list(evalExpression (car l) (cadr l) (caddr l))) (find_exp (cdddr l))))
    (t (append (list(car l)) (find_exp (cdr l))))
  )
)

(defun solve(l)
  (cond
    ((null l) nil)
    ((null (cdr l)) (car l))
    (t (solve (find_exp l)))
  )
)

(print (solve '(+ * 2 4 3)))

;; d) Write a function to return T if a list has an even number of elements on the first level,
;;and NIL on the 
; contrary case, without counting the elements of the list


(defun checkIfEvenLength (l flag)
  (cond
    ((and (null l) (= flag 0)) nil)
    ((and (null l) (= flag 1)) t)
    (t (checkIfEvenLength (cdr l) (- 1 flag)))
  )
)

(defun checkIfEvenLengthMain(l)
  (cond
    ((null l) t)
    (t (checkIfEvenLength l 1))
  )
)

(print(checkIfEvenLengthMain '(1 2 3 4)))
