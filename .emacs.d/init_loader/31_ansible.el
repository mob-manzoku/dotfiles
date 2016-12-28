(require 'ansible)

(add-hook 'yaml-mode-hook '(lambda ()
			     (when (string-match "main.yml" (buffer-file-name))
			       (ansible 1))))
(add-hook 'ansible::hook '(lambda () (auto-complete-mode t)))
