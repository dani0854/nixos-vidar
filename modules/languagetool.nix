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
  config = mkIf cfg.enable {
    systemd.services.languagetool = {
      description = "LanguageTool HTTP server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        DynamicUser = true;
        User = "languagetool";
        Group = "languagetool";
        CapabilityBoundingSet = [ "" ];
        RestrictNamespaces = [ "" ];
        SystemCallFilter = [ "@system-service" "~ @privileged" ];
        ProtectHome = "yes";
        ExecStart = ''
          ${pkgs.languagetool}/bin/languagetool-http-server \
            --port ${toString cfg.port} \
            ${optionalString cfg.public "--public"} \
            ${optionalString (cfg.allowOrigin != null) "--allow-origin ${cfg.allowOrigin}"} \
            "--config" ${settingsFormat.generate "languagetool.conf" cfg.settings}
        '';
      };
    };
  };
}
