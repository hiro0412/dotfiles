;; ==== ibuffer ====

;; Grouping
;; http://martinowen.net/blog/2010/02/03/tips-for-emacs-ibuffer.html

(setq ibuffer-saved-filter-groups
      '(("home"
	 ("emacs-config" (or (filename . ".emacs.d")
			     (filename . "emacs-config")
			     (filename . "dotfiles\/emacs")
			     ))
	 ("Org" (or (mode . org-mode)
		    (filename . "OrgMode")))
         ("code" (filename . "code"))
	 ("Web Dev" (or (mode . html-mode)
			(mode . css-mode)))
	 ("Subversion" (name . "\*svn"))
	 ("Magit" (name . "\*magit"))
	 ("helm" (name . "\*helm"))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))

(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")))

(setq ibuffer-show-empty-filter-groups nil)

;; https://tam5917.hatenablog.com/entry/2014/10/23/105832

;; ;; number of rows
;; (define-ibuffer-column row
;;     (:name "Rows" :inline t)
;;     (format "%5d" (count-lines (point-min) (point-max))))

;; ;; human readable size
;; (define-ibuffer-column size-h
;;     (:name "Size" :inline t)
;;     (cond
;;      ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
;;      ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
;;      (t (format "%8d" (buffer-size)))))

;; (setq ibuffer-formats '((mark modified read-only
;;                               " " (name 30 40 :left :elide)
;;                               " " (size-h 9 -1 :right)  ;modified
;;                               " " (row 5 -1 :right)     ;modified
;;                               " " (mode 16 16 :left :elide)
;;                               " " filename-and-process)
;;                         (mark " " (name 16 -1)
;;                               " " filename)))


;; ;; ==== ibuffer-vc ====

;; http://emacs.rubikitch.com/ibuffer-vc/
;;; リポジトリ順にするにはこの設定を加える
;; (add-hook 'ibuffer-hook
;;           (lambda ()
;;             (ibuffer-vc-set-filter-groups-by-vc-root)
;;             (unless (eq ibuffer-sorting-mode 'alphabetic)
;;               (ibuffer-do-sort-by-alphabetic))))

;;; ibufferにVC statusを表示させる
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))

;; "/ _" で ibuffer-vc-set-filter-groups-by-vc-root
(add-hook 'ibuffer-hook
	  (lambda ()
	    (define-key ibuffer-mode-map (kbd "/ -") 'ibuffer-vc-set-filter-groups-by-vc-root)
	    ))
