;; helm

(eval-after-load "helm-config"
  '(progn

;; ffap を使っていて find-file-at-point を起動した場合に、カーソル位置のパスや URL 等の
;; 文字列が正しく取り込まれないことの対策
     (defadvice helm-completing-read-default-1 (around ad-helm-completing-read-default-1 activate)
       (if (listp (ad-get-arg 4))
           (ad-set-arg 4 (car (ad-get-arg 4))))
       (letf (((symbol-function 'regexp-quote)
               (symbol-function 'identity)))
         ad-do-it))

     (when (require 'helm-mode nil t)
       (global-set-key (kbd "C-c h") 'helm-mode)
       ;; find-file にhelmを使用しない
       (helm-mode 1)
       (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
       )
     
     (when (require 'helm-descbinds nil t)
       (helm-descbinds-mode))
     ))

(defvar my-helm-key (kbd "C-x c"))
(define-key global-map my-helm-key
  (lambda ()
    (interactive)
    (require 'helm-config)
    (define-key global-map my-helm-key 'helm-command-map)
    ))

;; (when (require 'helm-descbinds nil t)
;;   (helm-descbinds-mode))
