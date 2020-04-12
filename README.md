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

The following ENV vars can be used:

```sh
CRYPTOPUS_API_URL='https://cryptopus.example.com/api'
CRYPTOPUS_TOKEN='your-token'
# vault settings
VAULT_ADDR='https://vault.example.com'
VAULT_TOKEN='my-vault-token'
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

Retrieves and stores passwords in [Hashicorp Vault](https://www.vaultproject.io/).

### Cryptopus

Retrieves and stores passwords in [Cryptopus](https://github.com/puzzle/cryptopus).

## YAML input files

pwmate takes YAML files as input in order to update one or many accounts.

Here is an example `input.yml` definition:

```yaml
accounts:
- name: My cloudscale account
  type: cloudscale.ch
  username: account@example.com
  secret_stores:
  - type: vault
    path: kv/data/spaces/my-secret
    key: password
  - type: cryptopus
    user: my-api-user
    account: 4242
  - type: cli
```

## Run it

Update all accounts defined in a input file:

```sh
./pwmate -f input.yml
```

Show all usage options:

```sh
./pwmate --help
```