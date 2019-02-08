sudo apt install xvfb libxrender1 libxtst6 libxi6 default-jdk unzip zip -y
mv gitStarter .gitStarter
mv boot_setup .boot_setup
chmod 700 autoInit.sh
./autoInit.sh
chmod 700 startgit.sh
./startgit.sh
rm firstRun.sh
