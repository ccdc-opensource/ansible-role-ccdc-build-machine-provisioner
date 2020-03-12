param (
    [string]$wslpassword,
)

$localuser = $Env:USERNAME

if ((wsl.exe -e "whoami") | out-string).trim() -eq "root" {
  wsl -e useradd $localuser
  wsl -e chpasswd $localuser:$wslpassword
  # TODO: add %USERNAME% to sudoers and switch default uid to 1000 via registry
  # HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{d5f3cdf5-e49e-4d34-8107-9beec78b9a41}\DefaultUid
}

# Add SSH keys
wsl -e mkdir -p ~/.ssh
wsl -e scp "$localuser@unix:~/.ssh/id_rsa*" /home/$localuser/.ssh/
wsl -e chmod 644 /home/$localuser/.ssh/id_rsa.pub
wsl -e chmod 600 /home/$localuser/.ssh/id_rsa

# Set up automount
wsl -u root echo -e [automount]\\nenabled = true\\nroot = /mnt/\\noptions = '\"metadata,umask=22,fmask=11\"'\\n `>> /etc/wsl.conf
