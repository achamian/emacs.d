(c42:require-packages 'go-mode 'go-def 'go-company 'go-imports 'go-test)

(defun c42:go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "C-c ," 'go-test-current-file)))

(c42:after-initializing
 (add-hook 'go-mode-hook 'c42:go-mode-hook)
 (add-hook 'go-mode-hook (lambda ()
			   (set (make-local-variable 'company-backends) '(company-go))
			   (company-mode))))

(when *is-mac*
  (c42:after-initializing
   `(add-to-list 'exec-path-from-shell-variables "GOPATH")))

(provide 'init-go)
