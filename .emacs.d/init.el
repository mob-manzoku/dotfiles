;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; el-get
;;; code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;; key binds
(global-set-key "\M-g" 'goto-line)
(keyboard-translate ?\C-h ?\C-?)
;;(normal-erase-is-backspace-mode 0)

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


;;Packages
(el-get-bundle auto-complete)
(el-get-bundle flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(el-get-bundle epc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Langage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; React.js
(el-get-bundle web-mode)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)
;; (el-get-bundle tern)
;; (el-get-bundle tern-auto-complete)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(add-hook 'web-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)


;; Python
(el-get-bundle tkf/emacs-python-environment)
(el-get-bundle tkf/emacs-jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; ;; Golang
;; (el-get-bundle go-mode)
;; (el-get-bundle go-autocomplete)
;; (el-get-bundle go-eldoc)
;; (el-get-bundle go-lint)
;; (setq gofmt-command "goimports")
;; (add-hook 'before-save-hook 'gofmt-before-save)


;; PHP
(el-get-bundle php-mode)

;; Ansible
(el-get-bundle yaml-mode)
(el-get-bundle nginx-mode)

;; etc
(el-get-bundle markdown-mode)

;;; init.el ends here
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (tern-auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
