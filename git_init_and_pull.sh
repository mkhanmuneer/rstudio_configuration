# script to initialize a git repository and pull the latest changes from a remote repository
# Usage: ./git_init_and_pull.sh <repository_url> <branch_name>
# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <repository_url> <branch_name>"
    exit 1
fi
# Assign arguments to variables
REPO_URL=$1
BRANCH_NAME=$2
# Check if the current directory is already a git repository
if [ -d ".git" ]; then
    echo "This directory is already a git repository."
    echo "Pulling the latest changes from the remote repository..."
    git pull origin $BRANCH_NAME
else
    # Initialize a new git repository
    echo "Initializing a new git repository..."
    git init
    # Add the remote repository
    echo "Adding remote repository..."
    git remote add origin $REPO_URL
    # Fetch the latest changes from the remote repository
    echo "Fetching the latest changes from the remote repository..."
    git fetch origin $BRANCH_NAME
    # Checkout the specified branch
    echo "Checking out branch $BRANCH_NAME..."
    git checkout -b $BRANCH_NAME origin/$BRANCH_NAME
fi
# Pull the latest changes from the remote repository
echo "Pulling the latest changes from the remote repository..."
git pull origin $BRANCH_NAME
# Check if the pull was successful
if [ $? -eq 0 ]; then
    echo "Successfully pulled the latest changes from the remote repository."
else
    echo "Failed to pull the latest changes from the remote repository."
    exit 1
fi
# Check if the branch exists
if git show-ref --verify --quiet refs/heads/$BRANCH_NAME; then
    echo "Branch $BRANCH_NAME exists."
else
    echo "Branch $BRANCH_NAME does not exist."
    exit 1
fi
# Check if the branch is up to date with the remote branch
if git rev-parse --abbrev-ref HEAD | grep -q $BRANCH_NAME; then
    echo "Branch $BRANCH_NAME is up to date with the remote branch."
else
    echo "Branch $BRANCH_NAME is not up to date with the remote branch."
    exit 1
fi
# Check if there are any uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "There are uncommitted changes in the repository."
else
    echo "There are no uncommitted changes in the repository."
fi
# Check if there are any untracked files
if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo "There are untracked files in the repository."
else
    echo "There are no untracked files in the repository."
fi
# Check if there are any merge conflicts
if [ -n "$(git diff --name-only --diff-filter=U)" ]; then
    echo "There are merge conflicts in the repository."
else
    echo "There are no merge conflicts in the repository."
fi
# Check if there are any stashed changes
if [ -n "$(git stash list)" ]; then
    echo "There are stashed changes in the repository."
else
    echo "There are no stashed changes in the repository."
fi
