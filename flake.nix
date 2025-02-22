{
  description = "Nix flake for TV box";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function (mkPkgs system));

      forAllSystemsDefault =
        function:
        forAllSystems (pkgs: {
          default = function pkgs;
        });
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            sops
            nixfmt-rfc-style
          ];
        };
      });

      packages = forAllSystems (pkgs: {
        deploy = pkgs.writeShellApplication {
          name = "deploy";
          text = ''
            if [[ $HOSTNAME == moguchan ]]; then
              echo "Deploying to the local system" >&2
              nixos-rebuild switch \
                --flake .#moguchan
            else
              echo "Deploying to the remote system" >&2
              nixos-rebuild switch \
                --flake .#moguchan \
                --target-host root@moguchan.skate-gopher.ts.net
            fi
          '';
          runtimeInputs = with pkgs; [
            nixos-rebuild
          ];
          meta = {
            description = "Deploy the configuration to the target system";
          };
        };
        ssh = pkgs.writeShellApplication {
          name = "ssh";
          text = ''
            ssh root@moguchan.skate-gopher.ts.net
          '';
          runtimeInputs = with pkgs; [
            openssh
          ];
          meta = {
            description = "SSH into the target system";
          };
        };
      });

      nixosConfigurations.moguchan = nixpkgs.lib.nixosSystem rec {
        pkgs = mkPkgs system;
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
        specialArgs = {
          inherit self inputs;
        };
      };
    };
}
