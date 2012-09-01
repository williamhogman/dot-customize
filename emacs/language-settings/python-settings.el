
(require 'python)

(when (load "flymake" t)
  (defun flymake-closure-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.customize/emacs/language-settings/pycheckers.py" (list local-file))))
    
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-closure-init)))

 
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq ipython-command "/usr/bin/ipython")
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")
(require 'ipython)


(provide 'python-settings)
