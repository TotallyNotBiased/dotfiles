# dotfiles

A unified Nix config merged from my ThinkPad and WSL configurations. Hosts include my ThinkPad X1 Carbon (running NixOS), my WSL installation (Debian using `home-manager`), and my M4 MacBook Pro (using `nix-darwin`).

## Installation

Clone this repository into your home directory:

```bash
git clone git@github.com:TotallyNotBiased/dotfiles.git ~/dotfiles 
```

### ThinkPad (NixOS)
```bash
sudo nixos-rebuild switch --flake ~/dotfiles#nixos
```
Note that if you are trying this out on your own machine, use your own `hardware-configuration.nix`.

### MacBook (nix-darwin) 
```bash
sudo nixos-rebuild switch --flake ~/dotfiles#macbook
```

### WSL (home-manager) 
```bash
sudo nixos-rebuild switch --flake ~/dotfiles#unbiased
```

## Usage

We have two aliases to help with the common task of applying flake updates. To enter our dotfiles directory we can use
```bash
conf 
```
and to rebuild we can simply run 
```bash
rebuild
```

## Templates

To quickstart with a reproducible development environment, we can use the integrated templates:
```bash
nix flake init -t ~/dotfiles#rust
```

for a Rust environment.
