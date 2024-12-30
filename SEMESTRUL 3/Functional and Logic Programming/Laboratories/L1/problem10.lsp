; 10.
; a) Write a function to return the product of all the numerical atoms from a list, at superficial level.
; b) Write a function to replace the first occurence of an element E in a given list with an other element 
; O.
; c) Write a function to compute the result of an arithmetic expression memorised 
; in preorder on a stack. Examples:
; (+ 1 3) ==> 4 (1 + 3)
; (+ * 2 4 3) ==> 11 [((2 * 4) + 3)
; (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))
; d) Write a function to produce the list of pairs (atom n), where atom appears for n times in the parameter 
; list. Example:
; (A B A B A C A) --> ((A 4) (B 2) (C 1)).

;a)

(defun getProduct (l current_product)
  (cond
    ((null l) current_product)
    ((listp (car l)) (getProduct (cdr l) current_product))
    ((= (car l) 0) 0)
    (t (getProduct (cdr l) (* current_product (car l))))
  )
)

(print(getProduct '(1 5 2 3 (10 200 (30))) 1))

;b)

(defun replaceElement (l E O)
  (cond
    ((null l) nil)
    ((listp (car l)) (append (list (replaceElement (car l) E O)) (replaceElement (cdr l) E O)))
    ((= (car l) E) (append (list O) (replaceElement (cdr l) E O)))
    (t (append (list (car l)) (replaceElement (cdr l) E O)))
  )
)

(print (replaceElement '(1 2 3 2 (2 20 (2) 2)) 2 9))

;c)

(defun calculateExpression (op a b)
  (cond
    ((string= op "+") (+ a b))
    ((string= op "-") (- a b))
    ((string= op "*") (* a b))
    ((string= op "/") (floor a b))
  )
)

(print(calculateExpression "+" 2 3))

(defun findExpression (exp)
  (cond
    ((null exp) nil)
    ((and (atom (car exp)) (numberp (cadr exp)) (numberp (caddr exp))) (cons (calculateExpression (car exp) (cadr exp) (caddr exp)) (findExpression (cdddr exp))))
    (t (cons (car exp) (findExpression (cdr exp))))
  )
)

(defun solve (exp)
  (cond
    ((null (cdr exp)) (car exp))
    (t (solve (findExpression exp)))
  )
)

(print(solve '(+ * 2 4 - 5 * 2 2)))

;d)

(defun count_occurences(l e count)
  (cond
    ((null l) count)
    ((and (atom (car l)) (equal (car l) e)) (count_occurences (cdr l) e (+ count 1)))
    (t (count_occurences (cdr l) e count))
  )
)

(print (count_occurences '(A B A B A C A)' A 0))

(defun removeOcc(l e)
  (cond
    ((null l) nil)
    ((equal (car l) e) (removeOcc (cdr l) e))
    (t (cons (car l) (removeOcc (cdr l) e)))
  )
)

(defun getListOcc(l)
  (cond
    ((null l) nil)
    (t (append (list (append (list (car l)) (list (count_occurences l (car l) 0)))) (getListOcc (removeOcc (cdr l) (car l)))))
  )
)

(print( getListOcc '(A B A B A C A)))








