;; load-path
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))

;; lisp directory's path
(add-to-load-path "~/.emacs.d/lisp")
;; load
(load "make-backup-file")
(load "package")

;; Markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Python
(load "jedi")
;;(load "python-pep8")

;; YAML
(load "yaml-mode")
(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
