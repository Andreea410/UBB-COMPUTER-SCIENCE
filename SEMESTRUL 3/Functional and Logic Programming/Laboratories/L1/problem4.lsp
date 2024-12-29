; 4.
; a) Write a function to return the sum of two vectors.
; b) Write a function to get from a given list the list of all atoms, on any 
; level, but on the same order. Example:
; (((A B) C) (D E)) ==> (A B C D E)
; c) Write a function that, with a list given as parameter, inverts only continuous
; sequences of atoms. Example:
; (a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g))
; d) Write a list to return the maximum value of the numerical atoms from a list, at superficial level.

;a)

(defun sumTwoVector (v1 v2)
  (cond
    ((null v1) nil)
    (t (append (list (+(car v1) (car v2))) (sumTwoVector (cdr v1) (cdr v2))))
  )
)

(print (sumTwoVector '(1 2 3) '(2 3 4)))

;b)
(defun transformToLinearList (l)  
  (cond
    ((null l) nil)
    ((listp (car l)) (append (transformToLinearList (car l)) (transformToLinearList (cdr l))))
    (t (append (list (car l)) (transformToLinearList(cdr l))))
  )
)

(print(transformToLinearList '(((A B)C)(D E))))


;c)
(defun reverse_list(l)
(
    cond
        ((null l) nil)
        (T (append (reverse_list (cdr l)) (list (car l))))
))

(defun invert_list(l aux)
(
    cond
        ((null l) (reverse_list aux))
        ((listp (car l)) (append (reverse_list aux) (cons (invert_list (car l) nil) (invert_list (cdr l) nil))))
        (T (invert_list (cdr l) (append aux (list (car l)))))
))

(print (invert_list '(a b c (d (e f) g h i)) nil))

;d)
(defun get_maximum (l current_max)  
  (cond
    ((null l) current_max)
    ((listp (car l)) (get_maximum (cdr l) current_max))
    ((> (car l) current_max) (get_maximum (cdr l) (car l)))
    (t (get_maximum (cdr l) current_max))
  )
)

(print(get_maximum '(1 10 3 (4 5)) 0))
