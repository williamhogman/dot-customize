(require 'python)


;;(setq ipython-command "/usr/bin/ipython")
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")


(provide 'python-settings)
