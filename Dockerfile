FROM mattbailey/actions-hugo:v0.57.2

LABEL "com.github.actions.name"="Hugo gh-pages action"
LABEL "com.github.actions.description"="GitHub Actions for building with hugo and pushing to gh-pages"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/mattbailey/actions-hugo"
LABEL "homepage"="https://github.com/mattbailey/actions-hugo"
LABEL "maintainer"="mattbailey"

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
