final: prev: with final; {

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (import ./python-modules { pkgs = final; })
  ];

  sparrow-wifi = callPackage ./sparrow-wifi { };

  qmk = prev.qmk.overridePythonAttrs (
    { pname, ... }:
    let
      version = "1.1.6";
    in
    {
      inherit version;
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-3ENs26vy+M7G261FPeODK+AbrI5+nBkHXCmGbuIqi1A=";
      };
    }
  );
}
