;; ESS
(if (not (boundp 'ess-lisp-directory))
    (progn (add-to-list 'load-path "/usr/share/emacs/site-lisp/ess")
           (require 'ess-site)))

(provide 'ess-settings)
