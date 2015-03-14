(eval-after-load "go-mode"
  (add-hook 'before-save-hook 'gofmt-before-save))


(provide 'golang-settings)
