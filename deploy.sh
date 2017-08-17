#!/usr/bin/env bash

REMOTE="git@github.com:johnchandlerburnham/johnchandlerburnham.github.io.git"



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
         --filter='P  CNAME'      \
         --filter='P .stack-work' \
         --delete-excluded        \
         _site/ .

# Commit
git add -A
git commit -m "Publish."

# Push
git push origin master

# Restoration
git checkout hakyll
