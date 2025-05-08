git status

git add -A

git status

echo 'Enter the commit message: '
read commit_message

git commit -m "$commit_message"

echo 'Enter the branch name to push to: '
read branch_name

git push origin $branch_name

git status