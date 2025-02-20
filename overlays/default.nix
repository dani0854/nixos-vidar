final: prev: with final; {

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (import ./python-modules { pkgs = final; })
  ];

  sparrow-wifi = callPackage ./sparrow-wifi { };
}
