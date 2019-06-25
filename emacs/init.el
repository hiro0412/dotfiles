;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ===== デバッグモード =====
;;(setq debug-on-error t)

(require 'cl)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; el-get
(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir)))
        
(add-to-list 'load-path (concat el-get-dir "/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(load (locate-user-emacs-file "Cask2Elget"))

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
(add-to-list 'exec-path "/usr/local/bin")
;(add-to-list 'exec-path "/usr/local/sbin")
(add-to-list 'exec-path "~/bin")

;; 環境変数 PATH に exec-path を追加する。
(setenv "PATH" (mapconcat 'identity exec-path ":"))

;;; ==== init-loader ====
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "ef0d2cd0b5ecebd6794a2012ffa08393e536b33e3e377ac2930bf5d7304dcb21" default)))
 '(package-selected-packages
   (quote
    (markdown-mode auto-save-buffers-enhanced edit-indirect pipenv howm yasnippet web-mode use-package smex smartparens projectile prodigy popwin paren-completer open-junk-file nyan-mode multiple-cursors magit init-loader idle-highlight-mode htmlize highlight-symbol flycheck-cask expand-region exec-path-from-shell drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
