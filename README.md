## NixOS
nix


## Darwin


## Nix
# After installing nix on a new device, run this to initialize:
nix build --extra-experimental-features 'nix-command flakes' .#homeConfigurations.it-jpn-31180.activationPackage
./result/activate

# From then, we can just rebuild with home manager
home-manager switch --flake .#it-jpn-31180
