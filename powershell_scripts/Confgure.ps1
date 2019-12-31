# enable installing modules in powershell
Set-ExecutionPolicy Unrestricted -Scope Process

# load helper functions. why two '.' is needed? to make functions from specified files avaialble in current scope
# https://stackoverflow.com/questions/1405750/calling-a-specific-powershell-function-from-the-command-line
. .\utils\MyUtils.ps1
. .\utils\WinSetup_Disable.ps1
. .\utils\MouseSpeed.ps1

Set-MouseSpeed 18
SetUACLow
DisableSmartScreen
DisableWebSearch
DisableAppSuggestions
DisableActivityHistory
DisableSensors
DisableLocation
DisableMapUpdates
DisableFeedback
DisableTailoredExperiences
DisableAdvertisingID
DisableDefenderCloud
DisableAutorun
DisableActionCenter
DisableFileDeleteConfirm
HideTaskbarSearch
ShowSmallTaskbarIcons
HideTaskbarPeopleIcon
DisableSearchAppInStore
HideRecentlyAddedApps
SetControlPanelSmallIcons
EnableDarkTheme
DisableDarkTheme
DisableStartupSound
HideMusicFromExplorer
DisableOneDrive
UninstallMsftBloat
UninstallThirdPartyBloat
UninstallWindowsStore
DisableXboxFeatures
DisableEdgeShortcutCreation
DisableIEFirstRun
UninstallInternetExplorer
UninstallWorkFolders
UninstallPowerShellV2
UninstallPDFPrinter
RemoveFaxPrinter
UninstallFaxAndScan
HideTaskView
HidePicturesFromExplorer
HidePicturesFromThisPC
HideVideosFromThisPC
HideVideosFromExplorer

# remove the folders that I never use
Remove-Item $env:userprofile\Contacts -recurse -force
Remove-Item "$env:userprofile\3d objects" -recurse -force
Remove-Item $env:userprofile\Favorites -recurse -force
Remove-Item $env:userprofile\Links -recurse -force
Remove-Item $env:userprofile\Music -recurse -force
Remove-Item $env:userprofile\OneDrive -recurse -force
Remove-Item "$env:userprofile\Saved Games" -recurse -force
Remove-Item $env:userprofile\Searches -recurse -force
Remove-Item $env:userprofile\Videos -recurse -force
Remove-Item $env:userprofile\MicrosoftEdgeBackups -recurse -force

# install scoop. if scoop is already installed, this script will give error, which is okay.
iwr -useb get.scoop.sh | iex
# add the 'extras' bucket for scoop
scoop bucket add extras

# install apps from scoop
scoop install touch
scoop install cmder
scoop install vim
scoop install git
scoop install everything
scoop install vscode
scoop install git
# download everything cli
_Download -url "https://www.voidtools.com/ES-1.1.0.15.zip" -fileNameWithExt "es-cli.zip"
# unzip file to c:\es-cli. thats the folder `find` function will look to execute es-cli.exe
Expand-Archive "$env:userprofile\Downloads\es-cli.zip" "$env:userprofile\es-cli"

# install settings sync for vscode

# create symlink
ln .\powershell\Profile.ps1 $profile
ln .\vimrc ..\.vimrc
ln .\conemu.xml $conemuSettings

# - git
# 	- repos and setting files
# - remove all ms junk
# - remove all 3rd parties junk
# - ui tweaks for icon size, task bar etc
# - windows without tying it to email address?
# - disable cortana and bunch of ui settings
# - to install
# 	- vim
# 		- apply vimrc
# 		- theme vim
# 	- make powershell pretty and useful modules
# 	- everything & everything for console (how to use this)
# 	- vscode 
# 		- all related extenstions
# 		- settings sync
# 	- dotnetcore
# 	- postgres/sql server
# 	- visual studio 2019
# 		- all extensions
# 		- settings with my keymap
# 		- proper configuration
# 	- notepad++
# 	- java
# 	- postman?
# 	- one note
# 	- chrome
# 	- slack, outlook
# 	- autohotkey
