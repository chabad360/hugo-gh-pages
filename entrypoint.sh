#!/usr/bin/env sh

set -e

PLAIN='\033[0m'
BOLD='\033[1;37m'

if [ "${CNAME}" ]; then
  NAME=${CNAME}
else
  NAME=${GITHUB_REPOSITORY}
fi

[ -z "${GITHUB_TOKEN}" ] && \
  (echo -e "\n${BOLD}ERROR: Missing GITHUB_TOKEN.${PLAIN}" ; exit 1)

[ -z "${BRANCH}" ] && \
  BRANCH=gh-pages

echo -e "\n${BOLD}Versions${PLAIN}"
hugo version
pygmentize -V
asciidoctor --version


echo -e "\n${BOLD}Generating Site ${NAME} at commit ${GITHUB_SHA}${PLAIN}"
hugo "$@"


echo -e "\n${BOLD}Setting up Git${PLAIN}"
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo "machine github.com login ${GITHUB_ACTOR} password ${GITHUB_TOKEN}" > ~/.netrc

git clone --depth=1 --single-branch --branch "${BRANCH}" "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" /tmp/gh-pages


echo -e "\n${BOLD}Commiting${PLAIN}"
rm -rf /tmp/gh-pages/*
cp -a public/* /tmp/gh-pages/
cd /tmp/gh-pages

[ "${CNAME}" ] && \
  echo "${CNAME}" > CNAME

git add -A && git commit --allow-empty -am "Publishing Site ${NAME} at ${GITHUB_SHA} on $(date -u)"

echo -e "\n${BOLD}Pushing${PLAIN}"
git push --force


echo -e "\n${BOLD}Site ${NAME} at ${GITHUB_SHA} was successfully deployed!${PLAIN}"
