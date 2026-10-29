<TeXmacs|2.1.5>

<style|source>

<\body>
  <active*|<\src-title>
    <src-package|super-colorful-notes|1.0>

    <\src-purpose>
      Colors for bold, italic and underlined text, headings, list labels,
      links, math, code and rules, with one switch for a serious look. Put it
      last in the list of packages (after my-notes and alt-colors).
    </src-purpose>

    <src-copyright|2026|Jacopo Rizzuto>

    <\src-license>
      This software falls under the GNU general public license, version 3
      or later. It comes WITHOUT ANY WARRANTY WHATSOEVER.
    </src-license>
  </src-title>>

  <\active*>
    <\src-comment>
      Switches. Every variable can be changed for one document in Document
      \<gtr\> Source or with the Colorful menu. scn-colorful turns all colors
      off at once; the others turn off one family of elements.
    </src-comment>
  </active*>

  <assign|scn-colorful|true>

  <assign|scn-inline|true>

  <assign|scn-headings|true>

  <assign|scn-lists|true>

  <assign|scn-links|true>

  <assign|scn-math|true>

  <assign|scn-rules|true>

  <assign|scn-brackets|true>

  <assign|scn-multiply|true>

  <assign|scn-serious-callouts|true>

  <assign|scn-serious-style|previous>

  <use-package|super-colorful-notes-palette>

  <\active*>
    <\src-comment>
      The serious look has two styles. With scn-serious-style "previous"
      (the default) every element gets back exactly what the other packages
      (alt-colors, my-notes...) give it; with "black" everything is black
      and the callout boxes are grey. A family of elements that is turned
      off always gets back what the other packages give it. The values of
      the colors set by other packages are kept here, before this package
      changes them.
    </src-comment>
  </active*>

  <provide|scn-plain-strong-color|<value|strong-color>>

  <provide|scn-plain-heading-color|<value|heading-color>>

  <provide|scn-plain-math-color|<value|math-color>>

  <provide|scn-plain-locus-color|<value|locus-color>>

  <provide|scn-plain-visited-color|<value|visited-color>>

  <\active*>
    <\src-comment>
      Helpers. scn-color gives the color @col when the family @what is on,
      and otherwise keeps the current color. scn-prev gives @col when the
      family is on, the serious ink in the black serious look, and @prev
      otherwise; scn-ink is scn-prev with the current color as @prev.
    </src-comment>
  </active*>

  <assign|scn-active|<macro|what|<and|<equal|<value|scn-colorful>|true>|<equal|<value|<arg|what>>|true>>>>

  <assign|scn-color|<macro|what|col|<if|<scn-active|<arg|what>>|<arg|col>|<value|color>>>>

  <assign|scn-black|<macro|<and|<equal|<value|scn-colorful>|false>|<equal|<value|scn-serious-style>|black>>>>

  <assign|scn-prev|<macro|what|col|prev|<if|<scn-active|<arg|what>>|<arg|col>|<if|<scn-black>|<value|scn-serious-ink>|<arg|prev>>>>>

  <assign|scn-ink|<macro|what|col|<scn-prev|<arg|what>|<arg|col>|<value|color>>>>

  <\active*>
    <\src-comment>
      Inline markup. The previous definitions are kept, so that the package
      also works on top of alt-colors and of other packages. Bold text takes
      the color strong-color, like in alt-colors, so that headings and box
      titles can give their own color to the bold text inside them.
    </src-comment>
  </active*>

  <provide|scn-plain-strong|<value|strong>>

  <assign|strong-color|<value|scn-strong-color>>

  <assign|strong|<macro|body|<with|color|<scn-color|scn-inline|<value|strong-color>>|strong-color|<scn-prev|scn-inline|<value|strong-color>|<value|strong-color>>|<scn-plain-strong|<arg|body>>>>>

  <provide|scn-plain-em|<value|em>>

  <assign|em|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-em-color>>|<scn-plain-em|<arg|body>>>>>

  <provide|scn-plain-underline|<value|underline>>

  <assign|underline|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-underline-line-color>>|<scn-plain-underline|<with|color|<scn-color|scn-inline|<value|scn-underline-color>>|<arg|body>>>>>>

  <provide|scn-plain-strike-through|<value|strike-through>>

  <assign|strike-through|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-strike-line-color>>|<scn-plain-strike-through|<with|color|<scn-color|scn-inline|<value|scn-strike-color>>|<arg|body>>>>>>

  <provide|scn-plain-name|<value|name>>

  <assign|name|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-name-color>>|<scn-plain-name|<arg|body>>>>>

  <provide|scn-plain-code*|<value|code*>>

  <assign|code*|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-code-color>>|<scn-plain-code*|<arg|body>>>>>

  <provide|scn-plain-verbatim|<value|verbatim>>

  <assign|verbatim|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-code-color>>|<scn-plain-verbatim|<arg|body>>>>>

  <provide|scn-plain-kbd|<value|kbd>>

  <assign|kbd|<macro|body|<with|color|<scn-color|scn-inline|<value|scn-code-color>>|<scn-plain-kbd|<arg|body>>>>>

  <provide|scn-plain-marked|<value|marked>>

  <assign|marked|<macro|body|<with|marked-color|<if|<scn-active|scn-inline>|<value|scn-marked-color>|<if|<scn-black>|<value|scn-serious-marked-color>|<value|marked-color>>>|<scn-plain-marked|<arg|body>>>>>

  <drd-props|strong|arity|1|accessible|all>

  <drd-props|em|arity|1|accessible|all>

  <drd-props|underline|with-like|yes|arity|1|accessible|all>

  <drd-props|strike-through|with-like|yes|arity|1|accessible|all>

  <drd-props|name|arity|1|accessible|all>

  <drd-props|marked|with-like|yes|arity|1|accessible|all>

  <\active*>
    <\src-comment>
      Headings, one color per level. heading-color is set as well, because
      alt-colors colors all titles with it.
    </src-comment>
  </active*>

  <assign|scn-heading|<macro|col|body|<with|color|<scn-ink|scn-headings|<arg|col>>|heading-color|<scn-prev|scn-headings|<arg|col>|<value|scn-plain-heading-color>>|strong-color|<scn-prev|scn-headings|<arg|col>|<value|strong-color>>|<arg|body>>>>

  <provide|scn-plain-doc-title-name|<value|doc-title-name>>

  <assign|doc-title-name|<macro|x|<scn-heading|<value|scn-title-color>|<scn-plain-doc-title-name|<arg|x>>>>>

  <provide|scn-plain-part-title|<value|part-title>>

  <assign|part-title|<macro|x|<scn-heading|<value|scn-part-color>|<scn-plain-part-title|<arg|x>>>>>

  <provide|scn-plain-chapter-title|<value|chapter-title>>

  <assign|chapter-title|<macro|x|<scn-heading|<value|scn-chapter-color>|<scn-plain-chapter-title|<arg|x>>>>>

  <provide|scn-plain-section-title|<value|section-title>>

  <assign|section-title|<macro|x|<scn-heading|<value|scn-section-color>|<scn-plain-section-title|<arg|x>>>>>

  <provide|scn-plain-subsection-title|<value|subsection-title>>

  <assign|subsection-title|<macro|x|<scn-heading|<value|scn-subsection-color>|<scn-plain-subsection-title|<arg|x>>>>>

  <provide|scn-plain-subsubsection-title|<value|subsubsection-title>>

  <assign|subsubsection-title|<macro|x|<scn-heading|<value|scn-subsubsection-color>|<scn-plain-subsubsection-title|<arg|x>>>>>

  <provide|scn-plain-paragraph-title|<value|paragraph-title>>

  <assign|paragraph-title|<macro|x|<scn-heading|<value|scn-paragraph-color>|<scn-plain-paragraph-title|<arg|x>>>>>

  <provide|scn-plain-subparagraph-title|<value|subparagraph-title>>

  <assign|subparagraph-title|<macro|x|<scn-heading|<value|scn-subparagraph-color>|<scn-plain-subparagraph-title|<arg|x>>>>>

  <\active*>
    <\src-comment>
      List labels: bullets get a color per level, numbers and letters are
      bold. scn-list-kind is set by itemize and enumerate.
    </src-comment>
  </active*>

  <assign|scn-list-kind|number>

  <assign|scn-bullet-color|<macro|<if|<equal|<itemize-reduce|<value|itemize-level>>|1>|<value|scn-bullet-1-color>|<if|<equal|<itemize-reduce|<value|itemize-level>>|2>|<value|scn-bullet-2-color>|<value|scn-bullet-3-color>>>>>

  <assign|scn-label|<macro|body|<if|<equal|<value|scn-list-kind>|bullet>|<with|color|<scn-ink|scn-lists|<scn-bullet-color>>|<arg|body>>|<with|color|<scn-ink|scn-lists|<value|scn-number-color>>|font-series|<if|<scn-active|scn-lists>|bold|<value|font-series>>|<arg|body>>>>>

  <provide|scn-plain-list|<value|list>>

  <assign|list|<\macro|item-render|item-transform|body>
    <\with|scn-item-render|<arg|item-render>>
      <scn-plain-list|<macro|name|<scn-label|<scn-item-render|<arg|name>>>>|<arg|item-transform>|<arg|body>>
    </with>
  </macro>>

  <provide|scn-plain-itemize|<value|itemize>>

  <assign|itemize|<macro|body|<with|scn-list-kind|bullet|<scn-plain-itemize|<arg|body>>>>>

  <provide|scn-plain-itemize-minus|<value|itemize-minus>>

  <assign|itemize-minus|<macro|body|<with|scn-list-kind|bullet|<scn-plain-itemize-minus|<arg|body>>>>>

  <provide|scn-plain-itemize-dot|<value|itemize-dot>>

  <assign|itemize-dot|<macro|body|<with|scn-list-kind|bullet|<scn-plain-itemize-dot|<arg|body>>>>>

  <provide|scn-plain-itemize-arrow|<value|itemize-arrow>>

  <assign|itemize-arrow|<macro|body|<with|scn-list-kind|bullet|<scn-plain-itemize-arrow|<arg|body>>>>>

  <provide|scn-plain-enumerate|<value|enumerate>>

  <assign|enumerate|<macro|body|<with|scn-list-kind|number|<scn-plain-enumerate|<arg|body>>>>>

  <\active*>
    <\src-comment>
      Links and references: their color is the locus color. The Colorful
      menu also sets it in the document when the serious look is chosen.
    </src-comment>
  </active*>

  <assign|locus-color|<value|scn-link-color>>

  <assign|visited-color|<value|scn-link-color>>

  <\active*>
    <\src-comment>
      Math (math-color is also used by alt-colors for displayed equations)
      and horizontal rules.
    </src-comment>
  </active*>

  <provide|scn-plain-math|<value|math>>

  <assign|math|<macro|x|<with|color|<scn-ink|scn-math|<value|scn-math-color>>|math-color|<scn-prev|scn-math|<value|scn-math-color>|<value|scn-plain-math-color>>|<scn-plain-math|<arg|x>>>>>

  <assign|math-color|<value|scn-math-color>>

  <assign|hrule|<macro|<with|color|<scn-ink|scn-rules|<value|scn-rule-color>>|<scn-plain-strike-through|<htab|5mm>>>>>

  <\active*>
    <\src-comment>
      Brackets colored by nesting level, and a dot for the invisible
      multiplications. Both need a TeXmacs with math-bracket-colors (the
      local trunk build); another TeXmacs keeps plain brackets, because its
      math-nesting-mode would color the whole content of the brackets. The
      Colorful menu turns them off in the document for the serious look,
      where the dots are still shown on the screen but not printed.
    </src-comment>
  </active*>

  <assign|math-nesting-mode|<if|<provides|math-bracket-colors>|brackets|off>>

  <assign|math-bracket-colors|<tuple|<value|scn-bracket-1-color>|<value|scn-bracket-2-color>|<value|scn-bracket-3-color>|<value|scn-bracket-4-color>>>

  <assign|math-multiply-mark|on>

  <assign|math-multiply-color|<value|scn-multiply-color>>

  <\active*>
    <\src-comment>
      Serious look for the callout boxes of my-notes: all boxes take the
      same grey colors. Without my-notes this definition is never used.
    </src-comment>
  </active*>

  <provide|scn-plain-notes-apply-style|<value|notes-apply-style>>

  <assign|scn-callouts-grey|<macro|<and|<scn-black>|<equal|<value|scn-serious-callouts>|true>>>>

  <assign|notes-apply-style|<\macro|title-bg|body-bg|title-text|body-text|accent|body>
    <\scn-plain-notes-apply-style|<if|<scn-callouts-grey>|<value|scn-serious-callout-title>|<arg|title-bg>>|<if|<scn-callouts-grey>|<value|scn-serious-callout-body>|<arg|body-bg>>|<if|<scn-callouts-grey>|white|<arg|title-text>>|<if|<scn-callouts-grey>|<value|scn-serious-ink>|<arg|body-text>>|<if|<scn-callouts-grey>|<value|scn-serious-callout-title>|<arg|accent>>>
      <arg|body>
    </scn-plain-notes-apply-style>
  </macro>>
</body>

<\initial>
  <\collection>
    <associate|preamble|true>
  </collection>
</initial>
