;;
;; Misc stuff


(eval-after-load 'volatile-highlights
  '(volatile-highlights-mode t))



;; Smart shell function
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

(defun clear-shell ()
   (interactive)
   (let ((comint-buffer-maximum-size 0))
     (comint-truncate-buffer)))

;; dir in modeline for shells
(defun add-mode-line-dirtrack ()
  "When editing a file, show the last 2 directories of the current path in the mode line."
  (add-to-list 'mode-line-buffer-identification 
               '(:eval (abbreviate-file-name default-directory))))

(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'after-init-hook (lambda () (require 'pretty-mode-plus) (global-pretty-mode 1)))

(provide 'misc)
;;; misc.el ends here 
