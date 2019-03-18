# update & upgrade first, on your own
sudo apt install xvfb libxrender1 libxtst6 libxi6 default-jdk unzip zip -y
mv gitBoot_setup .gitBoot_setup
chmod 700 autogit.sh
./autogit.sh
rm firstRun.sh
