#! /usr/bin/env nix-shell
#! nix-shell -i bash -p git bash

REMOTE="git@github.com:johnchandlerburnham/johnchandlerburnham.github.io.git"

info() {
  printf "  \033[00;32m+\033[0m $1\n"
}

fail() {
  printf "  \033[0;31m-\033[0m $1\n"
  exit
}

#Check git repo
if [[ $(git remote get-url origin) != $REMOTE ]];
  then fail "Can't find remote repository: $REMOTE"
fi

# Setup
git stash --include-untracked
git checkout hakyll
COMMIT=$(git log -1 HEAD --pretty=format:%H)

# Build _site
stack exec site clean
stack exec site build

git fetch --all
git checkout master

# Overwrite existing files with new files

rsync -a --filter='P _site/'      \
         --filter='P _cache/'     \
         --filter='P .git/'       \
         --filter='P .gitignore'  \
         --filter='P CNAME'       \
         --filter='P README.md'   \
         --filter='P .stack-work' \
         --delete-excluded        \
         _site/ .

# Commit
info "Publish site based on commit: $COMMIT"

git add -A
git commit -m "Publish site based on commit: $COMMIT"

# Push
git push origin master
info "Pushed"

# Restoration
git checkout hakyll
stack exec site clean
git stash pop
