# Contributing to Arliz

Thank you for your interest in contributing to **Arliz**—a bilingual (currently English, with planned Persian support) LaTeX-based book exploring Arrays, Logic, Identity, and Zero. Whether you’re submitting bug reports, suggesting new content, improving existing chapters, or refining build/packaging scripts, this document explains how to work with the repository in a consistent, efficient, and professional manner.

> **Maintainer Contact:** bitsgenix@gmail.com

## 1. Getting Started

Before you begin any work, please ensure you have:

1. **A Local Clone of Arliz**  
   ```bash
   git clone https://github.com/m-mdy-m/Arliz.git
   cd Arliz
   ```

2. **A LaTeX Environment**

   * Any modern LaTeX distribution (TeX Live, MiKTeX, MacTeX, etc.)
   * Although the primary maintainer uses **TeXstudio**, you are free to use any editor or IDE (e.g., TeXworks, Visual Studio Code + LaTeX Workshop, Vim/Emacs with appropriate plugins).

3. **Basic Familiarity with Git and GitHub**

   * Fork the repository to your own account.
   * Create feature or fix branches from `main` (e.g., `feature/part02-clarify-notation`, `bugfix/broken-crossref`).

4. **Understanding of Project Layout**

   * The principal LaTeX file is `book/Arliz.tex`. All content chapters reside under `book/parts/partXX/partXX.tex`.
   * Build scripts (when available) will live under `scripts/build/` (e.g., a shell or Python script to automate compilation).

---

## 2. Issue Reporting

If you encounter a problem or have a suggestion, please open an issue using one of the provided templates. This helps maintain clarity and structure.

1. **Bug Report**

   * Select the **Bug report** template.
   * Provide your operating system, LaTeX engine, steps to reproduce, expected vs. actual behavior, and any error logs.
   * Reference exact file names and line numbers when applicable (e.g., `book/parts/part02/part02.tex: line 134`).

2. **Feature Request**

   * Use the **Feature request** template when suggesting new content, structural changes, or enhancements (e.g., adding a glossary, example code blocks, or new illustrative diagrams).
   * Clearly explain *why* the feature is needed, *how* it benefits the reader, and, if possible, outline a high-level implementation approach.

3. **Documentation Update**

   * Choose the **Documentation update** template for corrections or improvements to existing text, LaTeX macros, configuration files, or build instructions.
   * Provide context regarding where in the documentation the change applies.

> ⚠️ **Before opening an issue**:
>
> * Search existing issues to see if your problem or suggestion has already been reported.
> * If you find a duplicate, feel free to comment on the existing issue instead of creating a new one.

---

## 3. Pull Request Process

When you’re ready to submit changes, follow these steps to ensure a smooth review and merge process:

1. **Branch from `main`**

   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/your-feature-name
   ```

2. **Adhere to the PR Template**

   * Fill out the **PULL\_REQUEST\_TEMPLATE.md** in full.
   * Provide a meaningful title, link to related issues, and a clear summary of changes.
   * Include details on how to compile, verify, or preview your changes (e.g., “Compiled PDF pages 45–52 to verify figure placement”).

3. **Make Incremental, Focused Commits**

   * Follow the [Commit Message Guidelines](#commit-message-guidelines) below.
   * Keep each commit aligned to a single logical change (e.g., “Update array notation in Part 02” rather than “Various fixes”).

4. **Ensure Build and Compilation Are Clean**

   * Run the build script (if available) or manually compile:

     ```bash
     cd book
     xelatex Arliz.tex
     bibtex Arliz           # if bibliography changed
     xelatex Arliz.tex      # twice for cross-references
     ```
   * Verify that `Arliz.pdf` reflects your intended updates without errors or missing references.

5. **Open a Pull Request on GitHub**

   * Push your branch to your fork:

     ```bash
     git push origin feature/your-feature-name
     ```
   * Navigate to the upstream repository and open a PR from your branch to `main`.
   * Select an appropriate label (e.g., `enhancement`, `bug`, `documentation`).

6. **Review and Address Feedback**

   * A maintainer or reviewer will comment on your PR. Please respond promptly by updating your branch.
   * When all review comments are resolved and CI/build checks pass, the PR will be merged.

---

## 4. Branching Strategy

* **`main`**: Always contains the latest stable version of Arliz.
* **Feature Branches**: Named as `feature/<short-description>` (e.g., `feature/part02-exercise-box`).
* **Bugfix Branches**: Named as `bugfix/<short-description>` (e.g., `bugfix/latex-crossref-error`).
* **Hotfix Branches** (rare): For urgent fixes to `main`, named `hotfix/<description>`.
* **Merge Strategy**:

  * PRs should be **merge-committed** (no squash), preserving commit history.
  * Avoid rebasing `main`-derived branches that have been shared with others.

---

## 5. Source Documentation Rules

**Every addition must be properly sourced**:

### For New Mathematical Content
- Primary mathematical sources (textbooks, papers)
- Historical context sources when relevant
- Original derivations clearly marked as such

### For Examples and Applications  
- Real-world application sources
- Programming language documentation
- Algorithm sources with proper attribution

### For Historical References
- Academic historical sources preferred
- Multiple sources for controversial claims
- Clear distinction between established fact and interpretation

### Source Format
Follow `resources/template.md`:

```markdown
# Sources for Chapter X

