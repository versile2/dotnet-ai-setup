# dotnet-ai-setup

This repo contains a small setup bundle for another .NET repo. The batch file copies the selected setup files into a target directory, preserves their relative paths, and renames any existing destination file to `.oldYYYYMMDDHHMMSS` before the new copy is written.

## Files copied

- `AGENTS.md`
- `AI_REVIEW.md`
- `PROJECTS.md`
- `.gitattributes`
- `.gitignore`
- `.github\copilot-instructions.md`
- `.github\instructions\tests.instructions.md`
- `.github\pull_request_template.md`
- `src\.editorconfig`
- `src\Directory.Build.props`

## Usage

1. Download or clone this repo.
2. Open Command Prompt and change to the root of the repo you want to update.
3. Run the batch file with `.` as the target directory. e.g. 

```bat
C:\path\to\dotnet-ai-setup\copy-open-ide-items.bat .
```

4. Edit `PROJECTS.md` and replace the placeholders with your real project paths and targets.
5. If your repo does not use `src` as its root, move `src\.editorconfig` and `src\Directory.Build.props` to the matching location in your repo.
