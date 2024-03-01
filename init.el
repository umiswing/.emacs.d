;; diff-hl
(add-to-list 'load-path "~/.emacs.d/diff-hl")
(require 'diff-hl)
(require 'diff-hl-margin)
(global-diff-hl-mode)
(diff-hl-margin-mode)

;; auto indent
(setq electric-indent-mode nil)

;; cuda-mode
(add-to-list 'load-path "~/.emacs.d/cuda-mode")
(autoload 'cuda-mode "cuda-mode.el")
(add-to-list 'auto-mode-alist '("\\.cuh?\\'" . cuda-mode))

;; built-in config

;; Don't show the splash screen
(setq inhibit-startup-message t)  ; Comment at end of line!

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :height 160)
(setq auto-save-default nil)
(setq auto-save-visited-mode nil)
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)

(defun scroll-up-one-line()
  "Scroll up one line."
  (interactive)
  (scroll-up 1))
(defun scroll-down-one-line()
  "Scroll down one line."
  (interactive)
  (scroll-down 1))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

(global-set-key (kbd "M-n") 'scroll-up-one-line)
(global-set-key (kbd "M-p") 'scroll-down-one-line)
(global-set-key (kbd "C-c r") 'recentf-open-files)
