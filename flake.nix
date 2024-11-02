{
  description = "My package list for mac os.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-darwin.my-packages = nixpkgs.legacyPackages.x86_64-darwin.buildEnv {
      name = "my-packages";
      paths = [
        nixpkgs.legacyPackages.x86_64-darwin.git
        nixpkgs.legacyPackages.x86_64-darwin.curl
        # ここにパッケージを追記していく
      ];
    };
  };
}
