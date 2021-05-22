;;; init.el --- -*- lexical-binding: t -*-

(defvar better-gc-cons-threshold 134217728 ; 128Mb
  "The default value to use for `gc-cons-threshold'.
If you experience freezing, decrease this.  If you experience stuttering, increase this.")

(add-hook 'emacs-startup-hook
          (lambda ()
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))
            (defun gc-minibuffer-setup-hook ()
              (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

            (defun gc-minibuffer-exit-hook ()
              (garbage-collect)
              (setq gc-cons-threshold better-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))


(defun update-to-load-path (folder)
  "Update FOLDER and its subdirectories to `load-path'."
  (let ((base folder))
    (unless (member base load-path)
      (add-to-list 'load-path base))
    (dolist (f (directory-files base))
      (let ((name (concat base "/" f)))
        (when (and (file-directory-p name)
                   (not (equal f ".."))
                   (not (equal f ".")))
          (unless (member base load-path)
            (add-to-list 'load-path name)))))))

(update-to-load-path (expand-file-name "elisp" user-emacs-directory))

(require 'init-const)

(require 'init-package)

(require 'init-global-config)

(require 'init-theme)

(require 'init-magit)

(require 'init-org)

(require 'init-lsp)
(require 'init-discover-my-major)
(require 'init-search)
(require 'init-dired)
(require 'init-avy)
(require 'init-which-key)
(require 'init-projectile)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-docker)
(require 'init-js)
(require 'init-golang)
(require 'init-rust)
(put 'downcase-region 'disabled nil)
