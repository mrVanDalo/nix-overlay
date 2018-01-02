# My fhUser Scripts

In here are some of my fhUser scripts which I sometimes need to start programs
from the internet.

## Difference to Packages

These scripts are called using (e.g. `bitwig.nix`)

    nix-shell bitwig.nix

But the can also be used as a package. The difference is the `.env` at the end,
and that you have to integrate it the overlay with `callPackage "./bitwig.nix"`.
