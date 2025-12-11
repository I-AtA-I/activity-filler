#!/bin/bash

#Script to set up a git repository to track streaks and automate commits every 6 hours

#Prompting user for their .git folder location
echo "Input your .git folder (example: ~/Downloads/.git ): "
read gitfolder

#creating a 'streak' repository
cd $gitfolder
mkdir streak
cd streak
touch README.md

#initializing git repository
git init

#creating necessary files and setting up cron job
cd ~
mkdir Streakerkeeper
cd Streakerkeeper
touch crontab.sh
chmod +x crontab.sh

echo '(crontab -l 2>/dev/null; echo "0 */6 * * * ~/Streakerkeeper/uploader.sh") | crontab -' >> crontab.sh


#creating uploader.sh file
touch uploader.sh
chmod +x uploader.sh

random=$(($RANDOM + $RANDOM * $RANDOM))

echo "$random" >> $gitfolder/streak/README.md

cd $gitfolder/streak

echo 'git push README.md' >> '~/Streakerkeeper/uploader.sh'


./crontab.sh
