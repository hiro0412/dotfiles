(when (require 'elscreen nil t)
  ;(setq elscreen-prefix-key "\C-z")
  (if window-system
      (progn
        (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
        ;(if (fboundp 'color-theme-select) (require 'elscreen-color-theme))
        )
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)
    )
  (elscreen-start)
  )
