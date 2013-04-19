(setq package-archives '(
                         ("marmalade" . "http://marmalade-repo.org/packages/")
;;                         ("emacs-elpa" . "http://elpa.gnu.org/packages")
                         ("melpa" . "http://mepla.milkbox.net/packages")
                         ))

(if (fboundp 'package-initialize)
  (package-initialize)
  (progn
    (load (concat (getenv "C_HOME") "emacs/compat/package.el"))
    (package-initialize)))

(provide 'elpa-settings)
