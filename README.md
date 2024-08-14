# PythonVersionRouter

> [!CAUTION]
>
> I just to learn some powershell script
> 
> This is no longer maintained and used


This script change different python version by modify PATH environment variable
It will remove all PythonXX\ and PythonXX\Scripts\ in PATH,
and add corresponding target version tag folder to PATH
Only temporarily works on the current process if without -keep flag

Add folder of this script to PATH first
Modify usepython-config.json to set root folder path for python folders If necessary
It should be `C:\\` or `C:\\Program Files\\`, by default it is `C:\\`

Usage: usepython `$version_tag` [-keep] [-root $path]

version_tag: 311, 310, 39, 38, 37, 36
keep: Set persistent modification, require admin permission
root: Specify root folder path for python folders instead of usepython-config.json

Example: 
usepython 38 
usepython 39 -keep
usepython 310 -root "C:\\"
usepython 311 -keep -root "C:\\Program Files\\"

