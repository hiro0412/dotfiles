(require 'smartparens-config)
(smartparens-global-mode t)

(electric-pair-mode 1)

;; paren: 対応する括弧を光らせる
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)                    ; カッコ内の色も変更
;(set-face-background 'show-paren-match-face nil)       ; カッコ内のフェイス
;(set-face-underline-p 'show-paren-match-face "yellow") ; カッコ内のフェイス

;; parenthesis
;(require 'parenthesis)
