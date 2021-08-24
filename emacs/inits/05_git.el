;; == magit ==

(use-package magit
  :bind (("C-x g" . magit-status))
  )

;; == git-gutter+-mode ==
;; https://github.com/nonsequitur/git-gutter-plus

;; (use-package git-gutter+
;;   :init (global-git-gutter+-mode)
;;   :config (progn
;;             (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
;;             (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
;;             (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
;;             (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
;;             (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
;;             (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
;;             (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
;;             (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
;;             (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer))
;;   :diminish (git-gutter+-mode . "gg")
;; )


;; == git-gutter-mode ==

(use-package git-gutter
  :init (global-git-gutter-mode +1)
  :config (progn
	    (global-set-key (kbd "C-x C-g") 'git-gutter)
	    (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

	    ;; Junp to next/previous hunk
	    (global-set-key (kbd "C-x p") 'git-gutter:popup-hunk)
	    (global-set-key (kbd "C-x n") 'git-gutter:popup-hunk)

	    ;; Jump to next/previous hunk
	    (global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
	    (global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

	    ;; Stage current hunk
	    (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

	    ;; Revert current hunk
	    (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

	    ;; Mark current hunk
	    (global-set-key (kbd "C-x v SPC") #'git-gutter:mark-hunk)

	    ;; seperator
	    (custom-set-variables '(git-gutter:separator-sign "|"))
	    (set-face-foreground 'git-gutter:separator "RoyalBlue1")
	    )
  )
