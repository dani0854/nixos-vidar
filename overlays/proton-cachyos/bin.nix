{
  lib,
  stdenvNoCC,
  fetchurl,
  # Can be overridden to alter the display name in steam
  # This could be useful if multiple versions should be installed together
  steamDisplayName ? "Proton CachyOS",
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "proton-cachyos-bin";
  version = "9.0-20250102"; # ntsync version

  src = fetchurl {
    url = "https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${finalAttrs.version}-slr/proton-cachyos-${finalAttrs.version}-slr-x86_64_v3.tar.xz";
    hash = "sha256-KVPMGUOMVV2K0D16qWXhK3vjDD2Ruc6YvNSIkOIzfLI=";
  };

  dontConfigure = true;
  dontBuild = true;

  outputs = [
    "out"
    "steamcompattool"
  ];

  installPhase = ''
    runHook preInstall

    # Make it impossible to add to an environment. You should use the appropriate NixOS option.
    # Also leave some breadcrumbs in the file.
    echo "${finalAttrs.pname} should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

    mkdir -p $steamcompattool
    cp -r * $steamcompattool/

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
      --replace-fail "proton-cachyos-${finalAttrs.version}-slr-x86_64_v3" "${steamDisplayName}"

    runHook postFixup
  '';

  meta = {
    description = ''
      Compatibility tool for Steam Play based on Wine and additional components.

      (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
    '';
    homepage = "https://github.com/CachyOS/proton-cachyos";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ dsuetin ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
