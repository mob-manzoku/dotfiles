(require yaml-mode)
(add-hook 'yaml-mode-hook '(lambda () (auto-complete-mode t))
