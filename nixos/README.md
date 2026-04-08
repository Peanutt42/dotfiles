
# Recipes

available hosts: `pc`, `framework-laptop`, `lenovo-laptop`

```
$ just --list
Available recipes:
    fmt                                  # formats all .nix files with nixfmt
    generate_hardware_configuration host # (re-)generates the `hardware-configuration.nix` file for that `host`
    install host                         # installs the configuration of the `host` configuration
```
