

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

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
