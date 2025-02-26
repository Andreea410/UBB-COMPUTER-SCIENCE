(labels 
  (
    (temp (n)
      (cond
        ((= n 0) 0)
        (t (+ 2 (temp (- n 1))))
      )
    )
  )
  (temp 3)
)
