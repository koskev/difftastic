{ inputs, self, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      craneLib = inputs.crane.mkLib pkgs;
    in
    {
      packages.default = craneLib.buildPackage {
        name = "difftastic";
        meta.mainProgram = "difft";
        src = self;
        nativeBuildInputs = with pkgs; [
          clang
          pkg-config
        ];

        LIBCLANG_PATH = with pkgs; "${llvmPackages.libclang.lib}/lib";
      };
    };
}
