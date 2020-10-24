;;; init-theme.el --- -*- lexical-binding: t -*-
;;
;; Filename: init-theme.el
;;
;;; Code:

(eval-when-compile
  (require 'init-const))

(setq initial-scratch-message ";; Showtime \n"
      inhibit-startup-screen t)
(scroll-bar-mode -1)
(setq default-frame-alist '((font . "Menlo-18")))

(use-package solarized-theme
  :init (setq solarized-distinct-fringe-background t)
  :config (load-theme 'solarized-light t))

(provide 'init-theme)
