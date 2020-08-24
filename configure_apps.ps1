# add the 'extras' bucket for scoop
scoop bucket add extras 
scoop bucket add jetbrains
scoop bucket add java

# install apps from scoop
scoop install authy
scoop install autohotkey
scoop install everything
scoop install fzf
scoop install git-with-openssh
scoop install googlechrome
scoop install nvm
scoop install openjdk
scoop install postgresql
scoop install python
scoop install slack
scoop install touch
scoop install vifm
scoop install vim
scoop install vscode
scoop install windows-terminal
scoop install yarn

# install github cli. must run after installing git.
scoop bucket add github-gh https://github.com/cli/scoop-gh.git
scoop install gh 

# install latest node via nvm rather than scoop
nvm install latest

# instal settings-sync 
code --install-extension shan.code-settings-sync