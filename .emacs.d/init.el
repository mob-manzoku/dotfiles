;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;;; Commentary:

;; My init.el.

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
	  (expand-file-name
	   (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
		       ("melpa" . "https://melpa.org/packages/")
		       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
	:ensure t
	:init
	;; optional packages if you want to use :hydra, :el-get, :blackout,,,
	(leaf hydra :ensure t)
	(leaf el-get :ensure t)
	(leaf blackout :ensure t)

	:config
	;; initialize leaf-keywords.el
	(leaf-keywords-init)))

;;; バージョンコントロールされたsymlinkに対する質問を消す
(setq vc-follow-symlinks t)
;;; ファイル末にスペース
(setq require-final-newline t)

;;; 行末空白の表示
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))
(set-face-background 'trailing-whitespace "purple4")

;; backup file
(setq make-backup-files t)
(setq backup-directory "~/.bak.emacs")
(if (and (boundp 'backup-directory)
	 (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
	    (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
	(if (and (file-exists-p (expand-file-name backup-directory))
		 (file-directory-p (expand-file-name backup-directory)))
	    (concat (expand-file-name backup-directory)
		    "/" (file-name-nondirectory filename))
	            (make-backup-file-name-original filename)))))

(leaf yaml-mode
  :ensure t)

(leaf nginx-mode
  :ensure t)

(leaf protobuf-mode
  :ensure t
  :config
  (setq c-basic-offset 4)
  )


;; Language Server
(leaf lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-prefer-capf t)
  )

(defun lsp-go-install-save-hooks()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks t t)

(leaf go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  (add-hook 'go-mode-hook #'yas-minor-mode))


(leaf lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(leaf company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(leaf yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (blackout el-get hydra leaf-keywords leaf))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
