;; ========================================
;;   Lisp関連
;; ========================================

;; (when (require 'eldoc)
;;   (require 'eldoc-extension)
;;   (setq eldoc-idle-delay 0.2)
;;   (setq eldoc-echo-area-use-multiline-p t)
;;   )

;; (defun lisp-mode-hooks ()
;;   "lisp-mode-hooks"  
;;   (parenthesis-register-keys "(\"[" (current-local-map))
;;   (turn-on-eldoc-mode)
;;   )

;; (add-hook 'emacs-lisp-mode-hook 'lisp-mode-hooks)
;; (add-hook 'lisp-interaction-mode-hook 'lisp-mode-hooks)
;; (add-hook 'lisp-mode-hook 'lisp-mode-hooks)
;; (add-hook 'scheme-mode-hook 'lisp-mode-hooks)
;; (add-hook 'leim-mode-hook 'lisp-mode-hooks)


;; Emacs Lisp
(defun emacs-lisp-mode-key-binds ()
  (define-key emacs-lisp-mode-map "\C-c\C-c" 'emacs-lisp-byte-compile)
  )

(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-mode-key-binds)
