{ pkgs, ... }:
let
  helix-gpt-wrapper = pkgs.writeScriptBin "helix-gpt" ''
    #!/usr/bin/env bash
    
    export OPENAI_API_KEY=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' $XDG_CONFIG_HOME/helix/openai_api_key 2>/dev/null)
    export COPILOT_API_KEY=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' $XDG_CONFIG_HOME/helix/copilot_api_key 2>/dev/null)
    export CODEIUM_API_KEY=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' $XDG_CONFIG_HOME/helix/codeium_api_key 2>/dev/null)

    set -e

    ${pkgs.helix-gpt}/bin/helix-gpt $@
  '';
in
{
  environment.systemPackages = [
    helix-gpt-wrapper
  ];
}
