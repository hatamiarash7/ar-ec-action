# ArvanCloud Edge Computing Action

[![CI](https://github.com/hatamiarash7/ar-ec-action/actions/workflows/ci.yml/badge.svg)](https://github.com/hatamiarash7/ar-ec-action/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Marketplace](https://img.shields.io/badge/marketplace-ar--ec--action-green?logo=github)](https://github.com/marketplace/actions/arvancloud-edge-computing-action)

Deploy a JavaScript bundle to [ArvanCloud Edge Computing](https://www.arvancloud.ir/en/products/edge-computing)
from a GitHub workflow. The action runs the official
[`arvan` CLI](https://git.arvancloud.ir/arvancloud/cli) inside a container, so
there is nothing to install on the runner.

## Usage

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Deploy to ArvanCloud
        uses: hatamiarash7/ar-ec-action@v1
        with:
          auth: ${{ secrets.ARVAN_API_KEY }}
          app: my-edge-app
          file: main.js
```

The bundle must exist on the runner before this step, so either commit it or
build it in an earlier step.

## Inputs

| Name                | Required | Default         | Description                                                                    |
| ------------------- | -------- | --------------- | ------------------------------------------------------------------------------ |
| `auth`              | Yes      |                 | ArvanCloud API token. Always read it from a secret.                            |
| `app`               | Yes      |                 | Name of the Edge Computing application to deploy to.                           |
| `file`              | No       | `main.js`       | Bundle file to deploy, relative to `working-directory`.                        |
| `working-directory` | No       | Repository root | Directory that `file` is resolved against.                                     |

## Outputs

| Name         | Description                                        |
| ------------ | -------------------------------------------------- |
| `id`         | Identifier of the created deployment.              |
| `status`     | Status reported by the API, for example `pending`. |
| `created-at` | Creation timestamp of the deployment.              |

Every run also writes a short table to the job summary.

## Examples

### Build the bundle first

```yaml
- uses: actions/checkout@v4

- uses: actions/setup-node@v4
  with:
    node-version: 20
    cache: npm

- run: npm ci && npm run build

- uses: hatamiarash7/ar-ec-action@v1
  with:
    auth: ${{ secrets.ARVAN_API_KEY }}
    app: my-edge-app
    file: bundle.js
    working-directory: dist
```

### Use the outputs

```yaml
- id: deploy
  uses: hatamiarash7/ar-ec-action@v1
  with:
    auth: ${{ secrets.ARVAN_API_KEY }}
    app: my-edge-app
    file: dist/bundle.js

- run: echo "Deployment ${{ steps.deploy.outputs.id }} is ${{ steps.deploy.outputs.status }}"
```

### Deploy to an environment on release

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    permissions:
      contents: read
    steps:
      - uses: actions/checkout@v4
      - uses: hatamiarash7/ar-ec-action@v1
        with:
          auth: ${{ secrets.ARVAN_API_KEY }}
          app: my-edge-app
          file: dist/bundle.js
```

## Getting an API token

1. Sign in to the [ArvanCloud panel](https://panel.arvancloud.ir).
2. Open **Profile → API Keys** and create a machine user key.
3. Add it to your repository under **Settings → Secrets and variables →
   Actions** as `ARVAN_API_KEY`.

Copy the value exactly as the panel shows it, including any prefix, and do not
add quotes around it.

## Notes

- The action runs in a Docker container, so it only works on Linux runners
  (`ubuntu-latest` and self-hosted Linux, `amd64` or `arm64`).
- The token is passed to the container as an environment variable and is masked
  in the logs. See [SECURITY.md](SECURITY.md) for the details.
- Pin the action to a tag (`@v1`) or a commit SHA rather than a branch.

## Troubleshooting

### `Bundle file '...' was not found`

The path is resolved relative to the repository root, or to
`working-directory` when it is set. Add an `actions/checkout` step, or check
that the build step ran before this one.

### `The CLI reported no reason` followed by a failed deployment

The CLI stays silent when the API rejects the credentials. Confirm that the
token is valid, has not expired, and belongs to an account that can see the
application.

### The deployment succeeds but the application is unchanged

`status` is `pending` right after a deployment. The platform rolls the new
bundle out asynchronously; check the panel or `arvan ec list` for the final
state.

---

## Support 💛

[![Donate with Bitcoin](https://img.shields.io/badge/Bitcoin-bc1qmmh6vt366yzjt3grjxjjqynrrxs3frun8gnxrz-orange)](https://donatebadges.ir/donate/Bitcoin/bc1qmmh6vt366yzjt3grjxjjqynrrxs3frun8gnxrz) [![Donate with Ethereum](https://img.shields.io/badge/Ethereum-0x0831bD72Ea8904B38Be9D6185Da2f930d6078094-blueviolet)](https://donatebadges.ir/donate/Ethereum/0x0831bD72Ea8904B38Be9D6185Da2f930d6078094)

<div><a href="https://payping.ir/@hatamiarash7"><img src="https://cdn.payping.ir/statics/Payping-logo/Trust/blue.svg" height="128" width="128"></a></div>

## Contributing 🤝

Don't be shy and reach out to us if you want to contribute 😉

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## Issues

Each project may have many problems. Contributing to the better development of this project by reporting them.
