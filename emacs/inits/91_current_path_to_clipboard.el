;; https://qiita.com/ShingoFukuyama/items/8f1d3342180d42ad9f78

;;; Get current path and put it to clipboard
(defun put-current-path-to-clipboard ()
  (interactive)
  (let ((file-path buffer-file-name)
        (dir-path default-directory))
    (cond (file-path
           (kill-new (expand-file-name file-path))
           (message "This file path is on the clipboard!"))
          (dir-path
           (kill-new (expand-file-name dir-path))
           (message "This directory path is on the clipboard!"))
          (t
           (error-message-string "Fail to get path name.")
           ))))
(global-set-key (kbd "C-c _") 'put-current-path-to-clipboard)
