# CONTRIBUTING TO ARLIZ

This project is not a product. It’s a long-term, evolving system of thought — about arrays, computation, representation, and the philosophical roots of structured logic. If you’re here, thank you for taking it seriously. Contributions are welcome, but only with full understanding of the system’s direction, precision, and writing discipline.

---

## Core File

The main file is:
- `book/Arliz.tex`

This is the entry point for the LaTeX build and contains all parts, structure, macros, and references to chapters. It is edited and compiled using **TeXstudio**. If you intend to change the book itself (content, structure, macros, parts, chapters), you must:
1. Understand the LaTeX environment well.
2. Test your changes thoroughly before any pull request.
3. Avoid unnecessary edits — whitespace changes, formatting deviations, or personal macro preferences will not be accepted.
4. Avoid adding dependencies or packages unless absolutely necessary.

Do not attempt to "refactor" the LaTeX. Stability matters more than elegance.

---

## Resources Directory

All research, sources, and extended materials live under:

- `resources/`

Each part has its own directory:

- `part-1`, `part-2`, ..., `part-n`

Inside each part, chapters are named:

- `chapter-1.md`
- `chapter-2.md`
- etc.

Each Markdown file holds the curated references, readings, notes, and links relevant to that specific chapter.

### When editing/adding/changing these:

- Do **not** add sources you haven’t read or understood.
- Do **not** dump links. Every entry must have a reason.
- Follow the format in `TEMPLATE.md` strictly.
- You may write personal notes and commentary under the `Notes` section.
- If you're unsure about a source’s validity or placement, comment it out with a `<!-- -->` and explain.
- Never remove or replace an existing source without explaining why in your commit message or pull request.
- All content must be in **English**.

Do not treat these files like blogs or link collections. Treat them like academic field notes: precise, minimal, justified.

---

## Philosophical Direction

This is not a textbook. It is not a tutorial. It is not for trends or algorithms or syntax. It is a narrative about thought and structure. If you contribute, understand that every part, chapter, and sentence is tied to an intellectual arc. The text avoids simplification. It does not serve beginners, but instead those willing to go back to first principles.

If you want to contribute, take time. Read the content. Think like a builder. Do not rush edits. Treat the material with the respect you would give to an architecture plan — not a social post, not a blog, not code.

---

## Adding/Editing Chapters

If you wish to propose or edit a chapter:
- You must open an issue first with a detailed explanation.
- No pull requests for new chapters will be merged unless there's clear intent, structure, and justification.

All chapters must:
- Fit the surrounding philosophical and technical context.
- Be written in a clear, layered, minimal style.
- Avoid fluff, digressions, or over-explaining.
- Include a dedicated resource file in `resources/part-X/chapter-Y.md`.

---

## Deletions

Do not delete anything without understanding its historical or conceptual reason for being. If you think something must go, open a discussion first.

If something is deprecated or no longer valid:
- Mark it as deprecated in the comments (in LaTeX or Markdown).
- Explain why it’s no longer necessary.
- Never hard-delete without trace or justification.

---

## Final Notes

This is not a collaborative writing playground. It is an evolving document rooted in long-form thinking. Precision matters. Style matters. Thoughtfulness matters.

If you’re ready for that, welcome.

Otherwise, feel free to read and observe.
