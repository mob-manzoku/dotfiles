;;; ansible-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ansible::dict-initialize ansible::snippets-initialize
;;;;;;  ansible) "ansible" "ansible.el" (21491 12303 206886 991000))
;;; Generated autoloads from ansible.el

(defvar ansible::key-map (make-sparse-keymap) "\
Keymap for Ansible.")

(autoload 'ansible "ansible" "\
Ansible minor mode.

\(fn &optional ARG)" t nil)

(autoload 'ansible::snippets-initialize "ansible" "\


\(fn)" nil nil)

(eval-after-load 'yasnippet '(ansible::snippets-initialize))

(autoload 'ansible::dict-initialize "ansible" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ansible-pkg.el") (21491 12303 214296
;;;;;;  592000))

;;;***

(provide 'ansible-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ansible-autoloads.el ends here