## Books
- *Introduction to Algorithms*, Cormen et al. – Used for algorithm complexity analysis in Section X.2

## Articles  
- "The History of Zero", Author, Journal (Year) – Historical context for Section X.1

## Videos/Talks
- [Conference Talk Title](link) – Provided modern perspective on classical problem

## Others
- Mathematical proof verification using Lean/Coq – Original formal verification
```


---
## 6. Commit Message Guidelines

Arliz follows **Semantic Commit Messages**. This convention helps maintain a clear, human-readable project history.

### Format

```
<type>(<scope>): <short summary>
<BLANK LINE>
<body>        # Optional, but encouraged for clarity
<BLANK LINE>
<footer>      # Optional, for breaking changes or issue references
```

### Types

* **feat**: A new feature or enhancement (e.g., new chapter section, additional example).
* **fix**: A bug fix (e.g., resolve compilation error, correct typo).
* **docs**: Documentation changes (e.g., updating frontmatter, modifying README).
* **chore**: Routine tasks (e.g., update CI script, change build script).
* **style**: Formatting, whitespace, or LaTeX style fixes (no code/content changes).
* **refactor**: Refactoring existing code or LaTeX macros without adding features or fixing bugs.
* **test**: Adding or updating tests/build verification scripts (e.g., scripts/build checks).

### Example

```
feat(part02): introduce \Z macro for integer notation

- Added \newcommand{\Z}{\mathbb{Z}} to config/macros.tex
- Updated part02.tex to demonstrate example usage
- Ensured PDF compiles without warnings

