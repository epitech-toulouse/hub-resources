#!/usr/bin/env sh

nix eval .#packages.x86_64-linux --apply builtins.attrNames --json | jq flatten[] -r
