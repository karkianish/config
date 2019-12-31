echo "Loading profile..."

# set psgallery as trusted repo so it doesn't prompt confirmation during module installation
# Set-PSRepository psgallery -InstallationPolicy Trusted
#Set-ExecutionPolicy RemoteSigned -Scope Process

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

. (join-path $env:userprofile 'config\powershell\MyUtils.ps1')

InstallAndImport posh-git
InstallAndImport zlocation
InstallAndImport oh-my-posh

Set-Theme Carkey

# add timestamp to prompt. since I have modified the paradox theme, I dont need lines below. But keep it!
# $GitPromptSettings.DefaultPromptPrefix = "$(get-date -Format HH:mm:ss.fff) "
# set prompt color
# $GitPromptSettings.DefaultForegroundColor = 'blue'

$conemuSettings = "$env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\ConEmu.xml";
$vimrc = "$env:userprofile\.vimrc";

# remove the default ls alias so that my custom one is used. my ls is in myutils.ps1. it shows hidden files and sorts by name.
Remove-Item alias:ls -ErrorAction SilentlyContinue

cd $env:userprofile