Closes #52
```

> **Note:** Always reference an issue number in the footer when applicable (e.g., “Closes #23”, “Relates to #45”).

---

## 7. LaTeX Coding Standards

To keep the LaTeX codebase consistent, please adhere to the following guidelines:

1. **File Encoding & Line Endings**

   * Use **UTF-8** encoding for all `.tex`, `.sty`, and `.bib` files.
   * Use Unix-style line endings (`LF`).

2. **Document Structure**

   * The root file is `book/Arliz.tex`. Do not add standalone `.tex` files outside `book/`.
   * Each major chapter or part resides in its own folder under `book/parts/partXX/partXX.tex`. Refer to existing parts (e.g., `book/parts/part02/part02.tex`) for naming conventions and folder structure.

3. **Macros and Packages**

   * Place all custom macros in `config/macros.tex`.
   * Add new package imports to `config/latex-packages.tex`.
   * Avoid inline `\usepackage{...}` calls inside chapter files; instead, reference the central configuration.

4. **Figures, Tables, and Images**

   * Store all image files (e.g., `.pdf`, `.png`, `.svg`) under `book/images/`.
   * Filenames should be lowercase, hyphen-separated, and descriptive (e.g., `array-indexing-diagram.pdf`).
   * Use the `figure` environment with the `htbp` specifier and include `\centering`, `\caption{}`, and `\label{}`.
   * Verify that all `\ref{}` targets resolve correctly. Run at least two LaTeX passes to ensure references update.

5. **Formatting Conventions**

   * Indent environments and sections by two spaces.
   * Limit line length to 100 characters if possible for readability.
   * Use `%` comments to explain nontrivial LaTeX logic (e.g., custom TikZ code, dynamic macros).
   * Do not commit commented-out blocks of code or text. Remove or archive them elsewhere if needed.

6. **Bibliography and Citations**

   * Use `biblatex` or `natbib` as defined in `config/latex-packages.tex`.
   * Place `.bib` files under a dedicated folder (e.g., `book/bibliography/`).
   * Run `bibtex` or `biber` as part of the build script whenever references change.

---

## 8. Building the Project

A consistent build process ensures contributors can verify their changes locally:

1. **Prerequisites**

   * LaTeX distribution with standard packages (`amsmath`, `amssymb`, `graphicx`, `xcolor`, `hyperref`, etc.).
   * If you do not have all packages installed, refer to your distribution’s package manager (e.g., `tlmgr` for TeX Live).

2. **Optional Build Script**

   * A build script may be provided under `scripts/build/` (e.g., `build.sh` or `build.py`).
   * To execute:

     ```bash
     cd scripts/build
     ./build.sh   # or python build.py
     ```
   * The script will typically:

     * Clean old artifacts (`*.aux`, `*.log`, `*.toc`, etc.).
     * Compile `book/Arliz.tex` with the configured LaTeX engine.
     * Generate `book/Arliz.pdf` in the `book/` directory.

3. **Manual Build Steps**
   If no script is available or you prefer a manual approach:

   ```bash
   cd book
   xelatex Arliz.tex
   bibtex Arliz       # only if bibliography changed
   xelatex Arliz.tex  # second pass for cross-references
   xelatex Arliz.tex  # optional third pass to ensure all references updated
   ```

   * Inspect console output for errors or warnings.
   * Open `Arliz.pdf` to confirm that all figures, tables, references, and citations render correctly.

4. **Cleaning Artifacts**

   * Many intermediate files are automatically ignored by `.gitignore` (e.g., `*.aux`, `*.log`, `*.toc`, `*.out`, `*.bbl`, etc.).
   * If you manually generate any custom artifacts that should not be committed (e.g., personal notes or scratch files), add them to your local `.git/info/exclude` or update the upstream `.gitignore` via PR.

---

## 9. Editorial Guidelines

Because Arliz is both a technical and conceptual work, consistency in style, terminology, and notation is crucial.

1. **Language and Tone**

   * Primary language is **English**.
   * Maintain a formal, academic tone. Avoid slang or personal anecdotes unless they serve a technical or historical purpose.
   * Use American English spelling (e.g., “organization,” “behavior,” “color”).

2. **Terminology**

   * Use consistent terms for core concepts (e.g., “array,” “element,” “index,” “identity element,” “zero”).
   * Define specialized terminology on first occurrence (e.g., “A **multidimensional array** is a contiguous block of memory indexed by two or more indices…”).
   * If introducing Persian text in the future, surround it with appropriate font declarations and ensure the build script supports bidirectional typesetting (e.g., via `polyglossia` or `bidi` packages).

3. **Section and Figure Numbering**

   * Follow the existing numbering scheme (e.g., Part 02, Chapter 2, Section 2.3).
   * Use `\label{}` immediately after section headings. For example:

     ```latex
     \section{Mathematical Fundamentals}
     \label{sec:math-fundamentals}
     ```

4. **Cross-Referencing**

   * Always refer to figures, tables, sections, or chapters using `\ref{}`. Do not hardcode page numbers.
   * Example:

     ```latex
     As shown in Figure~\ref{fig:array-structure}, …
     ```

5. **Equations and Theorems**

   * Number all displayed equations that will be referenced. Use the `equation` environment:

     ```latex
     \begin{equation}
       a_n = a_{n-1} + a_{n-2}, \quad \forall\,n \geq 2.
       \label{eq:fibonacci}
     \end{equation}
     ```
   * For theorems, definitions, and examples, use the appropriate theorem-like environments defined in `config/environments.tex`.

6. **Examples and Code Blocks**

   * Present LaTeX code using the `verbatim` or `lstlisting` environment (if using the `listings` package).
   * If you add new code examples (e.g., pseudocode for array algorithms), place them in a dedicated folder under `book/parts/partXX/` or `book/appendix/` if applicable.

---

## 10. Communication and Support

* **Questions & Discussion:**
  If you have questions about the scope of Arliz, how chapters should be structured, or general LaTeX-related queries, you can either:

  * Open an **Issue** of type “Documentation update” or “Feature request.”
  * Contact the maintainer directly at **[bitsgenix@gmail.com](mailto:bitsgenix@gmail.com)** for off-topic or broader architectural discussions.

* **Review Turnaround:**

  * The maintainer aims to review new issues and PRs within 3–5 business days.
  * For larger PRs or major content changes, expect additional time for thorough review.

* **Future Translations (Persian):**

  * Arliz is currently written in English. Plans exist to add Persian translations in future versions.
  * When that effort begins, dedicated guidelines for bilingual typesetting (e.g., `polyglossia` configuration, font selection) will be published in a separate document (e.g., `CONTRIBUTING-PERSIAN.md`).

---

Thank you for your contributions and for helping to make **Arliz** a rigorous, comprehensive, and accessible resource. We look forward to collaborating with you!
