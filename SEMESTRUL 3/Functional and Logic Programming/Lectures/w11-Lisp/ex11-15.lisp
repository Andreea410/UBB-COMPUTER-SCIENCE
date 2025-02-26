(defun subm (L)
  (cond
    ((null L) (list nil))
    (t ((lambda (submCdr) (append submCdr
                            (mapcar #'(lambda (sb) (cons (car L) sb)) submCdr)
                    )
        ) (subm (cdr L))
       )
    )
  )
)

; alternative
; (subm1 (cdr L)) is computed once and used twice via lambda

(defun subel (e L)
  (mapcar #'(lambda (x) (cons e x)) L)
)

(defun subm1 (L)  
  (cond  
    ((null L) (list nil))  
    (t ((lambda (submCdr) (append submCdr (subel (car L) submCdr))) 
        (subm1 (cdr L))
       ) 
    )
  )
)  

; alternative
; (subm2 (cdr L)) is computer twice

(defun subm2 (L)  
  (cond  
    ((null L) (list nil))  
    (t (append (subm2 (cdr L)) (subel (car L) (subm2 (cdr L)))))
  )
)  

