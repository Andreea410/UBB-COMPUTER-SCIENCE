(defun reverse (li)
  (do 
    (
      (l li (cdr l))  ; initialization of cycling symbols
      (result nil)  ; functions as a collector variable
    )
    ((null l) result)   ; test clause
    (setf result (cons (car l) result)); body of forms
  )
)
