;; settings for org-mode

;; Key bindings are written in ./90_key-binds.el

(setq my-todo-file "~/Dropbox/docs/SilverEgg/2021/todo.org")

(setq org-startup-with-inline-images t)

(setq org-image-actual-width nil)

;; speed-mode
(setq org-use-speed-commands t)

;; org-agenda
(setq org-agenda-files (list my-todo-file))

;; org-capture
(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?n %Un %in %a")
        ("m" "仕事メモ" entry (file+headline "~/org/memo.org" "仕事メモ")
         "* %?n %Un %i")
        ("p" "プライベートメモ" entry (file+headline "~/org/private_memo.org" "プライベートメモ")
         "* %?n %Un %i")
         ))

;; 遅いので一旦コメントアウト
;(find-file-noselect my-todo-file)

;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

;; org-edit-src-code したときの indent を0に
(setq org-edit-src-content-indentation 0)
