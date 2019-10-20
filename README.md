<div align="center" >

  <img width=400  alt="Image Credit: Peaceiris" src="https://raw.githubusercontent.com/peaceiris/actions-hugo/master/images/ogp.svg?sanitize=true" />

  <p style="font-size:12px;" >
    Image Credit: <a href="https://github.com/peaceiris">Peaceiris</a>
  </p>

  <h1>
    🚀 Build and Publish your Hugo Site to GitHub Pages 🚀
  </h1>

  <h3>
    <a href="https://github.com/gohugoio/hugo">
      gohugoio/hugo: The world’s fastest framework for building websites.
    </a>
  </h3>

  <span>
    <a href="https://github.com/chabad360/hugo-gh-pages/blob/master/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/chabad360/hugo-gh-pages.svg?style=for-the-badge" />
    </a>
    <a href="https://github.com/chabad360/hugo-gh-pages/releases/latest">
      <img alt="Release" src="https://img.shields.io/github/release/chabad360/hugo-gh-pages.svg?style=for-the-badge" />
    </a>
    <a href="https://github.com/marketplace/actions/hugo-to-gh-pages">
      <img alt="Release" src="https://img.shields.io/static/v1?label=&style=for-the-badge&logo=addthis&logoColor=white&message=Get+on+the+GH+Marketplace&color=green" />
    </a>
</div>

&nbsp;

This Action builds your Hugo Site (using the latest Hugo Extended) and pushes it to Github Pages.

This action also contains support for several external Hugo Helpers:

| Name | Support |
| ---- | ------- |
| reStructuredText |️ ✔️ |
| Pandoc | ✔️ |
| Asciidoctor | ✔️ |
| PostCSS | ✔️ |
| Pygments | ✔️ |

If your site requires the use of another external helper, submit an issue and I'll try to add it.

## ⭐ Getting started

This is a basic `workflow.yml` to get you started (for more information scroll down to [⭐ Inputs](#-inputs)):

```yaml
name: Publish Site

on:
  push:
    branches:
      - master

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repo
        uses: actions/checkout@master
        with:
          submodules: true

      - name: Publish Site
        uses: chabad360/hugo-gh-pages@master
        with:
          githubToken: ${{ secrets.PERSONAL_TOKEN }}
```

### ⭐ Inputs

| Key |  Description | Required | Default |
| --- | ----------- | -------- | ------- |
| `githubToken` | A Github Personal Access Token with repo permissions. | ✔️ | N/A |
| `cname` | The custom domain name for your GH Pages Site. | ❌ | N/A |
| `branch` |  The branch to push the built site to. | ❌ | `gh-pages`|
| `repo` | The repository to push the built site to. | ❌ | The current repo |
| `hugoVersion` | The version Hugo to use (append `extended_` to the beggining to use the extended version). | ❌ | Latest Hugo Extended |

#### Usage

```yaml
- name: Publish Site
  uses: chabad360/hugo-gh-pages@master
  with:
    githubToken: ${{ secrets.PERSONAL_TOKEN }}
    # Remember to set this as a secret (i.e. secrets.PERSONAL_TOKEN).
    # Don't forget to set the secret value in the project settings.
    cname: mysite.com # Or anything else
    # Use if you have a custom domain for your site.
    branch: master # Or anything else
    # Use if your site is not hosted on the gh-pages branch.
    repo: you/you.github.io
    # Use if your pushing to a different repo.
    # Dont add ".git" to the end of the URL (youl'll get 404s).
    hugoVersion: extended_0.58.3
    # Use if your site requires a specific version of Hugo
    # Append "extended_" to the beggining to use Hugo Extended
```

## ⭐ Credit

This project is based on [mattbailey/actions-hugo](https://github.com/mattbailey/actions-hugo)
