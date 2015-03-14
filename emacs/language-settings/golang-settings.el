(eval-after-load "go-mode"
  (add-hook 'before-save-hook 'gofmt-before-save))

;;
;;(eval-after-load "go-mode"
;;  '(progn
;;     (flycheck-declare-checker go-fmt
;;       "A Go syntax and style checker using the gofmt utility."
;;       :command '("gofmt" source-inplace)
;;       :error-patterns '(("^\\(?1:.*\\):\\(?2:[0-9]+\\):\\(?3:[0-9]+\\): \\(?4:.*\\)$" error))
;;       :modes 'go-mode)
;;     (add-to-list 'flycheck-checkers 'go-fmt)))
;;

(provide 'golang-settings)
