;; ESS
(if (not (boundp 'ess-lisp-directory))
    (progn (add-to-list 'load-path "/usr/share/emacs/site-lisp/ess")
           (require 'ess-site)))

(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session

(provide 'ess-settings)
