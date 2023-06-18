#!/usr/bin/env bash

set -e

if ! hash wget > /dev/null 2>&1; then
    echo "wget is required for download. Install wget and try again."
    exit 1
fi

if ! hash ruby > /dev/null 2>&1; then
    echo "ruby is required for execution. Install ruby and try again."
    exit 1
fi

mkdir -p ~/bin
wget https://github.com/peopledata/pplcid/blob/main/did-cmd/pplcid.rb -O ~/bin/pplcid
chmod +x ~/bin/pplcid

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  export PATH="$PATH:$HOME/bin"
  echo "consider adding ~/bin to your PATH"
  echo "the following libraries and gems need to be installed:"
  echo "$ apt-get install ruby-dev libsodium-dev"
  echo "$ gem install pplcid securerandom httparty ed25519 multibases multihashes optparse rbnacl dag uri"
fi
