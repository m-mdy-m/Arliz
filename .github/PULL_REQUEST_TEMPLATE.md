<!--
Thank you for contributing to Arliz! To help us review your Pull Request (PR) efficiently, please fill out the sections below as completely and accurately as possible. This template is designed to cover changes to text, code, documentation, and formatting within the Arliz repository. Be sure to replace placeholder text (in all caps or between brackets) with your own content.

GENERAL GUIDELINES
------------------
1. All PRs must target the `main` branch (or a designated feature branch if instructed).
2. Use clear, descriptive titles and summaries. Mention related issue numbers whenever possible (e.g., “Fix typo in Part 1 introduction (closes #23)”).
3. Ensure your fork is up to date with the latest `main` before creating a PR.
4. Validate that your changes do not break the LaTeX build pipeline (e.g., `xelatex` or `pdflatex` on `book/Arliz.tex`).
5. If your PR includes substantial content changes—especially to the book text—provide context for reviewers (e.g., PDF snapshots, links to rendered previews, or sample LaTeX output).
6. Confirm you have added any new resources (images, custom LaTeX packages, bibliography files) under the appropriate subfolder (e.g., `book/frontmatter/`, `book/parts/`, `book/images/`, or `config/`) and referenced them correctly in `Arliz.tex` or its subfiles.
7. For any external dependencies (fonts, custom LaTeX packages, bibliography styles), document them in `README.md` or `CONTRIBUTING.md` as needed.

─────────────────────────────────────────────────────────── -->

## 1. PR TITLE
<!--
Provide a concise, descriptive title for your PR. Reference related issue numbers with “closes #ISSUE_NUMBER” or “relates to #ISSUE_NUMBER” where applicable.
-->
**Title:** [SHORT DESCRIPTION OF CHANGES] (e.g., “Add new example in Part 2 on Set Theory (closes #45)”)

───────────────────────────────────────────────────────────

## 2. RELATED ISSUE(S)
<!--
List any related GitHub issue numbers. If this PR does not correspond to an existing issue, omit or write “N/A.”
-->
- Related Issue: [#ISSUE_NUMBER] or N/A

───────────────────────────────────────────────────────────

## 3. SUMMARY OF CHANGES
<!--
Provide a high-level summary of what this PR does. Include:
- The problem or gap you are addressing.
- The key modifications (e.g., added a new figure, corrected a theorem statement, updated LaTeX styling).
- Any new files added or existing files removed.
-->
- **Problem Addressed:**  
  [BRIEFLY DESCRIBE THE NEED OR BUG FIXED]

- **Key Modifications:**  
  1. [e.g., Updated `book/parts/part02/part02.tex` to correct Definition 2.1 and revised accompanying explanation.]  
  2. [e.g., Added `book/images/set-theory-diagram.pdf` and inserted a new figure environment in `book/parts/part02/part02.tex`.]  
  3. [e.g., Modified `book/config/example.tex` to include the `example` package for commutative diagrams.]  
  4. [e.g., Removed outdated example code in `book/parts/part03/part03.tex` related to array indexing.]

- **Files Added or Removed:**  
  - Added:  
    - `diagrams/set-theory-diagram.pdf`  
    - `book/config/example.tex`  
  - Removed:  
    - `book/parts/example.tex`

───────────────────────────────────────────────────────────

## 4. DETAILED DESCRIPTION OF CHANGES
<!--
Break down your changes in detail. Address each of the following scenarios based on the type of content you modified:
1. Textual or LaTeX content changes in the main book files.
2. New or updated code snippets (e.g., LaTeX macros, custom commands).
3. Addition or modification of figures, tables, or other images.
4. Structural changes (e.g., moving files, renaming sections, reorganizing folders).
-->

### 4.1 Textual / LaTeX Content Changes
- **Location(s):**  
  - `book/parts/part01/part01.tex` (Section “The Primordial Urge to Count and Order”):  
    - Revised historical narrative between pages 12–14 to clarify the origin of zero.  
    - Corrected citation format for [Book XYZ].
  - `book/frontmatter/title.tex`:  
    - Updated the author affiliation line to include University information.  
  - `book/Arliz.tex`:  
    - Incremented `\version` macro from “0.3” to “0.4” to reflect this update.

- **Changes to Chapter/Section Headings:**  
  - Renamed “Mathematical Foundations” to “Mathematical Fundamentals” in Part 2.  
  - Added new subsection “2.3.1 Identity in Set Theory” under Part 2, Section 2.3.

- **New LaTeX Macros or Commands (if any):**  
  - Defined `\newcommand{\Z}{\mathbb{Z}}` in `config/macros.tex` for integer notation.  
  - Added `\newenvironment{exampleblock}` in `config/environments.tex` for highlighted examples.

### 4.2 Code Snippets or LaTeX Macros
- **Location:**  
  - `book/config/macros.tex`  
  - `book/parts/part02/part02.tex` (example usage of `\Z` macro).

- **Description:**  
  1. Added macro `\Z`:  
     ```latex
     % In config/macros.tex
     \newcommand{\Z}{\mathbb{Z}}
     ```
  2. Updated Part 2 to demonstrate usage:  
     ```latex
     % In book/parts/part2.tex (Section 2.3.1)
     \begin{exampleblock}
       In \(\mathbb{Z}\), the identity element for addition is \(0\). This will be central to our discussion of arrays...
     \end{exampleblock}
     ```
  3. Confirmed that `latexmk` compiles without errors after adding this environment.

### 4.3 Figures, Tables, or Images
- **New Figure(s):**  
  - **File:** `book/images/set-theory-diagram.pdf`  
  - **Insertion Point:** `book/parts/part02/part02.tex`, Section “2.3.1 Identity in Set Theory”  
  - **LaTeX Code for Inclusion:**  
    ```latex
    \begin{figure}[ht]
      \centering
      \includegraphics[width=0.7\textwidth]{images/set-theory-diagram.pdf}
      \caption{Venn diagram illustrating the set of integers \(\mathbb{Z}\) and its substructures.}
      \label{fig:set-theory-diagram}
    \end{figure}
    ```
  - **Checklist for Images:**  
    - [ ] The image file is placed under `book/images/` (not in a root or unrelated folder).  
    - [ ] The image resolution is at least 300 dpi for printing quality.  
    - [ ] The filename is lowercase, hyphen-separated, and descriptive (e.g., `set-theory-diagram.pdf`).  
    - [ ] `\includegraphics` path is correct relative to `book/parts/part02/part02.tex`.

- **Updated Table(s):**  
  - N/A for this PR. If adding a table:  
    - Use the `book/parts/` subfolder’s local path.  
    - Provide a caption and a `\label{}` for cross-referencing.  
    - Ensure column alignment and line breaks render properly in the compiled PDF.

### 4.4 Structural Changes
- **Moved/Renamed Files:**  
  - Renamed `book/parts/old-array-example.tex` → `book/parts/deprecated-array-example.tex` to prevent accidental inclusion.  
  - Moved `config/latex-packages.tex` to `config/` root to centralize package imports.

- **Folder Organization:**  
  - Created new folder `book/images/` to store all image assets.  
  - Updated `.gitignore` to exclude any temporary `.aux`, `.log`, or `.toc` files generated by LaTeX builds.

───────────────────────────────────────────────────────────

## 5. BUILD & TEST INSTRUCTIONS
<!--
Describe the steps to compile and verify your changes. Include any special instructions for testing images, code, or formatting.
-->

1. **Ensure Dependencies Are Installed**  
   - Confirm that TeX Live is installed with packages: `amsmath`, `amssymb`, `tikz`, `xcolor`, `graphicx`, `hyperref`, etc., as specified in `config/latex-packages.tex`.  

2. **Pull Latest Changes and Switch to PR Branch**  
   ```bash
   git fetch origin
   git checkout -b feature/YOUR_BRANCH_NAME
   git merge origin/main
   ```

3. **Compile the Book**

   ```bash
   cd book
   xelatex Arliz.tex
   bibtex Arliz       # Only if bibliography changes were made
   xelatex Arliz.tex
   xelatex Arliz.tex
   ```

   * Verify that no errors or warnings appear related to undefined references, missing files, or package conflicts.

4. **Verify PDF Output**

   * Open `book/Arliz.pdf`.
   * Confirm that new figures/tables render correctly and captions appear.
   * Check that section numbers and cross-references (e.g., `\ref{fig:set-theory-diagram}`) resolve as expected.

5. **Check LaTeX Linting (Optional)**

   * Run a LaTeX linter or style checker if available (e.g., `lacheck Arliz.tex`).
   * Address any style or formatting warnings.

6. **Run Repository-Wide Validation**

   * If there are automated CI checks (e.g., a GitHub Actions workflow for LaTeX builds), ensure they pass.
   * Confirm no extraneous build artifacts were committed (e.g., `.aux`, `.log`, `.toc`).

───────────────────────────────────────────────────────────

## 6. CHECKLIST

<!--
Before submitting your PR, confirm that you have completed the following items. Replace “[ ]” with “[x]” when done.
-->

* [ ] I have added a descriptive title and linked any related issue numbers.
* [ ] I have updated or created new LaTeX files and ensured they compile without errors.
* [ ] All new images are stored under `book/images/` and referenced correctly.
* [ ] I have provided captions and labels for all new figures and tables.
* [ ] I have updated `config/macros.tex` or `config/latex-packages.tex` if adding new macros or packages.
* [ ] I have run `xelatex Arliz.tex` (twice) and verified that cross-references, citations, and PDF rendering are correct.
* [ ] I have checked that no temporary build files (e.g., `.aux`, `.log`) are committed.
* [ ] I have updated any relevant documentation (e.g., `README.md`, `CONTRIBUTING.md`) if necessary.

───────────────────────────────────────────────────────────

## 7. ADDITIONAL NOTES

<!--
Include any final comments, caveats, or context that reviewers should know. For example:
- If you changed the bibliography style or added new citations, mention how to regenerate `.bbl` files.
- If this PR introduces backward-incompatible changes (e.g., renaming macros), document migration steps.
- If your changes require additional reviewer attention (e.g., confirm historical accuracy or verify LaTeX style consistency), specify here.
-->

* This PR introduces the `\Z` macro for integer notation; ensure that no other macros conflict with this naming.
* The new figure uses PDF format; if the repository is compiled with `latexmk`, confirm it picks up `.pdf` graphics without issues.
* No external fonts were added in this PR; future PRs that introduce fonts should document their installation or bundling in `README.md`.

