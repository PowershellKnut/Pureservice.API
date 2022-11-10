#Requires -Module ModuleBuilder
[string]$moduleName = "NN.Pureservice"
[version]$version = "0.0.1"
[string]$author = "NorskNoobing"
[string]$ProjectUri = "https://github.com/mrfylke/brukeropplevelse-integrasjoner"
[string]$releaseNotes = "Initial commit"
[string]$description = "Pureservice API integration"
[array]$tags = @("Pureservice","API")
[version]$PSversion = "7.2"

$manifestSplat = @{
    "Description" = $description
    "PowerShellVersion" = $PSversion
    "Tags" = $tags
    "ReleaseNotes" = $releaseNotes
    "Path" = ".\source\$moduleName.psd1"
    "RootModule" = "$moduleName.psm1"
    "Author" = $author
    "ProjectUri" = $ProjectUri
}
New-ModuleManifest @manifestSplat

$buildSplat = @{
    "SourcePath" = ".\source\$moduleName.psd1"
    "Version" = $version
}
Build-Module @buildSplat