;; -*- Mode: Emacs-Lisp ; Coding: utf-8; lexical-binding: t; eval: (hs-minor-mode t) -*-
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))


;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>


;; --- leaf-tree ---
(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

;; --- macrostep ---
(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))


;; --- hydra-posframe ---
(leaf hydra-posframe
  :el-get Ladicle/hydra-posframe
  :require t
  :config (hydra-posframe-enable)
  )


;; --- org-mode ---
(leaf org
  :doc "Outline-based notes management and organizer"
  :tag "builtin"
  :added "2021-12-19"
  :setq ((my-todo-file . "~/Dropbox/docs/SilverEgg/2021/todo.org")
	 (org-startup-with-inline-images . t)
	 (org-use-speed-commands . t)
	 (org-capture-templates quote
				(("j" "Journal" entry
				  (file+datetree "~/org/journal.org")
				  "* %?n %Un %in %a")
				 ("m" "仕事メモ" entry
				  (file+headline "~/org/memo.org" "仕事メモ")
				  "* %?n %Un %i")
				 ("p" "プライベートメモ" entry
				  (file+headline "~/org/private_memo.org" "プライベートメモ")
				  "* %?n %Un %i")))
	 (org-hide-leading-stars . t)
	 (org-edit-src-content-indentation . 0))
  :config
  (setq org-agenda-files (list my-todo-file))
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  )


;; Git
;; ===

