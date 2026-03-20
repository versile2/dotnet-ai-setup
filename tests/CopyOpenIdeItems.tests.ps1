$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$batchPath = Join-Path $repoRoot 'copy-open-ide-items.bat'
$readmePath = Join-Path $repoRoot 'README.md'

if (-not (Test-Path $batchPath)) {
    throw "Missing batch file: $batchPath"
}

if (-not (Test-Path $readmePath)) {
    throw "Missing README: $readmePath"
}

$workspaceRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("copy-open-ide-items-tests-" + [System.Guid]::NewGuid().ToString('N'))
$targetRoot = Join-Path $workspaceRoot 'target'

try {
    New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null

    $existingProjectFile = Join-Path $targetRoot 'PROJECTS.md'
    Set-Content -Path $existingProjectFile -Value 'original projects content'

    $command = "cmd /c `"$batchPath`" `"$targetRoot`""
    Invoke-Expression $command | Out-Null

    if ($LASTEXITCODE -ne 0) {
        throw "Batch file failed with exit code $LASTEXITCODE"
    }

    $expectedFiles = @(
        '.gitattributes',
        '.gitignore',
        'AGENTS.md',
        'AI_REVIEW.md',
        'PROJECTS.md',
        '.github\copilot-instructions.md',
        '.github\instructions\tests.instructions.md',
        '.github\pull_request_template.md',
        'src\.editorconfig',
        'src\Directory.Build.props'
    )

    foreach ($relativePath in $expectedFiles) {
        $copiedPath = Join-Path $targetRoot $relativePath
        if (-not (Test-Path $copiedPath)) {
            throw "Expected copied file missing: $relativePath"
        }
    }

    $removedWorkflowPath = Join-Path $targetRoot '.github\workflows\build.yml'
    if (Test-Path $removedWorkflowPath) {
        throw 'Unexpected copied file present: .github\workflows\build.yml'
    }

    $backupFiles = Get-ChildItem -Path $targetRoot -Filter 'PROJECTS.md.old*' -File
    if ($backupFiles.Count -ne 1) {
        throw "Expected one PROJECTS.md backup file, found $($backupFiles.Count)"
    }

    if ($backupFiles[0].Name -notmatch '^PROJECTS\.md\.old\d{14}$') {
        throw "Unexpected backup file name: $($backupFiles[0].Name)"
    }

    $copiedProjectsContent = Get-Content -Path (Join-Path $targetRoot 'PROJECTS.md') -Raw
    $sourceProjectsContent = Get-Content -Path (Join-Path $repoRoot 'PROJECTS.md') -Raw

    if ($copiedProjectsContent -ne $sourceProjectsContent) {
        throw 'Copied PROJECTS.md content does not match the source file.'
    }
}
finally {
    if (Test-Path $workspaceRoot) {
        Remove-Item -Path $workspaceRoot -Recurse -Force
    }
}
