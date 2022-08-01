#!/usr/bin/env bash

set -e

if [ ! -d ~/.dotfiles ]; then
  dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  ln -sf "${dir}" ${HOME}/.dotfiles
fi

ln -sf "${HOME}/dotfiles/shell.sh" "${HOME}/.shell.sh"


# Source our shell configuration in any local shell config files.
config_files=(~/.bashrc ~/.zshrc)
for config_file in ${config_files[@]}; do
    # Skip config files that don't exist.
    [ -r "${config_file}" ] || continue

    # If we don't have the 'source ~/.shell.d' line in our config, add it.
    source_command="[ -r ~/.shell.sh ] && source ~/.shell.sh"
    if ! grep -q "${source_command}" "${config_file}"; then
        echo ".shell.sh is not sourced in '${config_file}' adding this now..."
        echo "${source_command}" >> "${config_file}"
    fi
done