final: prev: with final; {

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (import ./python-modules { pkgs = final; })
  ];

  sparrow-wifi = callPackage ./sparrow-wifi { };

  proton-cachyos-bin = callPackage ./proton-cachyos/bin.nix { };

  gramps = prev.gramps.overridePythonAttrs (
    {
      propagatedBuildInputs ? [ ],
      buildInputs ? [ ],
      ...
    }:
    {
      buildInputs = buildInputs ++ [
        goocanvas2
      ];

      propagatedBuildInputs = propagatedBuildInputs ++ [
        graphviz
      ];
    }
  );

  # TODO: remove when merged
  # https://github.com/NixOS/nixpkgs/pull/450849
  inherit (callPackage ./docker { })
    docker_25
    docker_28
    ;
  docker-compose = callPackage ./docker/compose.nix { };

  # TODO: remove when merged
  # https://github.com/NixOS/nixpkgs/pull/450737
  sdrpp = callPackage ./sdrpp/package.nix { };
}
