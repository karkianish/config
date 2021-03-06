function SetHyphenLessAlias($description) {
    $commands = Get-Command;
    foreach ($cmd in $commands) {
        $hyphenIndex = $cmd.Name.IndexOf("-");
        if ($hyphenIndex -gt -1) {
            $aliasName = $cmd.Name.Remove($hyphenIndex, 1);
            Set-Alias -Name $aliasName -Value $cmd -Description $description;
        }
    }
}

function uninstall($appName) {
    Get-AppxPackage $appName | Remove-AppxPackage;
}

# get list of installed and removable apps
# Get-AppxPackage | where-object nonremovable -ne "True" | select name, nonremovable

function GetPortInfo($portNum) {
    Get-Process -Id (Get-NetTCPConnection -LocalPort $portNum).OwningProcess;
}

# create and add public ssh key to github 
function SetSshForGithub ($rsaFilename, $sshPassphrase, $githubUsername, $githubPassword, $otp) {
    # todo - add param block and make params mandatory
    Write-Output "generating ssh key";
    if (!$PSBoundParameters.ContainsKey('sshPassphrase') -or $sshPassphrase -eq "") {
        $sshPassphrase = '""';
    }

    # ssh keygen without prompt https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt
    ssh-keygen -t rsa -N $sshPassphrase -f $env:USERPROFILE\.ssh\$rsaFilename;
    Write-Output "done generating ssh key"

    # start ssh-service and add private key to agent
    Get-Service ssh-agent | Set-Service -StartupType Manual
    ssh-agent
    ssh-add $env:USERPROFILE\.ssh\$rsaFilename

    # https://stackoverflow.com/questions/27969362/basic-authentication-with-the-github-api-using-powershell
    $authToken = "{0}:{1}" -f $githubUsername, $githubPassword;
    $authBytes = [System.Text.Encoding]::Ascii.GetBytes($authToken);
    $authCreds = [Convert]::ToBase64String($authBytes);
    $sshTitle = "{0}_{1}" -f $env:COMPUTERNAME, $env:USERNAME;
    $sshPubKey = Get-Content $env:USERPROFILE\.ssh\$rsaFilename.pub;
    # those @" "@ has to be exactly like that
    $requestBody = @"
    {
        "title": "$sshTitle", 
        "key": "$sshPubKey"
    }
"@;
    $headers = New-Object "System.Collections.Generic.Dictionary[[string],[string]]";
    $headers.Add("Authorization", "Basic $authCreds");
    # add check to see if this param is passed, else skip this
    $headers.Add("x-github-otp", $otp);

    # use backticks to break long command into multiple line. backtick MUST precede by a whitespace and SHOULDNOT have trailing whitespace
    Invoke-WebRequest -Headers $headers `
        -Method Post `
        -Uri "https://api.github.com/user/keys" `
        -Body $requestBody
}

# to download file
function download($url, $saveLocation, $fileNameWithExt) {
    if (!$saveLocation) {
        $saveLocation = "$env:USERPROFILE\Downloads"
    }
    if (!(Test-Path $saveLocation)) {
        New-Item -ItemType Directory -Path $saveLocation
    }
    # WebClient.DownloadFile needs a filename as a second param, not a directory
    $saveas = "$saveLocation\$fileNameWithExt"
    Write-Output "Saving to $saveas"
    
    $webClient = New-Object -TypeName System.Net.WebClient
    $webClient.DownloadFile($url, $saveas)
}

# alias Expand-Archive unzip and Compress-Archive to zip
# to view the list of added private keys to ssh-agent, use ssh-add -L
# you can send the output text to a file by doing `dir | vim/code fileName` 
# if filename doesn't exist a new file will be created, to send to an unnamed file use `-`

# get example for cmd usage
function eg($cmd) { 
    Get-Help $cmd -examples | more
}

# get definition of a function when applicable
function def($functionName) {
    (Get-Command $functionName).Definition | more 
}

function config {
   set-location $env:userprofile\repos\config
}

function repos {
   set-location $env:userprofile\repos
   ls
}

function dl {
   set-location $env:userprofile\downloads
   lst
}

function docs {
   set-location $env:userprofile\documents
   ls
}

function gs {
   set-location $env:userprofile\documents\grad_school
   ls
}

function ai {
   set-location $env:userprofile\documents\grad_school\cs7638
   ls
}

function cdh {
   set-location $env:userprofile
}

function cdp {
    set-location c:\repos\plan-analytics
}

# cd and ls combined
function cdls ($path) {
    Set-Location $path
    Get-ChildItem
}

# create directory if it doesn't exist and cd into it
function ccd ($path) {
    if (!(Test-Path $path)) {
        mkdir $path
    }
    Set-Location $path
}

# create destination folder if not exist and copy
function ccp($src, $dest) {
    if (!(Test-Path $dest)) {
        mkdir $dest
    }
    Copy-Item $src -Destination $dest
}

# create destination folder if not exist and move
function cmv($src, $dest) {
    if (!(Test-Path $dest)) {
        mkdir $dest
    }
    Move-Item $src -Destination $dest
}

# create symlink
function symlink($source, $target) {
    if (Test-Path $target) {
        Write-Output "$target exists. Deleting..."
        Remove-Item $target -Recurse -Force
    }
    New-Item -Path $target -ItemType SymbolicLink -Value $source;
    #   eg. symlink \app-settings\personal-settings\conemu.xml $conemuSettings
}

# get first x lines from a file 
function head($filePath, $lines = 30) {
    Get-Content $filePath -head $lines
}

# get last x lines from a file 
function tail($filePath, $lines = 30) {
    Get-Content $filePath -tail $lines
}

function vimrc(){
    code ~\repos\config\vimrc
}

# use 'everything' cli to find requested term
$stars = "************"
function find($searchString) {
    Write-Host ""
    Write-Host "$stars Displaying only top 30 results $stars"
    Write-Host ""
    &(Join-Path $env:USERPROFILE '\es-cli\es.exe') count:30 $searchString
}

function findf($searchString) {
    Write-Host ""
    Write-Host "$stars Searched files only. Displaying only the top 30 results $stars"
    Write-Host ""
    &(Join-Path $env:USERPROFILE '\es-cli\es.exe') count:30 file:$searchString
}

function findd($searchString) {
    Write-Host ""
    Write-Host "$stars Searched directories only. Displaying only the top 30 results $stars"
    Write-Host ""
    &(Join-Path $env:USERPROFILE '\es-cli\es.exe') count:30 file:$searchString
}
# list items sorted by name
function ls($path) {
    if ($path) {
        Get-ChildItem $path -Force | Sort-Object Name
    }
    else {
        Get-ChildItem -Force | Sort-Object Name
    }
}

# list items sorted by Length in descending order. Cuz we generally care for the biggest one
function lss($path) {
    if ($path) {
        Get-ChildItem $path -Force | Sort-Object Length, Name -Descending
    }
    else {
        Get-ChildItem -Force | Sort-Object Length, Name -Descending
    }
}

# list items sorted by LastWriteTime (time) in descending order. Cuz we generally care for the latest one
function lst {
    if ($path) {
        Get-ChildItem $path -Force | Sort-Object LastWriteTime, Name -Descending
    }
    else {
        Get-ChildItem -Force | Sort-Object LastWriteTime, Name -Descending
    }
}

# list only files (exclude directories)
function lsf {
    if ($path) {
        Get-ChildItem $path -File -Force | Sort-Object Name
    }
    else {
        Get-ChildItem -File -Force | Sort-Object Name
    }
}

# list only direct$path ories (exclude files) -DescLastWriteTime, ending
function lsd {
    if ($path) {
        Get-ChildItem $path -Directory -Force | Sort-Object Name
    }
    else {
        Get-ChildItem -Directory -Force | Sort-Object Name
    }
}

function rmrf($itemToRemove) {
    Remove-Item $itemToRemove -Recurse -Force
}

function utils {
    code $env:userprofile/repos/config/utility_functions.ps1
}

function StartSshAgent {
    if (!(get-process | Where-Object { $_.Name -eq 'ssh-agent' })) {
        Write-Host "Starting ssh-agent..."
        Start-SshAgent
    }
}

function InstallAndImport($moduleName) {
    if (!(Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue)) {
        Write-Output "Installing module $moduleName"
        Install-Module $moduleName -Scope CurrentUser
    }

    Write-Output "Importing module $moduleName"
    Import-Module $moduleName
}

function InstallFonts() {
    $destination = "$env:userprofile\downloads\CascadiaFonts.zip"
    Invoke-WebRequest https://github.com/microsoft/cascadia-code/releases/download/v2007.01/CascadiaCode-2007.01.zip -OutFile $destination

    Expand-Archive -path $destination -destinationPath $env:userprofile\downloads\CascadiaFonts -Force

    # https://superuser.com/a/788759/383506
    $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
    Get-ChildItem $env:userprofile\downloads\CascadiaFonts\ttf\*.ttf | ForEach-Object { $fonts.CopyHere($_.fullname, 8) }
}

# notes
function n($text) {
    $ts = Get-Date -Format "MM/dd/yyyy HH:mm:ss" ;
    Add-Content $env:userprofile\notes.txt -Value "$ts $text"
}

function notes() {
    vi $env:USERPROFILE\notes.txt
}

#set-location (Get-ChildItem -name | fzf) something like this or even better?
