#!/bin/bash

# Script to set up a git repository to track streaks and automate commits every 6 hours

# Step 1: Create the repo locally
cd ~
mkdir -p streak
cd streak
git init
echo "xxx" > README.md
git add README.md
git commit -m "initial commit"

# Step 2: Create the repo on GitHub
gh repo create streak --public --source=. --remote=origin --push

# Step 3: Ask user for their username (needed for cron path)
echo "Input your username you are currently logged in as: "
read user

# Step 4: Set up Streakerkeeper folder
cd ~
mkdir -p Streakerkeeper
cd Streakerkeeper

# Step 5: Add cron job (every 2 hours)
( crontab -l 2>/dev/null; echo "0 */2 * * * /home/$user/Streakerkeeper/uploader.sh" ) | crontab -

# Step 6: Create uploader.sh
cat > uploader.sh << 'EOF'
#!/bin/bash
randon=$(($RANDOM + $RANDOM * $RANDOM))
cd ~/streak
echo $randon > README.md
git add README.md
git commit -m "$randon"
git push
EOF

chmod +x uploader.sh

# Step 7: Run once immediately
bash uploader.sh
