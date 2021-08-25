(use-package backup-each-save
  :config
  (custom-set-variables
   '(make-backup-files f)
   '(backup-each-save-mirror-location "~/.emacs.d/backups")
   )
  (add-hook 'after-save-hook 'backup-each-save)
  )
