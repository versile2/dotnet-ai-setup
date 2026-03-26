# AGENTS.md - AI agent guide

Follow this file as the primary instruction source unless the user says otherwise. If a nested `AGENTS.md` exists, it overrides this file for that subtree.

## Instruction order

1. Follow `AGENTS.md` first.
2. Use `PROJECTS.md` for repository structure, naming paths, and targeted verification/commands.
3. Use `AI_REVIEW.md` for review requirements.
4. Use `.github/instructions/tests.instructions.md` for test-specific instructions.

## Do / Don't (Read First)

### Do

* default to TDD when behavior changes
* target specific projects only; solution-wide local commands are too slow
* keep changes small and targeted
* prefer existing patterns over introducing new abstractions
* follow `src/.editorconfig` and add required file headers
* treat all application, user, staff, and internal data as sensitive
* add XML `<summary>` docs for all public properties, classes, and methods
* preserve keyboard navigation and accessible naming for interactive UI
* ensure all output meets ARIA accessibility standards

### Don't

* do not run solution-wide build, test, or format commands unless explicitly requested
* do not commit secrets, tokens, passwords, certificates, private URLs, or real connection strings
* do not put secrets in tracked `appsettings*.json`, tests, docs, or examples
* do not add dependencies without approval
* do not suppress warnings to get a build through
* do not make large refactors or cross-project moves without approval
* do not suggest a change that is not in line with `AI_REVIEW.md` or existing project patterns without approval

## Working rules

* keep changes focused on the user request, do not make unrelated changes
* prefer minimal changes that fit the existing repository structure
* do not edit or suggest changes to protected projects unless explicitly instructed to do so

## Completion rules

* Code must satisfy the review requirements in `AI_REVIEW.md` in addition to `AGENTS.md` before submission
* Address review feedback and repeat until review notes are resolved unless the user explicitly directs otherwise

## Blazor and UI rules

* Component parameters must be auto-properties only.
* Do not set component parameters via `@ref`.
* Use `ParameterState<T>` for parameter update flows where applicable.
* Use `CssBuilder` and CSS variables. Do not hard-code styles or colors without user approval.

## Review and Escalation

* If you are unsure about any aspect of the request, ask for clarification.
* If a policy needs hard enforcement and an existing analyzer does not cover it, call that out. A custom analyzer may be required.
* Pause between major stages of multi-step work unless the user asks for end-to-end execution.
