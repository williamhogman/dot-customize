


(let  ((chome (concat (getenv "C_HOME") "emacs")))


  (let ((default-directory chome ))
    (normal-top-level-add-subdirs-to-load-path)
    )

  ;; You are gonna need color-theme for this work!
  (require 'color-theme)
  ;; Add solarized colour theme
  (add-to-list
   'load-path
   (concat (getenv "C_HOME") "vendor/solarized/emacs-colors-solarized/")
   )
  (require 'color-theme-solarized)
  (color-theme-solarized-dark)


  (setq package-archives '(("ELPA" . "http://tromey.com/elpa")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("emacs-elpa" . "http://elpa.gnu.org/packages")
                           ("melpa" . "http://mepla.milkbox.net/packages")
                           ))

  (package-initialize)
  
  (set-default-font "Inconsolata-13")



  (require 'framemove)
  (framemove-default-keybindings)
  (setq framemove-hook-into-windmove t)


  (setenv "ESHELL" (concat chome "/commands/eshell.sh"))
  
  )



(provide 'init)
