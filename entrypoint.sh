#!/usr/bin/env sh

set -e

echo "Generating site"
hugo "$@"

echo "Setting up git"
[ -z "${GITHUB_TOKEN}" ] && \
  (echo "ERROR: Missing GITHUB_TOKEN." ; exit 1)
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo "machine github.com login ${GITHUB_ACTOR} password ${GITHUB_TOKEN}" > ~/.netrc

echo "cloning"
git clone --depth=1 --single-branch --branch gh-pages https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git /tmp/gh-pages

echo "copying"
rm -rf /tmp/gh-pages/*
cp -av public/* /tmp/gh-pages/

echo "commit & push"
cd /tmp/gh-pages
git add -A && git commit --allow-empty -am "Publishing from mattbailey/actions-hugo ${GITHUB_SHA}"
git push

#echo "Triggering second commit (for some gh-pages builds, two commits are required)."
#date -u > last_deploy.txt
#git add last_deploy.txt
#git commit -am "Publishing from mattbailey/actions-hugo ${GITHUB_SHA}"
#git push
