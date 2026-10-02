# SuperColorfulNotes

A GNU TeXmacs addon that colors your notes the way the Obsidian snippets
`colors.css`, `colorful-headings.css`, `colorful-links-tags.css` and
`code-syntax.css` color Markdown: red bold, green italic, orange underlined text
with a violet line, rainbow headings, colored bullets and numbers, blue links.
The more color, the more dopamine. One switch gives a serious, black and white
look, and PDF files can be exported with that look automatically.

## What is colored

| Element | Default color (Obsidian light theme) |
|---|---|
| Bold (`strong`) | `#d9485f` |
| Italic (`em`) | `#148a4b` |
| Underlined text / its line | `#d97706` / `#7c3aed` |
| Struck out text / its line | `#6b7280` / `#b91c1c` |
| Names (small capitals) | `#7c3aed` |
| Inline code, verbatim, keys | `#be185d` |
| Highlighter (`marked`) | `#fde68a` |
| Document title, part, chapter | `#c0267d` |
| Section, subsection, subsubsection | `#ea580c`, `#a16207`, `#15803d` |
| Paragraph, subparagraph | `#0369a1`, `#7c3aed` |
| Bullets by level | `#0891b2`, `#2563eb`, `#ca8a04` |
| Numbers of enumerations (bold) | `#7c3aed` |
| Links and references | `#2563eb` |
| Mathematics | `dark red` (as with alt-colors) |
| Horizontal rules | `#db2777` |

In the serious look everything is black, highlighted text is light grey, and
the callout boxes of `my-notes` (definitions, theorems, warnings...) all become
grey.

## Installation

```sh
git clone <this repository> ~/Projects/texmacs-super-colorful-notes
ln -s ~/Projects/texmacs-super-colorful-notes/super-colorful-notes ~/.TeXmacs/plugins/super-colorful-notes
```

Restart TeXmacs. A **Colorful** menu appears in the menu bar. In a document,
choose *Colorful → Use SuperColorfulNotes in this document*: this adds the
style package `super-colorful-notes` at the end of the document's packages
(it is meant to come after `my-notes` and `alt-colors`).

## The Colorful menu

- **Colorful (off: serious look)**: switches the current document between the
  two looks.
- **What to color**: turns families of elements on or off (inline markup,
  headings, list labels, links, math, rules), and decides whether the
  callout boxes turn grey in the serious look.
- **Presets**: *Obsidian light* (the default), *Obsidian dark* (the exact dark
  theme colors of the snippets, on a dark page like Obsidian), *Neon dopamine*,
  *Ocean*.
- **Change colors**: a color picker for every element, including the colors of
  the serious look.
- **Reset to my default colors**: forgets the colors chosen for this document.
- **Color bold and italic made with the Format menu**: text made bold with
  *Format → Bold* is plain `with font-series bold`, which a style cannot
  recolor. This converts it, in the current document, to `strong` and `em`
  (it can be undone). Macro definitions are left alone.
- **Save as my defaults**: the colors of this document become the defaults of
  every document (written to
  `~/.TeXmacs/packages/super-colorful-notes-palette.ts`, which replaces the
  palette that comes with the addon). **Forget my defaults** removes that file.
- **Serious look in exported PDF files** (on by default): *File → Export as
  PDF* exports colorful documents with the serious look; the document itself
  stays colorful and is not marked as modified.
- **Export serious PDF**: the same for one export, whatever the setting.
- **Program code**: colors code blocks like `code-syntax.css` (light theme),
  or gives them the TeXmacs colors again. These are global preferences, used
  after restarting TeXmacs.

## Customizing by hand

Every color and switch is a variable of the style package, so it can also be
set in *Document → Source* or in the document's preamble, for instance
`<assign|scn-strong-color|#ff006e>` or `<assign|scn-headings|false>`. The
variables are listed in `packages/super-colorful-notes-palette.ts` and at the
top of `packages/super-colorful-notes.ts`. The switches are `scn-colorful`,
`scn-inline`, `scn-headings`, `scn-lists`, `scn-links`, `scn-math`, `scn-rules`
and `scn-serious-callouts`.

Links, math in displayed equations and bold text inside headings use plain
TeXmacs variables (`locus-color`, `math-color`, `strong-color`), which the
style can only set from the palette. The Colorful menu keeps them in step with
the document's colors, so use the menu rather than editing `scn-link-color`,
`scn-math-color` or `scn-strong-color` by hand.

## Development

Developed with the assistance of Claude Opus 5.5 (Anthropic). Tested with
TeXmacs 2.1.5 (trunk, Qt 5): every element in both looks, the presets, the
saved defaults, and the colored pixels of exported PDF files.

## License

GPL-3.0-or-later, see `LICENSE`.
