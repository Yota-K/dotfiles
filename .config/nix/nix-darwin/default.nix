# in configuration.nix
{ pkgs, ... }: {
  system.stateVersion = 4;

  system = {
    defaults = {
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
      };
    };
  };
}
# inputs.self, inputs.nix-darwin, and inputs.nixpkgs can be accessed here
