git config commit.template ./Scripts/.gitmessage.txt
mkdir -p .git/hooks
cp -f ./Scripts/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg
