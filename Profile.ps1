Write-Output "Loading profile..."

. $env:userprofile\repos\config\utility_functions

# map jk to esc when in vim mode
# source: https://github.com/PowerShell/PSReadLine/issues/759#issuecomment-518363364

import-module oh-my-posh
Set-Theme ParadoxModified

Set-PSReadLineOption -EditMode Vi -BellStyle None -ViModeIndicator Cursor

Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
    if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
      $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
      if ($key.Character -eq 'j') {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
      }
      else {
        [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
        [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
      }
    }
  }
  
import-module posh-git
import-module PSfzf
import-module PSEverything
# zlocation must be loaded AFTER promp customization
import-module zlocation

# Keep this block for future reference. Add timestamp to prompt. since I have modified the paradox theme, I dont need lines below. 
# $GitPromptSettings.DefaultPromptPrefix = "$(get-date -Format HH:mm:ss.fff) "
# set prompt color
# $GitPromptSettings.DefaultForegroundColor = 'blue'

# $conemuSettings = "$env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\ConEmu.xml";
# $vimrc = "$env:userprofile\.vimrc";
# $themes = "$env:userprofile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.342\Themes";
# $myutils = "$env:userprofile\config\powershell\myutils.ps1";
# $myprofile = "$env:userprofile\config\powershell\profile.ps1";

# remove the default ls alias so that my custom one is used. my ls is in UtilityFunctions.ps1. it shows hidden files and sorts by name.
Remove-Item alias:ls -ErrorAction SilentlyContinue
