;count how many of a list named ps of predicates p returned true for a
;given numerical value n by calling funcall(ps n) on each predicate
;ex num(2,[x<1, x= 5 ,l]) 

;ex: num_true 2 (list (lambda (x) (< 1 x)))
                ;(lambda (x) (= 3 x))
                ;(lambda (x) (< 5 x))



; (defun num_true (ps n)
;   (cond
;     ((null ps) 0)
;     ((funcall (car ps) n) (+ 1 (num_true (cdr ps) n)))
;     (t (num_true (cdr ps) n))
;   )
; )

(defun num_true (ps n)
  (cond
    ((null ps) 0)
    (t(count  
      t (mapcar (lambda (p) (funcall p n)) ps)))
  )    
)
  
  
(print (num_true (list (lambda (x) (< 1 x)) 
                       (lambda (x) (= 3 x)) 
                       (lambda (x) (< x 5))) 
                 2))

