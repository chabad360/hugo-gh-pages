## hugo to gh-pages

Combines a pre-built image with hugo and other required tools with a script to publish back to gh-pages branch.

Inspired by https://github.com/peaceiris/actions-hugo, but I wanted a faster deploy (pre-built image) and to combine the gh-pages deployment.

## Getting started

```yaml
name: github pages

on:
  push:
    branches:
    - master

jobs:
  build-deploy:
    runs-on: ubuntu-18.04
    steps:
    - uses: actions/checkout@master
      with:
        submodules: true
    - name: build
      uses: mattbailey/actions-hugo@v0.57.2
      if: github.event.deleted == false
      with:
        args: --gc --minify
      env:
        GITHUB_TOKEN: ${{ secrets.MY_PERSONAL_TOKEN }}
```

## On Tokens

GitHub doesn't recognize this as a bug, but if you use `secrets.GITHUB_TOKEN` (which is a token generated by Actions), site publishing will _not_ work in some scenarios, and it will _not_ tell you why. You'll just get a "Page build failed" in your repo's settings tab, with no further information. As above, add your _own_ personal access token with write access to your repo to GitHub Secrets for your repository and reference it in your action.

I opened a support ticket about this, the response was:

> ... GitHub Pages site builds aren’t able to be triggered by bot users or integrations that push to your repository. This is to prevent excessive resource usage and abuse of GitHub Pages systems.
> You can work around this but it will require your integration to push your code back to GitHub using a Personal Access Token created by your account.