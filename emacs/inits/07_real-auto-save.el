(use-package real-auto-save
  :config
  (add-hook 'find-file-hook 'real-auto-save-mode)
  (custom-set-variables
   '(real-auto-save-interval 5))
  )
