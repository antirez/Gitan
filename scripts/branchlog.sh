#!/bin/sh

cd $1
git log --abbrev-commit --pretty=format:'%h %d %s -- %an (%cr)' --date=relative | head -20
