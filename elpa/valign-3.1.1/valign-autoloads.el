;;; valign-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "valign" "valign.el" (0 0 0 0))
;;; Generated autoloads from valign.el

(autoload 'valign-table "valign" "\
Visually align the table at point." t nil)

(autoload 'valign-mode "valign" "\
Visually align Org tables.

If called interactively, enable Valign mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "valign" '("valign-")))

;;;***

;;;### (autoloads nil nil ("valign-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; valign-autoloads.el ends here
