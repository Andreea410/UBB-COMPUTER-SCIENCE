(defun inorder-traversal (tree)
  (cond
    ((null tree) nil) 
    (t 
     (append
      (inorder-traversal (second tree)) 
      (list (first tree))              
      (inorder-traversal (third tree))))
  )
) 


;; Example usage:
;; A tree represented as (1 (2 nil nil) (3 (4 nil nil) nil))
;;       1
;;      / \
;;     2   3
;;        /
;;       4


(print(inorder-traversal '(1 (2 nil nil) (3 (4 nil nil) nil))))
;; Output: (2 1 4 3)
