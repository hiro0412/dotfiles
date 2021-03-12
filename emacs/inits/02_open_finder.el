
;; Finderでディレクトリを開く
;; =======================
;;
;; - 参考: https://qiita.com/blue0513/items/8031893295cd609b935e

(when (eq system-type 'darwin)
  (progn
    ;; MacOSX

    ;; current directory open
    (defun finder-current-dir-open()
      (interactive)
      (shell-command "open ."))

    ;; directory open
    (defun finder-open(dirname)
      (interactive "DDirectoryName:")
      (shell-command (concat "open " dirname)))

    ;; set the keybind
    (global-set-key (kbd "C-x RET o") 'finder-current-dir-open)
    )
  )
