


(if (boundp 'menu-bar-mode) (menu-bar-mode 0))
(if (boundp 'tool-bar-mode) (tool-bar-mode 0))
(if (boundp 'scroll-bar-mode) (scroll-bar-mode 0))

;; If C_HOME hasn't been set give it a resonable default
(if (not (getenv "C_HOME"))
    (setenv "C_HOME" (concat (getenv "HOME") "/.customize/")))


(let  ((chome (concat (getenv "C_HOME") "emacs")))
  
  (let ((default-directory chome ))
    (normal-top-level-add-subdirs-to-load-path)
    )

  (require 'elpa-settings)
  
  (set-default-font "Inconsolata-13")
  )
(ignore-errors (load (concat (getenv "C_HOME") "private/emacs-priv.el")))


(setenv "ESHELL" (concat (getenv "C_HOME") "/commands/eshell.sh"))

(column-number-mode t)
(setq inhibit-splash-screen t)
;;set all coding systems to utf-8
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'misc)

(require 'python-settings)
(require 'clojure-settings)
(require 'golang-settings)

(require 'keybindings)

(provide 'init)
