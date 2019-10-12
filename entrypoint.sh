#!/usr/bin/env sh

set -e

if [ "${CNAME}" ]; then
  NAME=${CNAME}
else
  NAME=${GITHUB_REPOSITORY}
fi

[ -z "${GITHUB_TOKEN}" ] && \
  (echo "ERROR: Missing GITHUB_TOKEN." ; exit 1)

[ -z "${BRANCH}" ] && \
  BRANCH=gh-pages

echo "Versions"
hugo version
pygmentize -V
asciidoctor --version


echo "Generating Site ${NAME} at commit ${GITHUB_SHA}"
hugo "$@"


echo "Setting up Git"
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo "machine github.com login ${GITHUB_ACTOR} password ${GITHUB_TOKEN}" > ~/.netrc

git clone --depth=1 --single-branch --branch "${BRANCH}" "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" /tmp/gh-pages


echo "Commiting"
rm -rf /tmp/gh-pages/*
cp -a public/* /tmp/gh-pages/
cd /tmp/gh-pages

[ "${CNAME}" ] && \
  echo "${CNAME}" > CNAME

git add -A && git commit --allow-empty -am "Publishing Site ${NAME} at ${GITHUB_SHA} on $(date -u)"

echo "Pushing"
git push --force


echo "Site ${NAME} at ${GITHUB_SHA} was successfully deployed!"
