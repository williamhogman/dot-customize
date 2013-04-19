


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

  (let ((default-directory (concat chome "/vendor")))
    (normal-top-level-add-subdirs-to-load-path)
    )
  ;; Add solarized colour theme
  (add-to-list
   'load-path
   (concat (getenv "C_HOME") "vendor/solarized/emacs-colors-solarized/")
   )


  

  (require 'elpa-settings)
  
  (set-default-font "Inconsolata-13")



  (require 'framemove)
  (framemove-default-keybindings)
  (setq framemove-hook-into-windmove t)



  
  )
(ignore-errors (load (concat (getenv "C_HOME") "private/emacs-priv.el")))

(require 'colortheme-settings)

(setenv "ESHELL" (concat (getenv "C_HOME") "/commands/eshell.sh"))


(require 'rust-mode)

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

(require 'autocomplete-settings)
(require 'yas-settings)
(require 'misc)

(require 'ess-settings)

(require 'rainbow-delimiters)

(require 'yaml)

(require 'python-settings)
(require 'clojure-settings)
(require 'golang-settings)
(require 'fastnav)

(require 'keybindings)

(require 'erc-settings)

(provide 'init)
