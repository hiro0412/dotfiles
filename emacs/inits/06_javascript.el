(when (require 'js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;; https://github.com/yasuyk/web-beautify
(when (require 'web-beautify)
  (eval-after-load 'js2-mode
    '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))

  (eval-after-load 'json-mode
    '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

  (eval-after-load 'sgml-mode
    '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

  (eval-after-load 'web-mode
    '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

  (eval-after-load 'css-mode
    '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))
  )
