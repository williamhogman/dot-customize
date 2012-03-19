


(let  ((chome (concat (getenv "C_HOME") "emacs")))


  (let ((default-directory chome ))
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


(require 'colortheme-settings)

(setenv "ESHELL" (concat (getenv "C_HOME") "/commands/eshell.sh"))



(column-number-mode t)
(setq inhibit-splash-screen t)


(require 'misc)

(require 'ess-settings)
(require 'autocomplete-settings)



(require 'python-settings)
(require 'fastnav)

(require 'keybindings)

(provide 'init)
