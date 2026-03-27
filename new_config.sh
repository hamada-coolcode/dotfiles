
# This is a small util for gnu stow.
# Instead of making directories manually each time for dots.
# This creates the folders stow needs.
# Example:
#   $ ./new_config.sh nvim .config/nvim # do not pass ~. It automatically add them.
#   $ # This creates ./nvim/.config/nvim
#   $ # and run `stow nvim`

#!/bin/bash

# Taking Program Args
program_name=$1 # the name of the parent folder
location=$2     # the location of all dotfiles
parent_location="${location%/*}" # the parent of $location

# Making the rest of the relative path.
mkdir -p "$program_name/$parent_location"

# Moving Configs
mv "$HOME/$location" "./$program_name/$location"

# Making stow symlink

root=0

if [[ $# -eq 3 ]]; then
  case "$3" in
    --root) root=1; shift ;;
    -r) root=1; shift ;;
    *) echo "Unknown Option: $3" >&2; exit 1 ;;
  esac
fi

if [[ $root -eq 1 ]]; then
  stow -t=/ "$program_name"
else
  stow "$program_name"
fi

