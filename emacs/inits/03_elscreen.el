(when (require 'elscreen nil t)
  ;(setq elscreen-prefix-key "\C-z")
  (if window-system
      (progn
        (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
        ;(if (fboundp 'color-theme-select) (require 'elscreen-color-theme))
        )
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)
    )

  (setq elscreen-tab-display-kill-screen nil)
  (setq elscreen-tab-display-control nil)

  (define-key global-map (kbd "s-<right>") 'elscreen-next)
  (define-key global-map (kbd "s-<left>") 'elscreen-previous)

  (require 'elscreen-color-theme)

  (elscreen-start)
  )

