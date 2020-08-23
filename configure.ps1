# enable installing modules in powershell
Set-ExecutionPolicy Unrestricted -Scope Process

# load helper functions. why two '.' is needed? to make functions from specified files avaialble in current scope
# https://stackoverflow.com/questions/1405750/calling-a-specific-powershell-function-from-the-command-line
. .\utility_functions.ps1
. .\win10_features.ps1
. .\mouse_speed.ps1

SetUACLow

Set-MouseSpeed 18

UninstallMsftBloat
UninstallThirdPartyBloat
UninstallWindowsStore
UninstallOneDrive
UninstallInternetExplorer
UninstallWorkFolders
UninstallPowerShellV2
UninstallPDFPrinter
UninstallFaxAndScan
UninstallMediaPlayer
UninstallPowerShellISE
UninstallHelloFace
UninstallNET23
UninstallXPSPrinter

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
DisableSearchAppInStore
DisableDarkTheme
DisableStartupSound
DisableOneDrive
DisableXboxFeatures
DisableEdgeShortcutCreation
DisableIEFirstRun

Hide3DObjectsFromThisPC
Hide3DObjectsFromExplorer
HideMusicFromThisPC
HideMusicFromExplorer
HidePicturesFromExplorer
HidePicturesFromThisPC
HideVideosFromThisPC
HideVideosFromExplorer
HideNetworkFromExplorer
HideTaskbarSearch
HideTaskView
HideRecentlyAddedApps
HideTaskbarPeopleIcon

ShowSmallTaskbarIcons
SetControlPanelSmallIcons

RemoveFaxPrinter

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
scoop bucket add extras jetbrains

# install apps from scoop
scoop install authy
scoop install everything
scoop install ffz
scoop install git-with-openssh
scoop install googlechrome
scoop install nvm
scoop install postgres
scoop install touch
scoop install vifm
scoop install vim
scoop install vscode
scoop install windows-terminal

# install github cli. must run after installing git.
scoop bucket add github-gh https://github.com/cli/scoop-gh.git
scoop install gh 

# install latest node via nvm rather than scoop
nvm install latest

# create symlink. symlink is cmdlet in utility_functions
# windows terminal settings
symlink $env:userprofile\config\terminal_settings.json "$env:userprofile\AppData\Local\Microsoft\Windows Terminal\settings.json"
# vimrc
symlink $env:userprofile\config\vimrc $env:userprofile\.vimrc
# powershell profile
symlink $env:userprofile\config\profile.ps1 $profile

# Inside powershell profile, copy custom them to $env:userprofile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.465\Themes

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
# 	- vscode 
# 		- all related extenstions
# 		- settings sync
        # - setup for python
        # - setup for java
# 	- dotnetcore, net461 and above
# 	- postgres/sql server
# 	- visual studio community 2019
# 		- all extensions
# 		- settings with my keymap
# 		- proper configuration
# 	- notepad++
# 	- java & jre
# 	- postman?
# 	- one note (?)
# 	- chrome
#   - windows terminal
# 	- slack, outlook
# 	- autohotkey
#   - ovpn
#   datagrip, resharper

