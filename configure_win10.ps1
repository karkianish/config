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

# remove the folders that I never use
Remove-Item $env:userprofile\Contacts -recurse -force -erroraction silentlycontinue
Remove-Item "$env:userprofile\3d objects" -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\Favorites -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\Links -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\Music -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\OneDrive -recurse -force -erroraction silentlycontinue
Remove-Item "$env:userprofile\Saved Games" -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\Searches -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\Videos -recurse -force -erroraction silentlycontinue
Remove-Item $env:userprofile\MicrosoftEdgeBackups -recurse -force -erroraction silentlycontinue
