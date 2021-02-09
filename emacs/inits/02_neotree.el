;; emacs-neotree
;; -------
;;
;; - [Github] https://github.com/jaypei/emacs-neotree
;; - [Emacs wiki] https://www.emacswiki.org/emacs/NeoTree
;; - [Others:
;;   - https://kiririmode.hatenablog.jp/entry/20150806/1438786800

(use-package neotree)

(global-set-key [f8] 'neotree-toggle)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-autorefresh nil)

;; neotreeでファイルを新規作成した場合のそのファイルを開く
(setq neo-create-file-auto-open t)

;; Windowをリサイズできるように
(setq neo-window-fixed-size nil)
