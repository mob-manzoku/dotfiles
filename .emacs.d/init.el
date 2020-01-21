;;; package --- Summary
;;; Commentary:

;;; el-get
;;; code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;Packages
(el-get-bundle auto-complete)
(el-get-bundle flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(el-get-bundle epc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Langage
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Javascript
(el-get-bundle web-mode)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(javascript-jshint)))

(defun my-js2-mode-hook ()
  "Hooks for js2 mode."
  (setq indent-tabs-mode nil)
  (setq js2-basic-offset 4))

(add-hook 'js2-mode-hook  'my-js2-mode-hook)

;; Python
(el-get-bundle tkf/emacs-python-environment)
(el-get-bundle tkf/emacs-jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Ruby
(el-get-bundle robe-mode)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (setq flycheck-checker 'ruby-rubocop)
	     (flycheck-mode 1)))
(setq ruby-insert-encoding-magic-comment nil)

;; Golang
(el-get-bundle go-mode)
(el-get-bundle go-autocomplete)
(el-get-bundle go-eldoc)

(add-to-list 'load-path (concat (getenv "HOME")  "/usr/local/src/golang.org/x/lint/misc/emacs/"))
(require 'golint)

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
        (setf (cdr govet) (cddr govet))))

;; Protobuf
(el-get-bundle protobuf-mode)

;; Groovy
;; (el-get-bundle groovy-mode)
;; (add-to-list 'auto-mode-alist '("Jenkinsfile$" . groovy-mode))

;; PHP
(el-get-bundle php-mode)

;; Solidity
(el-get-bundle solidity-mode)
(setq solidity-comment-style 'slash)
(setq solidity-flycheck-solc-checker-active t)
(setq solidity-flycheck-solium-checker-active t)
(defun my-solidity-mode-hook ()
  "Hooks for solidity mode."
  (setq indent-tabs-mode nil)
  )

(add-hook 'solidity-mode-hook  'my-solidity-mode-hook)

;; Ansible
(el-get-bundle yaml-mode)
(el-get-bundle nginx-mode)
(add-to-list 'auto-mode-alist '("\\.cnf$" . conf-mode))
(el-get-bundle apache-mode)
(add-to-list 'auto-mode-alist '("td-agent\\.conf$" . apache-mode))

;; Elastic beanstalk
(add-to-list 'auto-mode-alist '("ebextensionfiles/.*\.config$" . yaml-mode))

;; etc
(el-get-bundle markdown-mode)
(flycheck-define-checker textlint
  "A linter for prose."
  :command ("textlint" "--format" "unix" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
	    (id (one-or-more (not (any " "))))
	    (message (one-or-more not-newline)
		     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
	    line-end))
  :modes (text-mode markdown-mode gfm-mode))
(add-to-list 'flycheck-checkers 'textlint)
(add-hook 'gfm-mode-hook 'flycheck-mode)
(add-hook 'markdown-mode-hook 'flycheck-mode)

(el-get-bundle toml-mode)

(el-get-bundle crontab-mode)
(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))
(add-to-list 'auto-mode-alist '("crontab"  . crontab-mode))

(add-to-list 'auto-mode-alist '(".zsh.d"  . shell-script-mode))
(add-to-list 'auto-mode-alist '(".envrc"  . shell-script-mode))

(add-to-list 'auto-mode-alist '("\\.pac$"  . js2-mode))
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
