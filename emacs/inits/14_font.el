;; Mac用フォント設定
;; http://tcnksm.sakura.ne.jp/blog/2012/04/02/emacs/

(when (eq system-type 'darwin)
  (when window-system

    ;; 英語
    (set-face-attribute 'default nil
			:family "Monaco" ;; font
			:height 140)    ;; font size

    ;; 日本語
    (set-fontset-font
     nil 'japanese-jisx0208
     ;; (font-spec :family "Hiragino Mincho Pro")) ;; font
     (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

    ;; 半角と全角の比を1:2にしたければ
    (setq face-font-rescale-alist
	  ;;'((".*Hiragino_Mincho_pro.*" . 1.2)))
	  '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定

    )
  )

;; Font setting for linux
(when (eq system-type 'gnu/linux)
  (create-fontset-from-ascii-font
   "Ricty Diminished-16:weight=normal:slant=normal"
   nil
   "Ricty Diminished")
  (set-fontset-font "fontset-Ricty Diminished"
		    'unicode
		    "Ricty Diminished-16"
		    nil
		    'append)
  (add-to-list 'default-frame-alist
	       '(font . "fontset-Ricty Diminished"))
  )
