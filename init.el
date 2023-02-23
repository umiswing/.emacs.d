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
(defun scroll-up-one-line()
  "Scroll up one line."
  (interactive)
  (scroll-up 1))
(defun scroll-down-one-line()
  "Scroll down one line."
  (interactive)
  (scroll-down 1))
(defun recenter-top-bottom-other-window()
  (interactive)
  (other-window 1)
  (recenter-top-bottom)
  (other-window 1))
(defun find-file-other-window()
  (interactive)
  (setq src (buffer-name))
  (consult-find)
  (if (not (one-window-p 'visible))
      (delete-other-windows))
  (split-window-horizontally)
  (switch-to-buffer src))
(defun scroll-other-window-up-one-line()
  (interactive)
  (scroll-other-window 1))
(defun scroll-other-window-down-one-line()
  (interactive)
  (scroll-other-window-down 1))
(defun block-forward()
  (interactive)
  (let* ((syntax-move-point
          (save-excursion
            (skip-syntax-forward (string (char-syntax (char-after))))
            (point)
            ))
         (subword-move-point
          (save-excursion
            (subword-forward)
            (point)))
	 (src-point (point)))
    (if (< syntax-move-point subword-move-point)
	     (if (equal syntax-move-point src-point)
		 (forward-char)
	       (skip-syntax-forward (string (char-syntax (char-after)))))
	(if (equal subword-move-point src-point)
	    (forward-char)
	  (subword-forward)))))
(defun block-backward()
  (interactive)
  (let* ((syntax-move-point
          (save-excursion
            (skip-syntax-backward (string (char-syntax (char-before))))
            (point)
            ))
         (subword-move-point
          (save-excursion
            (subword-backward)
            (point)))
	 (src-point (point)))
    (if (> syntax-move-point subword-move-point)
	(if (equal syntax-move-point src-point)
	    (backward-char)
	  (skip-syntax-backward (string (char-syntax (char-before)))))
      (if (equal subword-move-point src-point)
	  (backward-char)
	(subword-backward)))))

(defun xref-find-definitions-other-window()
  (interactive)
  (setq src_buffer (buffer-name))
  (setq src_cur (point))
  (xref-find-definitions())
  (setq dst_buffer (buffer-name))
  (setq dst_cur (point))
  (if (and (equal src_buffer dst_buffer) (equal src_cur dst_cur))
      ()
      (if (one-window-p 'visible)
	  (split-window-right))
      (switch-to-buffer-other-window dst_buffer)
      (goto-char dst_cur)
      (switch-to-buffer-other-window src_buffer)
      (goto-char src_cur)))
(defun umi-switch-to-buffer-other-window()
  (interactive)
  (setq src_buffer (buffer-name))
  (call-interactively 'switch-to-buffer)
  (setq dst_buffer (buffer-name))
  (if (equal src_buffer dst_buffer)
      ()
  (if (one-window-p 'visible)
      (split-window-right))
  (switch-to-buffer-other-window dst_buffer)
  (switch-to-buffer-other-window src_buffer)))
(defun umi-consult-recent-file-other-window()
  (interactive)
  (setq src_buffer (buffer-name))
  (if (one-window-p 'visible)
      (progn
	(split-window-right)
	(setq one_flag t)))
  (unwind-protect
      (progn
	(other-window 1)
	(call-interactively 'consult-recent-file)
	(setq dst_buffer (buffer-name))
	(switch-to-buffer-other-window src_buffer)
	(if (equal src_buffer dst_buffer)
	    ()	 
	  (setq one_flag nil)))
    (if one_flag
	(delete-other-windows))))
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


(add-to-list 'load-path "~/.emacs.d/open-newline")
(require 'open-newline)
(add-to-list 'load-path "~/.emacs.d/delete-block")
(require 'delete-block)
(add-to-list 'load-path "~/.emacs.d/move-text")
(require 'move-text)
(add-to-list 'load-path "~/.emacs.d/duplicate-line")
(require 'duplicate-line)
(use-package dot-mode
  :bind
  (("C-," . dot-mode-execute)
   ("C-." . nil)))

(setq url-proxy-services '(("http" . "127.0.0.1:7890")
			   ("https" . "127.0.0.1:7890")))
(setq socks-proxy "127.0.0.1:7891")

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

;; gdb
;; from https://stackoverflow.com/questions/3860028/customizing-emacs-gdb
(setq gdb-many-windows nil)

(defun set-gdb-layout(&optional c-buffer)
  (if (not c-buffer)
      (setq c-buffer (window-buffer (selected-window)))) ;; save current buffer

  ;; from http://stackoverflow.com/q/39762833/846686
  (set-window-dedicated-p (selected-window) nil) ;; unset dedicate state if needed
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows) ;; clean all

  (let* (
         (w-source (selected-window)) ;; left top
         (w-gdb (split-window w-source nil 'right)) ;; right bottom
         (w-locals (split-window w-gdb nil 'above)) ;; right middle bottom
         (w-stack (split-window w-locals nil 'above)) ;; right middle top
         (w-breakpoints (split-window w-stack nil 'above)) ;; right top
         (w-io (split-window w-source (floor(* 0.9 (window-body-height)))
                             'below)) ;; left bottom
         )
    (set-window-buffer w-io (gdb-get-buffer-create 'gdb-inferior-io))
    (set-window-dedicated-p w-io t)
    (set-window-buffer w-breakpoints (gdb-get-buffer-create 'gdb-breakpoints-buffer))
    (set-window-dedicated-p w-breakpoints t)
    (set-window-buffer w-locals (gdb-get-buffer-create 'gdb-locals-buffer))
    (set-window-dedicated-p w-locals t)
    (set-window-buffer w-stack (gdb-get-buffer-create 'gdb-stack-buffer))
    (set-window-dedicated-p w-stack t)

    (set-window-buffer w-gdb gud-comint-buffer)

    (select-window w-source)
    (set-window-buffer w-source c-buffer)
    ))
(defadvice gdb (around args activate)
  "Change the way to gdb works."
  (setq global-config-editing (current-window-configuration)) ;; to restore: (set-window-configuration c-editing)
  (let (
        (c-buffer (window-buffer (selected-window))) ;; save current buffer
        )
    ad-do-it
    (set-gdb-layout c-buffer))
  )
(defadvice gdb-reset (around args activate)
  "Change the way to gdb exit."
  ad-do-it
  (set-window-configuration global-config-editing))


;; recentf
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)


;; multiple-cursors
(require 'multiple-cursors)

;; eglot
(use-package eglot
  :bind ("C-M-i" . company-complete))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs
	       '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs
	       '(cuda-mode . ("clangd")))
  (add-to-list 'eglot-server-programs
	       '(python-mode . ("pylsp")))
  (global-company-mode))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'cuda-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)
(setq eldoc-echo-area-use-multiline-p nil
      company-idle-delay nil
      company-minimum-prefix-length 1
      gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil)
;;which key
(which-key-mode)
;;rainbow-delimiters
(add-hook 'c-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cuda-mode-hook #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

;; Spell checking on the fly
;;(add-hook 'org-mode-hook 'flyspell-mode)

;;unicode
;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)    
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;;term-mode
(add-hook 'term-mode-hook
   (lambda ()
     ;; C-x is the prefix command, rather than C-c
     (term-set-escape-char ?\C-x)
     (define-key term-raw-map (kbd "M-<RET>")  'toggle-term)
     (define-key term-raw-map (kbd "M-n") 'scroll-up-one-line)
     (define-key term-raw-map (kbd "M-p") 'scroll-down-one-line)
     (define-key term-raw-map (kbd "C-v") 'scroll-up-command)
     (define-key term-raw-map (kbd "M-v") 'scroll-down-command)
     (define-key term-raw-map (kbd "C-o") 'other-window)
     (define-key term-raw-map (kbd "C-x b") 'switch-to-buffer)))
(defun toggle-term()
  (interactive)
  (if (or (equal (get 'toggle-term 'state) 0) (equal (get 'toggle-term 'state) nil))
	(progn
	  (put 'toggle-term 'state 1)
	  (split-window-below)
	  (other-window 1)
	  (term "/usr/bin/fish"))
      (if (equal (get 'toggle-term 'state) 1)
	  (progn
	    (put 'toggle-term 'state 0)
	    (delete-window)))))
;; visual-line-mode
;;(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
(turn-on-visual-line-mode)

;; themes
(mapc #'disable-theme custom-enabled-themes)
;(modus-themes-select 'modus-vivendi)
(modus-themes-select 'modus-operandi)
;;highlight current line
(global-hl-line-mode)
(add-hook 'term-mode-hook (lambda () (setq-local global-hl-line-mode nil)))
;; kbd
(global-set-key (kbd "C-<up>") #'duplicate-line-or-region-above)
(global-set-key (kbd "C-<down>") #'duplicate-line-or-region-below)
(global-set-key (kbd "C-M-<up>") #'duplicate-line-above-comment)
(global-set-key (kbd "C-M-<down>") #'duplicate-line-below-comment)
(global-set-key (kbd "M-d") #'delete-block-forward)
(global-set-key (kbd "M-DEL") #'delete-block-backward)
(global-set-key (kbd "M-n") 'scroll-up-one-line)
(global-set-key (kbd "M-p") 'scroll-down-one-line)
(global-set-key (kbd "<up>") #'move-text-up)
(global-set-key (kbd "<down>") #'move-text-down)
(global-set-key (kbd "C-j") #'open-newline-below)
(global-set-key (kbd "C-k") #'open-newline-above)
(global-set-key (kbd "M-f") 'block-forward)
(global-set-key (kbd "M-b") 'block-backward)
(global-set-key (kbd "C-M-f") #'scroll-other-window-down)
(global-set-key (kbd "C-M-n") 'scroll-other-window-up-one-line)
(global-set-key (kbd "C-M-p") 'scroll-other-window-down-one-line)
(global-set-key (kbd "C-M-l") 'recenter-top-bottom-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-other-window)
(global-set-key (kbd "C-x C-M-b") 'umi-switch-to-buffer-other-window)
(global-set-key (kbd "C-M-.") 'xref-find-definitions-other-window)
(global-set-key (kbd "C-x w") 'elfeed)
(global-set-key (kbd "C-9") 'xah-backward-left-bracket)
(global-set-key (kbd "C-0") 'xah-forward-right-bracket)
(global-set-key (kbd "C-8") 'xah-goto-matching-bracket)
(global-set-key (kbd "M-9") 'xah-backward-left-bracket)
(global-set-key (kbd "M-0") 'xah-forward-right-bracket)
(global-set-key (kbd "M-8") 'xah-goto-matching-bracket)
(global-set-key (kbd "C-x C-r") #'consult-recent-file)
(global-set-key (kbd "C-x C-M-r") 'umi-consult-recent-file-other-window)
(global-set-key (kbd "C-u") 'undo)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-M-d") 'kill-whole-line)
(global-set-key (kbd "M-<RET>") 'toggle-term)
