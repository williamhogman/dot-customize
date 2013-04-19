(require 'tls)


(setq
;; Settings for znc
 znc-servers '(("gandalf.hogman.me" 7565 t
                ((freenode "w_freenode" "whderp"))))
 )

(defun whn-irc ()
  (interactive)
  (select-frame (make-frame '((name . "emacs-irc")
                              (class . "emacs-irc")
 			      (minibuffer . t))))
  (znc-erc 'freenode))

(provide 'erc-settings)
