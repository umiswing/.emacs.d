;;; abyss-theme.el --- A dark theme with contrasting colours.

;; Author: Matt Russell <matt@mgrbyte.co.uk>
;; Version: 0.7
;; Filename: abyss-theme.el
;; Package-Requires: ((emacs "24"))
;; Keywords: theme, dark, contrasting colours
;; URL: https://github.com/mgrbyte/emacs-abyss-theme
;; License: GPL-3+

;;; Commentary:

;; A dark theme with contrasting colours for Emacs24 based on the
;; ``Lush`` theme by Andre Richter, using the same colours palette
;; as the the built-in `dichromacy' theme; intended to be suitable
;; for red/green colour blind users.

;;; Code:

(deftheme abyss
  "Dark background and contrasting colours.")

(let* ((abyss/orange "#e69f00")
       (abyss/skyblue "#56b4e9")
       (abyss/bluegreen "#009e73")
       (abyss/yellow "#f8ec59")
       (abyss/vanilla-cream "#fcfbe3")
       (abyss/blue "#0072b2")
       (abyss/vermillion "#d55e00")
       (abyss/redpurple "#cc79a7")
       (abyss/scarlet "#FF1A00")
       (abyss/bluegray "#848ea9")
       (abyss/background "#050000")
       (abyss/background2 "#0d1000")
       (abyss/foreground "#bbe0f0")
       ;; (abyss/hl-line "#00f000")
       (abyss/hl-line "#333333")
       (abyss/magenta "#ff00ff")
       (abyss/hilite "#dd5542")
       (abyss/white "#ffffff")
       (abyss/green "#00ff00")
      ;; Cyberpunk palette
       (cyberpunk-fg "#dcdccc")
       (cyberpunk-bg-1 "#2b2b2b")
       (cyberpunk-bg-05 "#383838")
       (cyberpunk-bg "#000000")
       (cyberpunk-bg+1 "#4f4f4f")
       (cyberpunk-bg+2 "#5f5f5f")
       (cyberpunk-bg+3 "#6f6f6f")
       (cyberpunk-red+1 "#dca3a3")
       (cyberpunk-red "#ff0000")
       (cyberpunk-red-1 "#8b0000")
       (cyberpunk-red-2 "#8b0000")
       (cyberpunk-red-3 "#9c6363")
       (cyberpunk-red-4 "#8c5353")
       (cyberpunk-red-5 "#7F073F")
       (cyberpunk-pink "#ff69b4")
       (cyberpunk-pink-1 "#ff1493")
       (cyberpunk-pink-2 "#cd1076")
       (cyberpunk-orange-2 "#FF6400")
       (cyberpunk-orange-1 "#ff8c00") ;; DarkOrange
       (cyberpunk-orange "#ffa500")
       (cyberpunk-yellow "#ffff00")
       (cyberpunk-yellow-1 "#FBDE2D")
       (cyberpunk-yellow-2 "#d0bf8f")
       (cyberpunk-yellow-3 "#D8FA3C")
       (cyberpunk-yellow-4 "#E9C062")
       (cyberpunk-yellow-5 "#ffd700")
       (cyberpunk-green-2 "#006400")
       (cyberpunk-green-1 "#2e8b57")
       (cyberpunk-green "#00ff00")
       (cyberpunk-green+1 "#61CE3C")
       (cyberpunk-green+2 "#9fc59f")
       (cyberpunk-green+3 "#afd8af")
       (cyberpunk-green+4 "#bfebbf")
       (cyberpunk-cyan "#93e0e3")
       (cyberpunk-blue+1 "#94bff3")
       (cyberpunk-blue "#0000ff")    ;; blue
       (cyberpunk-blue-1 "#7b68ee")  ;; medium slate blue
       (cyberpunk-blue-2 "#6a5acd")  ;; slate blue
       (cyberpunk-blue-3 "#add8e6")  ;; light blue
       (cyberpunk-blue-4 "#b2dfee")  ;; LightBlue2
       (cyberpunk-blue-5 "#4c83ff")
       (cyberpunk-blue-6 "#96CBFE")
       (cyberpunk-blue-7 "#00ffff")
       (cyberpunk-blue-8 "#4F94CD")
       (cyberpunk-magenta "#dc8cc3")
       (cyberpunk-black (if (and cyberpunk-transparent-background
                                 (not (display-graphic-p))
                                 (eq system-type 'darwin))
                            "ARGBBB000000"
                          "#000000"))
       (cyberpunk-black-2 "#0C1021")
       (cyberpunk-black-3 "#0A0A0A")
       (cyberpunk-gray "#d3d3d3")
       (cyberpunk-gray-2 "#8B8989")
       (cyberpunk-gray-3 "#919191")
       (cyberpunk-gray-4 "#999999")
       (cyberpunk-gray-5 "#333333")
       (cyberpunk-gray-6 "#1A1A1A")
       (cyberpunk-gray-7 "#4D4D4D")
       (cyberpunk-gray-8 "#262626")
       (cyberpunk-white "#ffffff")
       (cyberpunk-white-2 "#F8F8F8")
       (cyberpunk-white-3 "#fffafa"))

  (custom-theme-set-faces
   `abyss
   `(bold ((t (:bold t))))
   `(bold-italic ((t (:bold t))))
   `(border-glyph ((t (nil))))
   `(default
      ((t (:foreground ,abyss/foreground :background ,abyss/background))))
   `(fringe ((t (:background ,abyss/background2))))
   `(buffers-tab
     ((t (:foreground ,abyss/foreground :background ,abyss/background))))
   `(font-lock-builtin-face ((t (:foreground ,abyss/vanilla-cream))));
   `(font-lock-comment-delimiter-face ((t (:foreground ,abyss/bluegray :italic t))))
   `(font-lock-comment-face ((t (:foreground ,abyss/bluegray :italic t))))
   `(font-lock-constant-face ((t (:foreground ,abyss/redpurple))))
   `(font-lock-doc-face ((t (:foreground ,abyss/orange))))
   `(font-lock-doc-string-face ((t (:foreground ,abyss/bluegray))))
   `(font-lock-string-face ((t (:foreground ,abyss/magenta))))
   `(font-lock-function-name-face ((t (:foreground ,abyss/skyblue))))
   `(font-lock-keyword-face ((t (:foreground ,abyss/yellow))))
   `(font-lock-preprocessor-face ((t (:foreground ,abyss/blue))))
   `(font-lock-type-face ((t (:foreground ,abyss/skyblue))))
   `(font-lock-variable-name-face ((t (:foreground ,abyss/green ))))
   `(font-lock-negation-char-face ((t (:foreground ,abyss/redpurple))))
   `(font-lock-warning-face ((t (:foreground ,abyss/scarlet :bold t))))
   `(gui-element
        ((t (:foreground ,abyss/background2 :background ,abyss/foreground))))
   `(mode-line
     ((t (:foreground ,abyss/background2 :background ,abyss/skyblue :box nil))))
   `(mode-line-highlight
     ((t (:foreground ,abyss/vanilla-cream :box nil))))
   `(mode-line-inactive
     ((t (:foreground ,abyss/redpurple :background ,abyss/background2 :box nil))))
   `(text-cursor
        ((t (:foreground ,abyss/foreground :background ,abyss/background))))
   `(region
     ((t (:foreground ,abyss/background :background ,abyss/redpurple))))
   `(italic ((t (nil))))
   `(left-margin ((t (nil))))
   `(toolbar ((t (nil))))
   `(whitespace-tab ((t (:background ,abyss/background))))
   `(whitespace-line ((t (:foreground ,abyss/white :background ,abyss/hilite))))
   `(magit-item-highlight ((t (:inherit region))))
   `(highlight ((t (:background ,abyss/hl-line)))))
   ;; `(highlight ((t (:foreground ,abyss/background2 :background ,abyss/foreground)))))

   ;; rainbow-delimiters
 `(rainbow-delimiters-depth-1-face ((:foreground ,cyberpunk-red-1)))
 `(rainbow-delimiters-depth-2-face ((:foreground ,cyberpunk-green-2)))
 `(rainbow-delimiters-depth-3-face ((:foreground ,cyberpunk-pink-1)))
 `(rainbow-delimiters-depth-4-face ((:foreground ,cyberpunk-yellow)))
 `(rainbow-delimiters-depth-5-face ((:foreground ,cyberpunk-green)))
 `(rainbow-delimiters-depth-6-face ((:foreground ,cyberpunk-blue-3)))
 `(rainbow-delimiters-depth-7-face ((:foreground ,cyberpunk-orange)))
 `(rainbow-delimiters-depth-8-face ((:foreground ,cyberpunk-blue-2)))
 `(rainbow-delimiters-depth-9-face ((:foreground ,cyberpunk-gray)))
 `(rainbow-delimiters-depth-10-face ((:foreground ,cyberpunk-white)))
 `(rainbow-delimiters-depth-11-face ((:foreground ,cyberpunk-blue+1)))
 `(rainbow-delimiters-depth-12-face ((:foreground ,cyberpunk-red-4)))

  `(underline ((nil (:underline nil)))))

;;;###autoload
(when load-file-name
  (add-to-list
   'custom-theme-load-path
   (file-name-as-directory (file-name-directory load-file-name))))

;;;###autoload
(defun abyss-theme()
  "Load abyss-theme."
  (interactive)
  (load-theme 'abyss t))

(provide-theme 'abyss)
;;; abyss-theme.el ends here
