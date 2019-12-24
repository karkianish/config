echo "Loading profile..."

Set-ExecutionPolicy RemoteSigned -Scope Process
Set-PSReadLineOption -EditMode Vi -BellStyle None -ViModeIndicator Cursor
# add timestamp to prompt. 
$GitPromptSettings.DefaultPromptPrefix = "$(get-date -Format HH:mm:ss.fff) "
# set prompt color
$GitPromptSettings.DefaultForegroundColor = 'yellow'

. .\powershell\MyUtils.ps1

import-module posh-git
import-module zlocation

$conemuSettings = "$env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\ConEmu.xml";
$vimrc = "$env:userprofile\_vimrc";

cd $env:userprofile
