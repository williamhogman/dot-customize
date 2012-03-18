


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



  
  )


(setenv "ESHELL" (concat (getenv "C_HOME") "/commands/eshell.sh"))

 (defun my-filter (condp lst)
     (delq nil (mapcar (lambda (x) (and (funcall condp x) x)) lst)))
 (defun shell-dwim (&optional create)
   "Start or switch to an inferior shell process, in a smart way.  If a
  buffer with a running shell process exists, simply switch to that buffer.
  If a shell buffer exists, but the shell process is not running, restart the
  shell.  If already in an active shell buffer, switch to the next one, if
  any.  With prefix argument CREATE always start a new shell."
    (interactive "P")
    (let ((next-shell-buffer) (buffer)
          (shell-buf-list (identity ;;used to be reverse
                           (sort
                            (my-filter (lambda (x) (string-match "^\\*shell\\*" (buffer-name x))) (buffer-list))
                            '(lambda (a b) (string< (buffer-name a) (buffer-name b)))))))
      (setq next-shell-buffer
            (if (string-match "^\\*shell\\*" (buffer-name buffer))
                (get-buffer (cadr (member (buffer-name) (mapcar (function buffer-name) (append shell-buf-list shell-buf-list)))))
              nil))
      (setq buffer
            (if create
                (generate-new-buffer-name "*shell*")
              next-shell-buffer))
      (shell buffer)))


(column-number-mode t)
(setq inhibit-splash-screen t)

(require 'fastnav)

(require 'keybindings)

(provide 'init)
