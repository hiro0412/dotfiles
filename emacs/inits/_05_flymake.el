;(require 'fringe-helper)
(require 'flymake)

(setq flymake-allowed-file-name-masks '())

(set-face-background 'flymake-errline "#8b3a3a")
;; (set-face-background 'flymake-warnline "dark slate gray")
(set-face-background 'flymake-errline nil)    ;既存のフェイスを無効にする
(set-face-foreground 'flymake-errline nil)
(set-face-background 'flymake-warnline nil)
(set-face-foreground 'flymake-warnline nil)
;; ;(set-face-underline 'flymake-warnline t)

;; ;; fringe-helper
;; (make-face 'my-flymake-err-face)
;; (set-face-foreground 'my-flymake-err-face "red")
;; (set-face-background 'my-flymake-err-face nil)
;; (setq my-flymake-err-face 'my-flymake-err-face)

;; (make-face 'my-flymake-warning-face)
;; (set-face-foreground 'my-flymake-warning-face "yellow")
;; (set-face-background 'my-flymake-warning-face nil)
;; (setq my-flymake-warning-face 'my-flymake-warning-face)


;; (defvar flymake-fringe-overlays nil)
;; (make-variable-buffer-local 'flymake-fringe-overlays)

;; (defadvice flymake-make-overlay (after add-to-fringe first
;;                                  (beg end tooltip-text face mouse-face)
;;                                  activate compile)
;;   (push (fringe-helper-insert-region
;;          beg end
;;          (fringe-lib-load (if (eq face 'flymake-errline)
;;                               fringe-lib-exclamation-mark
;;                             fringe-lib-question-mark))
;;          'left-fringe 'my-flymake-warning-face)
;;          ;; 'left-fringe (if (eq face 'flymake-errline)
;;          ;;                  'my-flymake-err-face
;;          ;;                  'my-flymake-warning-face))
;; ;        'left-fringe 'font-lock-warning-face)
;;         flymake-fringe-overlays))

;; (defadvice flymake-delete-own-overlays (after remove-from-fringe activate
;;                                         compile)
;;   (mapc 'fringe-helper-remove flymake-fringe-overlays)
;;   (setq flymake-fringe-overlays nil))


;; redefine to remove "check-syntax" target
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s"
              "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
               "SYNTAX_CHECK_MODE=1")))

(defun flymake-get-ant-cmdline (source base-dir)
  (list "ant"
        (list "-buildfile"
              (concat base-dir "/" "build.xml"))))

(require 'flymake-cursor)
(add-hook 'flymake-mode-hook
          '(lambda()
          (local-set-key "\C-c\C-p" 'flymake-goto-prev-error)
          (local-set-key "\C-c\C-n" 'flymake-goto-next-error)))

;; 固まらないためのおまじない
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)


;; flyspell-mode: 動的スペルチェッカ
(when (executable-find "aspell")
  (setq-default ispell-program-name "aspell"))
;; ポップアップでスペル修正候補を表示する
;; 修正したい単語の上にカーソルをもっていき, C-c s を押すことで候補を選択
(defun flyspell-mode-hooks ()
  (defun flyspell-correct-word-popup-el ()
    "Pop up a menu of possible corrections for misspelled word before point."
    (interactive)
    ;; use the correct dictionary
    (flyspell-accept-buffer-local-defs)
    (let ((cursor-location (point))
          (word (flyspell-get-word nil)))
      (if (consp word)
          (let ((start (car (cdr word)))
                (end (car (cdr (cdr word))))
                (word (car word))
                poss ispell-filter)
            ;; now check spelling of word.
            (ispell-send-string "%\n")	;put in verbose mode
            (ispell-send-string (concat "^" word "\n"))
            ;; wait until ispell has processed word
            (while (progn
                     (accept-process-output ispell-process)
                     (not (string= "" (car ispell-filter)))))
            ;; Remove leading empty element
            (setq ispell-filter (cdr ispell-filter))
            ;; ispell process should return something after word is sent.
            ;; Tag word as valid (i.e., skip) otherwise
            (or ispell-filter
                (setq ispell-filter '(*)))
            (if (consp ispell-filter)
                (setq poss (ispell-parse-output (car ispell-filter))))
            (cond
             ((or (eq poss t) (stringp poss))
              ;; don't correct word
              t)
             ((null poss)
              ;; ispell error
              (error "Ispell: error in Ispell process"))
             (t
              ;; The word is incorrect, we have to propose a replacement.
              (flyspell-do-correct (popup-menu* (car (cddr poss)) :scroll-bar t :margin t)
                                   poss word cursor-location start end cursor-location)))
            (ispell-pdict-save t)))))
  ;; C-c s でスペル修正候補をポップアップ
  (define-key flyspell-mode-map (kbd "C-c s") 'flyspell-correct-word-popup-el))

(add-hook 'flyspell-mode-hook 'flyspell-mode-hooks)

