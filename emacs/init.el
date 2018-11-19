;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ===== デバッグモード =====
(setq debug-on-error t)

(require 'cl)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; el-get
(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir)))
        
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(load (locate-user-emacs-file "Cask2ElGet"))

;; ****************************************
;;   基本設定
;; ****************************************

;; ===== load-path =====
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; elispディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp")

;; ===== exec-path =====
;(add-to-list 'exec-path "/opt/local/bin")
;(add-to-list 'exec-path "/opt/local/sbin")
(add-to-list 'exec-path "/usr/local/bin")
;(add-to-list 'exec-path "/usr/local/sbin")
(add-to-list 'exec-path "~/bin")
;(add-to-list 'exec-path "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin")

;; 環境変数 PATH に exec-path を追加する。
(setenv "PATH" (mapconcat 'identity exec-path ":"))

;; ELPA
;(when (require 'package) 
; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;  (package-initialize))

;; ========================================
;;   言語設定
;; ========================================

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
;; MacOSX
(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

;; ==== 日本語入力 ====
(setq  default-input-method "MacOSX")
(global-set-key "\C-o" 'toggle-input-method) ; Ctrl-o で日本語入力を切り替える
;; Control + すべてのキー　を無視する
(when (fboundp 'mac-add-ignore-shortcut) (mac-add-ignore-shortcut '(control)))

;; 親指シフトで"，"がうまく入力できないことへの対策
;(global-unset-key (kbd "s-,"))
(global-set-key (kbd "s-,") #'(lambda () (interactive) (insert "，")))

;;; ==== init-loader ====
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;; Emacsからの質問を y/n で回答する
(fset 'yes-or-no-p 'y-or-n-p)

;; カーソル位置のファイルパスやアドレスを "C-x C-f" で開く
;;(ffap-bindings)

;; Emacs and Other Info files
;(require 'info)
;(setq Info-default-directory-list
;  (cons (expand-file-name "~/.emacs.d/elisp/wl/info/")
;    Info-default-directory-list))
(require 'info)
(setq Info-default-directory-list
 (cons (expand-file-name "~/.emacs.d/info")
       Info-default-directory-list))
(put 'scroll-left 'disabled nil)

;; Emacsの起動時間を表示
(add-hook 'after-init-hook
  (lambda ()
    (message "init time: %.3f sec"
             (float-time (time-subtract after-init-time before-init-time)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (howm yasnippet web-mode use-package smex smartparens projectile prodigy popwin paren-completer pallet open-junk-file nyan-mode multiple-cursors magit init-loader idle-highlight-mode htmlize highlight-symbol flycheck-cask expand-region exec-path-from-shell drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
