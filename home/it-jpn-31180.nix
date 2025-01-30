{ inputs, outputs, lib, config, pkgs, myvars,... }:
with lib;
{
  imports = [
    ./home.nix
  ];

  my = {
    role = "laptop";
    homeRole = "laptop";
    owner = "work";
  };

}
