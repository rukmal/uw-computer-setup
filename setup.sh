# Getting config vars
CURRENT_DIR=$(dirname $BASH_SOURCE)
source $CURRENT_DIR/config

echo "Creating tmp directory"
mkdir ~/tmp
echo $'Done\n'

echo "Downloading and installing iTerm2"
curl $ITERM2_DOWNLOAD_URL > ~/tmp/iTerm2_v2_0.zip
unzip ~/tmp/iTerm2_v2_0.zip -d ~/tmp
sudo mv ~/tmp/iTerm.app /Applications
echo $'Done\n'

echo "Downloading and installing Sublime Text 3"
curl $ST3_DOWNLOAD_URL > ~/tmp/ST3.dmg
sudo hdiutil attach ~/tmp/ST3.dmg
sudo cp -r /Volumes/Sublime\ Text/Sublime\ Text.app/ /Applications/Sublime\ Text.app
sudo diskutil unmount Sublime\ Text
sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin
echo $'Done\n'

echo "Installing Sublime Text 3 Package Control"
curl $ST3_PACKAGE_CONTROL_URL > ~/tmp/Package\ Control.sublime-package
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
mv ~/tmp/Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
echo $'Done\n'

echo "Downloading and installing Spotify"
curl $SPOTIFY_DOWNLOAD_URL > ~/tmp/Spotify.zip
unzip ~/tmp/Spotify.zip -d ~/tmp
# Used open instead of running install script directly to use gui installer
open ~/tmp/Install\ Spotify.app

echo "Cloning dotfile configuration"
git clone $PREFERENCES_GIT_REPO ~/dotfiles
echo "Preparing and running setup script"
sh ~/dotfiles/.scripts/setup.sh
echo $'Done\n'

echo "Installing other tools:"
echo "Installing tig"
git clone $TIG_GIT_URL ~/tmp/tig
cd ~/tmp/tig
sudo make install prefix=/

echo "Deleting tmp folder"
sudo rm -fr ~/tmp
echo $'Done...\n'

echo "Adding items to dock"
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Sublime Text.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
echo "Restarting the dock"
killall Dock
echo $'Done...\n'

echo "Changing desktop background"
mkdir ~/.wallpaper
curl $WALLPAPER_URL > ~/.wallpaper/bg
osascript -e 'tell application "Finder" to set desktop picture to "/Users/'$UW_NET_ID'/.wallpaper/bg" as POSIX file'

echo "All operations completed successfully."
killall Terminal
