#!/bin/bash
# commit a changed file to staging area
cd /usr/local/pl
# only one file
git add LICENCE 
# stage and get ready to upload all the files
git add --all
git status

