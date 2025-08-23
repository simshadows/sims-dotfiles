#!/usr/bin/env sh

set -e

sudo apt-get install build-essential \
    tmux \
    vim \
    nodejs \
    npm \
    ruby-dev

npm install --global yarn
