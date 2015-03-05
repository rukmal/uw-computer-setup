# Getting config vars
source ./config

# Creating tmp directory, cloning preferences and moving stuff
mkdir tmp
cd tmp
git clone $PREFERENCES_GIT_REPO
mv -f dotfiles/.* ~/
