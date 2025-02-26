(defun long (li)
  (do
    (
      (l li (cdr l))  ; initialization of cycling variables
      (result 0 (+ result 1)); functions as a collector variable
    )
    ((null l) result); test clause
  )  ; note that this function has no body of forms
)
