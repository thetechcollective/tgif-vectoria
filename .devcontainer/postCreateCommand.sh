#!/usr/bin/env bash

set -e

PREFIX="🍰  "
echo "$PREFIX Running $(basename $0)"

echo "$PREFIX Setting up safe git repository to prevent dubious ownership errors"
git config --global --add safe.directory /workspace

echo "$PREFIX Setting up git configuration to support .gitconfig in repo-root"
git config --local --get include.path | grep -e ../.gitconfig >/dev/null 2>&1 || git config --local --add include.path ../.gitconfig

echo "$PREFIX Installing Python 3.11 to fix datetime.UTC compatibility"
sudo apt update
sudo apt install -y python3.11 python3.11-venv

echo "$PREFIX Setting Python 3.11 as default python3"
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
sudo update-alternatives --set python3 /usr/bin/python3.11

# Check if the GH CLI is required
if [ -e $(dirname $0)/_temp.token ]; then
    $(dirname $0)/gh-login.sh postcreate
    echo "$PREFIX setting up GitHub CLI"
    echo "$PREFIX Installing the techcollective/gh-tt gh cli extension"
    gh extension install thetechcollective/gh-tt --pin stable
    echo "$PREFIX Installing the lakruzz/gh-semver gh cli extension"
    gh extension install lakruzz/gh-semver
    echo "$PREFIX Installing the gh aliases"    
    gh alias import .gh_alias.yml --clobber

fi

sudo chown -R $(whoami) /workspaces/cts-risk-platform-backend

echo "$PREFIX SUCCESS"
exit 0