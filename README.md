# Hub resources

This is a monorepo made to host everything for the hub.

Everything here is managed my nix, if you want to build everything just run:
```sh
nix build
```

If you want to build only one package you can do (for example):
```sh
nix build .#eotw_2025-11-04
```

If you want to know which targets are available then execute the
`available_targets.sh` script.

By default nix builds absolutely everything.
