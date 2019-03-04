;; ==== キー設定 ====

;; commandキーとOptionキーの役割を入れ替える
;(when (eq system-type 'darwin)
;  (setq ns-command-modifier (quote meta))
;  (setq ns-alternate-modifier (quote super)))

;; "C-m" に newline-and-indent を割り当てる。初期値は newline
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; "M-k" でカレントバッファを閉じる。初期値は kill-sentence
(define-key global-map (kbd "M-k") 'kill-this-buffer)

;; "C-t" でウィンドウを切り替える。初期値は transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; ESC + 矢印キーでウィンドウ切り替え
(define-key esc-map (kbd "<left>") 'windmove-left)
(define-key esc-map (kbd "<right>") 'windmove-right)
(define-key esc-map (kbd "<up>") 'windmove-up)
(define-key esc-map (kbd "<down>") 'windmove-down)

;; M-RET でフルスクリーン切り替え
(if (commandp 'ns-fullscreen-toggle)
    (define-key global-map (kbd "M-RET") 'ns-fullscreen-toggle)
  (if (commandp 'ns-toggle-fullscreen)
      (define-key global-map (kbd "M-RET") 'ns-toggle-fullscreen)
  ))

;; C-% で query-replace-regexp
(define-key global-map (kbd "C-%") 'query-replace-regexp)

;; M-¥ で delete-horizontal-space
(define-key global-map (kbd "M-¥") 'delete-horizontal-space)

;; M-g で goto-line
(define-key global-map (kbd "M-g") 'goto-line)
