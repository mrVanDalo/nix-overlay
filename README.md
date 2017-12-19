# My Nixpkgs Overlay

> This is an experiment area

> `palo` is the example package defined in here (it is actually my user name)

## How to install 

### local

To install the overlay into `~/.config/nixpkgs/overlays` just run: 

    ./install.sh

now you can test your builds using:
    
    nix-shell -p palo

### global

add the following to your `/etc/nixos/configuration.nix`:

    nixpkgs.config.packageOverrides = import /path/to/overlay.nix pkgs;

now you can install the packages from the overlay

    environment.systemPackages = [
        pkgs.palo
    ];
