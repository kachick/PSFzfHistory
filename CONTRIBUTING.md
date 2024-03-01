# How to develop

## Setup

1. Install [Nix](https://nixos.org/) package manager
2. Allow [Flakes](https://nixos.wiki/wiki/Flakes)
3. Run dev shell as one of the following
   - with [direnv](https://github.com/direnv/direnv): `direnv allow`
   - nix only: `nix develop`
4. You can use development tools

```console
> nix develop
(prepared bash)
> dprint --version
...
```
