#!/usr/bin/env sh

set -e

echo "Generating site"
hugo "$@"

echo "Setting up git"
[ -z "${GITHUB_TOKEN}" ] && \
  (echo "ERROR: Missing GITHUB_TOKEN." ; exit 1)
[ -z "${BRANCH}" ] && \
  (BRANCH=gh-pages)

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo "machine github.com login ${GITHUB_ACTOR} password ${GITHUB_TOKEN}" > ~/.netrc

echo "cloning"
git clone --depth=1 --single-branch --branch ${BRANCH} https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git /tmp/gh-pages

echo "copying"
rm -rf /tmp/gh-pages/*
cp -av public/* /tmp/gh-pages/

echo "commit & push"
cd /tmp/gh-pages

[ "${CNAME}" ] && \
  echo "${CNAME}" > CNAME

git add -A && git commit --allow-empty -am "Publishing Site at ${GITHUB_SHA} Time: $(date -u)"
git push --force

echo "${GITHUB_SHA} was successfully deployed"
