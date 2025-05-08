# create a new repository on the command line
git init
git add -A
git commit -m "first commit"
git branch -M main

echo 'Enter the remote repository URL: '
read repo_url
# add the remote repository 

git remote add origin $repo_url
# push the changes to the remote repository
git push -u origin main
# check the status of the repository
git status
# check the remote repository
git remote -v
# check the branch
git branch -a
# check the log
git log
