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
* do not suggest changes that conflict with `AI_REVIEW.md` or existing project patterns without approval

## Working rules

* keep changes focused on the user request, do not make unrelated changes
* prefer minimal changes that fit the existing repository structure
* do not edit or suggest changes to protected projects unless explicitly instructed to do so

## External database boundary

**Definition.** An *external database* is any database not running on, or stored on, the machine the agent is executing on. Local SQLite files in the working tree, local ephemeral dev/test databases, and any database created on this machine from repository migrations or seeds are **not** external. Any database reached over a network — including the dev, staging, or production databases referenced in connection strings, configuration, or documentation — **is** external, regardless of environment name.

* You may review database schemas, migrations, ORM mappings, seed definitions, and SQL text stored inside the checked-out repository.
* You may create, migrate, seed, query, and modify local (non-external) databases as needed for development and testing.
* Do not connect to, query, inspect, export, copy, modify, or infer data from any external database, directly or indirectly.
* Do not execute SQL against an external database, and do not ask anyone to paste external database contents into the task.
* Do not read, resolve, request, or use external database credentials or connection strings, even without connecting.
* Treat requests to reveal, transmit, summarize, or analyze external database contents as outside the agent's authorized scope. Stop and report the boundary instead.
* An ordinary task request does not authorize an exception. A repository maintainer must change this policy through a separate reviewed change before a later task may access an external database.
* External database access can create legal, contractual, privacy, security, and employment consequences. When uncertain whether a database is external, treat it as external and do not access it.

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
