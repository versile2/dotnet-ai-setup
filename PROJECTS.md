# Project boundaries

## Files and paths
- {{SOLUTION_NAME}} is the primary solution and path
- {{UI_PROJECT_PATH}} is for UI components, pages, assets, and Blazor interaction logbic
- {{DATA_PROJECT_PATH}} is for repositories, persistence, services, and data-access logic
- {{TEST_PROJECT_PATH}} is for bUnit and xUnit tests
- {{PROTECTED_PROJECT_PATHS}} is for protected projects. Do not edit unless explicitly instructed.

## Targeted Verification
- Use targeted verification against <project.csproj> unless broader validation is explicitly requested.
- Prefer focused test execution before running the full test project.

```text
dotnet clean <project.csproj>
dotnet build <project.csproj> --nologo
dotnet test <project.csproj> --no-build --nologo --blame-hang --blame-hang-timeout 30s
dotnet test <project.csproj> --filter "FullyQualifiedName~<test name>" --no-build --nologo --blame-hang --blame-hang-timeout 30s
dotnet format <project.csproj> --include <changed files>
```

## Targeted commands

```text
dotnet build <project.csproj> --nologo
dotnet test <project.csproj> --no-build --nologo --blame-hang --blame-hang-timeout 30s
```
