# update & upgrade first, on your own
sudo apt install unzip -y
unzip install.zip
rm install.zip
rm -rf .DS_Store __MACOSX Thumbs.db
./firstRun.sh
rm install.sh
