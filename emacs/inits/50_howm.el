(setq howm-menu-lang 'ja)
(when (require 'howm' nil t)
  (setq howm-keyword-file "~/howm/.howm-keys")

  (setq howm-menu-expiry-hours 2) ;; メニューを 2 時間キャッシュ
  (setq howm-menu-refresh-after-save nil) ;; メモ保存時のメニュー更新も止める
  
  (define-key global-map [katakana] 'howm-menu)
  (define-key global-map [(control katakana)] 'howm-create)

  (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
  (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)

  (defun howm-outline-level ()
    (save-excursion
      (looking-at outline-regexp)
      (let ((title (buffer-substring (match-beginning 1) (match-end 1))))
        (cond ((string-match "=+" title) (- (match-begining 1) (match-end 1)))
              (t (length title))))))
  
  (add-hook 'howm-mode-hook
            (function
             (lambda ()
               (progn

                 (setq outline-level 'howm-outline-level)

                 (setq outline-regexp
                       (concat "^\\(=+\\)[^=]+\\1[ \\t]*$"))

                 ;; M-x calendar で日付を入力
                 (eval-after-load "calendar"
                   '(progn
                      (define-key calendar-mode-map
                        "\C-m" 'my-insert-day)
                      (defun my-insert-day ()
                        (interactive)
                        (let ((day nil)
                              (calendar-date-display-form
                               '("[" year "-" (format "%02d" (string-to-int month))
                                 "-" (format "%02d" (string-to-int day)) "]")))
                          (setq day (calendar-date-string
                                     (calendar-cursor-to-date t)))
                          (exit-calendar)
                          (insert day)))))

                 (defun my-get-date-gen (form)
                   (insert (format-time-string form)))
                 (defun my-get-date ()
                   (interactive)
                   (my-get-date-gen "[%Y-%m-%d]"))
                 (defun my-get-time ()
                   (interactive)
                   (my-get-date-gen "[%H:%M]"))
                 (defun my-get-dtime ()
                   (interactive)
                   (my-get-date-gen "[%Y-%m-%d %H:%M]"))
                 
                 (global-set-key "\C-c\C-d" 'my-get-date)
                 (global-set-key "\C-c\C-t" 'my-get-time)
                 (global-set-key "\C-c\ed" 'my-get-dtime)

                 ))))
  )
