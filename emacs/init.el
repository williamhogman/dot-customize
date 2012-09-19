


(if menu-bar-mode (menu-bar-mode 0))
(if tool-bar-mode (tool-bar-mode 0))
(if scroll-bar-mode (scroll-bar-mode 0))

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


(require 'misc)

(require 'ess-settings)
(require 'autocomplete-settings)

(require 'yaml)

(require 'python-settings)
(require 'clojure-settings)
(require 'fastnav)

(require 'keybindings)

(require 'erc-settings)

(provide 'init)
