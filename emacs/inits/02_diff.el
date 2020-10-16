;; 操作フレームを別フレームにしない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Freame幅が150を超えているなら横に、それ以下なら縦に分割
(setq ediff-split-window-function
      (if (> (frame-width) 150) 'split-window-horizontally
	'split-window-vertically))
