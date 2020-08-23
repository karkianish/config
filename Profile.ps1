echo "Loading profile..."

#set psgallery as trusted repo so it doesn't prompt confirmation during module installation 
# todo - add a check to see if the packages are already installed
echo "setting psgallery as trusted PSRepository..."
Set-PSRepository psgallery -InstallationPolicy Trusted
echo "updating execution policy..."
Set-ExecutionPolicy RemoteSigned -Scope Process
echo "installing posh-git..."
install-module posh-git -scope currentuser
echo "installing oh-my-posh..."
install-module oh-my-posh -scope currentuser
echo "installing zlocation..."
install-module zlocation -scope currentuser
echo "installing PSfzf..."
install-module PSfzf -scope currentuser
echo "installing PSEverything..."
install-module PSEverything -scope currentuser

Set-PSReadLineOption -EditMode Vi -BellStyle None -ViModeIndicator Cursor
# map jk to esc when in vim mode
# source: https://github.com/PowerShell/PSReadLine/issues/759#issuecomment-518363364
Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
    if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
      $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
      if ($key.Character -eq 'k') {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
      }
      else {
        [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
        [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
      }
    }
  }

. (join-path $env:userprofile 'config\powershell\UtilityFunctions.ps1')

import-module posh-git
import-module oh-my-posh
import-module zlocation

Set-Theme ThemeCarkey

# add timestamp to prompt. since I have modified the paradox theme, I dont need lines below. But keep it!
# $GitPromptSettings.DefaultPromptPrefix = "$(get-date -Format HH:mm:ss.fff) "
# set prompt color
# $GitPromptSettings.DefaultForegroundColor = 'blue'

$conemuSettings = "$env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\ConEmu.xml";
$vimrc = "$env:userprofile\.vimrc";
$themes = "$env:userprofile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.342\Themes";
$myutils = "$env:userprofile\config\powershell\myutils.ps1";
$myprofile = "$env:userprofile\config\powershell\profile.ps1";

# remove the default ls alias so that my custom one is used. my ls is in UtilityFunctions.ps1. it shows hidden files and sorts by name.
Remove-Item alias:ls -ErrorAction SilentlyContinue

cd $env:userprofile
