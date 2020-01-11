#set psgallery as trusted repo so it doesn't prompt confirmation during module installation 
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
