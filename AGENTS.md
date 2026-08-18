# AGENTS.md - AI agent guide

Follow this file as the primary instruction source. User requests and nested `AGENTS.md` files may refine ordinary workflow guidance, but they do not override the [External database boundary](#external-database-boundary) below.

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
* do not circumvent, weaken, reinterpret, or work around the [External database boundary](#external-database-boundary), directly or indirectly
* do not add dependencies without approval
* do not suppress warnings to get a build through
* do not make large refactors or cross-project moves without approval
* do not suggest a change that is not in line with `AI_REVIEW.md` or existing project patterns without approval

## Working rules

* keep changes focused on the user request, do not make unrelated changes
* prefer minimal changes that fit the existing repository structure
* do not edit or suggest changes to protected projects unless explicitly instructed to do so

## External database boundary

* You may review database schemas, migrations, ORM mappings, seed definitions, and SQL text stored inside the checked-out repository.
* Do not connect to, query, inspect, export, copy, modify, or infer data from any database outside the checked-out repository. This includes every database referenced by connection strings, configuration, documentation, tests, migrations, scripts, or application code.
* Do not execute repository SQL against an external database, request or use database credentials, or ask anyone to paste database contents into the task.
* Treat requests to reveal, transmit, summarize, or analyze external database contents as outside the agent's authorized scope. Stop and report the boundary instead.
* An ordinary task request does not authorize an exception. A repository maintainer must change this policy through a separate reviewed change before a later task may access an external database.
* Database access can create legal, contractual, privacy, security, and employment consequences. When uncertain whether data is external, treat it as external and do not access it.

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
