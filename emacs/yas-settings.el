(eval-after-load "yasnippet"
  '(progn
    (yas/global-mode 1)
    (yas/load-directory (concat (getenv "C_HOME") "emacs/snippets"))))
(provide 'yas-settings)
