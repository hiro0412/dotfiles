;; settings for org-mode

;; Key bindings are written in ./90_key-binds.el

(setq org-startup-with-inline-images t)

;; speed-mode
(setq org-use-speed-commands t)

;; org-agenda
(setq org-agenda-files '("/Users/honda.hiroaki/Dropbox/docs/SilverEgg/2020/todo.org"))

;; org-capture
(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?n %Un %in %a")
        ("m" "とりあえずメモ" entry (file+headline "~/org/memo.org" "とりあえずメモ")
         "* %?n %Un %i")
         ))
