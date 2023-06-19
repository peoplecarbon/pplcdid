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
wget https://github.com/peoplecarbon/pplcdid/blob/af4f12b2b2e51f5488488d5c8e685b4a054110b0/did-cmd/pplcdid.rb -O ~/bin/pplcdid
chmod +x ~/bin/pplcdid

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  export PATH="$PATH:$HOME/bin"
  echo "consider adding ~/bin to your PATH"
  echo "the following libraries and gems need to be installed:"
  echo "$ apt-get install ruby-dev libsodium-dev"
  echo "$ gem install pplcdid securerandom httparty ed25519 multibases multihashes optparse rbnacl dag uri"
fi
