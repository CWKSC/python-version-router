# PythonRouter

```
This script change different python version by modify PATH environment variable
Add folder of the script to PATH environment variable first
And modify usepython-config.json to set root folder path for python folders
it should be "C:\\" or "C:\\Program Files\\", by default it is "C:\\"

Usage: usepython `$version_tag [-keep] [-root `$path]

version_tag: 311, 310, 39, 38, 37, 36
keep: Set persistent modification, require admin permission
root: Specify root folder path for python folders instead of usepython-config.json

Example: 
usepython 38 
usepython 39 -keep
usepython 310 -root "C:\\"
usepython 311 -keep -root "C:\\Program Files\\"
```
