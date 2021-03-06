(when (require 'discover)
  (discover-add-context-menu
   :context-menu '(isearch
		   (description "Isearch, occur and highlighting")
		   (lisp-switches
		    ("-cf" "Case should fold search" case-fold-search t nil))
		   (lisp-arguments
		    ("=l" "context lines to show (occur)"
                     "list-matching-lines-default-context-lines"
                     (lambda (dummy) (interactive) (read-number "Number of context lines to show: "))))
		   (actions
		    ("Isearch"
                     ("_" "isearch forward symbol" isearch-forward-symbol)
                     ("w" "isearch forward word" isearch-forward-word))
		    ("Occur"
                     ("o" "occur" occur))
		    ("More"
                     ("h" "highlighters ..." makey-key-mode-popup-isearch-highlight))))
   :bind "M-s")
  )
