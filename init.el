;; Don't show the splash screen
(setq inhibit-startup-message t)  ; Comment at end of line!

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(defun init()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )
(defun update()
  (interactive)
  (load-file "~/.emacs.d/init.el")
  )
;; org mode
(defun nolinum ()
  (display-line-numbers-mode -1)
  )
(defun blog()
  (interactive)
  (find-file "~/org/blog.org")
  )
(defun note()
  (interactive)
  (find-file "~/org/note.org")
  )
(defun learn()
  (interactive)
  (find-file "~/org/gtd/learn.org")
  )
(defun dev()
  (interactive)
  (find-file "~/org/gtd/dev_tools.org")
  )
(defun vimforward()
  (interactive)
  (subword-forward)
  (subword-forward)
  (subword-backward)
  )
(defun scroll-up-one-line()
  "Scroll up one line."
  (interactive)
  (scroll-up 1))
(defun scroll-down-one-line()
  "Scroll down one line."
  (interactive)
  (scroll-down 1))
(add-to-list 'load-path "~/.emacs.d/open-newline")
(require 'open-newline)
(add-to-list 'load-path "~/.emacs.d/delete-block")
(require 'delete-block)
(add-to-list 'load-path "~/.emacs.d/move-text")
(require 'move-text)
(add-to-list 'load-path "~/.emacs.d/duplicate-line")
(require 'duplicate-line)
(global-set-key (kbd "C-<up>") #'duplicate-line-or-region-above)
(global-set-key (kbd "C-<down>") #'duplicate-line-or-region-below)
(global-set-key (kbd "C-M-<up>") #'duplicate-line-above-comment)
(global-set-key (kbd "C-M-<down>") #'duplicate-line-below-comment)
;(global-set-key (kbd "C-<S-N>") #'move-text-down)      
;(global-set-key (kbd "C-<S-P>") #'move-text-up)  
(global-set-key (kbd "M-d") #'delete-block-forward)
(global-set-key (kbd "M-DEL") #'delete-block-backward)
(global-set-key (kbd "M-n") 'scroll-up-one-line)
(global-set-key (kbd "M-p") 'scroll-down-one-line)
(global-set-key (kbd "<up>") #'move-text-up)
(global-set-key (kbd "<down>") #'move-text-down)
(global-set-key (kbd "C-M-n") #'open-newline-below)
(global-set-key (kbd "C-M-p") #'open-newline-above)
(global-set-key (kbd "M-f") 'vimforward)
(global-set-key (kbd "M-b") #'subword-backward)
(add-hook 'org-mode-hook 'nolinum)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-log-done t)
(setq org-agenda-files '("~/org/gtd"))
(add-hook 'org-mode-hook #'valign-mode)

;;(require 'color-theme-sanityinc-tomorrow)
;;(color-theme-sanityinc-tomorrow-night)

(setq url-proxy-services '(("http" . "127.0.0.1:7890")
			   ("https" . "127.0.0.1:7890")))
(setq socks-proxy "127.0.0.1:7891")
(setq elfeed-curl-extra-arguments '("-x127.0.0.1:7890"))
(setq elfeed-feeds '("https://protesilaos.com/master.xml"
		     "http://xahlee.info/emacs/emacs/blog.xml"
		     "http://xahlee.info/comp/blog.xml"))
(global-set-key (kbd "C-x w") 'elfeed)

(use-package rime
  :custom
  (default-input-method "rime"))
(setq rime-user-data-dir "~/.config/fcitx/rime")
(setq rime-show-candidate 'posframe)

;; lsp
;(setq lsp-keymap-prefix "C-c l")
(lsp-treemacs-sync-mode 1)
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'cuda-mode-hook 'lsp)
(add-hook 'python-mode-hook 'lsp)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cuda-mode-hook #'rainbow-delimiters-mode)
(global-set-key (kbd "C-,") 'lsp-find-definition)
;;(setenv "PYTHONPATH" "~/miniconda3/envs/pytorch/bin")
;;(setq lsp-pyls-server-command "/home/wsm/miniconda3/envs/pytorch/bin/pylsp")
;;(setq lsp-clients-python-library-directories "/home/wsm/miniconda3/envs/pytorch
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(setq lsp-pyright-venv-path "/home/wsm/miniconda3/envs/pytorch/")

;(setq lsp-clients-clangd-args '("--fallback-style=\"BasedOnStyle: Google\""))

;(setq lsp-clients-clangd-library-directories '("/home/wsm/pytorch/niu_attn/cutlass/include",
;					       "/home/wsm/pytorch/niu_attn/cutlass/tools/util/include"))
					       
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                     :major-modes '(c-mode c++-mode cuda-mode)
                     :remote? t
                     :server-id 'clangd-remote))
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "pylsp")
                     :major-modes '(python-mode)
                     :remote? t
                     :server-id 'pylsp-remote))
;(lsp-register-client
; (make-lsp-client :new-connection (lsp-tramp-connection "pyright")
;		  :major-modes '(python-mode)
;		  :remote? t
;		  :server-id 'pyright-remote))
							


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "TAB") #'lsp-format-region)))
  (add-hook 'lsp-mode-hook
	    (lambda () (c-toggle-electric-state -1)))
  (require 'dap-cpptools)
  (yas-global-mode))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
;;(helm-mode)
;;(require 'helm-xref)
;;(define-key global-map [remap find-file] #'helm-find-files)
;;(define-key global-map [remap execute-extended-command] #'helm-M-x)
;;(define-key global-map [remap switch-to-buffer] #'helm-mini)


;; consult
;; Example configuration for Consult
(use-package consult

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)
(define-key global-map [remap find-file] #'consult-find)

;; vertico
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; orderless
;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;;brackets

;; highlight matching paren
(show-paren-mode 1)

;; jump to matching bracket by xah lee
(defvar xah-brackets '("“”" "()" "[]" "{}" "<>" "＜＞" "（）" "［］" "｛｝" "⦅⦆" "〚〛" "⦃⦄" "‹›" "«»" "「」" "〈〉" "《》" "【】" "〔〕" "⦗⦘" "『』" "〖〗" "〘〙" "｢｣" "⟦⟧" "⟨⟩" "⟪⟫" "⟮⟯" "⟬⟭" "⌈⌉" "⌊⌋" "⦇⦈" "⦉⦊" "❛❜" "❝❞" "❨❩" "❪❫" "❴❵" "❬❭" "❮❯" "❰❱" "❲❳" "〈〉" "⦑⦒" "⧼⧽" "﹙﹚" "﹛﹜" "﹝﹞" "⁽⁾" "₍₎" "⦋⦌" "⦍⦎" "⦏⦐" "⁅⁆" "⸢⸣" "⸤⸥" "⟅⟆" "⦓⦔" "⦕⦖" "⸦⸧" "⸨⸩" "｟｠")
  "A list of strings, each element is a string of 2 chars, the left bracket and a matching right bracket. Used by `xah-select-text-in-quote' and others.")

(defconst xah-left-brackets
  (mapcar (lambda (x) (substring x 0 1)) xah-brackets)
  "List of left bracket chars. Each element is a string.")

(defconst xah-right-brackets
  (mapcar (lambda (x) (substring x 1 2)) xah-brackets)
  "List of right bracket chars. Each element is a string.")

(defconst ming-brackets
  (append xah-left-brackets xah-right-brackets)
  "List of left and right bracket chars. Each element is a string.")

(defun xah-goto-matching-bracket ()
  "Move cursor to the matching bracket.
If cursor is not on a bracket, call `backward-up-list'.
The list of brackets to jump to is defined by `xah-left-brackets' and `xah-right-brackets'.

URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version: 2016-11-22"
  (interactive)
  (if (nth 3 (syntax-ppss))
      (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
    (cond
     ((eq (char-after) ?\") (forward-sexp))
     ((eq (char-before) ?\") (backward-sexp ))
     ((looking-at (regexp-opt xah-left-brackets))
      (forward-sexp))
     ((looking-back (regexp-opt xah-right-brackets) (max (- (point) 1) 1))
      (backward-sexp))
     (t (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)))))

;; move cursor to bracket by xah lee
(defun xah-backward-left-bracket ()
  "Move cursor to the previous occurrence of left bracket.
The list of brackets to jump to is defined by `xah-left-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-backward (regexp-opt xah-left-brackets) nil t))

(defun xah-forward-right-bracket ()
  "Move cursor to the next occurrence of right bracket.
The list of brackets to jump to is defined by `xah-right-brackets'.
URL `http://xahlee.info/emacs/emacs/emacs_navigating_keys_for_brackets.html'
Version 2015-10-01"
  (interactive)
  (re-search-forward (regexp-opt xah-right-brackets) nil t))

(global-set-key (kbd "C-9") 'xah-backward-left-bracket)
(global-set-key (kbd "C-0") 'xah-forward-right-bracket)
(global-set-key (kbd "C-8") 'xah-goto-matching-bracket)

;; blamer
(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 111
                    :italic t)))
  :config
  (global-blamer-mode -1))

(blamer-mode -1)

;; ef-themes
;;(setq ef-themes-file "~/.emacs.d/ef_themes.el")
;;(load ef-themes-file)

;; modus-themes
(setq modus-themes-file "~/.emacs.d/modus_themes.el")
(load modus-themes-file)
;; demap


;; git-gutter

;; diff-hl

(global-diff-hl-mode)

;; others

;; make backup to a designated dir, mirroring the full path
(defun xah-backup-nested-dir-file-path (Fpath)
  "Return a new file path and create dirs.
If the new path's directories does not exist, create them.
version 2022-06-09"
  (let* ($backupRoot $backupFilePath)
    (setq $backupRoot "~/.emacs.d/backup/")
    ;; remove Windows driver letter in path, e.g. C:
    (setq $backupFilePath
          (format "%s%s~" $backupRoot (replace-regexp-in-string "^[A-Za-z]:/" "" Fpath)))
    (make-directory
     (file-name-directory $backupFilePath)
     (file-name-directory $backupFilePath))
    $backupFilePath
    ))

(setq make-backup-file-name-function 'xah-backup-nested-dir-file-path)

;; stop creating those #auto-save# files
(setq auto-save-default nil)
(setq create-lockfiles nil)
;; auto revert/refresh file when change detected
(global-auto-revert-mode 1)
