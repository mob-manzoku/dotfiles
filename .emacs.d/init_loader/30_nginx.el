(require 'nginx-mode)

;;(add-to-list 'auto-mode-alist '("nginx\\.conf$" . nginx-mode))
(add-hook 'conf-mode-hook
          (lambda ()
            (when (string-match "nginx" (buffer-file-name))
              (nginx-mode))))
