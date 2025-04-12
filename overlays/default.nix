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
}
