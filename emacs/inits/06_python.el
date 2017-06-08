;;; Python
(add-hook 'python-mode-hook
	  (lambda ()
            ;(parenthesis-register-keys "(\"[{" (current-local-map))  ; 括弧の補完
            (define-key python-mode-map "\C-m" 'newline-and-indent)  ; 改行時にインデントする
            ))

(add-hook 'find-file-hook 'flymake-find-file-hook)

;;== flymake for python ==
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
;;    (list "lintrunner.py"  (list local-file))))
    (list "flake8"  (list local-file))))

;;(add-to-list 'flymake-allowed-file-name-masks
;;               '("\\.py\\'" flymake-pyflakes-init))

(setq flymake-warning-re "^[wWeE]")

;; ;; elpy
;; (elpy-enable)
;; (setq python-check-command "lintrunner.py")
