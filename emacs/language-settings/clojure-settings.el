
(setq nrepl-server-command "lein2 repl")

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))

(eval-after-load 'find-file-in-project
  '(add-to-list 'ffip-patterns "*.clj"))


(add-hook 'clojure-mode-hook
          (lambda ()
            (enable-paredit-mode)
            ;;(add-to-list 'ac-sources 'ac-source-yasnippet)
n            (setq buffer-save-without-query t)))



;;Treat hyphens as a word character when transposing words
;;(defvar clojure-mode-with-hyphens-as-word-sep-syntax-table
;;  (let ((st (make-syntax-table clojure-mode-syntax-table)))
;;    (modify-syntax-entry ?- "w" st)
;;    st))

;;(defun live-transpose-words-with-hyphens (arg)
;;  "Treat hyphens as a word character when transposing words"
;;  (interactive "*p")
;;  (with-syntax-table clojure-mode-with-hyphens-as-word-sep-syntax-table
;;    (transpose-words arg)))

;;(define-key clojure-mode-map (kbd "M-t") 'live-transpose-words-with-hyphens)

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode))
                              auto-mode-alist))

(add-hook 'nrepl-interaction-mode-hook
          (lambda ()
            (enable-paredit-mode)))

(add-hook 'nrepl-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (define-key nrepl-mode-map
              (kbd "{") 'paredit-open-curly)
            (define-key nrepl-mode-map
              (kbd "}") 'paredit-close-curly)))

(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")

(provide 'clojure-settings)
