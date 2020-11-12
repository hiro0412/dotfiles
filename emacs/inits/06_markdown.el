(setq markdown-command "multimarkdown")

;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (autoload 'gfm-mode "markdown-mode"
;;   "Major mode for editing GitHub Flavored Markdown files" t)
;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(setq markdown-css-paths (list "http://thomasf.github.io/solarized-css/solarized-light.min.css"))

(when (require 'markdown-preview-mode)
  (setq markdown-preview-stylesheets (list "http://thomasf.github.io/solarized-css/solarized-light.min.css"))
  )

