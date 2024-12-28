;3.
;a) Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element.
;b) Write a function to get from a given list the list of all atoms, on any 
 ;level, but reverse order. Example:
 ;(((A B) C) (D E)) ==> (E D C B A)
;c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list.
;d) Write a function that determines the number of occurrences of a given atom in a nonlinear list.


;a)

(defun insertAtom(l e pos)
  (cond
    ((null l) nil)
    ((= 0 (mod pos 2)) (cons (car l) (cons e (insertAtom (cdr l) e (+ 1 pos)))))
    (t (cons (car l) (insertAtom (cdr l) e (+ 1 pos))))
  )
)

(print (insertAtom '(1 2 3 4 5 6) 10 1))


;b)

(defun reverse_list(l)  
  (cond
    ((null l) nil)
    (t (append (reverse_list (cdr l)) (list(car l))))
  )
)

(print( reverse_list '(1 2 3 4)))

(defun transformIntoLinearList (l)
  (cond
    ((null l) nil)  
    ((atom (car l)) (append (list(car l)) (transformIntoLinearList (cdr l) ))) 
    (t (append (transformIntoLinearList (car l)) 
               (transformIntoLinearList (cdr l)))))  
)

(print (transformIntoLinearList '(((A B) C) (D E))))

(defun transformAndReverse(l)
  (cond
    ((null l) l)
    (t (reverse_list (transformIntoLinearList l)))
  )
)

(print(transformAndReverse '(((A B) C) (D E))))


;c)
(defun my_gcd (e1 e2)
  (cond
    ((= e1 e2) e1)
    ((> e2 e1) (my_gcd e2 e1))
    (t (my_gcd (- e1 e2) e2))))

(defun calculate_gcd_list (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) (car lst))  
    (t (my_gcd (car lst) (calculate_gcd_list (cdr lst)))))) 

(print (calculate_gcd_list '(18 3 6))) 


;d)

(defun count_occurences(l e count)
  (cond
    ((null l) count)
    ((equal e (car l)) (count_occurences (cdr l) e (+ count 1)))
    ((listp (car l))  (+ (count_occurences (car l) e 0) (count_occurences (cdr l) e count)))
    (t (count_occurences (cdr l) e count))
  )
)

(print (count_occurences '(1 2 3 4 ((1 2) 1)) 1 0))


