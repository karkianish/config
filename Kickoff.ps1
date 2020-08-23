# open powershell in admin mode and run the following commands
# install scoop
iwr -useb get.scoop.sh | iex

scoop bucket add extras jetbrains

scoop install git

# configure git
git config --global user.name "Anish Karki"
git config --global user.email "karkianish@hotmail.com"

# create and add public ssh key to github 
function _SetSshForGithub ($rsaFilename, $sshPassphrase, $githubUsername, $githubPassword, $otp) {
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
    # preparing header and payload for api call to add ssh key to github
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
    $headers.Add("x-github-otp", $otp);

    # use backticks to break long command into multiple line. backtick MUST precede by a whitespace and SHOULDNOT have trailing whitespace
    Invoke-WebRequest -Headers $headers `
        -Method Post `
        -Uri "https://api.github.com/user/keys" `
        -Body $requestBody
}

# replace the github username and password with correct one. otp is you mfa token. if you want sshpassphrase, specify that using -sshPassphrase
_SetSshForGithub -rsaFilename id_rsa -githubUsername karkianish -githubPassword password -otp 123456
