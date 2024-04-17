{ inputs, pkgs, ... }: {
  home-manager.users.main.programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix;
    defaultEditor = true;
    settings = {
      theme = "nord";
      editor = {
        bufferline = "multiple";
        color-modes = true;
        true-color = true;
      };
      keys.insert = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
        pageup = "no_op";
        pagedown = "no_op";
        home = "no_op";
        end = "no_op";
      };
    };
    languages = {
      language-server = {
        ltex-ls.config.ltex.languageToolHttpServerUri = "http://localhost:8081/";
        gpt = {
          command = "helix-gpt";
          args = [ "--handler" "copilot" ];
        };
      };
      language = [
        {
          name = "nix";
          formatter.command = "nixpkgs-fmt";
        }
        {
          name = "go";
          language-servers = [ "gopls" "golangci-lint-lsp" "gpt" ];
        }
        {
          name = "markdown";
          language-servers = [ "marksman" "ltex-ls" ];
        }
      ];
    };
  };
}
