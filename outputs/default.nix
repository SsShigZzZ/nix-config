{ self, darwin, nixpkgs, home-manager, ... }@inputs: let
  inherit (self) outputs;
  inherit (inputs.nixpkgs) lib;
  myvars = {
    userName = "mpask";
    fullName = "Matt Pask";
    domain = "pask.xyz";
    email = "mpask@pask.xyz"; # No email addr here but fuggit
  };
  systems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];
  forAllSystems = nixpkgs.lib.genAttrs systems;
in {
  packages = forAllSystems (system: import ../pkgs nixpkgs.legacyPackages.${system});
  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  overlays = import ../overlays {inherit inputs;};
  nixosModules = import ../modules/nixos;
  homeManagerModules = import ../modules/home-manager;

  nixosConfigurations = {
    desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs myvars ;
        role = "desktop";
        hostname = "desktop";
        owner = "me";
        displays = 1;
        display_center = "Virtual-1";
        networkInterface = "enp0s3";
        #displays = 2;
        #display_center = "DP-3";
        #display_right = "";
        #display_left = "DP-2";
        #networkInterface = "enp34s0";
      };
      modules = [
        ../nixos/desktop
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
      ];
    };
  };

  darwinConfigurations = {
    macbook = darwin.lib.darwinSystem {
      modules = [ ../darwin/macbook ];
      specialArgs = { inherit inputs outputs myvars; };
    };
  };

  homeConfigurations = {
    it-jpn-31180 = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs outputs myvars; };
      modules = [
        ../home/it-jpn-31180.nix
        {
          home = {
            username = "${myvars.userName}";
            homeDirectory = "/home/${myvars.userName}";
            packages = [ nixpkgs.legacyPackages.x86_64-linux.home-manager ];
            stateVersion = "24.05";
          };
        }
      ];
    };
  };
}
