#! /usr/bin/env nix-shell
#! nix-shell -i bash jq -p bash

echo -e "Available targets for \`nix build\`:\n"
(nix eval .#packages.x86_64-linux --apply builtins.attrNames --json 2> /dev/null) | jq flatten[] -r
