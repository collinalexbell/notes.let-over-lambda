
(defmacro nif-buggy (expr pos zero neg)
  `(let ((obscure-name ,expr))
     (cond ((plusp obscure-name) ,pos)
           ((zerop obscure-name) ,zero)
           ((negp obscure-name) ,neg))))

;; This shouldn't  be set to 3, it should be set to 'foo
;; ... but obscure-name is captured by the macroexpansion
;; note: this produces compiler warning becuase the binding in the first let is never used
(defvar *captured-variable*
  (let ((obscure-name 'foo )) (nif-buggy 3 obscure-name 'zero 'neg)))

;; Notice the double let in this macro expansion
;; please not the macroexpand is only called on nif-buggy,
;; because that is the only macro we wish to observe (in context of the other let of course)
(defvar *captured-variable-macroexpand*
  `(let ((obscure-name 'foo )) ,(macroexpand '(nif-buggy 3 obscure-name 'zero 'neg))))
