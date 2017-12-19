# My Nixpkgs Overlay

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


## How to check builds

    nix-build -p palo
    
should create a `./result` folder which contains the result of the package.


# Links

* [A presentation about Overlays](https://www.youtube.com/watch?v=6bLF7zqB7EM&feature=youtu.be&t=39m50s) 
* [Package Binaries](https://nixos.wiki/wiki/Packaging_Binaries)
