# pwmate

Automated password changes for [cloudcsale.ch](https://cloudscale.ch) accounts.
Passwords can be retrieving and saved using [Vault](https://www.vaultproject.io/), [Cryptopus](https://github.com/puzzle/cryptopus) or command line.

## Dev dependencies on Ubuntu

Build tools and dev dependiencies are required:

```sh
sudo apt install ruby-dev libffi-dev build-essential
```

## Install gem dependencies

```sh
# make sure bundler is installed
gem install bundler
# install dependencies from Gemfile
bundle install
```

## Configure it

The following ENV vars can be set:

```sh
# cloudscale.ch credentials
CLOUDSCALE_USER = 'user@example.com'
CLOUDSCALE_PASSWORD = 'your-password'
# cryptopus credentials
CRYPTOPUS_USER = 'user-xyz01'
CRYPTOPUS_TOKEN = 'your-token'
```

## Acounts Types

### cloudscale.ch

Update your cloudscale.ch account password.

Make sure 2FA is disabled, or pwmate won't be able to login to your account.

## Secret Stores Types

The current password is always retriefed from the first store from the list.

### Cli

Prompts for the current password and outputs the new password to the command line.

Only used for testing puposes!

### Vault

Retrieves and stores passwords in Hashicrp Vault.

### Cryptopus

Retrieves and stores passwords in Hashicrp Vault.

## Prepare an playbook for pwmate

pwmate takes YAML files as input in order to update one or many accounts.

Here is an example `input.yml` definition:

```yaml
accounts:
- name: My account
  type: cloudscale.ch
  username: account@example.com
  secret_stores:
  - type: cli
  - type: vault
    path: myaccount/secret
  - type: cryptopus
    account: 42
```

## Run it

```sh
pwmate -f input.yml
```
