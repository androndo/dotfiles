#!/usr/bin/env bash

set -e

if [ ! -d ~/.dotfiles ]; then
  dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  ln -sf "${dir}" ${HOME}/.dotfiles
fi

ln -sf "${HOME}/dotfiles/shell.sh" "${HOME}/.shell.sh"


add_source_cmd='\n# Source our shell configuration if it exists. \
[ -r ~/.shell.sh ] && source ~/.shell.sh \
'

echo ${add_source_cmd} >> ${HOME}/.bashrc
echo ${add_source_cmd} >> ${HOME}/.zshrc
