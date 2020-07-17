;; ==== キー設定 ====

;; MacかつcocoaのときにcommandキーとOptionキーの役割を入れ替える
(when (eq system-type 'darwin)
  (when window-system
    (setq ns-command-modifier (quote meta))
    (setq ns-alternate-modifier (quote super)))
  )

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

;; ;; M-RET でフルスクリーン切り替え
;; (if (commandp 'ns-fullscreen-toggle)
;;     (define-key global-map (kbd "M-RET") 'ns-fullscreen-toggle)
;;   (if (commandp 'ns-toggle-fullscreen)
;;       (define-key global-map (kbd "M-RET") 'ns-toggle-fullscreen)
;;   ))

;; M-% で query-replace-regexp
(define-key global-map (kbd "M-%") 'query-replace-regexp)

;; M-¥ で delete-horizontal-space
(define-key global-map (kbd "M-¥") 'delete-horizontal-space)

;; M-g で goto-line
(define-key global-map (kbd "M-g") 'goto-line)

;; C-^ で 'hs-toggle-hiding
(define-key global-map (kbd "C-^") 'hs-toggle-hiding)

;; M-_ で whitespace-mode
(define-key global-map (kbd "M-_") 'whitespace-mode)

;; s-down で scroll-other-window
(define-key global-map (kbd "<s-down>") 'scroll-other-window)

;; s-up で scroll-other-window-down
(define-key global-map (kbd "<s-up>") 'scroll-other-window-down)

;; == org-mode ==
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; \(バックスラッシュ)が¥になってしまう問題への対処
;; https://qiita.com/katoken-0215/items/4ac7d9b100bdce0b8920
(define-key global-map [?¥] [?\\])
