<div align="center" >
  
  <img width=400  alt="Image Credit: Peaceiris" src="https://raw.githubusercontent.com/peaceiris/actions-hugo/master/images/ogp.svg?sanitize=true" />

  <p style="font-size:12px;" >
    Image Credit: <a href="https://github.com/peaceiris">Peaceiris</a>
  </p>
  
  <h1>
    Build and Publish your Hugo Site to Github Pages
  </h1>
  
  <h3>
    <a href="https://github.com/gohugoio/hugo">
      gohugoio/hugo: The world’s fastest framework for building websites.
    </a>
  </h3>

</div>

&nbsp;

This Action builds your Hugo Site (using the latest Hugo Extended) and pushes it to Github Pages.

This action also contains support for several Hugo Helpers:

| Name | Support |
| ---- | ------- |
| reStructuredText |️ ✔ |
| Pandoc | ✔ |
| Asciidoctor | ✔ |
| PostCSS | ✔ |
| Pygments | ✔ |

If your site requires the use of another externel helper, submit an issue and I'll try to add it.

## Getting started

This is a basic `Yaml` workflow to get you started (for more information scroll down to [Inputs](#inputs)):

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

To add to an already exsiting workflow, this is the section that matters:

```yaml
- name: Publish Site
  uses: chabad360/hugo-gh-pages@master
  with:
    githubToken: ${{ secrets.PERSONAL_TOKEN }}
```

### Inputs

| Key |  Description | Required | Default |
| --- | ----------- | -------- | ------- |
| `githubToken` | A Github Personal Access Token with repo permissions. | ✔ | N/A |
| `cname` | The custom domain name for your GH Pages Site. | ✘ | N/A
| `branch` |  The branch to push the built site to. | ✘ | `gh-pages`|

#### Example

```yaml
- name: Publish Site
  uses: chabad360/hugo-gh-pages@master
  with:
    githubToken: ${{ secrets.PERSONAL_TOKEN }}
    # Remember to set this as a secret (i.e. secrets.PERSONAL_TOKEN).
    # Don't forget to set the secret value in the project settings.
    cname: mysite.com # Or anything else
    # Only use if you have a custom domain for your site.
    branch: master # Or anything else
    # Only use if your site is not hosted on the gh-pages branch.
```

## Credit

This project is forked from [mattbailey/actions-hugo](github.com/mattbailey/actions-hugo)
