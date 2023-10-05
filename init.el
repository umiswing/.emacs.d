;; avy
(add-to-list 'load-path "~/.emacs.d/avy")
(require 'avy)

;; diff-hl
(add-to-list 'load-path "~/.emacs.d/diff-hl")
(require 'diff-hl)
(require 'diff-hl-margin)
(global-diff-hl-mode)
(diff-hl-margin-mode)

;; cuda-mode
(add-to-list 'load-path "~/.emacs.d/cuda-mode")
(autoload 'cuda-mode "cuda-mode.el")
(add-to-list 'auto-mode-alist '("\\.cuh?\\'" . cuda-mode))

;; org-mode
(setq org-agenda-files '("~/org/gtd/inbox.org"
                         "~/org/gtd/gtd.org"))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file "~/org/gtd/inbox.org")
                               "* TODO %?\nOPENED: %T")))
(setq org-refile-targets '(("~/org/gtd/gtd.org" :level . 1)
                           ("~/org/gtd/someday.org" :level . 1)))
(setq org-log-done 'time)
(advice-add 'org-refile :after
        (lambda (&rest _)
          (org-save-all-org-buffers)))

;; magit
;; Installing from melpa from melpa will generate custom varibale automatically,
;; which is not elegant. However, it's very unconvient to install magit manually.
;; Run following commands to install from melpa the first time you load init.el
;; M-x package-refresh-contents RET
;; M-x package-install RET magit RET
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

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
(global-set-key (kbd "C-'") 'avy-goto-char)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
