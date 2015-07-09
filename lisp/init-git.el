(c42:require-packages 'magit)

(c42:after-initializing
 (global-set-key (kbd "C-c g") 'magit-status))

(provide 'init-git)
