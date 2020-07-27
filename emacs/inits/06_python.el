;;; Python
(add-hook 'python-mode-hook
	  (lambda ()
            ;(parenthesis-register-keys "(\"[{" (current-local-map))  ; 括弧の補完
            (define-key python-mode-map "\C-m" 'newline-and-indent)  ; 改行時にインデントする
            ))

; 保存時に無駄な空白を削除
(add-hook 'before-save-hook
	  (lambda () (when (eq major-mode 'python-mode)
		       (delete-trailing-whitespace))))

;; ;;== flymake for python ==
;; (defun flymake-pyflakes-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;; ;;    (list "lintrunner.py"  (list local-file))))
;;     (list "flake8"  (list local-file))))

;;(add-to-list 'flymake-allowed-file-name-masks
;;               '("\\.py\\'" flymake-pyflakes-init))

;; (setq flymake-warning-re "^[wWeE]")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")

;; Use jupyter as python repl
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)

;; elpy
(when (require 'elpy)
  (custom-set-variables '(elpy-rpc-virtualenv-path 'current))
  (elpy-enable)

  (add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")
  )
;; (setq python-check-command "lintrunner.py")

(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  (add-hook 'elpy-mode-hook 'flycheck-mode))
