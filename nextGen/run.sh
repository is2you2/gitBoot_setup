echo "auto create shell end."
sleep 2
eval `ssh-agent -s`
ssh-add /Users/sungsoo/.ssh/kncuration_aws_korea.pem
ssh-add /Users/sungsoo/.ssh/test_personal.pem
echo "add ssh-keys from ~/.ssh"
sleep 1
sleep 1
cd /Users/sungsoo/.config
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Music
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.expo
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.node-gyp
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.dart
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.thumbnails
git config --bool core.bare true
cd ~
cd /Users/sungsoo/thours
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.local
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Pictures
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.dartServer
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.bash_imb
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.rncache
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.gnome2
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Desktop
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Library
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.oracle_jre_usage
git config --bool core.bare true
cd ~
cd /Users/sungsoo/gitBoot_setup
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.android
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.cocoapods
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.cups
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.bash_sessions
git config --bool core.bare true
cd ~
cd /Users/sungsoo/flutter
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Public
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.ssh
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Movies
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Applications
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.gradle
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.Trash
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.npm
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Documents
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.ionic
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.vscode
git config --bool core.bare true
cd ~
cd /Users/sungsoo/Downloads
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.cache
git config --bool core.bare true
cd ~
cd /Users/sungsoo/.putty
git config --bool core.bare true
cd ~
rm run.sh
