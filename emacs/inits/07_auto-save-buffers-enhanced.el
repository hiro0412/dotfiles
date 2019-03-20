;; http://emacs.rubikitch.com/auto-save-buffers-enhanced/

(when (require 'auto-save-buffers-enhanced)

  ;;; 1秒後に保存
  (setq auto-save-buffers-enhanced-interval 1)
  ;;; 特定のファイルのみ有効にする
  (setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル
  ;; not-save-fileと.ignoreは除外する
  (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
  ;;; Wroteのメッセージを抑制
  (setq auto-save-buffers-enhanced-quiet-save-p t)
  ;;; *scratch*も ~/.emacs.d/scratch に自動保存
  (setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
  (setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
	(locate-user-emacs-file "scratch"))
  (auto-save-buffers-enhanced t)

  ;;; C-x a sでauto-save-buffers-enhancedの有効・無効をトグル
  (global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)

  ; If you're using CVS or Subversion or git
  (auto-save-buffers-enhanced-include-only-checkout-path t)
  (auto-save-buffers-enhanced t)
)
