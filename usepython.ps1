param(
    [string]$target_version_tag,
    [switch]$keep,
    [string]$root
)

function PrintUsage {
    Write-Output @"

This script change different python version by modify PATH environment variable
It will remove all PythonXX\ and PythonXX\Scripts\ in PATH,
and add corresponding target version tag folder to PATH
Only temporarily works on the current process if without -keep flag

Add folder of this script to PATH first
Modify usepython-config.json to set root folder path for python folders If necessary
It should be "C:\\" or "C:\\Program Files\\", by default it is "C:\\"

Usage: usepython `$version_tag [-keep] [-root `$path]

version_tag: 311, 310, 39, 38, 37, 36
keep: Set persistent modification, require admin permission
root: Specify root folder path for python folders instead of usepython-config.json

Example: 
usepython 38 
usepython 39 -keep
usepython 310 -root "C:\\"
usepython 311 -keep -root "C:\\Program Files\\"

"@
}

$config_file_path = ".\usepython-config.json"
$config = Get-Content -Path $config_file_path -Raw | ConvertFrom-Json
$root = $config.root
$version_tag_list = $config.version_tag_list

if ([string]::IsNullOrEmpty($target_version_tag)) {
    PrintUsage
    exit 1
}
Write-Output "Target version tag: $target_version_tag"

if ($keep) {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (!$isAdmin) {
        Write-Host "PowerShell not running as admin, -keep flag require admin permission"
        exit 1
    }
    Write-Output "keep flag is open, it is persistent modification"
}

if ($keep) {
    $path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine').Split(';')
}
else {
    $path = [System.Environment]::GetEnvironmentVariable('PATH').Split(';')
}

foreach ($version in $version_tag_list) {
    $path = $path | Where-Object { $_ -ne $root + "Python" + $version + "\" }
    $path = $path | Where-Object { $_ -ne $root + "Python" + $version + "\Scripts\" }
}
$path += $root + "Python" + $target_version_tag + "\" 
$path += $root + "Python" + $target_version_tag + "\Scripts\" 

$path = $path -join ';'

if ($keep) {
    [System.Environment]::SetEnvironmentVariable('PATH', $path, 'Machine')
}
else {
    [System.Environment]::SetEnvironmentVariable('PATH', $path)
}
Write-Output "Changed PATH environment variable"
