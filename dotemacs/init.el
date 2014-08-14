;; load-path
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))

;; lisp directory's path
(add-to-load-path "~/.emacs.d/lisp")
;; load
(load "jedi")
(load "make-backup-file")
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

;; add list
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

