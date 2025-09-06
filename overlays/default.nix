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

  gns3-server = prev.gns3-server.overridePythonAttrs (
    {
      disabledTestPaths ? [ ],
      ...
    }:
    {
      disabledTestPaths = disabledTestPaths ++ [
        "tests/controller/test_project.py"
      ];
    }
  );
}
