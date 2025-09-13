
(use-package org
  :ensure nil
  :defer t
  :hook (org-mode . auto-fill-mode)
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  (:map org-mode-map ("C-c C-p" . org-export-as-pdf-and-open))
  :init

  (defvar bh/hide-scheduled-and-waiting-next-tasks t)
  (defun bh/hide-other ()
    (interactive)
    (save-excursion
      (org-back-to-heading 'invisible-ok)
      (hide-other)
      (org-cycle)
      (org-cycle)
      (org-cycle)))

  (defun bh/set-truncate-lines ()
    "Toggle value of truncate-lines and refresh window display."
    (interactive)
    (setq truncate-lines (not truncate-lines))
    ;; now refresh window display (an idiom from simple.el):
    (save-excursion
      (set-window-start (selected-window)
			(window-start (selected-window)))))

  (defun bh/make-org-scratch ()
    (interactive)
    (find-file "/tmp/publish/scratch.org")
    (gnus-make-directory "/tmp/publish"))

  (defun bh/switch-to-scratch ()
    (interactive)
    (switch-to-buffer "*scratch*"))

  (defun bh/find-project-task ()
    "Move point to the parent (project) task if any"
    (save-restriction
      (widen)
      (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
	(while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
	(goto-char parent-task)
	parent-task)))

  (defun bh/is-project-p ()
    "Any task with a todo keyword subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	(save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
	(and is-a-task has-subtask))))

  (defun bh/is-project-subtree-p ()
    "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
    (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
				(point))))
      (save-excursion
	(bh/find-project-task)
	(if (equal (point) task)
            nil
          t))))

  (defun bh/is-task-p ()
    "Any task with a todo keyword and no subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	(save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
	(and is-a-task (not has-subtask)))))

  (defun bh/is-subproject-p ()
    "Any task which is a subtask of another project"
    (let ((is-subproject)
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
	(while (and (not is-subproject) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq is-subproject t))))
      (and is-a-task is-subproject)))

  (defun bh/list-sublevels-for-projects-indented ()
    "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
    (if (marker-buffer org-agenda-restrict-begin)
	(setq org-tags-match-list-sublevels 'indented)
      (setq org-tags-match-list-sublevels nil))
    nil)

  (defun bh/list-sublevels-for-projects ()
    "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
    (if (marker-buffer org-agenda-restrict-begin)
	(setq org-tags-match-list-sublevels t)
      (setq org-tags-match-list-sublevels nil))
    nil)

  (defvar bh/hide-scheduled-and-waiting-next-tasks t)

  (defun bh/toggle-next-task-display ()
    (interactive)
    (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
    (when  (equal major-mode 'org-agenda-mode)
      (org-agenda-redo))
    (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

  (defun bh/skip-stuck-projects ()
    "Skip trees that are not stuck projects"
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	(if (bh/is-project-p)
            (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                   (has-next ))
              (save-excursion
		(forward-line 1)
		(while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                  (unless (member "WAITING" (org-get-tags-at))
                    (setq has-next t))))
              (if has-next
                  nil
		next-headline)) ; a stuck project, has subtasks but no next task
          nil))))

  (defun bh/skip-non-stuck-projects ()
    "Skip trees that are not stuck projects"
    ;; (bh/list-sublevels-for-projects-indented)
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	(if (bh/is-project-p)
            (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                   (has-next ))
              (save-excursion
		(forward-line 1)
		(while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                  (unless (member "WAITING" (org-get-tags-at))
                    (setq has-next t))))
              (if has-next
                  next-headline
		nil)) ; a stuck project, has subtasks but no next task
          next-headline))))

  (defun bh/skip-non-projects ()
    "Skip trees that are not projects"
    ;; (bh/list-sublevels-for-projects-indented)
    (if (save-excursion (bh/skip-non-stuck-projects))
	(save-restriction
          (widen)
          (let ((subtree-end (save-excursion (org-end-of-subtree t))))
            (cond
             ((bh/is-project-p)
              nil)
             ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
              nil)
             (t
              subtree-end))))
      (save-excursion (org-end-of-subtree t))))

  (defun bh/skip-non-tasks ()
    "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	(cond
	 ((bh/is-task-p)
          nil)
	 (t
          next-headline)))))

  (defun bh/skip-project-trees-and-habits ()
    "Skip trees that are projects"
    (save-restriction
      (widen)
      (let ((subtree-end (save-excursion (org-end-of-subtree t))))
	(cond
	 ((bh/is-project-p)
          subtree-end)
	 ((org-is-habit-p)
          subtree-end)
	 (t
          nil)))))

  (defun bh/skip-projects-and-habits-and-single-tasks ()
    "Skip trees that are projects, tasks that are habits, single non-project tasks"
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	(cond
	 ((org-is-habit-p)
          next-headline)
	 ((and bh/hide-scheduled-and-waiting-next-tasks
               (member "WAITING" (org-get-tags-at)))
          next-headline)
	 ((bh/is-project-p)
          next-headline)
	 ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
          next-headline)
	 (t
          nil)))))

  (defun bh/skip-project-tasks-maybe ()
    "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
    (save-restriction
      (widen)
      (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
             (next-headline (save-excursion (or (outline-next-heading) (point-max))))
             (limit-to-project (marker-buffer org-agenda-restrict-begin)))
	(cond
	 ((bh/is-project-p)
          next-headline)
	 ((org-is-habit-p)
          subtree-end)
	 ((and (not limit-to-project)
               (bh/is-project-subtree-p))
          subtree-end)
	 ((and limit-to-project
               (bh/is-project-subtree-p)
               (member (org-get-todo-state) (list "NEXT")))
          subtree-end)
	 (t
          nil)))))

  (defun bh/skip-project-tasks ()
    "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
    (save-restriction
      (widen)
      (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
	(cond
	 ((bh/is-project-p)
          subtree-end)
	 ((org-is-habit-p)
          subtree-end)
	 ((bh/is-project-subtree-p)
          subtree-end)
	 (t
          nil)))))

  (defun bh/skip-non-project-tasks ()
    "Show project tasks.
Skip project and sub-project tasks, habits, and loose non-project tasks."
    (save-restriction
      (widen)
      (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
             (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	(cond
	 ((bh/is-project-p)
          next-headline)
	 ((org-is-habit-p)
          subtree-end)
	 ((and (bh/is-project-subtree-p)
               (member (org-get-todo-state) (list "NEXT")))
          subtree-end)
	 ((not (bh/is-project-subtree-p))
          subtree-end)
	 (t
          nil)))))

  (defun bh/skip-projects-and-habits ()
    "Skip trees that are projects and tasks that are habits"
    (save-restriction
      (widen)
      (let ((subtree-end (save-excursion (org-end-of-subtree t))))
	(cond
	 ((bh/is-project-p)
          subtree-end)
	 ((org-is-habit-p)
          subtree-end)
	 (t
          nil)))))

  (defun bh/skip-non-subprojects ()
    "Skip trees that are not projects"
    (let ((next-headline (save-excursion (outline-next-heading))))
      (if (bh/is-subproject-p)
          nil
	next-headline)))

  (defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-int (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))

  (setq
   org-modules (quote (org-bbdb
                       org-bibtex
                       org-crypt
                       org-gnus
                       org-id
                       org-info
                       org-jsinfo
                       org-habit
                       org-inlinetask
                       org-irc
                       org-mew
                       org-mhe
                       org-protocol
                       org-rmail
                       org-vm
                       org-wl
                       org-w3m))
   org-directory "~/org"
   org-agenda-files '("~/org/")
   org-hide-leading-stars t
   org-return-follows-link t
   org-log-done 'time
   org-default-notes-file (concat org-directory "/notes.org")
   org-hide-emphasis-markers t
   org-export-coding-system 'utf-8
   org-inbox (concat org-directory "/inbox.org")
   org-journal (concat org-directory "/journal.org")
   org-archive-mark-done nil
   org-archive-location "%s_archive::* Archived Tasks"
   org-refile-targets (quote ((nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9)))
   org-refile-use-outline-path t
   org-outline-path-complete-in-steps nil

					; Targets complete directly with IDO
   org-outline-path-complete-in-steps nil
   org-refile-allow-creating-parent-nodes (quote confirm)
					; Use IDO for both buffer and file completion and ido-everywhere to t
   org-completion-use-ido t
   ido-everywhere t
   ido-max-directory-size 100000
   org-indirect-buffer-display 'current-window

   org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
		       (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))
   org-todo-state-tags-triggers
   (quote (("CANCELLED" ("CANCELLED" . t))
           ("WAITING" ("WAITING" . t))
           ("HOLD" ("WAITING") ("HOLD" . t))
           (done ("WAITING") ("HOLD"))
           ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
           ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
           ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))

   org-todo-state-tags-triggers
   (quote (("CANCELLED" ("CANCELLED" . t))
           ("WAITING" ("WAITING" . t))
           ("HOLD" ("WAITING") ("HOLD" . t))
           (done ("WAITING") ("HOLD"))
           ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
           ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
           ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))




   org-capture-templates
   `(("t" "todo" entry (file org-inbox)
      "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
     ("r" "respond" entry (file org-inbox)
      "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
     ("n" "note" entry (file org-inbox)
      "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
     ("w" "org-protocol" entry (file org-inbox)
      "* TODO Review %c\n%U\n" :immediate-finish t)
     ("m" "Meeting" entry (file org-inbox)
      "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
     ("p" "Phone call" entry (file org-inbox)
      "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
     ("h" "Habit" entry (file org-inbox)
      "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))



   ;; Keep tasks with dates on the global todo lists
   org-agenda-todo-ignore-with-date nil
   ;; Keep tasks with deadlines on the global todo lists
   org-agenda-todo-ignore-deadlines nil
   ;; Keep tasks with scheduled dates on the global todo lists
   org-agenda-todo-ignore-scheduled nil
   ;; Keep tasks with timestamps on the global todo lists
   org-agenda-todo-ignore-timestamp nil
   ;; Remove completed deadline tasks from the agenda view
   org-agenda-skip-deadline-if-done t
   ;; Remove completed scheduled tasks from the agenda view
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-timestamp-if-done t

   org-agenda-custom-commands
   (quote (("N" "Notes" tags "NOTE"
            ((org-agenda-overriding-header "Notes")
             (org-tags-match-list-sublevels t)))
           ("h" "Habits" tags-todo "STYLE=\"habit\""
            ((org-agenda-overriding-header "Habits")
             (org-agenda-sorting-strategy
              '(todo-state-down effort-up category-keep))))
           (" " "Agenda"
            ((agenda "" nil)
             (tags "REFILE"
                   ((org-agenda-overriding-header "Tasks to Refile")
                    (org-tags-match-list-sublevels nil)))
             (tags-todo "-CANCELLED/!"
                        ((org-agenda-overriding-header "Stuck Projects")
                         (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                         (org-agenda-sorting-strategy
                          '(category-keep))))
             (tags-todo "-HOLD-CANCELLED/!"
                        ((org-agenda-overriding-header "Projects")
                         (org-agenda-skip-function 'bh/skip-non-projects)
                         (org-tags-match-list-sublevels 'indented)
                         (org-agenda-sorting-strategy
                          '(category-keep))))
             (tags-todo "-CANCELLED/!NEXT"
                        ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                               (if bh/hide-scheduled-and-waiting-next-tasks
                                                                   ""
                                                                 " (including WAITING and SCHEDULED tasks)")))
                         (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                         (org-tags-match-list-sublevels t)
                         (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-sorting-strategy
                          '(todo-state-down effort-up category-keep))))
             (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                        ((org-agenda-overriding-header (concat "Project Subtasks"
                                                               (if bh/hide-scheduled-and-waiting-next-tasks
                                                                   ""
                                                                 " (including WAITING and SCHEDULED tasks)")))
                         (org-agenda-skip-function 'bh/skip-non-project-tasks)
                         (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-sorting-strategy
                          '(category-keep))))
             (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                        ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                               (if bh/hide-scheduled-and-waiting-next-tasks
                                                                   ""
                                                                 " (including WAITING and SCHEDULED tasks)")))
                         (org-agenda-skip-function 'bh/skip-project-tasks)
                         (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-sorting-strategy
                          '(category-keep))))
             (tags-todo "-CANCELLED+WAITING|HOLD/!"
                        ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                               (if bh/hide-scheduled-and-waiting-next-tasks
                                                                   ""
                                                                 " (including WAITING and SCHEDULED tasks)")))
                         (org-agenda-skip-function 'bh/skip-non-tasks)
                         (org-tags-match-list-sublevels nil)
                         (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                         (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
             (tags "-REFILE/"
                   ((org-agenda-overriding-header "Tasks to Archive")
                    (org-agenda-skip-function nil) ;;'bh/skip-non-archivable-tasks
                    (org-tags-match-list-sublevels nil))))
            nil)))))

(use-package org-roam
  :ensure t
  :after org
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
	 ("C-c n d c" . org-roam-dalies-capture)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :init
  (setq org-roam-directory (file-truename "~/org/roam")
	org-roam-completion-everywhere t
	org-roam-dailies-directory "daily/")
  )

(provide 'init-org)
