
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; SuperColorfulNotes for TeXmacs: the "Colorful" menu.
;; The colors themselves live in the style package super-colorful-notes
;; (packages/super-colorful-notes.ts); this file only changes the variables
;; of that package in the current document, saves the user's own defaults,
;; and exports a serious looking PDF.
;;
;; Developed with the assistance of Claude Opus 5.5 (Anthropic).
;;
;; Copyright (C) 2026 Jacopo Rizzuto
;; This software is released under the GNU General Public License version 3
;; or any later version; see the LICENSE file in the repository.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(plugin-configure super-colorful-notes
  (:require #t))

(define-preferences
  ("super colorful notes: serious pdf" "on" noop))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The package in the current document
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define scn-package "super-colorful-notes")

(tm-define (scn-in-document?)
  (in? scn-package (get-style-list)))

(tm-define (scn-toggle-package)
  (:synopsis "Use SuperColorfulNotes in the current document")
  (:check-mark "v" scn-in-document?)
  (if (scn-in-document?)
      (begin
        (scn-forget-document-settings)
        (remove-style-package scn-package))
      (add-style-package scn-package)))

(define (scn-forget-document-settings)
  ;; leave no trace of the package in the document's environment
  (apply init-default
         (append '("scn-colorful" "scn-inline" "scn-headings" "scn-lists"
                   "scn-links" "scn-math" "scn-rules" "scn-serious-callouts"
                   "scn-serious-style" "locus-color" "visited-color"
                   "math-color" "strong-color")
                 (scn-color-vars)))
  ;; the page colors of the dark preset
  (when (== (get-init-env "bg-color") "#1e1e1e") (init-default "bg-color"))
  (when (== (get-init-env "color") "#dcddde") (init-default "color")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switches
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (scn-switch-on? var)
  (!= (get-init-env var) "false"))

(define (scn-set-switch var on?)
  ;; all switches are "true" in the package, so "on" is the default
  (if on? (init-default var) (init-env var "false")))

(define (scn-black?)
  (and (not (scn-switch-on? "scn-colorful"))
       (== (get-init-env "scn-serious-style") "black")))

(define (scn-sync-one targets plains source family)
  ;; some colors are plain variables of TeXmacs or of alt-colors (the locus
  ;; color of links, math-color, strong-color), which the package can only
  ;; set once from its own palette: they are set in the document when they
  ;; must differ from it. When the family is off (or in the serious look
  ;; that keeps the other packages' colors) they get back the values they
  ;; had before the package, which it keeps in scn-plain-...
  (let ((on? (and (scn-switch-on? "scn-colorful") (scn-switch-on? family)))
        (custom? (init-has? source)))
    (cond ((and on? (not custom?)) (apply init-default targets))
          (on? (for (v targets) (init-env v (get-init-env source))))
          ((scn-black?)
           (with ink (or (get-init-env "scn-serious-ink") "black")
             (for (v targets) (init-env v ink))))
          (else
           (for-each (lambda (v p)
                       (with old (get-init-env p)
                         (if (and (string? old) (!= old ""))
                             (init-env v old)
                             (init-default v))))
                     targets plains)))))

(define (scn-sync-links)
  (scn-sync-one '("locus-color" "visited-color")
                '("scn-plain-locus-color" "scn-plain-visited-color")
                "scn-link-color" "scn-links")
  (scn-sync-one '("math-color") '("scn-plain-math-color")
                "scn-math-color" "scn-math")
  (scn-sync-one '("strong-color") '("scn-plain-strong-color")
                "scn-strong-color" "scn-inline"))

(tm-define (scn-serious-style? style)
  (== (if (scn-black-style?) "black" "previous") style))

(define (scn-black-style?)
  (== (get-init-env "scn-serious-style") "black"))

(tm-define (scn-set-serious-style style)
  (:check-mark "o" scn-serious-style?)
  (if (== style "black")
      (init-env "scn-serious-style" "black")
      (init-default "scn-serious-style"))
  (scn-sync-links))

(tm-define (scn-colorful?)
  (scn-switch-on? "scn-colorful"))

(tm-define (scn-toggle-colorful)
  (:synopsis "Switch between the colorful and the serious look")
  (:check-mark "v" scn-colorful?)
  (scn-set-switch "scn-colorful" (not (scn-colorful?)))
  (scn-sync-links))

(tm-define (scn-family-on? var)
  (scn-switch-on? var))

(tm-define (scn-toggle-family var)
  (:check-mark "v" scn-family-on?)
  (scn-set-switch var (not (scn-switch-on? var)))
  (scn-sync-links))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Colors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (variable menu label), in menu order; "---" separates groups
(define scn-colors
  '(("scn-strong-color" "Bold")
    ("scn-em-color" "Italic")
    ("scn-underline-color" "Underlined text")
    ("scn-underline-line-color" "Underline")
    ("scn-strike-color" "Struck out text")
    ("scn-strike-line-color" "Strike-through line")
    ("scn-name-color" "Names (small capitals)")
    ("scn-code-color" "Inline code, verbatim, keys")
    ("scn-marked-color" "Highlighter background")
    "---"
    ("scn-title-color" "Document title")
    ("scn-part-color" "Part")
    ("scn-chapter-color" "Chapter")
    ("scn-section-color" "Section")
    ("scn-subsection-color" "Subsection")
    ("scn-subsubsection-color" "Subsubsection")
    ("scn-paragraph-color" "Paragraph")
    ("scn-subparagraph-color" "Subparagraph")
    "---"
    ("scn-bullet-1-color" "Bullets, level 1")
    ("scn-bullet-2-color" "Bullets, level 2")
    ("scn-bullet-3-color" "Bullets, level 3")
    ("scn-number-color" "Numbers of enumerations")
    ("scn-link-color" "Links and references")
    ("scn-math-color" "Mathematics")
    ("scn-rule-color" "Horizontal rules")
    "---"
    ("scn-serious-ink" "Serious look: ink")
    ("scn-serious-marked-color" "Serious look: highlighter")
    ("scn-serious-callout-title" "Serious look: box titles")
    ("scn-serious-callout-body" "Serious look: box background")))

(define (scn-color-vars)
  (map car (list-filter scn-colors pair?)))

(define (scn-get var)
  (with v (get-env var)
    (if (== v "") "black" v)))

(tm-define (scn-choose-color var)
  (interactive-color
    (lambda (col)
      (when (string? col)
        (init-env var col)
        (scn-sync-links)))
    (list (scn-get var))))

(tm-menu (scn-colors-menu)
  (for (x scn-colors)
    (if (string? x) ---)
    (if (pair? x)
        ((eval (cadr x)) (scn-choose-color (car x))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Presets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; colors that are not given keep the value of the package (or of the
;; user's own defaults); bg-color and color are the page and the text
(define scn-presets
  `(("Obsidian light (colors.css, light theme)"
     ("scn-strong-color" . "#d9485f") ("scn-em-color" . "#148a4b")
     ("scn-underline-color" . "#d97706") ("scn-underline-line-color" . "#7c3aed")
     ("scn-strike-color" . "#6b7280") ("scn-strike-line-color" . "#b91c1c")
     ("scn-name-color" . "#7c3aed") ("scn-code-color" . "#be185d")
     ("scn-marked-color" . "#fde68a")
     ("scn-title-color" . "#c0267d") ("scn-part-color" . "#c0267d")
     ("scn-chapter-color" . "#c0267d") ("scn-section-color" . "#ea580c")
     ("scn-subsection-color" . "#a16207") ("scn-subsubsection-color" . "#15803d")
     ("scn-paragraph-color" . "#0369a1") ("scn-subparagraph-color" . "#7c3aed")
     ("scn-bullet-1-color" . "#0891b2") ("scn-bullet-2-color" . "#2563eb")
     ("scn-bullet-3-color" . "#ca8a04") ("scn-number-color" . "#7c3aed")
     ("scn-link-color" . "#2563eb") ("scn-math-color" . "dark red")
     ("scn-rule-color" . "#db2777")
     ("bg-color" . :default) ("color" . :default))
    ("Obsidian dark (colors.css, dark theme, dark page)"
     ("scn-strong-color" . "#ff6b6b") ("scn-em-color" . "#7ee787")
     ("scn-underline-color" . "#fd921e") ("scn-underline-line-color" . "#b197fc")
     ("scn-strike-color" . "#8b949e") ("scn-strike-line-color" . "#ff6b6b")
     ("scn-name-color" . "#b197fc") ("scn-code-color" . "#ff79c6")
     ("scn-marked-color" . "#5c4d1f")
     ("scn-title-color" . "#ff79c6") ("scn-part-color" . "#ff79c6")
     ("scn-chapter-color" . "#ff79c6") ("scn-section-color" . "#ffb86c")
     ("scn-subsection-color" . "#f1fa8c") ("scn-subsubsection-color" . "#7ee787")
     ("scn-paragraph-color" . "#66d9ef") ("scn-subparagraph-color" . "#b197fc")
     ("scn-bullet-1-color" . "#66d9ef") ("scn-bullet-2-color" . "#74c0fc")
     ("scn-bullet-3-color" . "#d8bd7c") ("scn-number-color" . "#b197fc")
     ("scn-link-color" . "#74c0fc") ("scn-math-color" . "#66d9ef")
     ("scn-rule-color" . "#ff79c6")
     ("bg-color" . "#1e1e1e") ("color" . "#dcddde"))
    ("Neon dopamine"
     ("scn-strong-color" . "#e11d48") ("scn-em-color" . "#059669")
     ("scn-underline-color" . "#ea580c") ("scn-underline-line-color" . "#9333ea")
     ("scn-strike-color" . "#64748b") ("scn-strike-line-color" . "#dc2626")
     ("scn-name-color" . "#9333ea") ("scn-code-color" . "#db2777")
     ("scn-marked-color" . "#fef08a")
     ("scn-title-color" . "#db2777") ("scn-part-color" . "#db2777")
     ("scn-chapter-color" . "#db2777") ("scn-section-color" . "#f97316")
     ("scn-subsection-color" . "#ca8a04") ("scn-subsubsection-color" . "#16a34a")
     ("scn-paragraph-color" . "#0284c7") ("scn-subparagraph-color" . "#9333ea")
     ("scn-bullet-1-color" . "#06b6d4") ("scn-bullet-2-color" . "#3b82f6")
     ("scn-bullet-3-color" . "#eab308") ("scn-number-color" . "#a21caf")
     ("scn-link-color" . "#2563eb") ("scn-math-color" . "#7c3aed")
     ("scn-rule-color" . "#f43f5e")
     ("bg-color" . :default) ("color" . :default))
    ("Ocean (cooler, easier on the eyes)"
     ("scn-strong-color" . "#0f766e") ("scn-em-color" . "#4338ca")
     ("scn-underline-color" . "#0369a1") ("scn-underline-line-color" . "#14b8a6")
     ("scn-strike-color" . "#64748b") ("scn-strike-line-color" . "#be123c")
     ("scn-name-color" . "#6d28d9") ("scn-code-color" . "#0e7490")
     ("scn-marked-color" . "#ccfbf1")
     ("scn-title-color" . "#1e3a8a") ("scn-part-color" . "#1e3a8a")
     ("scn-chapter-color" . "#1e3a8a") ("scn-section-color" . "#1d4ed8")
     ("scn-subsection-color" . "#0e7490") ("scn-subsubsection-color" . "#0f766e")
     ("scn-paragraph-color" . "#4338ca") ("scn-subparagraph-color" . "#6d28d9")
     ("scn-bullet-1-color" . "#0891b2") ("scn-bullet-2-color" . "#6366f1")
     ("scn-bullet-3-color" . "#14b8a6") ("scn-number-color" . "#1d4ed8")
     ("scn-link-color" . "#0284c7") ("scn-math-color" . "#1e40af")
     ("scn-rule-color" . "#0891b2")
     ("bg-color" . :default) ("color" . :default))))

(tm-define (scn-apply-preset name)
  (:synopsis "Use the colors of a preset in the current document")
  (and-with p (assoc name scn-presets)
    (for (x (cdr p))
      (if (== (cdr x) :default)
          (init-default (car x))
          (init-env (car x) (cdr x))))
    (scn-sync-links)))

(tm-define (scn-reset-colors)
  (:synopsis "Go back to my default colors in the current document")
  (apply init-default (cons* "bg-color" "color" (scn-color-vars)))
  (scn-sync-links))

(tm-menu (scn-presets-menu)
  (for (p scn-presets)
    ((eval (car p)) (scn-apply-preset (car p)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The user's own defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; a palette in $TEXMACS_HOME_PATH/packages replaces the one of the plugin,
;; because the home packages are searched first
(define (scn-user-palette)
  (url-append "$TEXMACS_HOME_PATH" "packages/super-colorful-notes-palette.ts"))

(define (scn-reload-style)
  ;; compiled styles are cached: forget them, and typeset the document again
  (style-clear-cache)
  (set-style-tree (tm->tree `(tuple ,@(get-style-list)))))

(define (scn-palette-text)
  (string-append
   "<TeXmacs|2.1.5>\n\n<style|source>\n\n<\\body>\n"
   "  <active*|<\\src-title>\n"
   "    <src-package|super-colorful-notes-palette|1.0>\n\n"
   "    <\\src-purpose>\n"
   "      My default colors for SuperColorfulNotes (written by Colorful\n"
   "      \\<gtr\\> Save as my defaults).\n"
   "    </src-purpose>\n"
   "  </src-title>>\n\n"
   (apply string-append
          (map (lambda (var)
                 (string-append "  <assign|" var "|" (scn-get var) ">\n\n"))
               (scn-color-vars)))
   "</body>\n\n<\\initial>\n  <\\collection>\n"
   "    <associate|preamble|true>\n  </collection>\n</initial>\n"))

(tm-define (scn-save-defaults)
  (:synopsis "Make the colors of this document my defaults")
  (string-save (scn-palette-text) (scn-user-palette))
  ;; the document now gets the same colors from the package
  (apply init-default (scn-color-vars))
  (scn-sync-links)
  (scn-reload-style)
  (set-message "Saved as the default colors of SuperColorfulNotes"
               "SuperColorfulNotes"))

(tm-define (scn-has-user-defaults?)
  (url-exists? (scn-user-palette)))

(tm-define (scn-forget-defaults)
  (:synopsis "Go back to the colors that come with SuperColorfulNotes")
  (when (scn-has-user-defaults?)
    (url-remove (scn-user-palette))
    (scn-reload-style)
    (set-message "Back to the Obsidian colors of SuperColorfulNotes"
                 "SuperColorfulNotes")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Serious PDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(tm-define (scn-serious-pdf?)
  (== (get-preference "super colorful notes: serious pdf") "on"))

(tm-define (scn-toggle-serious-pdf)
  (:synopsis "Export PDF files of colorful documents with the serious look")
  (:check-mark "v" scn-serious-pdf?)
  (set-boolean-preference "super colorful notes: serious pdf"
                          (not (scn-serious-pdf?))))

(define (scn-export-serious thunk)
  ;; switch to the serious look, let the document be typeset again, export,
  ;; and come back to the colorful look without leaving the document modified
  (let* ((buf (current-buffer))
         (modified? (buffer-modified? buf)))
    (scn-set-switch "scn-colorful" #f)
    (scn-sync-links)
    (delayed
      (:idle 100)
      (thunk)
      (when (== (current-buffer) buf)
        (scn-set-switch "scn-colorful" #t)
        (scn-sync-links)
        (when (not modified?) (buffer-pretend-saved buf))))))

(tm-define (wrapped-print-to-file fname)
  (:require (and (scn-serious-pdf?) (scn-in-document?) (scn-colorful?)
                 (== (url-suffix fname) "pdf")))
  (scn-export-serious (lambda () (former fname))))

(tm-define (scn-export-serious-pdf fname)
  (if (and (scn-in-document?) (scn-colorful?))
      (scn-export-serious (lambda () (print-to-file fname)))
      (print-to-file fname)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bold and italic text made with Format > Bold or Format > Italic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; such text is <with|font-series|bold|...>, which no macro can color:
;; it is turned into <strong|...> and <em|...>
(define scn-manual-tags
  '((("font-series" "bold") . strong) (("font-shape" "italic") . em)))

(define (scn-manual-tag t)
  (and (tree-is? t 'with) (== (tree-arity t) 3)
       (tree-atomic? (tree-ref t 0)) (tree-atomic? (tree-ref t 1))
       (assoc-ref scn-manual-tags (list (tree->string (tree-ref t 0))
                                        (tree->string (tree-ref t 1))))))

(define (scn-manual-markup t)
  ;; the trees to convert inside @t, innermost first; macro definitions
  ;; and the preamble are left alone
  (cond ((tree-atomic? t) '())
        ((tree-in? t '(assign macro xmacro hide-preamble show-preamble)) '())
        (else (append (apply append (map scn-manual-markup (tree-children t)))
                      (if (scn-manual-tag t) (list t) '())))))

(tm-define (scn-convert-manual-markup)
  (:synopsis "Turn bold and italic text made with the Format menu into strong and em")
  (let* ((l (scn-manual-markup (buffer-tree)))
         (n (length l)))
    (for (t l)
      (with tag (scn-manual-tag t)
        (tree-remove! t 0 2)
        (tree-assign-node! t tag)))
    (set-message (string-append (number->string n)
                                " pieces of bold or italic text converted")
                 "SuperColorfulNotes")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Colors of program code (preferences, used after a restart)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define scn-code-languages
  '("python" "java" "cpp" "scala" "scheme" "fortran" "julia" "octave"
    "javascript" "json" "r" "sql" "rust" "go" "csharp" "dot" "mathemagix"))

;; light colors of code-syntax.css
(define scn-code-syntax
  '(("none" . "#24292f") ("comment" . "#6b7280") ("error" . "#b91c1c")
    ("preprocessor" . "#b45309") ("preprocessor_directive" . "#b45309")
    ("constant" . "#b45309") ("constant_identifier" . "#b45309")
    ("constant_function" . "#1d4ed8") ("constant_type" . "#a16207")
    ("constant_category" . "#a16207") ("constant_module" . "#a16207")
    ("constant_number" . "#b45309") ("constant_string" . "#15803d")
    ("constant_char" . "#15803d")
    ("variable" . "#24292f") ("variable_identifier" . "#0e7490")
    ("variable_function" . "#1d4ed8") ("variable_type" . "#a16207")
    ("variable_category" . "#a16207") ("variable_module" . "#a16207")
    ("variable_ioarg" . "#0e7490")
    ("declare" . "#1d4ed8") ("declare_identifier" . "#0e7490")
    ("declare_function" . "#1d4ed8") ("declare_type" . "#a16207")
    ("declare_category" . "#a16207") ("declare_module" . "#a16207")
    ("operator" . "#be185d") ("operator_openclose" . "#57606a")
    ("operator_field" . "#57606a") ("operator_special" . "#be185d")
    ("keyword" . "#7c3aed") ("keyword_conditional" . "#7c3aed")
    ("keyword_control" . "#7c3aed")))

(tm-define (scn-apply-code-colors)
  (:synopsis "Color program code like code-syntax.css")
  (for (lan scn-code-languages)
    (for (x scn-code-syntax)
      (set-preference (string-append "syntax:" lan ":" (car x)) (cdr x))))
  (set-message "Code colors set: they are used after restarting TeXmacs"
               "SuperColorfulNotes"))

(tm-define (scn-reset-code-colors)
  (:synopsis "Give program code the colors of TeXmacs again")
  (for (lan scn-code-languages)
    (for (x scn-code-syntax)
      (reset-preference (string-append "syntax:" lan ":" (car x)))))
  (set-message "TeXmacs code colors restored: they are used after restarting TeXmacs"
               "SuperColorfulNotes"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu-bind scn-menu
  ("Use SuperColorfulNotes in this document" (scn-toggle-package))
  (when (scn-in-document?)
    ---
    ("Colorful (off: serious look)" (scn-toggle-colorful))
    (-> "What to color"
        ("Bold, italic, underline..." (scn-toggle-family "scn-inline"))
        ("Headings" (scn-toggle-family "scn-headings"))
        ("List bullets and numbers" (scn-toggle-family "scn-lists"))
        ("Links and references" (scn-toggle-family "scn-links"))
        ("Mathematics" (scn-toggle-family "scn-math"))
        ("Horizontal rules" (scn-toggle-family "scn-rules"))
        ---
        ("Grey boxes in the black and white look"
         (scn-toggle-family "scn-serious-callouts")))
    (-> "Serious look"
        ("Colors of the other packages (alt-colors, my-notes...)"
         (scn-set-serious-style "previous"))
        ("Black and white" (scn-set-serious-style "black")))
    ---
    (-> "Presets" (link scn-presets-menu))
    (-> "Change colors" (link scn-colors-menu))
    ("Reset to my default colors" (scn-reset-colors))
    ---
    ("Color bold and italic made with the Format menu" (scn-convert-manual-markup))
    ---
    ("Save as my defaults" (scn-save-defaults))
    (when (scn-has-user-defaults?)
      ("Forget my defaults" (scn-forget-defaults))))
  ---
  ("Serious look in exported PDF files" (scn-toggle-serious-pdf))
  ("Export serious PDF"
   (choose-file scn-export-serious-pdf "Export serious PDF" "pdf"))
  ---
  (-> "Program code"
      ("Use the code-syntax.css colors" (scn-apply-code-colors))
      ("Use the TeXmacs colors" (scn-reset-code-colors))))

(menu-bind texmacs-extra-menu
  (former)
  (if (not (in-graphics?))
      (=> "Colorful" (link scn-menu))))
