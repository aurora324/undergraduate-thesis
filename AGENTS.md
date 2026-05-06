# Repository Guidelines

## Project Structure & Module Organization

This repository is a Typst-based SUSTech undergraduate thesis project. The main entry point is `thesis.typ`, which imports `template/template.typ`, defines thesis metadata, and includes body chapters from `sections/`.

- `sections/`: thesis content files, ordered with numeric prefixes such as `0_introduction.typ` and `3_experiments.typ`.
- `template/`: reusable page and component templates for covers, declarations, abstracts, contents, references, acknowledgements, and appendices.
- `utils/`: shared Typst helpers for fonts, heading numbering, page style, and date display.
- `images/` and `assets/`: figures, diagrams, logos, and other visual resources.
- `fonts/`: bundled Chinese font files used during local compilation.
- `references.bib`: BibTeX bibliography data.
- `build/`: generated PDF output; avoid treating generated artifacts as source.

## Build, Test, and Development Commands

Install the Typst CLI and ensure it is available on `PATH`.

```bash
typst compile --font-path fonts thesis.typ ./build/thesis.pdf
```

Compiles the thesis to `build/thesis.pdf` using the bundled fonts.

```bash
typst watch --font-path fonts thesis.typ ./build/thesis.pdf
```

Runs live recompilation while editing. VS Code users can also use the Tinymist Typst extension for preview.

## Coding Style & Naming Conventions

Use two-space indentation in Typst dictionaries and function calls, matching `thesis.typ`. Keep chapter filenames numeric and descriptive: `N_topic.typ`. Prefer lowercase English filenames with underscores. When adding templates, export a focused function from a dedicated file and re-export it through `template/template.typ` if it is part of the public template interface. Keep Chinese and English variants explicit with `zh`, `en`, or `show_both` naming where relevant.

## Testing Guidelines

There is no automated unit test suite. Validate changes by compiling the thesis and reviewing the generated PDF, especially page breaks, headings, figures, citations, Chinese fonts, and cover/declaration pages. For bibliography edits, compile once after updating `references.bib` and confirm every new `@cite_key` resolves.

## Commit & Pull Request Guidelines

The current Git history is brief and uses short milestone-style messages, including Chinese messages such as `中期`. Keep commits concise and scoped, for example `Fix bibliography formatting` or `更新实验章节图表`. Pull requests should describe the affected thesis or template areas, include the compile command used for validation, link related issues when available, and attach screenshots or PDF excerpts for visual layout changes.

## Agent-Specific Instructions

Do not rename existing section files without updating the matching `#include` statements in `thesis.typ`. Avoid broad formatting churn in content-heavy `.typ` files. Preserve user-authored thesis text unless the requested change explicitly involves editing prose.
