
foreach ($item in Get-ChildItem -Path $PSScriptRoot\*.ps1 -Recurse -Exclude '*tests*') {

    # InvokeScript(useLocalScope, scriptBlock, input, args)
    $ExecutionContext.InvokeCommand.InvokeScript(
        $false,
        (
            [scriptblock]::Create(
                [io.file]::ReadAllText(
                    $item.FullName
                )
            )
        ),
        $null,
        $null
    )
}