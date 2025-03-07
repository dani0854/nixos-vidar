final: prev: with final; {

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (import ./python-modules { pkgs = final; })
  ];

  sparrow-wifi = callPackage ./sparrow-wifi { };

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
