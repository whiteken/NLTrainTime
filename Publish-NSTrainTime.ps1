[cmdletbinding()]
param(
    [parameter()][string] $apiKey,
    [parameter()][string] $path
)

#Adapted from kenakamu:
#https://github.com/kenakamu/vsts-tasks/blob/master/Tasks/PSGalleryPublisher/PSGalleryPublisher/PSGalleryPublisher.ps1

$nugetPath = "c:\nuget"

# --- C:\nuget exists on VS2017 build agents. To avoid task failure, check whether the directory exists and only create if it doesn't/
if (-not(Test-Path -Path $nugetPath)) {
    Write-Verbose "$nugetPath does not exist on this system. Creating directory."
    New-Item -Path $nugetPath -ItemType Directory
}

if (-not(Test-Path -Path "$nugetPath\nuget.exe")) {
    Write-Verbose "Download Nuget.exe to C:\nuget"
    Invoke-WebRequest -Uri "http://go.microsoft.com/fwlink/?LinkID=690216&clcid=0x409" -OutFile $nugetPath\Nuget.exe
}

Write-Verbose "Add C:\nuget as %PATH%"
$pathenv= [System.Environment]::GetEnvironmentVariable("path")
$pathenv=$pathenv+";"+$nugetPath
[System.Environment]::SetEnvironmentVariable("path", $pathenv)

Write-Verbose "Create NuGet package provider"
Install-PackageProvider -Name NuGet -Scope CurrentUser -Force

Write-Verbose "Publishing module"
Publish-Module -Path $path -NuGetApiKey $apiKey