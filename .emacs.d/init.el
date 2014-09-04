;; Emacs package system
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; init-loader
(custom-set-variables
 '(init-loader-show-log-after-init 'error-only))
(init-loader-load (concat user-emacs-directory "init_loader"))
