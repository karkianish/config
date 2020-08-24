#set psgallery as trusted repo so it doesn't prompt confirmation during module installation 
Write-Output "adding nuget..."
Install-PackageProvider -name nuget -minimumversion 2.8.5.201 -force
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
Write-Output "adding symlink for powershell profile..."
symlink $env:userprofile\repos\config\profile.ps1 $profile
# windows terminal settings
Write-Output "creating windows terminal directory at appdata\local\microsoft\..."
New-Item -Type Directory -Path "$env:userprofile\AppData\Local\Microsoft\Windows Terminal" -Force -ErrorAction SilentlyContinue
Write-Output "adding symlink for windows terminal settings..."
symlink $env:userprofile\repos\config\terminal_settings.json "$env:userprofile\AppData\Local\Microsoft\Windows Terminal\settings.json"
# vimrc
Write-Output "adding symlink for .vimrc..."
symlink $env:userprofile\repos\config\vimrc $env:userprofile\.vimrc
# .ideavimrc - for datagrip
Write-Output "adding symlink for .ideavimrc..."
symlink $env:userprofile\repos\config\vimrc $env:userprofile\.ideavimrc
# move the modified theme to the theme folder
Write-Output "adding symlink for powershell theme paradoxmodified..."
symlink $env:userprofile\repos\config\ParadoxModified.psm1 $env:userprofile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.465\Themes\ParadoxModified.psm1
# move the modified theme to the theme folder
# symlink $env:userprofile\repos\config\conemu.xml $env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\conemu.xml
Write-Output "installing powerline fonts..."
InstallFonts