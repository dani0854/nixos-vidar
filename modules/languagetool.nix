{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.services.languagetool;
  settingsFormat = pkgs.formats.javaProperties { };
in
{
  options.services.languagetool = {
    jvmOptions = mkOption {
      description = lib.mdDoc "Extra command line options for the JVM running languagetool.";
      default = [ ];
      type = types.listOf types.str;
      example = [
        "-Xmx512m"
      ];
    };
  };

  config = mkIf cfg.enable {
    systemd.services.languagetool.serviceConfig = {
      Restart = "on-failure";
      ExecStart = mkForce ''
        ${pkgs.jre}/bin/java \
          -cp ${pkgs.languagetool}/share/languagetool-server.jar \
          ${toString cfg.jvmOptions} \
          org.languagetool.server.HTTPServer \
            --port ${toString cfg.port} \
            ${optionalString cfg.public "--public"} \
            ${optionalString (cfg.allowOrigin != null) "--allow-origin ${cfg.allowOrigin}"} \
            "--config" ${settingsFormat.generate "languagetool.conf" cfg.settings}
      '';
    };
  };
}
