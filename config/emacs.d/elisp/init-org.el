
(use-package org
  :ensure nil
  :defer t
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  (:map org-mode-map ("C-c C-p" . org-export-as-pdf-and-open))
  :init
  (setq org-directory "~/org"
      org-agenda-files '("~/org/agenda.org")
      org-hide-leading-stars t
      org-return-follows-link t
      org-log-done 'time
      org-default-notes-file (concat org-directory "/notes.org")
      org-hide-emphasis-markers t
      org-export-coding-system 'utf-8
      org-capture-templates
      `(("t" "todo" entry (file "")  ; "" => `org-default-notes-file'
         "* NEXT %?\n%U\n" :clock-resume t)
        ("n" "note" entry (file "")
         "* %? :NOTE:\n%U\n%a\n" :clock-resume t)))
  )

(provide 'init-org)
