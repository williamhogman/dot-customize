(provide 'init)


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
  
  
  
  )



