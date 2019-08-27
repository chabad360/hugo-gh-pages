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
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
