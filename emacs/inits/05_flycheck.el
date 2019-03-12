(require 'flycheck)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(global-flycheck-mode)

(define-key global-map (kbd "\C-cn") 'flycheck-next-error)
(define-key global-map (kbd "\C-cp") 'flycheck-previous-error)
(define-key global-map (kbd "\C-cd") 'flycheck-list-errors)

;;; 05_flycheck.el ends here
