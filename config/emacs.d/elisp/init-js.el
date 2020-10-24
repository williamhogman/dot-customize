(use-package js2-mode
  :mode "\\.jsx?\\'"
  :interpreter "node")

(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :commands (typescript-mode))

(provide 'init-js)
