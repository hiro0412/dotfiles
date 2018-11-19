(require 'expand-region)
(global-set-key (kbd "M-@") 'er/expand-region)
;(global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
(transient-mark-mode t)
