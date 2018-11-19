;; ========================================
;;   言語設定
;; ========================================

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

(when (eq system-type 'darwin)
  (progn
    ;; MacOSX
    (require 'ucs-normalize)
    (setq file-name-coding-system 'utf-8-hfs)
    (setq locale-coding-system 'utf-8-hfs)

    ;; ==== 日本語入力 ====
    ;(setq default-input-method "MacOSX")
    ;(setq default-input-method "japanese")
    (global-set-key "\C-o" 'toggle-input-method) ; Ctrl-o で日本語入力を切り替える
    ;; Control + すべてのキー　を無視する
    (when (fboundp 'mac-add-ignore-shortcut) (mac-add-ignore-shortcut '(control)))

    ;; 親指シフトで"，"がうまく入力できないことへの対策
    ;(global-unset-key (kbd "s-,"))
    (global-set-key (kbd "s-,") #'(lambda () (interactive) (insert "，")))
    )
  )
