;; 14 - Start the game already!

;; No menubar, toolbar, scrollbar or startup message
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)

;; Packages should go here
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; Custom lisp
(setq settings-dir
      (expand-file-name "lisp" user-emacs-directory))

;; Load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; Backups go here
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Emacs on OS X?
(setq *is-mac* (equal system-type 'darwin))

;; Init packages
(require 'init-package)

;; Theme first
(c42:require-packages 'color-theme-solarized)
(c42:after-initializing
 (color-theme-solarized-dark)
 (set-default-font "Monaco 12"))
(require 'init-base)

;; Sync packages
(el-get 'sync c42:el-get-packages)
(run-hooks 'c42:initialized-hook)

;; Local customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))
