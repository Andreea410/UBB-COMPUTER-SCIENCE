; 8. 
; Write a function to determine the number of nodes on the level k from a n-tree 
; represented as follows: (root list_nodes_subtree1 ... list_nodes_subtreen) 
; Eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes

; count(l1, l2,..., ln, level) = 0, n = 0
;                              = 1, level = 0
;                              = count(l2, level - 1) + ... + count(ln, level - 1)


(defun count1 (l l1)
  (cond
    ((null l) 0)
    ((= l1 0) 1)
    (t (apply #'+
       (mapcar #'(lambda (x) (count1 x (- l1 1) )) (cdr l))
       )
    )
  )
)

(print (count1 '(a (b (c)) (d) (e (f))) 1))
