(defun clojure-slime-maybe-compile-and-load-file ()
  "Call function `slime-compile-and-load-file' if current buffer is connected to a swank server.
  Meant to be used in `after-save-hook'."
  (when (and (eq major-mode 'clojure-mode) (slime-connected-p))
    (slime-compile-and-load-file)))


(add-hook 'after-save-hook 'clojure-slime-maybe-compile-and-load-file)

(provide 'clojure-settings)
