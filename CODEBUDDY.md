# CODEBUDDY.md

This file provides guidance to CodeBuddy Code when working with code in this repository.

## Project Overview

This is a Typst-based thesis template for Southern University of Science and Technology (SUSTech) undergraduate thesis. It provides formatting for Chinese and English covers, declarations, abstracts, table of contents, body sections, references, and acknowledgements following the [SUSTech undergraduate thesis writing guidelines](https://tao.sustech.edu.cn/xueshengfuwu/biyelunwen).

## Build Commands

```bash
# Compile thesis to PDF (fonts must be specified for correct rendering)
typst compile --font-path fonts thesis.typ ./build/thesis.pdf

# Watch mode for live preview during development
typst watch --font-path fonts thesis.typ ./build/thesis.pdf
```

For VS Code users, the [Tinymist Typst](https://github.com/Myriad-Dreamin/tinymist) extension provides integrated preview and compilation.

## Project Architecture

### Entry Point
- `thesis.typ` - Main document that imports templates and assembles all thesis components

### Directory Structure
```
├── thesis.typ          # Main entry point
├── template/           # Thesis component templates
│   ├── template.typ    # Re-exports all components
│   ├── cover_zh.typ    # Chinese cover page
│   ├── cover_en.typ    # English cover page
│   ├── decl_zh.typ     # Chinese declaration (诚信承诺书)
│   ├── decl_en.typ     # English declaration
│   ├── abstract_zh.typ # Chinese abstract
│   ├── abstract_en.typ # English abstract
│   ├── abstract_header.typ # Abstract header formatting
│   ├── content.typ     # Table of contents
│   ├── references.typ  # Bibliography section
│   ├── acknowledgement.typ # Acknowledgements
│   └── appendix.typ    # Appendix formatting
├── utils/              # Utilities
│   ├── style.typ       # Document class, heading styles, code blocks, page layout
│   ├── font.typ        # Font definitions (FSIZE, FONTS dictionaries)
│   └── headings.typ    # Heading numbering scheme
├── sections/           # Thesis body sections
│   ├── 0_introduction.typ
│   ├── 1_related_work.typ
│   ├── 2_methedology.typ
│   ├── 3_experiments.typ
│   ├── 4_conclusion.typ
│   └── appendix.typ
├── fonts/              # Custom fonts (Source Han Sans/Serif)
├── images/             # Figures and images
└── references.bib      # BibTeX bibliography
```

### Key Design Patterns

**Font System**: Uses `FONTS` and `FSIZE` dictionaries in `utils/font.typ` for consistent typography. Chinese font names map to fallback lists (e.g., `FONTS.宋体` → Times New Roman, SimSun, Source Han Serif SC, etc.).

**Template Functions**: Each template file exports a function (e.g., `cover()`, `abstract()`, `declare()`) that accepts configuration via named parameters.

**Thesis Info Dictionary**: The `info` dictionary in `thesis.typ` contains metadata (title, author, student_id, department, etc.) passed to template functions.

**Language Support**: Most templates support `en: true/false` parameter for Chinese/English switching. The document class also accepts `lang: "zh"` or `lang: "en"`.

### Dependencies (Typst packages)
- `@preview/cuti:0.3.0` - Chinese fake bold support
- `@preview/codly:1.2.0` - Code block styling
- `@preview/codly-languages:0.1.7` - Language definitions for codly

### Bibliography
Uses GB/T 7714-2005 numeric style (`style: "gb-7714-2005-numeric"`). References are managed in `references.bib` and cited using `@cite_key` syntax.

### Adding New Sections
1. Create new `.typ` file in `sections/`
2. Add `#include "sections/your_section.typ"` in `thesis.typ` at the appropriate position

### Font Requirements
The template requires Chinese fonts. Custom fonts are provided in `fonts/` directory (Source Han Sans/Serif). The `--font-path fonts` flag ensures these fonts are used during compilation.
