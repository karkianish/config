# enable installing modules in powershell
Set-ExecutionPolicy Unrestricted -Scope Process

# load helper functions. why two '.' is needed? to make functions from specified files avaialble in current scope
# https://stackoverflow.com/questions/1405750/calling-a-specific-powershell-function-from-the-command-line
. $env:userprofile\repos\config\mouse_speed.ps1
Set-MouseSpeed 18

. $env:userprofile\repos\config\win10_features.ps1
SetUACLow

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
#DisableDarkTheme
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

#RemoveFaxPrinter

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

# add the 'extras' bucket for scoop
scoop bucket add extras jetbrains

# install apps from scoop
scoop install authy
scoop install autohotkey
scoop install everything
scoop install fzf
scoop install git-with-openssh
scoop install googlechrome
scoop install nvm
scoop install openjdk
scoop install postgresql
scoop install python
scoop install slack
scoop install touch
scoop install vifm
scoop install vim
scoop install vscode
scoop install windows-terminal
scoop install yarn

# install github cli. must run after installing git.
scoop bucket add github-gh https://github.com/cli/scoop-gh.git
scoop install gh 

# install latest node via nvm rather than scoop
nvm install latest

# instal settings-sync 
code --install-extension shan.code-settings-sync

#set psgallery as trusted repo so it doesn't prompt confirmation during module installation 
Write-Output "setting psgallery as trusted PSRepository..."
Set-PSRepository psgallery -InstallationPolicy Trusted
Write-Output "updating execution policy..."
Set-ExecutionPolicy RemoteSigned -Scope Process
Write-Output "installing posh-git..."
install-module posh-git -scope currentuser
Write-Output "installing oh-my-posh..."
install-module oh-my-posh -scope currentuser
Write-Output "installing zlocation..."
install-module zlocation -scope currentuser
Write-Output "installing PSfzf..."
install-module PSfzf -scope currentuser
Write-Output "installing PSEverything..."
install-module PSEverything -scope currentuser

. $env:userprofile\repos\config\utility_functions.ps1
# create symlink. symlink is cmdlet in utility_functions
# powershell profile
symlink $env:userprofile\repos\config\profile.ps1 $profile
# windows terminal settings
symlink $env:userprofile\repos\config\terminal_settings.json "$env:userprofile\AppData\Local\Microsoft\Windows Terminal\settings.json"
# vimrc
symlink $env:userprofile\repos\config\vimrc $env:userprofile\.vimrc
# .ideavimrc - for datagrip
symlink $env:userprofile\repos\config\vimrc $env:userprofile\.ideavimrc
# move the modified theme to the theme folder
symlink $env:userprofile\repos\config\ParadoxModified.psm1 $env:userprofile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.465\Themes\ParadoxModified.psm1
# move the modified theme to the theme folder
# symlink $env:userprofile\repos\config\conemu.xml $env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\conemu.xml
