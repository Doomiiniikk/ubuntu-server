#!/usr/bin/env bash
if ! sudo -l -U $USER &> /dev/null ; then
  echo "you do not have privileges"
  exit 1
fi

echo "updating repositories"
sudo apt update

# micro - a preferred text editor
echo "installing micro"
sudo apt install micro && echo "curl installed successfully"

# curl
echo "installing curl"
sudo apt install curl && echo "curl installed successfully"

# pyenv - a python environment manage
echo "installing pyenv"
curl https://pyenv.run | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile

# pyenv dependencies
echo "installing pyenv build dependencies"
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

