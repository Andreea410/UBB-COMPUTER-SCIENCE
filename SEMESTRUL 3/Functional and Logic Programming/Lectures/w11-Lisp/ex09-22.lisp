; version 0 - superficial

(defun subst0 (enew eold l)
  (cond
    ((null l) nil)
    ((equal eold (car l)) (cons enew    (subst0 enew eold (cdr l))))
    (t                    (cons (car l) (subst0 enew eold (cdr l))))
  )
)

; version 1 - in depth, l is list

(defun subst1 (enew eold l)
  (cond
    ((null l) nil)
    ((equal eold (car l)) (cons enew    (subst1 enew eold (cdr l))))
    ((atom (car l))       (cons (car l) (subst1 enew eold (cdr l))))
    (t                    (cons (subst1 enew eold (car l))
                                (subst1 enew eold (cdr l))
                          )
    )
  )
)

; version 2 - in depth, l may be atom

(defun subst2 (enew eold l)
  (cond
    ((equal eold l) enew)
    ((atom l) l)
    (t (cons (subst2 enew eold (car l)) 
             (subst2 enew eold (cdr l))
       )
    )
  )
)

; version 3 - in depth, uses mapcar and lambda

(defun subst3 (enew eold l)
  (cond
    ((equal eold l) enew)
    ((atom l) l)
    (t (mapcar #'(lambda (l) (subst3 enew eold l)) l))
  )
)

; version 4 - in depth, uses mapcar without lambda
; homework

; results

(setq l  '(1 2 (1 2 (1 2) 1 2)))
(setq l0 (subst0 0 1 l))
(setq l1 (subst1 0 1 l))
(setq l2 (subst2 0 1 l))
(setq l3 (subst3 0 1 l))