(leaf *git
  :config

  ;; --- magit ---
  (leaf magit
    :doc "A Git porcelain inside Emacs."
    :req "emacs-25.1" "dash-20210826" "git-commit-20211004" "magit-section-20211004"
    "transient-20210920" "with-editor-20211001"
    :tag "vc" "tools" "git" "emacs>=25.1"
    :url "https://github.com/magit/magit"
    :added "2021-12-19"
    :emacs>= 25.1
    :ensure t
    :after git-commit magit-section with-editor
    :bind (("C-x g" . magit-status)))

  ;; --- git-gutter-mode ---
  (leaf git-gutter
    :doc "git-gutter.el"
    :req "emacs-25.1"
    :tag "vc" "tools" "git"
    :url "https://github.com/emacsorphanage/git-gutter"
    :added "2022-08-06"
    :emacs>= 25.1
    :ensure t
    :init (global-git-gutter-mode +1)
    :bind (("C-x C-g" . 'git-gutter)
	   ("C-x v =" . 'git-gutter:popup-hunk)

	    ;; Junp to next/previous hunk
	   ("C-x p" . 'git-gutter:popup-hunk)
	   ("C-x n" . 'git-gutter:popup-hunk)

	    ;; Jump to next/previous hunk
	   ("C-x p" . 'git-gutter:previous-hunk)
	   ("C-x n" . 'git-gutter:next-hunk)

	    ;; Stage current hunk
	   ("C-x v s" . 'git-gutter:stage-hunk)

	    ;; Revert current hunk
	   ("C-x v r" . 'git-gutter:revert-hunk)

	    ;; Mark current hunk
	   ("C-x v SPC" . #'git-gutter:mark-hunk)
	   )
    )
)


;; --- yasnippet ---
(leaf yasnippet
  :doc "Yet another snippet extension for Emacs"
  :req "cl-lib-0.5"
  :tag "emulation" "convenience"
  :url "http://github.com/joaotavora/yasnippet"
  :added "2021-12-19"
  :ensure t)


;; --- highlight-symbol ---
(leaf highlight-symbol
  :doc "automatic and manual symbol highlighting"
  :tag "matching" "faces"
  :url "http://nschum.de/src/emacs/highlight-symbol/"
  :added "2021-12-19"
  :ensure t)


;; --- undo-tree ---
(leaf undo-tree
  :doc "Treat undo history as a tree"
  :tag "tree" "history" "redo" "undo" "files" "convenience"
  :url "http://www.dr-qubit.org/emacs.php"
  :added "2021-12-19"
  :ensure t)


;; --- ddskk ---
;; ※omeletを使うためにはソースからインストールしなければならない
(leaf skk
  :require skk-setup
  :setq ((skk-user-directory . "~/.emacs.d/ddskk")
	 (skk-use-kana-keyboard . t)
	 (skk-kanagaki-keyboard-type quote omelet-jis)
	 (skk-large-jisyo . "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L"))
  :config
   (leaf ddskk-posframe
    :ensure t
    :global-minor-mode t)
  )


;; --- marginalia ---
(leaf marginalia
  :ensure t
  :init
  ;; 補完でも icon 表示
  (leaf all-the-icons-completion
    :ensure t
    :hook
    (after-init-hook . all-the-icons-completion-mode)
    )
  :bind (("M-A" . marginalia-cycle)
         (:minibuffer-local-map
          ("M-A" . marginalia-cycle)
          ))
  :hook
  ((after-init-hook . marginalia-mode)
   (marginalia-mode-hook . all-the-icons-completion-marginalia-setup))
  )


;; Prog modes
;; ==========

;; --- highlight-indent-guides ---
(leaf highlight-indent-guides
  :ensure t
  :blackout t
  :hook (((prog-mode-hook yaml-mode-hook) . highlight-indent-guides-mode))
  :custom (
           (highlight-indent-guides-method . 'character)
           (highlight-indent-guides-auto-enabled . t)
           (highlight-indent-guides-responsive . t)
           (highlight-indent-guides-character . ?\|)))

;; --- flycheck ---
(leaf flycheck
  :ensure t
  :hook (prog-mode-hook . flycheck-mode)
  :custom ((flycheck-display-errors-delay . 0.3))
  :config
  (leaf flycheck-color-mode-line
    :ensure t
    :hook (flycheck-mode-hook . flycheck-color-mode-line-mode)))

(leaf python
  :config
  
  ;; --- elpy ---
  (leaf elpy
    :ensure t
    :init
    (elpy-enable)
    :config
    (remove-hook 'elpy-modules 'elpy-module-highlight-indentation) ;; インデントハイライトの無効化
    (remove-hook 'elpy-modules 'elpy-module-flymake) ;; flymakeの無効化
    :custom
    (elpy-rpc-python-command . "python3")
    ;; https://mako-note.com/ja/elpy-rpc-python-version/の問題を回避するための設定
    (flycheck-python-flake8-executable . "flake8")
    :bind (elpy-mode-map
	   ("C-c C-r f" . elpy-format-code))
    :hook ((elpy-mode-hook . flycheck-mode))
    )

  ;; --- poetry ---
  (leaf poetry
    :ensure t
    ;; :hook ((elpy-mode-hook . poetry-tracking-mode))
    )
  
)

;; --- yaml --
(leaf yaml-mode
  :ensure t
  :leaf-defer t
  :mode ("\\.yaml\\'" . yaml-mode))


;; --- docker --

(leaf docker
  :config

  (leaf docker
    :ensure t
    :bind ("C-c d" . docker))

  (leaf docker-tramp
    :ensure t
    )

  (leaf dockerfile-mode
    :ensure t
    :mode "Dockerfile\\'")

  (leaf docker-compose-mode
    :ensure t)
)

;; Window Management
;; =================


;; --- ace-window ---
(leaf ace-window
  :ensure t
  :bind (("M-o" . ace-window))
  :setq ((aw-keys . '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))
  :config
  (defun ace-maximize-window ()
    "Ace maximize window."
    (interactive)
    (select-window (aw-select " Ace - Maximize Window"))
    (delete-other-windows))
  )

(leaf leaf-convert
  :preface
  (defun hydra-move-splitter-left (arg)
    "Move window splitter left."
    (interactive "p")
    (if (let ((windmove-wrap-around ))
	  (windmove-find-other-window 'right))
	(shrink-window-horizontally arg)
      (enlarge-window-horizontally arg)))

  (defun hydra-move-splitter-right (arg)
    "Move window splitter right."
    (interactive "p")
    (if (let ((windmove-wrap-around ))
	  (windmove-find-other-window 'right))
	(enlarge-window-horizontally arg)
      (shrink-window-horizontally arg)))

  (defun hydra-move-splitter-up (arg)
    "Move window splitter up."
    (interactive "p")
    (if (let ((windmove-wrap-around ))
	  (windmove-find-other-window 'up))
	(enlarge-window arg)
      (shrink-window arg)))

  (defun hydra-move-splitter-down (arg)
    "Move window splitter down."
    (interactive "p")
    (if (let ((windmove-wrap-around ))
	  (windmove-find-other-window 'up))
	(shrink-window arg)
      (enlarge-window arg)))

  :config
  (defhydra hydra-window nil
    (concat
     "\nMovement^^        ^Split^         ^Switch^		^Resize^"
     "\n----------------------------------------------------------------"
     "\n_h_ ←       	_v_ertical    	_b_uffer		_q_ X←"
     "\n_j_ ↓        	_x_ horizontal	_f_ind files	_w_ X↓"
     "\n_k_ ↑        	_z_ undo      	_a_ce 1		_e_ X↑"
     "\n_l_ →        	_Z_ reset      	_s_wap		_r_ X→"
     "\n_F_ollow		_D_lt Other   	_S_ave		max_i_mize"
     "\n_SPC_ cancel	_o_nly this   	_D_elete	\n")
    ("h" windmove-left)
    ("j" windmove-down)
    ("k" windmove-up)
    ("l" windmove-right)
    ("q" hydra-move-splitter-left)
    ("w" hydra-move-splitter-down)
    ("e" hydra-move-splitter-up)
    ("r" hydra-move-splitter-right)
    ("b" switch-to-buffer)
    ("f" find-file)
    ("F" follow-mode)
    ("a"
     (lambda nil
       (interactive)
       (ace-window 1)
       (add-hook 'ace-window-end-once-hook 'hydra-window/body)))
    ("v"
     (lambda nil
       (interactive)
       (split-window-right)
       (windmove-right)))
    ("x"
     (lambda nil
       (interactive)
       (split-window-below)
       (windmove-down)))
    ("s"
     (lambda nil
       (interactive)
       (ace-window 4)
       (add-hook 'ace-window-end-once-hook 'hydra-window/body)))
    ("S" save-buffer)
    ("d" delete-window)
    ("D"
     (lambda nil
       (interactive)
       (ace-window 16)
       (add-hook 'ace-window-end-once-hook 'hydra-window/body)))
    ("o" delete-other-windows)
    ("i" ace-maximize-window)
    ("z"
     (progn
       (winner-undo)
       (setq this-command 'winner-undo)))
    ("Z" winner-redo)
    ("SPC" nil))
  (winner-mode t)

  :bind ("M-p" . hydra-window/body)
  )

;; --- tab-bar-mode ---

(leaf tab-bar-mode
  :init
  (defvar my:ctrl-z-map (make-sparse-keymap)
    "My original keymap binded to C-z.")
  (defalias 'my:ctrl-z-prefix my:ctrl-z-map)
  (define-key global-map (kbd "C-z") 'my:ctrl-z-prefix)
  (define-key my:ctrl-z-map (kbd "c")   'tab-new)
  (define-key my:ctrl-z-map (kbd "C-c") 'tab-new)
  (define-key my:ctrl-z-map (kbd "k")   'tab-close)
  (define-key my:ctrl-z-map (kbd "C-k") 'tab-close)
  (define-key my:ctrl-z-map (kbd "n")   'tab-next)
  (define-key my:ctrl-z-map (kbd "C-n") 'tab-next)
  (define-key my:ctrl-z-map (kbd "p")   'tab-previous)
  (define-key my:ctrl-z-map (kbd "C-p") 'tab-previous)
  ;;
  (defun my:tab-bar-tab-name-truncated ()
    "Custom: Generate tab name from the buffer of the selected window."
    (let ((tab-name (buffer-name (window-buffer (minibuffer-selected-window))))
          (ellipsis (cond
                     (tab-bar-tab-name-ellipsis)
                     ((char-displayable-p ?…) "…")
                     ("..."))))
      (if (< (length tab-name) tab-bar-tab-name-truncated-max)
          (format "%-12s" tab-name)
        (propertize (truncate-string-to-width
                     tab-name tab-bar-tab-name-truncated-max nil nil
                     ellipsis)
                    'help-echo tab-name))))
    :custom
  ((tab-bar-close-button-show      . nil)
   (tab-bar-close-last-tab-choice  . nil)
   (tab-bar-close-tab-select       . 'left)
   (tab-bar-history-mode           . nil)
   (tab-bar-new-tab-choice         . "*scratch*")
   (tab-bar-new-button-show        . nil)
   (tab-bar-tab-name-function      . 'my:tab-bar-tab-name-truncated)
   (tab-bar-tab-name-truncated-max . 12)
   (tab-bar-separator              . "")
   )
  :config
  (tab-bar-mode +1)
  )


;; Key Bindings
;; ============

;; MacかつcocoaのときにcommandキーとOptionキーの役割を入れ替える
(leaf leaf-convert
  :when (eq system-type 'darwin) window-system
  :setq ((ns-command-modifier quote meta)
	 (ns-alternate-modifier quote super)))

(leaf leaf-convert
  :bind (("C-m" . newline-and-indent)
	 ("M-k" . kill-this-buffer)
	 ("C-t" . other-window)
	 (esc-map
	  ("<left>" . windmove-left))
	 (esc-map
	  ("<right>" . windmove-right))
	 (esc-map
	  ("<up>" . windmove-up))
	 (esc-map
	  ("<down>" . windmove-down))
	 ("C-^" . hs-toggle-hiding)
	 ("M-%" . query-replace-regexp)
	 ("M-¥" . delete-horizontal-space)
	 ("M-g" . goto-line)
	 ("C-^" . hs-toggle-hiding)
	 ("M-_" . whitespace-mode)
	 ("<s-down>" . scroll-other-window)
	 ("<s-up>" . scroll-other-window-down)
	 ("C-x C-b" . ibuffer)
	 ("C-c C-:" . toggle-truncate-lines)
	 ))

 ;; Karabinar-Elements で "Change ¥ to Alt+¥" を設定している場合に \ に変換されるようにする
(leaf leaf-convert
  :config
  (define-key global-map
    [8388773] ; [?\s-¥]
    [92] ; [?\\]
    ))


;; --- hydra zoom ---
(leaf leaf-convert
  :config
  (defhydra hydra-zoom
    (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")))


;; --- hydra setting on ibuffer ---
;; original setting: https://github.com/abo-abo/hydra/wiki/Ibuffer
(leaf leaf-convert
  :config
  (defhydra hydra-ibuffer-main
    (:color pink :hint nil)
    (concat
     "\n ^Navigation^ | ^Mark^        | ^Actions^        | ^View^"
     "\n-^----------^-+-^----^--------+-^-------^--------+-^----^-------"
     "\n  _k_:    ʌ   | _m_: mark     | _D_: delete      | _g_: refresh"
     "\n _RET_: visit | _u_: unmark   | _S_: save        | _s_: sort"
     "\n  _j_:    v   | _*_: specific | _a_: all actions | _/_: filter"
     "\n-^----------^-+-^----^--------+-^-------^--------+-^----^-------\n")
    ("j" ibuffer-forward-line)
    ("RET" ibuffer-visit-buffer :color blue)
    ("k" ibuffer-backward-line)
    ("m" ibuffer-mark-forward)
    ("u" ibuffer-unmark-forward)
    ("*" hydra-ibuffer-mark/body :color blue)
    ("D" ibuffer-do-delete)
    ("S" ibuffer-do-save)
    ("a" hydra-ibuffer-action/body :color blue)
    ("g" ibuffer-update)
    ("s" hydra-ibuffer-sort/body :color blue)
    ("/" hydra-ibuffer-filter/body :color blue)
    ("o" ibuffer-visit-buffer-other-window "other window" :color blue)
    ("q" quit-window "quit ibuffer" :color blue)
    ("." nil "toggle hydra" :color blue))
  (defhydra hydra-ibuffer-mark
    (:color teal :columns 5 :after-exit
	    (hydra-ibuffer-main/body))
    "Mark"
    ("*" ibuffer-unmark-all "unmark all")
    ("M" ibuffer-mark-by-mode "mode")
    ("m" ibuffer-mark-modified-buffers "modified")
    ("u" ibuffer-mark-unsaved-buffers "unsaved")
    ("s" ibuffer-mark-special-buffers "special")
    ("r" ibuffer-mark-read-only-buffers "read-only")
    ("/" ibuffer-mark-dired-buffers "dired")
    ("e" ibuffer-mark-dissociated-buffers "dissociated")
    ("h" ibuffer-mark-help-buffers "help")
    ("z" ibuffer-mark-compressed-file-buffers "compressed")
    ("b" hydra-ibuffer-main/body "back" :color blue))
  (defhydra hydra-ibuffer-action
    (:color teal :columns 4 :after-exit
	    (if (eq major-mode 'ibuffer-mode)
		(hydra-ibuffer-main/body)))
    "Action"
    ("A" ibuffer-do-view "view")
    ("E" ibuffer-do-eval "eval")
    ("F" ibuffer-do-shell-command-file "shell-command-file")
    ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
    ("H" ibuffer-do-view-other-frame "view-other-frame")
    ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
    ("M" ibuffer-do-toggle-modified "toggle-modified")
    ("O" ibuffer-do-occur "occur")
    ("P" ibuffer-do-print "print")
    ("Q" ibuffer-do-query-replace "query-replace")
    ("R" ibuffer-do-rename-uniquely "rename-uniquely")
    ("T" ibuffer-do-toggle-read-only "toggle-read-only")
    ("U" ibuffer-do-replace-regexp "replace-regexp")
    ("V" ibuffer-do-revert "revert")
    ("W" ibuffer-do-view-and-eval "view-and-eval")
    ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
    ("b" nil "back"))
  (defhydra hydra-ibuffer-sort
    (:color amaranth :columns 3)
    "Sort"
    ("i" ibuffer-invert-sorting "invert")
    ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
    ("v" ibuffer-do-sort-by-recency "recently used")
    ("s" ibuffer-do-sort-by-size "size")
    ("f" ibuffer-do-sort-by-filename/process "filename")
    ("m" ibuffer-do-sort-by-major-mode "mode")
    ("b" hydra-ibuffer-main/body "back" :color blue))
  (defhydra hydra-ibuffer-filter
    (:color amaranth :columns 4)
    "Filter"
    ("m" ibuffer-filter-by-used-mode "mode")
    ("M" ibuffer-filter-by-derived-mode "derived mode")
    ("n" ibuffer-filter-by-name "name")
    ("c" ibuffer-filter-by-content "content")
    ("e" ibuffer-filter-by-predicate "predicate")
    ("f" ibuffer-filter-by-filename "filename")
    (">" ibuffer-filter-by-size-gt "size")
    ("<" ibuffer-filter-by-size-lt "size")
    ("/" ibuffer-filter-disable "disable")
    ("b" hydra-ibuffer-main/body "back" :color blue))

  (with-eval-after-load 'ibuffer
    (define-key ibuffer-mode-map "." 'hydra-ibuffer-main/body))
  )

;; Appearance
;; ==========
(leaf *appearance
  :config
  
  ;; --- font-setting ---
  (leaf font
    :config
    (create-fontset-from-ascii-font
     "Ricty Diminished-16:weight=normal:slant=normal"
     nil
     "Ricty_Diminished")
    (set-fontset-font
     "fontset-Ricty_Diminished"
     'unicode
     "Ricty Diminished-16:weight=normal:slant=normal"
     nil
     'append)
    (add-to-list
     'default-frame-alist
     '(font . "fontset-Ricty_Diminished")))

  ;; --- all-the-icons ---
  (leaf all-the-icons
    :ensure t
    :init
    :require t)
 
  ;; --- moody (mode line) ---
  (leaf moody
    :doc "Tabs and ribbons for the mode line"
    :req "emacs-25.3"
    :tag "emacs>=25.3"
    :url "https://github.com/tarsius/moody"
    :added "2021-12-19"
    :emacs>= 25.3
    :ensure t
    :config
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode)
    )

  (line-number-mode t)
  (column-number-mode t)

  ;; --- modus-themes ---
  (leaf modus-themes
    :doc "Highly accessible themes (WCAG AAA)"
    :req "emacs-27.1"
    :tag "accessibility" "theme" "faces" "emacs>=27.1"
    :url "https://gitlab.com/protesilaos/modus-themes"
    :added "2021-12-19"
    :emacs>= 27.1
    :ensure t
    :custom
    ((modus-themes-italic-constructs . t)
     (modus-themes-bold-constructs . nil)
     (modus-themes-region . '(bg-only no-extend))
     ;(modus-themes-mode-line . '(moody accented (padding . 1) (hight . 0.9)))
     (modus-themes-hl-line . '(accented))
     ;(modus-themes-paren-match . '(bold underline intense))
     )
    :bind (("<f5>" . modus-themes-toggle))
    ;:config (modus-themes-load-vivendi)
    )
  
  (load-theme 'modus-vivendi t)
  )

;; --- recentf ---

(leaf recentf
  :config
  (leaf recentf
    ;; Settings for recentf itself
    :setq ((recentf-max-saved-items . 2000)
	   (recentf-auto-cleanup quote never)
	   (recentf-exclude quote
			    ("/recentf"
			     "COMMIT_EDITMSG"
			     "/.?TAGS"
			     "^/sudo:"
			     "/\\.emacs\\.d/games/*-scores"
			     "/\\.emacs\\.d/\\.cask/")))
    :config
    (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
    (recentf-mode t)
    )

  (leaf icomplete
    ;; open recent files with icomplete interface
    :config
    (defun my/find-recent-file ()
      (interactive)
      (find-file (completing-read "Find recent file: " recentf-list)))
    :bind
    (("C-c t" . my/find-recent-file))
    )
  )


(setq inhibit-startup-message t)

;; time locale
(setq system-time-locale "C")

;; fido-vertical-mode (補完)
(fido-vertical-mode t)


(leaf leaf-convert
  :config
  ;; Emacsからの質問を y/n で回答する
  (fset 'yes-or-no-p 'y-or-n-p))


;; ~/.emacs.d/init.el 保存時に自動でバイトコンパイル
(leaf leaf-convert
  :config
  (add-hook 'after-save-hook
	    #'(lambda nil
		(if (string=
		     (expand-file-name "~/.emacs.d/init.el")
		     (buffer-file-name))
		    (save-excursion
		      (byte-compile-file (buffer-file-name)))))))


;; Emacsの起動時間を表示
(leaf leaf-convert
  :config
  (add-hook 'after-init-hook
	    (lambda nil
	      (message "init time: %.3f sec"
		       (float-time
			(time-subtract after-init-time before-init-time))))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5fdc0f5fea841aff2ef6a75e3af0ce4b84389f42e57a93edc3320ac15337dc10" default))
 '(package-selected-packages
   '(queue spacemacs-theme csv-mode shut-up paren-completer package-build git-commit bind-key async))
 '(safe-local-variable-values '((eval hs-minor-mode t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
