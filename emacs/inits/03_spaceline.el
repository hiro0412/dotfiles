;; https://github.com/TheBB/spaceline
;; http://amitp.blogspot.com/2017/01/emacs-spaceline-mode-line.html
(when (require 'spaceline-config)
  (spaceline-emacs-theme)
  )

;; http://blog.livedoor.jp/tek_nishi/archives/9654557.html
(spaceline-define-segment buffer-encoding-abbrev
  "The line ending convention used in the buffer."
  (let ((buf-coding (format "%s" buffer-file-coding-system)))
    (list (replace-regexp-in-string "-with-signature\\|-unix\\|-dos\\|-mac" "" buf-coding)
          (concat (and (string-match "with-signature" buf-coding) "ⓑ")
                  (and (string-match "unix"           buf-coding) "ⓤ")
                  (and (string-match "dos"            buf-coding) "ⓓ")
                  (and (string-match "mac"            buf-coding) "ⓜ")
                  )))
  :separator " ")
