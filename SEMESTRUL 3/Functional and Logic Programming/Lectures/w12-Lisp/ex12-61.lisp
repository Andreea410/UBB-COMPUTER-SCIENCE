(defmacro putprop (var val prop)
  `(setf (get ,var ,prop) ,val)
) 
  
(putprop 'ion 'mihai 'father)       ; father (ion) = mihai
(putprop 'ion 'maria 'mother)       ; mother (ion) = maria
(putprop 'mihai 'gheorghe 'father)  ; father (mihai) = gheorghe
(putprop 'mihai 'ana 'mother)       ; mother (mihai) = ana
(putprop 'maria 'george 'father)    ; father (maria) = george
(putprop 'maria 'mihaela 'mother)   ; mother (maria) = mihaela

  
(setq grandparents 
  (mapcar 
    #'get 
    (list  
      (get 'ion 'father) 
      (get 'ion 'mother)
      (get 'ion 'father) 
      (get 'ion 'mother)  
    )
   '(father father mother mother)
  )  ; returns (gheorghe george ana mihaela)
)
