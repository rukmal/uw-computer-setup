# Getting config vars
source ./config

echo "Creating tmp directory"
mkdir ~/tmp
echo $'Done\n'

echo "Downloading and installing iTerm2"
curl https://iterm2.com/downloads/stable/iTerm2_v2_0.zip > ~/tmp/iTerm2_v2_0.zip
open ~/tmp/iTerm2_v2_0.zip
sudo mv ~/tmp/iTerm.app /Applications
echo $'Done\n'

echo "Downloading and installing Sublime Text 3"
curl http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203065.dmg > ~/tmp/ST3.dmg
sudo hdiutil attach ~/tmp/ST3.dmg
sudo cp -r /Volumes/Sublime\ Text/Sublime\ Text.app/ /Applications/
sudo diskutil unmount Sublime\ Text
echo $'Done\n'

echo "Installing Sublime Text 3 Package Control"
curl https://packagecontrol.io/Package%20Control.sublime-package > ~/tmp/Package\ Control.sublime-package
mv ~/tmp/Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
echo $'Done\n'

echo "Cloning dotfile configuration"
git clone $PREFERENCES_GIT_REPO ~/dotfiles
echo "Preparing and running setup script"
sh ~/dotfiles/.scripts/setup.sh
echo $'Done\n'

echo "Deleting tmp folder"
rm -r ~/tmp
echo $'Done...\n'

echo "All operations completed successfully."
