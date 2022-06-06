#!/usr/bin/env sh

set -e

PLAIN='\033[0m'
BOLD='\033[1;37m'
CLONE_DIRECTORY="/tmp/gh-pages"

if [ "${INPUT_HUGOVERSION}" ]; then
  echo -e "\n${BOLD}Using Hugo version ${INPUT_HUGOVERSION}.${PLAIN}"
  wget "https://github.com/gohugoio/hugo/releases/download/v$(echo "${INPUT_HUGOVERSION}" | grep -o  "[0-9]\+.[0-9]\+.[0-9]\+")/hugo_${INPUT_HUGOVERSION}_Linux-64bit.tar.gz"
  tar x -zvf hugo*.tar.gz
  mv hugo /usr/bin/hugo
  rm hugo*.tar.gz
fi


if [ "${INPUT_CNAME}" ]; then
  NAME=${INPUT_CNAME}
else
  NAME=${GITHUB_REPOSITORY}
fi

if [ "${INPUT_REPO}" ]; then
  REPO=${INPUT_REPO}
else
  REPO=${GITHUB_REPOSITORY}
fi

if [ "${INPUT_DESTINATIONDIR}" ]; then
  PUBLISH_DIRECTORY="${CLONE_DIRECTORY}/${INPUT_DESTINATIONDIR}"
else
  PUBLISH_DIRECTORY="${CLONE_DIRECTORY}"
fi

CD=${INPUT_SITEDIR:=$(pwd)}

[ -z "${INPUT_GITHUBTOKEN}" ] && \
  (echo -e "\n${BOLD}ERROR: Missing githubToken.${PLAIN}" ; exit 1)


echo -e "\n${BOLD}Versions:${PLAIN}"
echo -ne "${BOLD}Hugo: ${PLAIN}"
hugo version
echo -ne "${BOLD}Pygments: ${PLAIN}"
pygmentize -V
echo -ne "${BOLD}Asciidoctor: ${PLAIN}"
asciidoctor --version
echo -ne "${BOLD}PostCSS: ${PLAIN}"
postcss --version
echo -ne "${BOLD}Pandoc: ${PLAIN}"
pandoc -v
echo -ne "${BOLD}Babel: ${PLAIN}"
babel --version


echo -e "\n${BOLD}Setting up Git${PLAIN}"
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git config --global --add safe.directory "${GITHUB_WORKSPACE}"
echo "machine github.com login ${GITHUB_ACTOR} password ${INPUT_GITHUBTOKEN}" > ~/.netrc

git clone --depth=1 --single-branch --branch "${INPUT_BRANCH}" "https://x-access-token:${INPUT_GITHUBTOKEN}@github.com/${REPO}.git" $CLONE_DIRECTORY
rm -rf "${PUBLISH_DIRECTORY}/*"


echo -e "\n${BOLD}Generating Site ${NAME} at commit ${GITHUB_SHA}${PLAIN}"
cd ${CD}
hugo mod get
hugo ${INPUT_ARGS} -d "${PUBLISH_DIRECTORY}"


echo -e "\n${BOLD}Commiting${PLAIN}"
cd $CLONE_DIRECTORY

[ -n "${INPUT_CNAME}" ] && \
  echo "${INPUT_CNAME}" > CNAME

git add -A && git commit --allow-empty -am "Publishing Site ${NAME} at ${GITHUB_SHA} on $(date -u)"


echo -e "\n${BOLD}Pushing${PLAIN}"
git push --force


echo -e "\n${BOLD}Site ${NAME} at ${GITHUB_SHA} was successfully deployed!${PLAIN}"
