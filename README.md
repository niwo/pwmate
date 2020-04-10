# pwmate

Automated password changes for [cloudcsale.ch](https://cloudscale.ch) accounts and saving secrets in [Cryptopus](https://github.com/puzzle/cryptopus).

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
CLOUDSCALE_USER = 'wolfgramm@puzzle.ch'
CLOUDSCALE_PASSWORD = 'your-password'
# cryptopus credentials
CRYPTOPUS_USER = 'nwolfgramm-xyz01'
CRYPTOPUS_TOKEN = 'your-token'
CRYPTOPUS_ACCOUNT = '42'
```

## Run it

```sh
/.pwmate.rb
```
