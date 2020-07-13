;; https://qiita.com/takaxp/items/6ec37f9717e362bef35f

;; Hide toolbar
(when (display-graphic-p)
  (tool-bar-mode -1))

;; Adjust titlebar, scroll-bars, internal-border-width
(when (memq window-system '(mac ns))
  (setq initial-frame-alist
        (append
         '((ns-transparent-titlebar . t) ;; タイトルバーを透過
           (vertical-scroll-bars . nil) ;; スクロールバーを消す
           (ns-appearance . dark) ;; 26.1 {light, dark}
           (internal-border-width . 0))))) ;; 余白を消す
(setq default-frame-alist initial-frame-alist)

;; (when (require 'night-theme nil t) ;; night-theme はプライベートテーマ．適宜書き換えてください．
;;     (mapc 'disable-theme custom-enabled-themes)
;;     (load-theme 'night t) ;; ここも適宜書き換えてください．
;;     (add-to-list 'default-frame-alist '(ns-appearance . dark)))

;; Define my-toggle-mode-line (Hide mode line)
(set-default 'my-mode-line-format mode-line-format)

(defun my-mode-line-off ()
  "Turn off mode line."
  (setq my-mode-line-format mode-line-format)
  (setq mode-line-format nil))

(defun my-toggle-mode-line ()
  "Toggle mode line."
  (interactive)
  (when mode-line-format
    (setq my-mode-line-format mode-line-format))
  (if mode-line-format
      (setq mode-line-format nil)
    (setq mode-line-format my-mode-line-format)
    (redraw-display))
  (message "%s" (if mode-line-format "( ╹ ◡╹)ｂ ON !" "( ╹ ^╹)ｐ OFF!")))
(define-key global-map (kbd "<f5>") 'my-toggle-mode-line)
;;(add-hook 'find-file-hook #'my-mode-line-off)

;; Indicate buffer boundaries by fringe.
(setq-default indicate-buffer-boundaries
              '((top . nil) (bottom . right) (down . right)))

;; dimmer.el
(when (require 'dimmer nil t)
  (setq dimmer-fraction 0.6)
  (setq dimmer-exclusion-regexp "^\\*helm\\|^ \\*Minibuf\\|^\\*Calendar") 
  (dimmer-mode 1))
(with-eval-after-load "dimmer"
  (defun dimmer-off ()
    (dimmer-mode -1)
    (dimmer-process-all))
  (defun dimmer-on ()
    (dimmer-mode 1)
    (dimmer-process-all))
  (add-hook 'focus-out-hook #'dimmer-off)
  (add-hook 'focus-in-hook #'dimmer-on))
