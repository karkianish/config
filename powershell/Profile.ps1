echo "Loading profile..."

Set-ExecutionPolicy RemoteSigned -Scope Process
Set-PSReadLineOption -EditMode Vi -BellStyle None -ViModeIndicator Cursor

import-module posh-git
import-module zlocation

# add timestamp to prompt. 
$GitPromptSettings.DefaultPromptPrefix = "$(get-date -Format HH:mm:ss.fff) "
# set prompt color
$GitPromptSettings.DefaultForegroundColor = 'blue'

. (join-path $env:userprofile 'config\powershell\MyUtils.ps1')

$conemuSettings = "$env:userprofile\scoop\apps\cmder\current\vendor\conemu-maximus5\ConEmu.xml";
$vimrc = "$env:userprofile\_vimrc";

cd $env:userprofile
