https://gist.github.com/jchandra74/5b0c94385175c7a8d1cb39bc5157365e
# Verify you have the proper fonts
create the function below in your powershell session
```
function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}

```
execute the command below and you should see symbols. If you donot see the symbols or question mark symbols, Powerline font has not been installed correctly. Please follow the instructions to install it correctly.
```
Write-Host "$(U 0xE0B0) $(U 0x00B1) $(U 0xE0A0) $(U 0x27A6) $(U 0x2718) $(U 0x26A1) $(U 0x2699)"
```
# Install fonts
`git clone https://github.com/powerline/fonts.git`

`
cd fonts
.\install.ps1 "Meslo*"
`

# Install `oh-my-posh`

`install-module oh-my-posh -scope CurrentUser`

You could see the available themes at https://github.com/JanDeDobbeleer/oh-my-posh. I took the `paradox` theme and made few adjustments to look as I want it.

Show how to edit....

In your powershell profile add `Set-Theme Carkey` after `import-module oh-my-posh`. I've made the following changes:
- remove user and machine info
- update timestamp to include miliseconds 
- move timestamp to the place of user@machine in the prompt
- use prompt background color for text color of admin symbol and timestamp
- remove $lastCommandFailed symbol 
- remove prompt symbol
- update to enter command on the same line

Explain the part about updating the color of prompt background from `conemu -> settings -> colors`

