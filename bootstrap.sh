#!/usr/bin/env bash

set -e

echo \#\#Install dotfiles
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


echo \#\#Install OS-specific apps
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    # Package manager brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Windows management
    brew install --cask rectangle
    # Dev tools
    brew install git, git-gui, pwgen
    brew install --cask iterm2, visual-studio-code
else
    echo This OS_TYPE=$OSTYPE is not supported yet, feel free to add ...
fi
