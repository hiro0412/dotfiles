;; 出展: https://qiita.com/l3msh0/items/8665122e01f6f5ef502f
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)

;; 出展: https://qiita.com/kkatsuyuki/items/02b07ef5b20893b51f3b
;;  ただし、 dired-open を使わないので "dired-open-file" を "dired-find-file" に変更

;; カレントディレクトリをdired で開く
(defun find-file-current-dir ()
  "Find-file current directory"
  (interactive)
  (find-file default-directory))

(defun kill-current-buffer-and/or-dired-find-file ()
  "In Dired, dired-find-file for a file. For a directory, dired-find-file and
kill previously selected buffer."
  (interactive)
  (if (file-directory-p (dired-get-file-for-visit))
      (dired-find-alternate-file)
    (dired-find-file)))

(defun kill-current-buffer-and-dired-up-directory (&optional other-window)
  "In Dired, dired-up-directory and kill previously selected buffer."
  (interactive "P")
  (let ((b (current-buffer)))
    (dired-up-directory other-window)
    (kill-buffer b)))

(defun dired-find-file-other-window ()
  "In Dired, open file on other-window and select previously selected buffer."
  (interactive)
  (let ((cur-buf (current-buffer)) (tgt-buf (dired-find-file)))
    (switch-to-buffer cur-buf)
    (when tgt-buf
      (with-selected-window (next-window)
        (switch-to-buffer tgt-buf)))))

(defun dired-up-directory-other-window ()
  "In Dired, dired-up-directory on other-window"
  (interactive)
  (dired-up-directory t))


(with-eval-after-load 'dired
 (bind-keys :map dired-mode-map
          ;; ("j" . dired-next-line)
          ;; ("k" . dired-previous-line)
          ("h" . kill-current-buffer-and-dired-up-directory)
          ("l" . kill-current-buffer-and/or-dired-find-file)
          ("f" . kill-current-buffer-and/or-dired-find-file)
          ("H" . dired-up-directory-other-window)
          ("L" . dired-find-file-other-window)))

(bind-key "M-." 'find-file-current-dir)
